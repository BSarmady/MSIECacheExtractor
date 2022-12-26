unit uMain;

interface

uses
  Windows, SysUtils, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, Buttons,
  FileCtrl, HTTPApp, ImgList, ActnList, Classes, System.ImageList, System.Actions;

type
  TfrmMain = class(TForm)
    Menu: TMainMenu;
    MFile: TMenuItem;
    MOpen: TMenuItem;
    MSave: TMenuItem;
    MExit: TMenuItem;
    ML1: TMenuItem;
    MHelp: TMenuItem;
    ML2: TMenuItem;
    MAbout: TMenuItem;
    MIndex: TMenuItem;
    OpenDialog: TOpenDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    L3: TLabel;
    L5: TLabel;
    L4: TLabel;
    ProgressBar: TProgressBar;
    LUrl: TStaticText;
    LRedr: TStaticText;
    LHash: TStaticText;
    L2: TLabel;
    L1: TLabel;
    Animate: TAnimate;
    MStart: TMenuItem;
    ActionList: TActionList;
    AcOpen: TAction;
    AcSave: TAction;
    AcStart: TAction;
    AcExit: TAction;
    ImgList: TImageList;
    StatusBar: TStatusBar;
    BOpen: TBitBtn;
    BSave: TBitBtn;
    BStart: TBitBtn;
    AcStop: TAction;
    procedure AcOpenExecute(Sender: TObject);
    procedure AcSaveExecute(Sender: TObject);
    procedure AcExitExecute(Sender: TObject);
    procedure AcStartExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AcStopExecute(Sender: TObject);
    procedure MAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ResetData;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses ufrmAbout;

{$R *.DFM}


Const
  Daysofweek: Array [1 .. 7] of string[3] = ('SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI');

Var
  Cach: File of Char;
  Fin, Fout: File;
  ErrLog,
    Log: Text;
  HTTPAddress,
    OpenRoot,
    SaveRoot,
    OpenFile,
    SaveFile,
    Url,
    TempStr: String;
  Cachfolders: Array [0 .. 4] of string;
  Buff: Array [0 .. 64000] of Byte;
  QPosition,
    Bkopen,
    Bkclose,
    ErrCount,
    Dcount,
    UrlCount,
    RedrCount,
    Filecount,
    HashCount,
    CodeCount,
    TempInt: Integer;
  CachCode: Byte;
  Ch1, Ch2,
    Ch: Char;
  BreakProc: Boolean;

procedure TfrmMain.ResetData;
Var
  Index: Integer;
Begin
  QPosition := 0;
  Bkopen := 0;
  Bkclose := 0;
  ErrCount := 0;
  Dcount := 0;
  UrlCount := 0;
  RedrCount := 0;
  Filecount := 0;
  HashCount := 0;
  CodeCount := 0;
  TempInt := 0;
  CachCode := 0;
  Ch1 := #00;
  Ch2 := #00;
  Ch := #00;
  BreakProc := False;

  HTTPAddress := '';
  OpenFile := '';
  SaveFile := '';
  Url := '';
  TempStr := '';
  For Index := 0 to 3 Do
      Cachfolders[Index] := '';
  Cachfolders[4] := '';

  LUrl.Caption := '0';
  LHash.Caption := '0';
  LRedr.Caption := '0';
  ProgressBar.Position := 0;
  ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
  StatusBar.Panels[1].Text := '0';
End;

Procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ResetData;
  SaveRoot := '';
  OpenRoot := '';
  Animate.ResName := 'Move';
end;

procedure TfrmMain.AcOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute Then
  Begin
    OpenRoot := ExtractFilePath(OpenDialog.FileName);
    StatusBar.Panels[0].Text := OpenRoot;
    AcSave.Enabled := true;
    BSave.SetFocus;
  End;
end;

procedure TfrmMain.AcSaveExecute(Sender: TObject);
begin
  if SelectDirectory('HTTP Save Root', 'Desktop', SaveRoot) then
  Begin
    if copy(SaveRoot, Length(SaveRoot), 1) <> '\'
    Then
        SaveRoot := SaveRoot + '\';
    StatusBar.Panels[0].Text := SaveRoot;
    AcStart.Enabled := true;
    BStart.SetFocus;
  End;
end;

procedure TfrmMain.AcStartExecute(Sender: TObject);
Var
  Index,
    Index1: Integer;
begin
  ResetData;
  AcSave.Enabled := False;
  AcOpen.Enabled := False;
  MStart.Action := AcStop;
  BStart.Action := AcStop;
  Animate.Visible := true;
  Animate.Active := true;

  { openning Log files at SaveRoot for Full Access }
  FileMode := 1;
  AssignFile(Log, SaveRoot + 'Result.Log');
  Rewrite(Log);
  AssignFile(ErrLog, SaveRoot + 'Error.Log');
  Rewrite(ErrLog);
  { Writing initial logs to result log and error log }
  Writeln(Log, '*******************************************************************************');
  Writeln(Log, '*                            IE4 Cach Explorer log                            *');
  Writeln(Log, '*******************************************************************************');
  Writeln(Log);
  Writeln(Log, 'Log file generated at ', TimeToStr(Time), ' on ', Daysofweek[DayOfWeek(Now)], ' ', DateToStr(Date), '.');
  Writeln(Log);
  Writeln(Log, 'Using:');
  Writeln(Log, '      ', OpenRoot, ' as root of MS internet Explorer 4.0 Cach ');
  Writeln(Log, '      ', SaveRoot, ' as root of HTTP fo saving Files');
  Writeln(Log);

  Writeln(ErrLog, '*******************************************************************************');
  Writeln(ErrLog, '*                         IE4 Cach Explorer error log                         *');
  Writeln(ErrLog, '*******************************************************************************');
  Writeln(ErrLog);
  Writeln(ErrLog, 'Log file generated at ', TimeToStr(Time), ' on ', Daysofweek[DayOfWeek(Now)], ' ', DateToStr(Date), '.');
  Writeln(ErrLog);
  Writeln(ErrLog, 'Using:');
  Writeln(ErrLog, '      ', OpenRoot, ' as root of MS internet Explorer 4.0 Cach ');
  Writeln(ErrLog, '      ', SaveRoot, ' as root of HTTP fo saving Files');
  Writeln(ErrLog);
{$I-}
  { openning Ie cach at OpenPath for readonly }
  FileMode := 0;
  AssignFile(Cach, OpenRoot + 'Index.dat');
  Reset(Cach);
  if IORESULT <> 0 Then
  Begin
    Writeln(ErrLog, 'Error Openning file INDEX.DAT at root of cash');
    Exit;
  End;
{$I+}
  { searching cach file for cach folder names }
  Seek(Cach, 80);
  Writeln(Log, 'Using Cash Paths:');
  For Index := 0 to 3 Do
  Begin
    For Index1 := 1 to 8 Do
    Begin
      Read(Cach, Ch);
      Cachfolders[Index] := Cachfolders[Index] + Ch;
    End;
    Cachfolders[Index] := Cachfolders[Index] + '\';
    Writeln(Log, '      ', OpenRoot, Cachfolders[index]);
    Seek(Cach, FilePos(Cach) + 4);
  End;
  Writeln(Log, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(Log);
  Writeln(ErrLog, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(ErrLog);

  { ** Main Loop ***************************************************************** }
  While not eof(Cach) do
  Begin
    Read(Cach, Ch);
    Case Ch of
      'U': Begin { URL director, next is origin url of file and its name in cach }
          Read(Cach, Ch1, Ch2);
          if (Ch1 = 'R') and (Ch2 = 'L')
          Then Begin
            Url := '';
            OpenFile := '';
            SaveFile := '';
            Seek(Cach, FilePos(Cach) + 57);
            { reading code of cach folders (0 to 3 and 255) }
            Read(Cach, Ch);
            CachCode := ord(Ch);
            if CachCode = 255 Then
                CachCode := 4;
            { Seek to start of url }
            Seek(Cach, FilePos(Cach) + 43);
            { read until first zero byte, this is url of file }
            Repeat
              Read(Cach, Ch);
              Url := Url + Ch;
            Until Ch = #000;
            { deleting leading zero and cach signs that may be before file name }
            Delete(Url, Length(Url), 1);
            While (Ch = #000) or (Ch = #240) or
              (Ch = #173) or (Ch = #011) Do
            Begin
              Read(Cach, Ch);
            End;
            { read until first zero byte, this is file name in the cach }
            Repeat
              OpenFile := OpenFile + Ch;
              Read(Cach, Ch);
            Until Ch = #000;

            { *** Proccess save path of file *********************************************** }
            HTTPAddress := Url;
            { Deletting HTTP:// from first of url }
            Delete(HTTPAddress, 1, 7);
            { Proccessing FileSavePath for Redirects that mey be found }
            { Some of them use ? ; or for seprating redirector from filename }
            { & Some of them use ; : or & $  for seprating fields }
            QPosition := Pos('?', HTTPAddress);
            { if ? found after that is redirect, delete all of them }
            if QPosition > 0 Then
                Delete(HTTPAddress, QPosition, Length(HTTPAddress) - QPosition + 1);
            { Delete from end to first found / sign, this is file name, delete that }
            { Delete last / from end of path }
            While (copy(HTTPAddress, Length(HTTPAddress), 1) <> '/') And (Length(HTTPAddress) > 1) Do
                Delete(HTTPAddress, Length(HTTPAddress), 1);
            { Change all of : to _, this is redirector path but cannot delete them
              so we change them to only one path }
            While Pos(':', HTTPAddress) > 0 Do
            Begin
              QPosition := Pos(':', HTTPAddress);
              Delete(HTTPAddress, QPosition, 1);
              Insert('_', HTTPAddress, QPosition);
            End;
            { Change Unix path to Dos Path and delete remainig file names }
            HTTPAddress := ExtractFilePath(UnixPathToDosPath(HTTPAddress));
            SaveFile := OpenFile;
            { delete (n) renaming mode of msie4 from file names }
            Bkopen := Pos('(', SaveFile);
            Bkclose := Pos(')', SaveFile);
            if Bkopen > 0 Then
                Delete(SaveFile, Bkopen, Bkclose - Bkopen + 1);

            { *** file existing checks and validating save path **************************** }
            { Here We have OpenRoot   = root of cach
              SaveRoot   = root of http
              SaveFile   = name of file to save
              OpenFile   = name of file in cach folders
              HTTPAddress= save path from root of http
              CachFolders= name of cach folders }
            { Check for file if exists in cach, if not may be cach damaged }
            if FileExists(OpenRoot + Cachfolders[CachCode] + OpenFile)
            Then Begin
              { Create all of savepath folders atonce }
              ForceDirectories(SaveRoot + HTTPAddress);
              { openning input file with readonly access }
              FileMode := 0;
              AssignFile(Fin, OpenRoot + Cachfolders[CachCode] + OpenFile);
              Reset(Fin, 1);
              Filecount := 0;
              { if file exists at output path (duplicate files),rename new file with (n) additive }
              TempStr := SaveFile;
              While FileExists(SaveRoot + HTTPAddress + SaveFile) Do
              Begin
                SaveFile := TempStr;
                Inc(Filecount);
                Insert('(' + IntToStr(Filecount) + ')', SaveFile, Pos('.', SaveFile));
              End;
              if SaveFile <> TempStr Then
              Begin
                { count files that their names changed with (n) additive }
                Inc(Dcount);
              End;
              { openning output file with full access }
              FileMode := 1;
              TempInt := IORESULT;
{$I-}
              AssignFile(Fout, SaveRoot + HTTPAddress + SaveFile);
              Rewrite(Fout, 1);
{$I+}
              { if check if file can be written, if not may be its name
                or path is not valid for ms-dos and windows }
              if IORESULT <> 0
              Then Begin
                { write error to error log we also need url & openning
                  path and saving path of file in log }
                Writeln(ErrLog, 'Error Writing File!',
                  #13#10, '     Url:  ', Url,
                  #13#10, '     Open: ', Cachfolders[CachCode] + OpenFile,
                  #13#10, '     Save: ', HTTPAddress + SaveFile);
                Inc(ErrCount);
              End
              Else Begin
                { copy file from cach (OpenRoot+CachFolders[CachCode]+OpenFile)
                  to destination url (SaveRoot+HTTPAddress+SaveFile) }
                While Not eof(Fin) Do
                Begin
                  BlockRead(Fin, Buff, 64000, CodeCount);
                  BlockWrite(Fout, Buff, CodeCount);
                End;
                CloseFile(Fin);
                CloseFile(Fout);
                { write succesful operation to log we also need url & openning
                  path and saving path of file in log }
                Writeln(Log, 'URL => Url:  ', Url,
                  #13#10, '       Open: ', Cachfolders[CachCode] + OpenFile,
                  #13#10, '       Save: ', HTTPAddress + SaveFile);
              End;
            End
            Else Begin
              { Cach code 4 is Channel Description File and can not found in cach,
                so we do not try to write it to dest. }
              if CachCode = 4
              Then
                  Writeln(Log, 'CDF => ', Url)
                { file not found in cach, may be long file names dammaged or
                  file erased from cach, we can not copy that to dest. and
                  reporting it in error log }
              Else Begin
                Writeln(ErrLog, 'Error Openning file, file not found or Cach may be dammaged',
                  #13#10, '     Url:  ', Url,
                  #13#10, '     Open: ', Cachfolders[CachCode] + OpenFile,
                  #13#10, '     Save: ', HTTPAddress + SaveFile);
                Inc(ErrCount);
              End;
            End;
            { *** basic works for refreshing display *************************************** }
            Inc(UrlCount); { count of urls found }
            { write url count to display }
            LUrl.Caption := IntToStr(UrlCount);
            { Write Byte position of url to status bar }
            StatusBar.Panels[1].Text := IntToStr(FilePos(Cach));
            { Writting save address to status bar }
            StatusBar.Panels[0].Text := HTTPAddress + SaveFile;
            { after this we need refereshing status bar to display changes }
            StatusBar.Repaint;
            { Update progress bar to new position }
            ProgressBar.Position := (FilePos(Cach) * 100) Div FileSize(Cach);
            ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
            { this command prossesses window messages in application
              like: repaint, resize, move, ... }
            Forms.Application.ProcessMessages;
          End { Then }
          Else
              Seek(Cach, FilePos(Cach) - 2);
          { the U that found is not sign of URL so we go back and continue }
        End;
      'R': Begin
          Read(Cach, Ch1, Ch2);
          { Redirector director, we does not do anything for that
            except refreshing Display and log file }
          if (Ch1 = 'E') and (Ch2 = 'D')
          Then Begin
            Url := '';
            { Seek to start of url name }
            Seek(Cach, FilePos(Cach) + 13);
            { Read Url to first Zero after }
            Repeat
              Read(Cach, Ch);
              Url := Url + Ch;
            Until Ch = #000;
            { Delete zero from end of string }
            Delete(Url, Length(Url), 1);
            { Write the url to log as REDR (the sign of redirector }
            Writeln(Log, 'REDR=> ', Url);

            { *** basic works for refreshing display *************************************** }
            { increse count of REDRs }
            Inc(RedrCount);
            { Display it }
            LRedr.Caption := IntToStr(RedrCount);
            { Write Byte position of url to status bar }
            StatusBar.Panels[1].Text := IntToStr(FilePos(Cach));
            { Writting Url to status bar }
            StatusBar.Panels[0].Text := Url;
            { after this we need refereshing status bar to display changes }
            StatusBar.Repaint;
            { Update progress bar to new position }
            ProgressBar.Position := (FilePos(Cach) * 100) Div FileSize(Cach);
            ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
            { this command prossesses window messages in application
              like: repaint, resize, move, ... }
            Forms.Application.ProcessMessages;
          End { Then }
          { the R that found is not sign of REDR so we go back and continue }
          Else
              Seek(Cach, FilePos(Cach) - 2);
        End;
      'H': Begin
          Read(Cach, Ch1, Ch2);
          { Hash Table, we does not do anything for that
            except refreshing Display and log file }
          if (Ch1 = 'A') and (Ch2 = 'S')
          Then Begin
            { Report it to log }
            Writeln(Log, 'HASH=> Hash Table at Address: ', FilePos(Cach));

            { *** basic works for refreshing display *************************************** }
            { Increase Hash table count }
            Inc(HashCount);
            { Display it }
            LHash.Caption := IntToStr(HashCount);
            { Write Byte position of url to status bar }
            LHash.Caption := IntToStr(HashCount);
            StatusBar.Panels[1].Text := IntToStr(FilePos(Cach));
            { after this we need refereshing status bar to display changes }
            StatusBar.Repaint;
            { Update progress bar to new position }
            ProgressBar.Position := (FilePos(Cach) * 100) Div FileSize(Cach);
            ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
            { Seek to end of hash and continue This saves time }
            Seek(Cach, FilePos(Cach) + 4093);
            { this command prossesses window messages in application
              like: repaint, resize, move, ... }
            Forms.Application.ProcessMessages;
          End { Then }
          { the H that found is not sign of HASH so we go back and continue }
          Else
              Seek(Cach, FilePos(Cach) - 2);
        End;
    End; { Case }
    if BreakProc then
    Begin
      AcSave.Enabled := true;
      AcOpen.Enabled := true;
      BStart.Action := AcStart;
      MStart.Action := AcStart;
      Animate.Active := False;
      Animate.Visible := False;
      Writeln(Log);
      Writeln(Log, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      Writeln(Log, ' Process cancelled By user request');
      Writeln(ErrLog);
      Writeln(ErrLog, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
      Writeln(ErrLog, ' Process cancelled By user request');
      CloseFile(Cach);
      CloseFile(Log);
      CloseFile(ErrLog);
      Exit;
    End;
  End;
  { This is end of loop and end of cach index file }
  Writeln(Log);
  Writeln(Log, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(Log, 'Operation Successful');
  Writeln(Log, 'Summary:');
  Writeln(Log, 'Hash(s)                 : ', HashCount);
  Writeln(Log, 'Url(s)                  : ', UrlCount);
  Writeln(Log, 'Redirect(s)             : ', RedrCount);
  Writeln(Log, 'Renamed Duplicate Files : ', Dcount);
  Writeln(Log);
  Writeln(Log, 'See ERROR.LOG for errors found');
  Writeln(Log);
  Writeln(ErrLog);
  Writeln(ErrLog, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(ErrLog, ' Total Errors Found : ', ErrCount);
  CloseFile(Cach);
  CloseFile(Log);
  CloseFile(ErrLog);
  AcSave.Enabled := true;
  AcOpen.Enabled := true;
  Animate.Active := False;
  Animate.Visible := False;
  MStart.Action := AcStart;
  BStart.Action := AcExit;
End;

Procedure TfrmMain.AcExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.AcStopExecute(Sender: TObject);
begin
  BreakProc := true;
end;

procedure TfrmMain.MAboutClick(Sender: TObject);
var
  frmAbout: TfrmAbout;
begin

  frmAbout := TfrmAbout.Create(Self);
  frmAbout.ShowModal;
  frmAbout.Free;
end;

end.

unit uFrmMain;

interface

uses
  Windows, SysUtils, Controls, Forms, Dialogs, StdCtrls, ComCtrls, ExtCtrls, Menus, Buttons,
  FileCtrl, HTTPApp, ImgList, ActnList, Classes, System.ImageList, System.Actions;

type
  TMainForm = class(TForm)
    Menu: TMainMenu;
    MFile: TMenuItem;
    MOpen: TMenuItem;
    MSave: TMenuItem;
    MExit: TMenuItem;
    MHelp: TMenuItem;
    MAbout: TMenuItem;
    MIndex: TMenuItem;
    ML1: TMenuItem;
    ML2: TMenuItem;
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
    Procedure GetUrl;
  private
    { Private declarations }
  public
    procedure ResetData;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses uFrmAbout;

{$R *.DFM}


Const
  Daysofweek: Array [1 .. 7] of string[3] = ('SAT', 'SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI');

Var
  Cach: File;
  Err,
    Log: Text;
  OpenRoot,
    SaveRoot,
    TempStr: String;
  FieldName: String[4];
  Cachfolders: Array [0 .. 255] of string[8];
  CachBuff: Array [0 .. 32768] of byte;
  NextHashAddr: Longint;
  NumOfCachDirs: Word;
  Check,
    ErrCount,
    Dcount,
    UrlCount,
    RedrCount,
    HashCount: Integer;
  BreakProc: Boolean;
  CachFolderNo: byte;
  REDRName: String;
  { ** GetUrl ******************************************************************** }
Procedure TMainForm.GetUrl;
Var
  Buff: Array [0 .. 64000] of byte;
  Fin, Fout: File;
  TempInt,
    Filecount,
    LenOfField,
    Bkopen,
    BkClose,
    Index: Integer;
  CachFile,
    SaveFile,
    FileInCach,
    SavePath,
    SaveUrl: String;
  Ch: byte;
  CachFileStart: Word;
Begin
  SaveUrl := '';
  CachFile := '';
  SaveFile := '';
  BlockRead(Cach, LenOfField, 1, Check);
  Seek(Cach, FilePos(Cach) - 5);
  BlockRead(Cach, CachBuff, LenOfField * 128, Check);
  CachFolderNo := CachBuff[56];
  CachFileStart := CachBuff[60] + CachBuff[61] * 256;
  Index := 0;
  Ch := CachBuff[96];
  While Ch <> 0 Do
  Begin
    SaveUrl := SaveUrl + chr(Ch);
    Inc(Index);
    Ch := CachBuff[96 + Index];
  End;
  Index := 0;
  Ch := CachBuff[CachFileStart];
  While Ch <> 0 Do
  Begin
    CachFile := CachFile + chr(Ch);
    Inc(Index);
    Ch := CachBuff[CachFileStart + Index];
  End;
  { *** Proccess save path of file ********************************************* }
  { Deletting HTTP:// from first of url }
  Delete(SaveUrl, 1, 7);
  { Proccessing double slash "//" }
  While pos('Http://', SaveUrl) > 0 Do
  Begin
    Delete(SaveUrl, pos('Http://', SaveUrl), 7);
  End;
  While pos('//', SaveUrl) > 0 Do
  Begin
    Delete(SaveUrl, pos('//', SaveUrl), 2);
  End;
  { Proccessing FileSavePath for Redirects that mey be found }
  { These chars are invalid for file name so we change them to some valid chars }
  For Index := 0 to Length(SaveUrl) Do
    Case SaveUrl[Index] of
      ':': SaveUrl[Index] := '^';
      '|': SaveUrl[Index] := '^';
      '?': SaveUrl[Index] := '%';
      '>': SaveUrl[Index] := ';';
      '<': SaveUrl[Index] := ';';
      '/': SaveUrl[Index] := '\';
      '"': SaveUrl[Index] := '''';
      '*': SaveUrl[Index] := '#';
    End;
  SaveFile := CachFile;
  { delete [n] renaming mode of msie5 from file names }
  Bkopen := pos('[', SaveFile);
  BkClose := pos(']', SaveFile);
  if Bkopen > 0 Then
      Delete(SaveFile, Bkopen, BkClose - Bkopen + 1);
  { *** file existing checks and validating save path **************************** }
  FileInCach := OpenRoot + Cachfolders[CachFolderNo] + '\' + CachFile;
  SaveFile := LowerCase(SaveFile);
  SaveUrl := LowerCase(SaveUrl);
  Index := Length(SaveUrl);
  While SaveUrl[Index] <> '\' Do
      Dec(Index);
  SetLength(SaveUrl, Index);
  if pos(SaveFile, SaveUrl) + Length(SaveFile) - 1 = Length(SaveUrl) Then
      Delete(SaveUrl, pos(SaveFile, SaveUrl) - 1, Length(SaveFile) + 1);
  SavePath := SaveRoot + SaveUrl;
  { Here We have OpenRoot   = root of cach
    SaveRoot   = root of http
    CachFile   = name of file to read
    SaveFile   = name of file to save
    SaveUrl    = save path from root of http
    CachFolders= name of cach folders }
  { Check for file if exists in cach, if not may be cach damaged }
  if FileExists(FileInCach)
  Then Begin
    { Create all of savepath folders atonce }
    ForceDirectories(SavePath);
    { openning input file with readonly access }
    FileMode := 0;
    AssignFile(Fin, FileInCach);
    Reset(Fin, 1);
    Filecount := 0;
    { if file exists at output path (duplicate files),rename new file with (n) additive }
    TempStr := SaveFile;
    While FileExists(SavePath + SaveFile) Do
    Begin
      SaveFile := TempStr;
      Inc(Filecount);
      Insert('(' + IntToStr(Filecount) + ')', SaveFile, pos('.', SaveFile));
    End;
    if SaveFile <> TempStr Then
    Begin
      { count files that their names changed with (n) additive }
      Inc(Dcount);
    End;
    { openning output file with full access }
    FileMode := 1;
    TempInt := IORESULT;
    if TempInt = 0 then; { a trick for removing compiler hint }
{$I-}
    AssignFile(Fout, SavePath + SaveFile);
    Rewrite(Fout, 1);
{$I+}
    { check if file can be written, if not may be its name
      or path is not valid for ms-dos and windows }
    if IORESULT <> 0
    Then Begin
      { write error to error log we also need url & openning
        path and saving path of file in log }
      Writeln(Err, '  Error Writing File!',
        #13#10, '     Open: ', FileInCach,
        #13#10, '     Save: ', SaveUrl + SaveFile);
      Inc(ErrCount);
    End
    Else Begin
      { copy file from cach (OpenRoot+CachFolders[CachCode]+OpenFile)
        to destination url (SaveRoot+HTTPAddress+SaveFile) }
      While Not Eof(Fin) Do
      Begin
        BlockRead(Fin, Buff, 64000, Check);
        BlockWrite(Fout, Buff, Check);
      End;
      CloseFile(Fin);
      CloseFile(Fout);
      DeleteFile(FileInCach);
      { write succesful operation to log we also need url & openning
        path and saving path of file in log }
      Writeln(Log, ' Open Name=', FileInCach);
      Writeln(Log, ' Save Name=', SaveUrl + SaveFile);
    End;
  End
  Else Begin
    { Cach code 255 is Channel Description File and can not found in cach,
      so we do not try to write it to dest. }
    if CachFolderNo = 255
    Then
        Writeln(Log, 'CDF File Name=', SaveUrl + SaveFile)
      { file not found in cach, may be long file names dammaged or
        file erased from cach, we can not copy that to dest. and
        reporting it in error log }
    Else Begin
      Writeln(Err, '  Open: ', FileInCach);
      Writeln(Err, '  Save: ', SaveUrl + SaveFile);
      Writeln(Err);
      Inc(ErrCount);
    End;
  End;
  Inc(UrlCount); { count of urls found }
  { write url count to display }
  LUrl.Caption := IntToStr(UrlCount);
  { Write Byte position of url to status bar }
  StatusBar.Panels[1].Text := IntToStr(FilePos(Cach));
  { Writting save address to status bar }
  StatusBar.Panels[0].Text := SaveUrl + SaveFile;
  { after this we need refereshing status bar to display changes }
  { Update progress bar to new position }
  ProgressBar.Position := (FilePos(Cach) * 100) Div FileSize(Cach);
  ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
  { this command prossesses window messages in application
    like: repaint, resize, move, ... }
  Forms.Application.ProcessMessages;
End;

{ ** ResetData****************************************************************** }
Procedure TMainForm.ResetData;
Var
  Index: Integer;
Begin

  For Index := 0 to 255 Do
      Cachfolders[Index] := '';
  LUrl.Caption := '0';
  LHash.Caption := '0';
  LRedr.Caption := '0';
  ProgressBar.Position := 0;
  ProgressBar.Hint := 'Progress Status (%' + IntToStr(ProgressBar.Position) + ')';
  StatusBar.Panels[1].Text := '0';
End;

Procedure TMainForm.FormCreate(Sender: TObject);
begin
  SaveRoot := '';
  OpenRoot := '';
  Animate.ResName := 'Move';
end;

procedure TMainForm.AcOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute Then
  Begin
    OpenRoot := ExtractFilePath(OpenDialog.FileName);
    StatusBar.Panels[0].Text := OpenRoot;
    AcSave.Enabled := true;
    BSave.SetFocus;
  End;
end;

procedure TMainForm.AcSaveExecute(Sender: TObject);
begin

  if SelectDirectory('HTTP Save Root', SaveRoot, SaveRoot) then
  Begin
    if Copy(SaveRoot, Length(SaveRoot), 1) <> '\'
    Then
        SaveRoot := SaveRoot + '\';
    StatusBar.Panels[0].Text := SaveRoot;
    AcStart.Enabled := true;
    BStart.SetFocus;
  End;
end;

procedure TMainForm.AcStartExecute(Sender: TObject);
Var
  Index: Integer;
  LenOfField: Integer;

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
  AssignFile(Err, SaveRoot + 'Error.Log');
  Rewrite(Err);
  { Writing initial logs to result log and error log }
  Writeln(Log, '*******************************************************************************');
  Writeln(Log, '*                            IE5 Cach Explorer log                            *');
  Writeln(Log, '*******************************************************************************');
  Writeln(Log);
  Writeln(Log, 'Log file generated on ', FormatDateTime('ddd d","mmm","yyyy hh:nnam/pm', Now), '.');
  Writeln(Log);
  Writeln(Log, 'Root Folder of MS internet Explorer 5.0 Cach:');
  Writeln(Log, '    ', OpenRoot);

  Writeln(Err, '*******************************************************************************');
  Writeln(Err, '*                         IE5 Cach Explorer error log                         *');
  Writeln(Err, '*******************************************************************************');
  Writeln(Err);
  Writeln(Err, 'Log file generated on ', FormatDateTime('ddd d","mmm","yyyy hh:nnam/pm', Now), '.');
  Writeln(Err);
  Writeln(Err, 'Root Folder of MS internet Explorer 5.0 Cach:');
  Writeln(Err, '    ', OpenRoot);
{$I-}
  { openning Ie cach at OpenPath for readonly }
  FileMode := 0;
  AssignFile(Cach, OpenRoot + 'Index.dat');
  Reset(Cach, 1);
  if IORESULT <> 0 Then
  Begin
    Writeln(Err, 'Error Openning file INDEX.DAT at root of cash');
    Exit;
  End;
{$I+}
  { Start address of first Hash table }
  Seek(Cach, 32);
  BlockRead(Cach, NextHashAddr, 4, Check);
  { Number of Cach folders }
  Seek(Cach, 72);
  BlockRead(Cach, NumOfCachDirs, 2, Check);
  { Name of Cach Folders
    With format of;
    IDontKnow :Longint;
    NameOfFolder : String[8];
  }
  Writeln(Log, '    ', NumOfCachDirs, ' Cash Folders:');
  { searching cach file for cach folder names }
  Seek(Cach, FilePos(Cach) + 2);
  For Index := 0 to NumOfCachDirs - 1 Do
  Begin
    Seek(Cach, FilePos(Cach) + 3);
    BlockRead(Cach, Cachfolders[Index], 9, Check);
    Cachfolders[Index][0] := #08;
    Writeln(Log, '      ', OpenRoot, Cachfolders[index]);
  End;
  Writeln(Err);
  Writeln(Err, 'Folder used as HTTP root for saving files:');
  Writeln(Err, '    ', SaveRoot);
  Writeln(Err);
  Writeln(Err, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(Err);

  Writeln(Log);
  Writeln(Log, 'Folder used as HTTP root for saving files:');
  Writeln(Log, '    ', SaveRoot);
  Writeln(Log);
  Writeln(Log, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(Log);

  { ** Main Loop ***************************************************************** }

  { Start address of next Hash table }
  Seek(Cach, NextHashAddr + 8);
  { Each Hash is a 4096 byte Table
    I dont Know The structure and I need not it also,
    so i jump it and now i'm in start of first url(URL ) or redirect(REDR)
  }
  Seek(Cach, FilePos(Cach) + 4096 - 8);
  While not Eof(Cach) do
  Begin
    Seek(Cach, FilePos(Cach) - 1);
    BlockRead(Cach, FieldName, 5, Check);
    FieldName[0] := #4;
    if FieldName = 'URL '
    Then
        GetUrl
    Else
      if FieldName = 'REDR'
    Then Begin
      REDRName := '';
      BlockRead(Cach, LenOfField, 1, Check);
      Seek(Cach, FilePos(Cach) - 5);
      BlockRead(Cach, CachBuff, LenOfField * 128, Check);
      // Writeln(Log,'REDR Found');
    End
    Else
      if FieldName = 'LEAK'
    Then Begin
      BlockRead(Cach, LenOfField, 1, Check);
      Seek(Cach, FilePos(Cach) - 5);
      BlockRead(Cach, CachBuff, LenOfField * 128, Check);
      // Writeln(Log,'LEAK Found');
    End
    Else
      if FieldName = 'HASH'
    Then Begin
      Seek(Cach, FilePos(Cach) + 4096 - 4);
      // Writeln(Log,'HASH Found');
    End
    Else Begin
      BlockRead(Cach, CachBuff, 124, Check);
      // Writeln(Log,'This Is an Unknown');
    End;
  End;

  (*

    {*** file existing checks and validating save path ****************************}
    {Here We have OpenRoot   = root of cach
    SaveRoot   = root of http
    SaveFile   = name of file to save
    OpenFile   = name of file in cach folders
    HTTPAddress= save path from root of http
    CachFolders= name of cach folders}
    {Check for file if exists in cach, if not may be cach damaged}
    if FileExists(OpenRoot+CachFolders[CachCode]+OpenFile)
    Then Begin
    {Create all of savepath folders atonce}
    ForceDirectories(SaveRoot+HTTPAddress);
    {openning input file with readonly access}
    FileMode:=0;
    AssignFile(Fin,OpenRoot+CachFolders[CachCode]+OpenFile);Reset(Fin,1);
    Filecount:=0;
    {if file exists at output path (duplicate files),rename new file with (n) additive}
    TempStr:=SaveFile;
    While FileExists(SaveRoot+HTTPAddress+SaveFile) Do
    Begin
    SaveFile:=TempStr;
    Inc(fileCount);
    Insert('('+IntToStr(FileCount)+')',SaveFile,Pos('.',SaveFile));
    End;
    if SaveFile<>TempStr Then
    Begin
    {count files that their names changed with (n) additive}
    Inc(Dcount);
    End;
    {openning output file with full access}
    FileMode:=1;
    TempInt:=IORESULT;
    {$I-}
    AssignFile(Fout,SaveRoot+HTTPAddress+SaveFile);Rewrite(Fout,1);
    {$I+}
    {if check if file can be written, if not may be its name
    or path is not valid for ms-dos and windows}
    if IORESULT<>0
    Then Begin
    {write error to error log we also need url & openning
    path and saving path of file in log }
    Writeln(Err,'Error Writing File!',
    #13#10,'     Url:  ',Url,
    #13#10,'     Open: ',CachFolders[Cachcode]+OpenFile,
    #13#10,'     Save: ',HTTPAddress+SaveFile);
    Inc(ErrCount);
    End
    Else Begin
    {copy file from cach (OpenRoot+CachFolders[CachCode]+OpenFile)
    to destination url (SaveRoot+HTTPAddress+SaveFile) }
    While Not Eof(Fin) Do
    Begin
    BlockRead(Fin,Buff,64000,CodeCount);
    BlockWrite(Fout,Buff,CodeCount);
    End;
    CloseFile(Fin);CloseFile(Fout);
    {write succesful operation to log we also need url & openning
    path and saving path of file in log }
    Writeln(Log,'URL => Url:  ',Url,
    #13#10,'       Open: ',CachFolders[Cachcode]+OpenFile,
    #13#10,'       Save: ',HTTPAddress+SaveFile);
    End;
    End
    Else Begin
    {Cach code 4 is Channel Description File and can not found in cach,
    so we do not try to write it to dest.}
    if CachCode=4
    Then Writeln(Log,'CDF => ',Url)
    {file not found in cach, may be long file names dammaged or
    file erased from cach, we can not copy that to dest. and
    reporting it in error log }
    Else Begin
    Writeln(Err,'Error Openning file, file not found or Cach may be dammaged',
    #13#10,'     Url:  ',Url,
    #13#10,'     Open: ',CachFolders[Cachcode]+OpenFile,
    #13#10,'     Save: ',HTTPAddress+SaveFile);
    Inc(ErrCount);
    End;
    End;
    {*** basic works for refreshing display ***************************************}
  *)
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
    Writeln(Err);
    Writeln(Err, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    Writeln(Err, ' Process cancelled By user request');
    CloseFile(Cach);
    CloseFile(Log);
    CloseFile(Err);
    Exit;
  End;
  (* End; *)
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
  Writeln(Err);
  Writeln(Err, '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
  Writeln(Err, ' Total Errors Found : ', ErrCount);
  CloseFile(Cach);
  CloseFile(Log);
  CloseFile(Err);
  AcSave.Enabled := true;
  AcOpen.Enabled := true;
  Animate.Active := False;
  Animate.Visible := False;
  MStart.Action := AcStart;
  BStart.Action := AcExit;
End;

Procedure TMainForm.AcExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.AcStopExecute(Sender: TObject);
begin
  BreakProc := true;
end;

procedure TMainForm.MAboutClick(Sender: TObject);
var
  FrmAbout: TFrmAbout;
begin
  FrmAbout := TFrmAbout.Create(self);
  FrmAbout.Left := Left + 10;
  FrmAbout.Top := Top + 10;
  FrmAbout.ShowModal;
  FrmAbout.free;
end;

end.

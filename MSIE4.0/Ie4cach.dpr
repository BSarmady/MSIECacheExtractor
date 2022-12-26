program ie4cach;

uses
  Forms,
  ufrmAbout in 'ufrmAbout.pas' {About},
  ufrmBob in 'ufrmBob.pas' {frmBob},
  uMain in 'uMain.pas' {frmMain};

{$R *.RES}
{$R AVI.RES}

begin
  Application.Initialize;
  Application.Title := 'MSIE4 Cach Explorer';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

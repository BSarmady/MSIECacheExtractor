program Ie5cach;

uses
  Forms,
  uFrmMain in 'uFrmMain.pas' {MainForm},
  uFrmBob in 'uFrmBob.pas' {frmBob},
  uFrmAbout in 'uFrmAbout.pas' {frmAbout};

{$R *.RES}
{$R AVI.RES}

begin
  Application.Initialize;
  Application.Title := 'MSIE4 Cach Explorer';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

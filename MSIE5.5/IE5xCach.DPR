program IE5xCach;

uses
  Forms,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  ufrmAbout in 'ufrmAbout.pas' {frmAbout},
  ufrmBob in 'ufrmBob.pas' {frmBob};

{$R *.RES}
{$R AVI.RES}

begin
  Application.Initialize;
  Application.Title := 'MSIE5.x Cach Explorer';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

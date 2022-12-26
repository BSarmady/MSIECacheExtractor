unit ufrmAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TfrmAbout = class(TForm)
    Image: TImage;
    Bok: TButton;
    procedure BokClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses ufrmBob;

{$R *.DFM}

procedure TfrmAbout.BokClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAbout.FormPaint(Sender: TObject);
begin
  Canvas.Brush.Color := clBtnFace;
  Canvas.Pen.Color := ClRed;
  Canvas.TextOut(89, 130, 'By B. Sarmady');
end;

procedure TfrmAbout.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  frmBob: TfrmBob;
begin
  if (Shift = [ssCtrl, ssAlt]) And (Key = VK_F1) Then begin
    frmBob := TfrmBob.Create(Self);
    frmBob.ShowModal;
    frmBob.Free;
  end;

end;

end.

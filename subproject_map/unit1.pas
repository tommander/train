unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, Spin, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
var lAngleRad: double;
    lArc01Radius, lArc01ArcLength, lArc01AngleDeg, lArc01AngleRad, lArc01ChordLength, lArc01DeltaX, lArc01DeltaY: double;
    lArc02Radius, lArc02Length: double;
    lBeta,lDelta,lDX,lDY: double;
begin
  lAngleRad := 0;
  // Redraw
  Image1.Canvas.Brush.Color := clBtnFace;
  Image1.Canvas.Brush.Style := bsSolid;
  Image1.Canvas.Pen.Style := psClear;
  Image1.Canvas.Pen.Width := 0;
  Image1.Canvas.Pen.Color := clNone;
  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);

  // Current position on map
  Image1.Canvas.Pen.Style := psSolid;
  Image1.Canvas.Pen.Width := 2;
  Image1.Canvas.Pen.Color := clBlack;
  Image1.Canvas.MoveTo(Image1.Width div 2, (6*Image1.Height) div 7);
  Image1.Canvas.EllipseC(Image1.Width div 2, (6*Image1.Height) div 7, 4, 4);

  // Straight `100/7 vh`
  Image1.Canvas.LineTo(Image1.Width div 2, (5*Image1.Height) div 7);
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.EllipseC(Image1.Canvas.PenPos.X, Image1.Canvas.PenPos.Y, 4, 4);
  Image1.Canvas.Pen.Color := clBlack;

  // First arc - left R=300m l=471.238m  o=1884.9m
  lArc01Radius := SpinEdit1.Value;
  lArc01AngleDeg := SpinEdit2.Value;
  lArc01AngleRad := DegToRad(lArc01AngleDeg);
  lBeta := DegToRad((180-lArc01AngleDeg)/2);
  lDelta := DegToRad(90-((180-lArc01AngleDeg)/2));
  lArc01ArcLength := lArc01Radius * lArc01AngleRad;
  lArc01ChordLength := lArc01Radius * (sin(lArc01AngleRad)/sin(DegToRad((180-lArc01AngleDeg)/2)));
  lDX := -1 * lArc01ChordLength * sin(lDelta);
  lDY := -1 * lArc01ChordLength * sin(lBeta);
  Image1.Canvas.Arc(
    Round(Image1.Canvas.PenPos.X - lArc01Radius*2),
    Round(Image1.Canvas.PenPos.Y - (lArc01Radius)),
    Image1.Canvas.PenPos.X,
    Round(Image1.Canvas.PenPos.Y + (lArc01Radius)),
    0,
    16 * Round(lArc01AngleDeg)
  );
  Image1.Canvas.MoveTo(
    Round(Image1.Canvas.PenPos.X + lDX),
    Round(Image1.Canvas.PenPos.Y + lDY)
  );
  lAngleRad := lAngleRad + lArc01AngleRad;

  Image1.Canvas.Pen.Color := clLime;
  Image1.Canvas.EllipseC(Image1.Canvas.PenPos.X, Image1.Canvas.PenPos.Y, 4, 4);
  Image1.Canvas.Pen.Color := clBlack;

  // Straight `100 m`
  lDX := 100 * sin(lAngleRad);
  lDY := 100 * sin(degtorad(90)-lAngleRad);
  Image1.Canvas.LineTo(
    Round(Image1.Canvas.PenPos.X - lDX),
    Round(Image1.Canvas.PenPos.Y - lDY)
  );
  Image1.Canvas.Pen.Color := clRed;
  Image1.Canvas.EllipseC(Image1.Canvas.PenPos.X, Image1.Canvas.PenPos.Y, 4, 4);
  Image1.Canvas.Pen.Color := clBlack;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Panel1.Color := clLime;
end;

end.


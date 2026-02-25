unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

function SplitByChar(const AText: string; const ASeparator: string; var ALeft: string): string;

implementation



{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var lStr,lItem: string;
    i,lOld: integer;
begin
  lItem := '';
  lStr := Edit1.Text;

  Memo1.Lines.Clear;
  Memo1.Lines.Add('Input str: "%s"', [lStr]);

  i := 0;
  while Length(lStr) > 0 do
  begin
    lOld := Length(lStr);
    lStr := SplitByChar(lStr, ',', lItem);
    if lOld = Length(lStr) then
    begin
      break;
    end;
    Memo1.Lines.Add('  %.2d/ extracted "%s", returned "%s"', [i, lItem, lStr]);
    Inc(i);
  end;
end;

end.


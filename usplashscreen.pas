unit usplashscreen;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, umainmenu;

type

  { TfSplash }

  TfSplash = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function StepMessage(): string;
  public

  end;

var
  fSplash: TfSplash;

implementation

{$R *.lfm}

procedure TfSplash.FormShow(Sender: TObject);
begin
  if not Timer1.Enabled then
  begin
    ProgressBar1.Min := 0;
    ProgressBar1.Max := 10;
    ProgressBar1.Position := 0;
    Label1.Caption := StepMessage();
    Timer1.Interval := 123;
    Timer1.Enabled := true;
  end;
end;

procedure TfSplash.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position >= ProgressBar1.Max then
  begin
    Timer1.Enabled := false;
    Application.UpdateMainForm(fMainMenu);
    fMainMenu.Show;
    Close();
  end;
  ProgressBar1.Position := ProgressBar1.Position + 1;
  if ProgressBar1.Position = 10 then
  begin
    Timer1.Interval := 1234;
  end;
  Label1.Caption := StepMessage();
end;

function TfSplash.StepMessage(): string;
begin
  result := '<nic>';
  case ProgressBar1.Position of
    0: result := 'Nacitam zaklad...';
    1: result := 'Overuju aktualizace...';
    2: result := 'Kontroluji herni data...';
    3: result := 'Nacitam konfiguraci...';
    4: result := 'Caching obrazku...';
    5: result := 'Nacitam herni engine...';
    6: result := 'Nacitam vlacky...';
    7: result := 'Nacitam trate...';
    8: result := 'Nacitam profil...';
    9: result := 'Pripravuji GUI...';
   10: result := '✅ Hra je vase!';
  end;
end;

end.


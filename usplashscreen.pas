unit usplashscreen;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, umainmenu;

type

  { TfSplash }

  TfSplash = class(TForm)
    Image1: TImage;
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
    Timer1.Interval := 543;
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
  Label1.Caption := StepMessage();
end;

function TfSplash.StepMessage(): string;
begin
  result := '<No Message>';
  case ProgressBar1.Position of
    0: result := 'Bootloader running...';
    1: result := 'Checking for updates...';
    2: result := 'Verifying game data...';
    3: result := 'Loading configuration...';
    4: result := 'Caching sprites...';
    5: result := 'Initializing game engine...';
    6: result := 'Loading trains...';
    7: result := 'Loading tracks...';
    8: result := 'Loading profile...';
    9: result := 'Preparing UI...';
   10: result := '✅ The game is yours. Enjoy!';
  end;
end;

end.


unit umainmenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  umain, uhelp, uabout, ututorial, utrains, utracks, udashboard, usettings;

type

  { TfMainMenu }

  TfMainMenu = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private

  public

  end;

var
  fMainMenu: TfMainMenu;

implementation

{$R *.lfm}

{ TfMainMenu }

procedure TfMainMenu.Button5Click(Sender: TObject);
begin
  Close;
end;

procedure TfMainMenu.Button6Click(Sender: TObject);
begin
  fDashboard.ShowModal;
end;

procedure TfMainMenu.Button7Click(Sender: TObject);
begin
  fTracks.ShowModal;
end;

procedure TfMainMenu.Button8Click(Sender: TObject);
begin
  fTrains.ShowModal;
end;

procedure TfMainMenu.Button3Click(Sender: TObject);
begin
  fAbout.ShowModal;
end;

procedure TfMainMenu.Button10Click(Sender: TObject);
begin
  fTutorial.ShowModal;
end;

procedure TfMainMenu.Button1Click(Sender: TObject);
begin
  Hide();
  fMain.ShowModal();
  Show();
end;

procedure TfMainMenu.Button2Click(Sender: TObject);
begin
  fSettings.ShowModal();
end;

procedure TfMainMenu.Button4Click(Sender: TObject);
begin
  fHelp.ShowModal();
end;

end.


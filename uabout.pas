unit uabout;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  lclintf;

type

  { TfAbout }

  TfAbout = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Label21Click(Sender: TObject);
  private

  public

  end;

var
  fAbout: TfAbout;

implementation

{$R *.lfm}

{ TfAbout }

procedure TfAbout.Label21Click(Sender: TObject);
begin
  if (not Assigned(Sender)) or (not(Sender is TLabel)) then
  begin
    showmessage('Uh-oh');
    Exit;
  end;
  OpenURL((Sender as TLabel).Caption);
end;

procedure TfAbout.Button1Click(Sender: TObject);
begin
  Close;
end;

end.


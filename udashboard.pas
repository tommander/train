unit udashboard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, uprofile, ucommon, LMessages;

type

  { TfDashboard }

  TfDashboard = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    ilTrains64: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListView1: TListView;
    ListView2: TListView;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter5: TSplitter;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public
    procedure RefreshUI();
  end;

var
  fDashboard: TfDashboard;
  boolRefresh: boolean;

implementation

{$R *.lfm}

{ TfDashboard }


procedure TfDashboard.ComboBox1Select(Sender: TObject);
var lStatus: TProfessionalStatus;
begin
  lStatus := TProfessionalStatus(ComboBox1.ItemIndex+1);
  theProfile.SetStatus(lStatus);
  RefreshUI();
end;

procedure TfDashboard.Button1Click(Sender: TObject);
begin
  RefreshUI();
end;

procedure TfDashboard.Edit1EditingDone(Sender: TObject);
begin
  theProfile.SetName(Edit1.Text);
  RefreshUI();
end;

procedure TfDashboard.FormCreate(Sender: TObject);
var i: TProfessionalStatus;
begin
  boolRefresh := false;
  ComboBox1.Items.Clear;
  for i := Low(TProfessionalStatus) to High(TProfessionalStatus) do
  begin
    ComboBox1.Items.Add(ProfessionalStatusLabel(i));
  end;
end;

procedure TfDashboard.FormShow(Sender: TObject);
begin
  Button1.Click;
end;

procedure TfDashboard.RefreshUI();
begin
  if boolRefresh then
  begin
    Exit;
  end;
  boolRefresh := true;
  try
    Label1.Caption := ProfessionalStatusLabel(theProfile.Status);
    ComboBox1.ItemIndex := Integer(theProfile.Status)-1;
    Label4.Caption := theProfile.Name;
    Edit1.Text := theProfile.Name;
    Label5.Caption := Format('%.2f FVM', [theProfile.Amount]);
    Label9.Caption := theProfile.GUIDStr();
    Label13.Caption := IntToStr(theProfile.StatPassengers);
    Label14.Caption := IntToStr(theProfile.StatMeters div 1000) + ' km';
    Label15.Caption := IntToStr(theProfile.StatDrives);
  finally
    boolRefresh := false;
  end;
end;

end.


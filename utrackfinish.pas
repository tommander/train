unit utrackfinish;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TfTrackFinish }

  TfTrackFinish = class(TForm)
    btnClose: TButton;
    Label1: TLabel;
    lblRating: TLabel;
    lblHeading: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lvFinances: TListView;
    pnlRating0: TPanel;
    pnlRating2: TPanel;
    pnlRating1: TPanel;
    Panel5: TPanel;
  public
    procedure SetRating(ARating: byte);
    //procedure SetStations(AStations: word; AStationRate: double);
    //procedure SetDuration(ADuration: word; ADurationRate: double);
    //procedure SetPassengers(APassengers: word; APassengerRate: double);
    //procedure SetFines(AFines: double);
    //procedure SetBonuses(ABonuses: double);
  end;

var
  fTrackFinish: TfTrackFinish;

implementation

{$R *.lfm}

procedure TfTrackFinish.SetRating(ARating: byte);
begin
  pnlRating0.Visible := (ARating = 0);
  pnlRating1.Visible := (ARating = 1);
  pnlRating2.Visible := (ARating = 2);
end;

end.


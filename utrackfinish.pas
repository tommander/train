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
  private

  public

  end;

var
  fTrackFinish: TfTrackFinish;

implementation

{$R *.lfm}

end.


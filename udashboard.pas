unit udashboard;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls;

type

  { TfDashboard }

  TfDashboard = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ListView1: TListView;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    ScrollBox1: TScrollBox;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
  private

  public

  end;

var
  fDashboard: TfDashboard;

implementation

{$R *.lfm}

{ TfDashboard }


end.


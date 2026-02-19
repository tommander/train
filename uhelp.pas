unit uhelp;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  RichMemo;

type
  TSubtopic = record
    strName: string;
    strContent: string;
  end;
  TTopic = class(TCollectionItem)

  end;

  { TfHelp }

  TfHelp = class(TForm)
    RichMemo1: TRichMemo;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    TreeView1: TTreeView;
  private
    var strSelected: string;
  public

//    procedure Refresh();
  end;

var
  fHelp: TfHelp;

implementation

{$R *.lfm}



end.


unit udebug;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls;

type

  { TfDebug }

  TfDebug = class(TForm)
    Memo1: TMemo;
    StatusBar1: TStatusBar;
  private

  public

  end;

var
  fDebug: TfDebug;

implementation

{$R *.lfm}

end.


unit utrains;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ucommon;

type
  TProfile = record
    strName: shortstring;
    strDrivID: shortstring;
    psStatus: TProfessionalStatus;
    crcWallet: Currency;
    crcPassengerRate: Currency;
    crcHourRate: Currency;
    // depot
    //
  end;

  TfTrains = class(TForm)
  private

  public

  end;

var
  fTrains: TfTrains;

implementation

{$R *.lfm}

end.


unit uprofile;

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

  TfProfile = class(TForm)
  private

  public

  end;

var
  fProfile: TfProfile;

implementation

{$R *.lfm}

end.


program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  SysUtils,
  Forms, umain, uengine, //Unit2,
  DateUtils, utrackfinish, umainmenu, usplashscreen,
udashboard, ucommon,
  udebug, uabout, uhelp, ututorial, usettings, uversionhelper,
uprofile, utrainmgr, utrackmgr, udrivestart;

{$R *.res}
begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}

  Application.Initialize;
  Application.CreateForm(TfMainMenu, fMainMenu);
  Application.CreateForm(TfSplash, fSplash);
  Application.CreateForm(TfDashboard, fDashboard);
  Application.CreateForm(TfTrackFinish, fTrackFinish);
  Application.CreateForm(TfDebug, fDebug);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfHelp, fHelp);
  Application.CreateForm(TfCertification, fCertification);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TfDriveStart, fDriveStart);
  Application.CreateForm(TfMain, fMain);

  fSplash.ShowModal();

  InitTrains();
  InitTracks();

  theProfile := TProfile.Create();
  theProfile.LoadFromFile(AppDir('profile.dat'));
  if IsEqualGUID(theProfile.GUID, GUID_NULL) then
  begin
    //show welcome message
    theProfile.GenerateGUID();
    theProfile.SetName('Anonym');
  end;

  try
    //fMain.RefreshUI();
    Application.Run;
  finally
    try
      if Assigned(sim) then
      begin
        sim.Free();
      end;
      if Assigned(theProfile) then
      begin
        theProfile.SaveToFile(AppDir('profile.dat'));
        theProfile.Free();
      end;
    finally
      sim := nil;
      theProfile := nil;
    end;
  end;
end.


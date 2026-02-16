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
  Forms, umain, uengine, //Unit2,
  DateUtils, utrackfinish, umainmenu, usplashscreen,
udashboard, ucommon, utrains,
  udebug, uabout, uhelp, ututorial, utracks, usettings, uversionhelper;

{$R *.res}
var LNow: TDateTime;

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
  Application.CreateForm(TfTrains, fTrains);
  Application.CreateForm(TfDebug, fDebug);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TfHelp, fHelp);
  Application.CreateForm(TfTutorial, fTutorial);
  Application.CreateForm(TfTracks, fTracks);
  Application.CreateForm(TfSettings, fSettings);
  Application.CreateForm(TfMain, fMain);

  Application.Title := AppTitle();
  fMain.Caption := Application.Title;
  fMainMenu.Label1.Caption := GetExecVersion().strFileVersion;

  fSplash.ShowModal();

  sim := TSimulation.Create();
  sim.SetMass(20000);
  sim.SetMaxPower(155000);
  sim.SetMaxBrake(20000);
  sim.SetMaxForce(28000);
  sim.SetMaxVelocity(80, true);
  sim.SetBrakeElmagControl(1);
  sim.EValueChangedDouble := @fMain.SimOnValueChangedDouble;
  sim.EValueChangedString := @fMain.SimOnValueChangedString;
  sim.EValueChangedInteger := @fMain.SimOnValueChangedInteger;
  sim.EValueChangedBoolean := @fMain.SimOnValueChangedBoolean;
  sim.EValueChangedDateTime := @fMain.SimOnValueChangedDateTime;
  sim.EValueChangedTunnel := @fMain.SimOnValueChangedTunnel;
  sim.EValueChangedInteriorLights := @fMain.SimOnValueChangedInteriorLights;
  sim.EValueChangedTrainLights := @fMain.SimOnValueChangedTrainLights;
  sim.EValueChangedDoorStatus := @fMain.SimOnValueChangedDoorStatus;
  sim.EValueChangedTrainRangeControl := @fMain.SimOnValueChangedTrainRangeControl;
  sim.EValueChangedTrainDirection := @fMain.SimOnValueChangedTrainDirection;

  try
    LNow := VirtualNow();
    fMain.BlockSort();
    fMain.AddStation(Station('Stanice A 000-80-2', LNow,                IncMinute(LNow,  5), 0,   80, 2));
    fMain.AddStation(Station('Stanice B 200-40-3', IncMinute(LNow, 15), IncMinute(LNow, 20), 200, 40, 3));
    fMain.AddStation(Station('Stanice C 500-01-1', IncMinute(LNow, 30), IncMinute(LNow, 35), 500,  1, 1));
    fMain.AddStation(Station('Stanice D 765-50-8', IncMinute(LNow, 50), IncMinute(LNow, 55), 765, 50, 8));
    fMain.UnblockSort();

    fMain.RefreshUI();
    Application.Run;
  finally
    try
      if Assigned(sim) then
      begin
        sim.Free();
      end;
    finally
      sim := nil
    end;
  end;
end.


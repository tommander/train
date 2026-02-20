# Trains

This is a train simulator written in FreePascal using gtk2 and Lazarus 4.4.0 on Debian amd64. I haven't tested it anywhere else.

**TL;DR:** Not even alpha version yet, but driving is kinda safe to try. Hint: turn on main switch, click - on brake, then you are free to go.

Current status:

* Physics engine is minimum implementation, but works fine
  * Train has a simplified resistance as $A + BV + CV^2$ ($V$ in `km/h`)
  * Tracks have slope, tunnel and arc resistance
  * Forward/backward movement feels sufficiently real for now
  * There is maximum force, maximum power and maximum speed
* Stations (everything works)
  * Stations have position, name, planned/real arrival/departure, max passengers, some parameter
  * Passengers in/out are computed using Gaussian - max passengers ($a$), time ($x$), 12 (as in 12:00, $b$), "some parameter" ($c$) in $ae^\frac{(x-b)^2}{2c^2}$
* Doors (everything works)
  * Doors open only within 10m of the station point
  * Doors have an "animation"
    * When they're closed, they first go into "opening" state and automatically switch to open after some predefined time.
    * Upon opening, the train locks (can be unlocked) and waits for some time, depending on how many people get on/off the train. At the end, it shows "Free to go" message
    * When they're open, they go to "alarm" state, after another click "closing" and after predefined time, automatically "closed".
    * Power control does not work if the door are not closed
* UI
  * All forms created, some are empty
  * Splash screen is just using timer for now
  * Main menu - all buttons work
  * Main form (drive)
    * All controls work except for dynamic brake and air brake.
    * All status components - the same as controls
    * Basically - you can drive from station to station, get people, have the real arrival / departure, and at the end, there is a Congrats dialog.

Documentation and some more structured and useful info will follow soon; there are frequent changes in the code at the moment.

Graphics so far:

* Some ugly LLM-generated graphics for the logo and main menu (will be replaced asap)
* OTOH a beautiful [photo by Zetong Li](https://www.pexels.com/photo/railroad-neat-the-coast-13135150/) as a placeholder for driver's view.

## Roadmap

There might be a lot missing here, so this is not a final roadmap.

| | |
| --- | --- |
| 🟡 | Physics engine | 
| 🔴 | Graphics (camera view) | 
| 🔴 | Graphics (other) | 
| 🟡 | Controls (GUI) | 
| 🔴 | Controls (keyboard) | 
| 🔴 | Profile | 
| 🔴 | Financial System | 
| 🔴 | List of trains | 
| 🔴 | Train definition | 
| 🔴 | List of tracks | 
| 🔴 | Track definition | 
| 🔴 | Settings | 
| 🔴 | Loading / saving files | 
| 🔴 | Help | 
| 🔴 | Tutorial | 
| 🔴 | Dashboard | 
| 🔴 | Conditions for professional statuses | 
| 🔵 | Minimap | 
| 🔴 | ... | 

🔴 Not implemented
🟡 Works, but it's a minimum implementation
🟢 Done with minimal bugs
🔵 In progress

# SleighRide
This is a 3D visualization written in POV-Ray that involves extending a slapstick instrument to a certain angle such that when released, it will make an impact in exactly .5 seconds, in unison with the final note.

# Rendering
- **Prerequisites:**
  - POV-Ray v3.1 or higher must be installed
### Windows and Mac
  1. Install the official [POV-Ray editor for Windows](http://www.povray.org/download/) or the unofficial [MacOS Port](http://megapov.inetart.net/povrayunofficial_mac/index.html) (Mac)
  2. Ensure slapstick.ini and slapstick.pov are in the same directory
  3. Open slapstick.ini in the editor and press "Run"
  4. Make yourself a cup of coffee because it may take awhile to render

### Linux
  1. Install POV-Ray using your distro's package manager or the [tarball for version 3.6](http://www.povray.org/download/index-3.6.php)
     ```bash
     sudo apt -y install povray
     ```
     ```bash
     sudo pacman -S extra/povray
     ```
     ```bash
     sudo emerge media-gfx/povray
     ```
   2. cd into the directory containing slapstick.pov and slapstick.ini
   3. Render the animation
      ```bash
      povray slapstick.ini
      ```
   4. Refer to step 4 for Windows and Mac

# Post-Processing
  
     

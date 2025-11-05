# fmw_patches
WIP Patch Repository for Fantasy Maiden Wars Complete Box - Dream of the Stray Dreamer

Latest modding version: **1.2.2.4**

# Instructions
1. Download [Delta Patcher](https://www.romhacking.net/utilities/704/) to apply the `*.xdelta` patches in this repo. Each folder corresponds to the original version of the game; download the patches in the folder that apply to your current game version.
2. Download the mods folder and place it inside your user FMW app data folder for `fmw_dosd` (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\`). The game will read this folder to access all json files that contain the EXE mods.
3. Browse your local files for your installation of FMWCB - DSoD from Steam.
4. Make a copy of your original `data.win` file; rename the old file to `data_old.win`.
5. In Delta Patcher, select the `*.xdelta` patch to apply to your `data.win` file. Make sure the output file is renamed to `data.win` and its destination is the same folder as the `fmw_dsod.exe`.
6. Patch should be applied, and the new changes will take effect next time you play the game.
7. If anything fails in prev steps, restore from the original `data_old.win` and rename it to `data.win`.

# Modding UI
The new modding UI interface can be accessed from the GlobalMenu (where the manual, settings, and return to title screen options are located). The interface allows for real-time toggling of mod options, and changes will be immediately reflected in the json files corresponding to each mod in `C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\mods`. In the future, once a better mod loader/patcher has been implemented, it should be possible to integrate code changes without constant xdelta patching.

# TODO
- Future mod loader implementation
- Plugins
- Improve Patching Framework

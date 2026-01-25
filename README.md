# fmw_patches
WIP Patch Repository for Fantasy Maiden Wars - DREAM OF THE STRAY DREAMER -

Latest modding version: **1.2.3.3a**

# Instructions
1. Download [Delta Patcher](https://www.romhacking.net/utilities/704/) to apply the `*.xdelta` patches in this repo. Each folder corresponds to the original version of the game; download the patches in the folder that apply to your current game version.
2. Download the mods folder and place it inside your user FMW app data folder for `fmw_dosd` (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\`). The game will read this folder to access all json files that contain the EXE mods.
3. (Optional, but very helpful) Download the addOns folder and place it inside your user FMW app data folder for `fmw_dosd` (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\`). The addOns for each data file allow you to add new json structure entries that correspond to individual spreadsheet rows for each data file. Basically, this lets you patch and add in-memory data file structures with your own custom fields.
4. Browse your local files for your installation of FMWCB - DSoD from Steam.
5. Make a copy of your original `data.win` file; rename the old file to `data_old.win`.
6. In Delta Patcher, select the `*.xdelta` patch to apply to your `data.win` file. Make sure the output file is renamed to `data.win` and its destination is the same folder as the `fmw_dsod.exe`.
7. Patch should be applied, and the new changes will take effect next time you play the game.
8. If anything fails in prev steps, restore from the original `data_old.win` and rename it to `data.win`.

# Modding UI
The new modding UI interface can be accessed from the GlobalMenu (where the manual, settings, and return to title screen options are located). The interface allows for real-time toggling of mod options, and changes will be immediately reflected in the json files corresponding to each mod in `C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\mods`. In the future, once a better mod loader/patcher has been implemented, it should be possible to integrate code changes without constant xdelta patching.

# TODO
- Future mod loader implementation
- Plugins
- Improve Patching Framework

# Patch Information
This repository contains xdelta binary patches.
These patches do not include any copyrighted game data.

You must own a legitimate, unmodified copy of the game to use them.

Fantasy Maiden Wars - DREAM OF THE STRAY DREAMER - and all related assets are © their respective owners.

This project is not affiliated with or endorsed by the developer or publisher.

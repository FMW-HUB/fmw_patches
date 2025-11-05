###1.2.2.4###
- Update modding menu UI framework to accept mod jsons that edit numerical and text values
  - Display new popup window for accepting user input
  - Text mods have no length limit for input, but input cannot be empty; this is to prevent potential crashes.
  - Numerical mods have a minimum and maximum value defined in the json; input cannot exceed these boundaries and the game will throw an error message otherwise. This is to prevent crashes, however the minimum and maximum values can still be edited from the json on the user's end. Be careful if you try to modify these values outside the default safe boundaries.
- Text: Change the global variable for the army name at any time. Due to the way the game reads the army name, you will need to set this through the modding menu, and create another save file for the new army name to be permanently written into your save.
  - Additionally, the text prompt for inputting the army name on Chapter 71's intro has been restored. By default, the army name prompt will be set to "Fantasy Maiden Wars". Easter egg responses are currently not available; this requires a change to the data resource files for them to display properly.
- Number: Edit deployment cost for the intermission and the map unit selection screen. Set to -1 for default chapter cost, or 500 or higher for infinite cost. Reload your saves for the updated cost to apply. 
- Toggle: Change whether to display the HP/MP bar during battle animations
- Toggle: Change whether to display the message window during battle animations

###1.2.2.3###
- Fix animation issues for Sakuya's World and Private Square from faulty UTMT compilation.
- Add back "Private Square" animation text.

###1.2.2.2###
- Batch mod updates when exiting from mod screen instead of modifying json file per update
- Implement fallback to handle cases where mod files are not found to set global vars
- Handle edge case when no mod file is found in `mods` folder

###1.2.2.1###
- Init patch for prototype mod file framework with modding menu UI
- Toggle: Restore +5 initial Power bonus for 50 kills and #1 Ace kills
- Toggle: Display Friendship Level of current frontline and/or backline unit in Battle Info
- Toggle: Disable level up jingle SE
- Toggle: Translated Debug Menu, enable debug menu as option (Need to exit the GlobalMenu and re-enter it to see the debug option pop up; this is currently how the game loads this option by mod) (DISCLAIMER: Make frequent backup saves. The DebugMenu may not be fully stable when modifying in-game save values and may crash on unexpected actions. I am not responsible for any unintended consequence on your saves. Better to be safe than sorry.)
- Fix backline unit effects not activating due to missing pilot/unit_code update, like Ran's 1.5x/2x multiplying PSes
- Restored FMW1 Private Square dodge animation
- Restored Sakuya's World animation:

  - Fully darkened background before spell ring appears as in the OG animation.
  - Reverted Switch change and reduced saturation of knife auras so that each knife appears clearly in set up.
  - Reverted Switch change and ensured Sakuya is drawn at a lower depth to appear in front of the knives.
  - Restored afterimage trails present in the original animation when Sakuya moves among the 5 locations for placing knives.
  - Knife collapse animation portion used to prematurely draw opponent in the middle of knives. Reverted Switch change to draw opponent sprite behind knives and slash effects.
  - Inserted grayscale effect in animation. gpu_set_blendmode_ext is bugged when compiled in UTMT's GML compiler; 50% of the src/dest blending options do not work. Atm, I can't get the desired blending equation to preserve the present hue and alpha of the opponent sprite like in the old animation. Until this is fixed in the modding tool, the grayscale effect will need to be applied to the whole screen without the hue and alpha blending option.







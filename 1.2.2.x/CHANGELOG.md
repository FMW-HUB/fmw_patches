###1.2.2.5b hotfix###
- Fix instance variable initialization crash when bullet objects are created. Certain animations spawn generic bullets that need to have certain variables set to work with Private Square.
- Fix race condition bug caused by referencing the green screen object instance after it is destroyed. This crash can occur right before the animation for Private Square finishes. so there is a check now for whether the instance exists to avoid the bug. 

###1.2.2.5a hotfix###
- Fix instance variable initialization crash when Sakuya grazes during Private Square. This bug was caused by certain variables not being set when the game attempts to draw the damage numbers during the Graze portion of Private Square.

###1.2.2.5###
- Toggle: Restore FMW4 SP mechanics. This is an involved fix: 
  - The SP Regen skill only works in 1st 10 turns for player and enemy. SP Regen+ is untouched as it's an enemy-only skill.
  - Disable the universal +10 SP Regen for all player units. This includes singular units, units in a team, sub-units in Palanquin Ship and/or Unzan, and combined units. Enemy units still have the base +10 SP Regen as in FMW4.
  - Player SP is no longer halved at the start of a chapter.
  - Regen functions are updated to display the new SP regen values with these changes. 
  - Reload your saves to update SP mechanics on various screens. Ideally, you should start chapters with the mod turned on. It can work in the middle of the chapter, but not everything will be updated for SP mechanics.

- Toggle: Display parry, shield defense, and counter chances of the current ally and enemy frontline units in Battle Info. The text will dynamically appear and/or resize depending on the probability of each rate, i.e. if the enemy cannot counter in the case that an ally team launches an FPM attack, the counter chance text will never appear.

- Toggle: Stop PP-invested Skill stat points from increasing the enemy's shield defense activation chance. This is a mechanic since the original FMW3 that has always been an unusual interaction. It stands in stark contrast to the enemy Parry formula, which does get intuitively reduced if a player unit has Skill stat points from invested PP. The displayed shield defense chance will also update with this fix if that mod is available.

- Toggle: Disable casting spirits in the Battle Info screen. Both the button shortcut and UI option in Battle Info are disabled.

- Toggle: Fix infinite turns bug with combined units by tracking turn count between splitting and recombining. This stops the Doorway to Dreams item and the +1 action from MAX EX investment from giving infinite turns to combined units. This may not be stable if toggled repeatedly throughout a chapter; it would be best to turn this on before the start of a chapter. This does not fix splitting and recombining refreshing the effect of the Exceeded Eternity item. A future mod will fix this; this is more involved as the game fills a global buffer that keeps track of which units have or have not activated the item. Thus, the fix will need to rework the integrated logic for the item.

- Fix modding menu bug where toggling a mod would not update the internal global variables if the mod value was marked as unchanged.
- Fix Blossoming of Gensokyo's animation to get the correct sky background on Chapter 75.
- Fix instance variable initialization bugs for Private Square that could cause crashes against certain enemy attacks.

- Set foreground layers in the battle animation for Sakuya's World to be transparent, just like the animation in the OG games. Ideally, I would try to improve the animation by blending the foreground layers with grayscale colors. However, compiled graphical functions with UTMT are still buggy and the foreground layers do not lend well to using the GPU blend modes to change their colors. Once the modding tool improves, this could be a future improvement to be made.

- Fix deployment cost editor mod to use default cost in resource files if it equals 0. This prevents potential locks barring player progression if the chapter is hard set to use 0 default cost.

- Set the window caption to display the current modding version. This is now added after the title "Fantasy Maiden Wars - Dream of the Stray Dreamer -".
- Fix RNG bug that prevented the loading screen from randomly displaying either the sweeping Reimu sprite or the flying Marisa sprite.

###1.2.2.4###
- Update modding menu UI framework to accept mod jsons that edit numerical and text values
  - Display new popup window for accepting user input
  - Text mods have no length limit for input, but input cannot be empty; this is to prevent potential crashes.
  - Numerical mods have a minimum and maximum value defined in the json; input cannot exceed these boundaries and the game will throw an error message otherwise. This is to prevent crashes, however the minimum and maximum values can still be edited from the json on the user's end. Be careful if you try to modify these values outside the default safe boundaries.
- Text: Change the global variable for the army name at any time. Due to the way the game reads the army name, you will need to set this through the modding menu, and create another save file for the new army name to be permanently written into your save.
  - Additionally, the text prompt for inputting the army name on Chapter 71's intro has been restored. By default, the army name prompt will be set to "Fantasy Maiden Wars". Easter egg responses are currently not available; this requires a change to the data resource files for them to display properly.
- Number: Edit deployment cost for the intermission and the map unit selection screen. Set to -1 for default chapter cost, or 500 or higher for infinite cost. Reload your saves for the updated cost to apply.
- Number: Force suspend dialog to play a specific entry with an entry number of your choosing. Set to -1 for the default, chapter-dependent suspend save behavior. Suspend save entry numbers are indexed from 0, so dialog 20 in the Library would correspond to an internal entry number of 19; this will be the number you set in the modding menu to play dialog 20.
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
- Fix backline unit effects not activating due to missing pilot/unit_code update.
  - List of effects impacted by this bug:
    - Satori's Recollection boosts
    - Patchouli's Unmoving Library
    - Hina's Centrifrugal Force
    - Mima's Ancient Moon ability
    - Rearguard Sanae's Faith buffs
    - Shou's MP cost reduction PS
    - Marisa's Orreries Sun ability
    - Ran's Nine-tail PS
    - Reimu's Fantasy Nature
    - Utusho's Limiter Release buffs
    - Patchouli's Philosopher's Stone
- Restored FMW1 Private Square dodge animation
- Restored Sakuya's World animation:

  - Fully darkened background before spell ring appears as in the OG animation.
  - Reverted Switch change and reduced saturation of knife auras so that each knife appears clearly in set up.
  - Reverted Switch change and ensured Sakuya is drawn at a lower depth to appear in front of the knives.
  - Restored afterimage trails present in the original animation when Sakuya moves among the 5 locations for placing knives.
  - Knife collapse animation portion used to prematurely draw opponent in the middle of knives. Reverted Switch change to draw opponent sprite behind knives and slash effects.
  - Inserted grayscale effect in animation. gpu_set_blendmode_ext is bugged when compiled in UTMT's GML compiler; 50% of the src/dest blending options do not work. Atm, I can't get the desired blending equation to preserve the present hue and alpha of the opponent sprite like in the old animation. Until this is fixed in the modding tool, the grayscale effect will need to be applied to the whole screen without the hue and alpha blending option.













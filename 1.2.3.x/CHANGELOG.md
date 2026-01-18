###1.2.3.3###
- Implement LayeredFS loading for unit portraits.
  - To replace unit portraits, create a new `data2-1` folder in your `modData` folder and insert your portraits respective to the character you want to modify using the filename pattern `face_<CHAR_ID><PORTRAIT_ID>.png`. For example, `face_Nitori0a.png` is a valid replacement.

- Implement folder searching for the `mods` folder. Now you can easily organize all the json mod files into multiple folders that can be named in whatever way you'd like. This only searches through 1 subfolder level at the moment. For example, you can make a folder called `AudioVisual` and place it in your `mods` folder, then move your json files into the `AudioVisual` folder. Your folder structure would then look like `mods/AudioVisual/*.json` for your files. The `mods` folder in the repo has been updated with default folders; from now on, any newer mod that is developed will be organized into these folders. Once you download any of these json files, feel free to organize them however you'd like.
  - There is one small exception: The `ChangeArmyName.json` mod needs to be put in this folder path in order to update properly: `mods/Visual/ChangeArmyName.json`. In the future, this will be updated to not require an explicit folder path.
  - Use `LB` and `RB` in the modding menu to cycle through each page that corresponds to one of your folders in `mods`.
 
- [Toggle|Bugfixes] Fix animation choreography for spirit casting. Originally, spirit animations were played at 30 FPS by default in the OG FMW games. The sound effects for these animations were made to match this frame speed to sync the timing correctly in the choreography. However, CB now plays spirit animations at 45 FPS. Often at times, you will find that the spirit animation completes before the SE has finished playing. With this mod, the frame speed is now toggleable to be restored to the original 30 FPS. In addition, when the spirit casting animation is sped up, the mod retains CB's original speedup at 45 FPS, so you will not be compromised with slower gameplay animations.

- [Toggle]Mechanics] Restore the ability for enemies to deal critical hits. Additionally, the enemy's final critical rate is halved in the critical calculations like in most versions of the OG FMW games.

- [Toggle]Mechanics] Restore MP cost for movement in Air Terrain. The Shimenawa also regains its original effect to nullify MP cost for movement in Air.

- PSes (Update your addOns folder for `Data_Skills` and `data_char_skill_all`):
  - [NEW|Alice] Trip Wire L1/2/3/4
  ```
  Increases Seeker Wire's ATK by <100|200|300|400> and Range by +<1|1|2|2>.
  Lv. 2/3: In addition, Alice can chain an extra 1 doll in Seeker Wire's path.
  Lv. 4: In addition, Alice can chain an extra 2 dolls in Seeker Wire's path. Finally, increases the number of uses of Create Doll (Hourai) by +1.
  ``` 
  - [RESTORED|Aya|FMW4] Sarutahiko's Guidance
  ```
  At 120+ Power, unit's pair gains +10% evasion rate and +1 Unfocused Move.
  ```
  - [RESTORED|Kogasa|FMW4] Nanny's Parasol
  ```
  50% of the damage taken by the frontline unit is shared with the backline unit.
  This applies to both units in the pair but does not work during Graze.
  Ineffective if the backline unit is shot down or the shared damage exceeds the backline unit's HP.
  ```


- Add special functionality for this prepended text `***` for `WepShape` property in `data_weapon_all.txt`. By adding `***` to the beginning of the WepShape text that defines the range/type of a MAP attack, you can specify units in the `WepEffect` property to exclude from the MAP attack targetting. Basically, this will let you have fine-grained control for Friendly Fire on specific units.

- Add FMW1 demo Meditation Slash animation script. Use the internal name `danmeiken_old` to see it in your modded weapon files.

- Add FMW1 Beta Flight of Idaten animation script for Chen. Internal Name: `idaten_old`

- Add FMW1 Beta Bakeneko [Chen] animation script. Internal name: `Chen_old`

- Fix massive legacy FMW4 weapon paging bug for characters with 9 or more weapons.
  - In summary, FMW4 used to accommodate large weapon lists (9+ weapons) in the UI by splitting the weapon status into multiple pages displaying 8 weapons in the current viewed chunk. However, CB removed the paging functionality in the UI and now displays all weapons on a single page. Unfortunately, the internal paging logic that organizes the internal weapon lists was not updated to account for this.
  - This bug is extremely detrimental to Reimu/Marisa, who in their final forms have more than 8 weapons and heavily suffer from this bug. This bug is responsible for unusual interactions when selecting weapons. For example, sometimes you want to select the strongest weapons for Reimu/Marisa, the game will autoselect the incorrect weapons and direct the cursor to the top of the screen. This is the game trying to invoke the legacy paging logic by resetting the cursor to the top as if the player proceeded to view the next weapon page.
  - In addition, there's now no logic to reset the internal index pointer that's used in the Support Attack weapon UI. If you go in and out of the Support Attack weapon UI menu with a character thats affected by this bug, you can keep infinitely increasing the index pointer and cause and array out-of-bounds error when returning to the main character's weapon selection.
  - In the modding plane, it will be simply unsustainable to leave this bug alone, as more weapons are added to new custom characters. So, it is a must to solve this bug at the current time. A future enhancement will also revamp the paging logic to allow more weapons to be displayed in-game.


- Fix SE choreography in Proto Malice Cannon's animation to only play the SE for Alice's laser and Marisa's Magic Missiles when they've finished speaking their preliminary lines.

- Fix background color bug for animation for Sakuya's World not resetting to the default black background. Some animations in the game set the background color without reverting it once the animation completes. This could cause Sakuya's World to display incorrect background colors that would override the grayscale image displayed after the time stop flash. Thus, the animation for Sakuya's World now always returns the background color to the default black to avoid this bug. Specifically, Remilia's Red the Nightless Castle was a relevant culprit for this bug that would cause Sakuya's World to become completely opaque and white.
  
###1.2.3.2###
- Implement addOn support for Data_Change in data5-4. Make sure to remove the dummy Data_Change addOn in your current files since the game will now try to read from the Data_Change folder. The new addOn `Form_FlagID_Fix.json` uploaded to this repo is an important one: This fixes the Route B form availability bug by rewriting the Data_Change file and internal game logic for checking the ROUTE_B and Classic form flags before proceeding to update either character.

- Implement addOn support for `_anime.json` in dat. This file defines the frame chroreography for all sprite resource files in `data2-2` and `data2-3`. This is required when adding new files in `data2-2` and `data2-3` that will be used for any animation in the game. For the list of fields and what they do:
  - Top level and "src" fields is usually your sprite file name without the extension.
  - "n_frames" is the number of frames your sprite strip image is split into. 
  - "index" is the list of frames the game will play in order at each frame timestep.

- Implement LayeredFS loading for idle sprites, field sprites (uniticon), and spirit data file resources. Replace these in the following folders.
  - For idle sprites, replace the files in data2-2.
  - For field sprites, replace the files in data8.
  - For spirit sprites, replace the files in data8.

- Implement custom drawn modding UI input screen instead of using the synchronous `get_string` and `get_integer` functions. This should eliminate any further infinite loop bugs from inputting new numerical/text values in the modding menu.

- Add FMW1 demo Half-ghost animation script. You can see this animation by overriding an animation for a weapon with the internal name `hanrei_old`.

- Enable latent stat growth curves for `ATP_LATE`, `MGR_LATE`, `ALL_LATE`. These can now be used with other units from this version forward.

- Fix blue aura not being drawn in front of enemy during Eternal Meek if the enemy has too large of a sprite.

- Fix gamebreaking quicksave bug for Noblesse Oblige caused by passing an incompatible text data type instead of a number for tracking the barrier effect for units on adjacent tiles. Please redownload the `NoblessePS.json` AddOn in `Data_Skills` and update to 1.2.3.2 to fix this bug.

- Fix Meditation Slash and Eternal Meek animations failing to completely split enemy sprite in half for sprites that are larger than 128x128 pixels.

- Fix the floatmenu text positioning displaying "Focus/Switch/Unfocus" on the map. There is no longer any redundant whitespace between text and button icons, and the UI now matches up similarly to the JPN version.

- Fix screen darkening during support action selection not covering the whole screen as it should due to a x-position scaling bug.

- Pre-allocate 12 slots in memory instead of 11 for the nested weapon availability list to accommodate Toyohime's quantum superpositioning technique opening 11 support action slots in the Battle Info screen. This fixes the crash that can happen if say, 11 support attackers are actively available for selection in the Battle Info screen.

- Fix Weapon ATK bug that caused Limiter Release Utsuho's weapon list to become scrambled out of order if an item that boosted Weapon ATK was equipped on her. This is a simple fix to call the sort weapon function after Limiter Release is activated.

- Fix Radiator Pack PS bug that did not lower Heat costs when equipped on Utsuho. Originally, Heat costs were directly read from the Weapon Properties section. However, these were later refactored into the Special effects field for weapons that would apply unique effects depending on the weapon. The internal game logic had not updated to account for this refactoring; this fix applies the analogous change to read from the Special effects field to lower Heat costs.

- Disable the FMW4Youmu custom character for NG+ carryover as she could cause currently unknown crashes.

- Toggle: Restore the Weapon Range of Waveguider Fan to the version present in early FMW4 patches. Enjoy a MAP attack that completely outranges High Giga Cannon Giga Flare by default.

###1.2.3.1###
- Implement addOn support for Data_Spirits in data5-4. Make sure to remove the dummy Data_Spirits addOn in your current files since the game will now try to read from the Data_Spirits folder.
  - Add Data_Spirits addOn to display N/A spirits for units that the "NA" spirit in their character data. The Evil Eye, Kedama, and Makai Insect char addOns in data_char_all have been updated to use the NA spirit.
 
- Implement FMW4 Youmu as another custom unit addOn in the repo. Remember to enable the character by setting the "Enabled" field to `true` for the respective `Data_IsIN`, `data_unit_all`, and `data_char_all` addOns.

- Toggle: Display the number of actions that frontline/backline units have remaining in the unit subwindow. This will be useful for simply checking your unit's actions without needing to memorize their EX, DtD, Zeal set up. Later on, this will be immensely useful for debugging QoL when giving units extra actions and confirming assumptions.

- Toggle: Fix dialog bug where the transformations for Keine/Byakuren/Lily White would display their UnitIDs instead of their normal names. This was a running bug that was seen in early fan-localization efforts since the original FMW3. When the game reads from the text script files, it reads in each line including the portion before the ":"; this portion is the name used to fetch the correct portrait sprite. Now, there is specific logic in the game that is supposed to update these portrait sprite names if a transformation has taken place. There are 3 transformations that are subject to this code logic: Hakutaku Keine, Superhuman Byakuren, and Lily Black. The game will search the map to see if any of these transformations are active and will apply the portrait sprite name update.

  - Let's use Keine as an example. She has two sets of portraits sprites tied to her UnitID: KeineXX for her normal form and KeineHXX for her Hakutaku form. When she transforms on the map, the game will now dynamically update every line of the text script to use KeineH instead of Keine for the portrait sprite. The Hakutaku portrait sprite should then correctly appear in the chat window.

  - The code to do this is very simple.
    1. Do the following for every line of the game script if Keine is transformed.
    2. Parse the line, and replace every instance of text containing `KeineH` with `Keine`.
    3. Then, replace the *first* instance of `Keine` with `KeineH`.
    4. Hopefully, the portrait sprite correctly updates with Hakutaku Keine's face.

  - If you look closely, you can see a bug that can happen in certain circumstances that causes the UnitID to be displayed in the chat window. So far, the game has assumed that the text `Keine` appears only once and specifically in the portrait sprite name. This makes sense in the JPN version: There should never be any English text for `Keine` except in the portrait sprite.

  - Now in an English translation, for obvious reasons, the text `Keine` will appear much more frequently, especially in the actual dialog displayed in the window. What happens if the text `Keine` isn't present in the portrait sprite name, but appears in the dialog after? If this happens, then the previous logic will see that first instance of `Keine` inside the dialog and replace that with `KeineH`, leading to the UnitID dialog bug for these transformed units.
    - The fix for this simply looks inside the portrait sprite portion of the text script line, and then does a dummy replacement to replace the UnitID in the portrait sprite name with blank text. This is done so we're just left a dummy test string with only the extra modifiers for the portrait sprite name, like N for Nightmare units, and XX as the ID for the specific face sprite group. If the dummy test string is any length aside from 2, that means the original portrait sprite name does not have an exact matching instance for the UnitID; this means there are extra modifiers. And if there are extra modifiers, then we shouldn't replace the text inside the portrait sprite name since it's either A) a unit with a different form like KeineH for a transformation, or B) it's a unit with a nightmare form, like ByakurenN.
    - Because we are only looking at the portrait sprite, there's no risk that the dialog runs into unnecessary replacements with the UnitID. Additionally, this also fixes the ??? portrait for ByakurenN if player Byakuren is transformed. It's a similar replacement bug where ByakurenN is replaced with ByakurenHN for the portrait sprite name. There's no valid portrait with the ByakurenHN name, so the default ??? portrait is returned.

- Toggle: Dynamically update the values calculated for regen throughout various UI menus. Previously, regen values would only update when reloading a save in the Intermission, or in most circumstances on a chapter map. This mod now updates regen calculations in every instance that a unit would gain or lose regen, such as equipping or removing items, equipping certain skills, or even upgrading units and increasing their base HP/MP values.

- Toggle: Restore the display for terrain icons in the unit subwindow. You can now instantly see what terrain units are in on the map by looking at the subwindow instead of the unit sprite animations/position.

- Toggle: Display whether the Exceeded Eternity item effect is active in the unit status screen. The text "Active/Inactive" will now be displayed next to the item name. The "Active" status accounts for meeting all the conditions for EE, i.e. the unit is at 120 or above Power and has not yet activated the effect within the current turn. "Inactive" accounts for all other scenarios where the item will not give the unit an extra turn.

- Toggle: Restore the purple-colored text for Full Power Mode in the unit command menu. This used to be displayed in this way back in FMW4, but in PC CB and later versions, the drawing functions removed color blending options for text.


- Add guardrails to the Debug Menu when executing the Stage End (Internal to the debug menu) and Forced Game Over (newly added) commands only in the Player Phase. To specify, there is a Stage End command that used to be activated by pressing the View button (the same button used to open the GlobalMenu). However, this would bug out if you pressed it and then backed out of the Debug Menu without pressing confirm. Now, there is a new window prompt that asks the player whether they would like to immediately end and clear the stage.
  - With the current changes, the button mappings for the Stage End and Forced Game Over commands have been changed; these can be executed while the cursor is not on the confirm button on the Debug Menu:
    - View button: Execute a Forced Game Over with a window prompt. If "Yes" is selected, the game will immediately transition to the Game Over screen and the chapter will restart.
    - Menu (or the button combined with L+R for a soft reset) button: Execute a Stage End with a window prompt. If "Yes" is selected, the game will move to the Stage Clear event dialog, then as usual, the Stage Clear results screen will come up, and the player will transition to the Intermission.
   
- Fix regen calculation bug where an incorrect function call for `ds_list_find_index` was used to retrieve the ItemID position from the object list instead of the value. To get the value, this was changed to `ds_list_find_value`. This specifically affected the items that would give regen, such as the Sunflower, Mini Reactor, Ibuki Gourd, etc., and would cause them to not factor in the calculated regen value.

- Fix wildcard for reading the dialog_text_* and dialog_meta_* folders for unit dialog in the data4 addOn. The string pattern used to search for `dialog_text_<UNIT_ID>*` and dialog_meta_<UNIT_ID>*, but this now just searches for `dialog_text_*` and `dialog_meta_*` to allow for adding onto any existing `dialog_text_*` or `dialog_meta_* file`. For example, you can modify Reimu's dialog files by creating a Reimu folder in data4, and then creating a dialog_text_Marisa and dialog_meta_Marisa in it to replace her dialog with Marisa's dialog files.

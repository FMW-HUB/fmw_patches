###1.2.3.2###
- Implement addOn support for Data_Change in data5-4. Make sure to remove the dummy Data_Change addOn in your current files since the game will now try to read from the Data_Change folder. The new addOn `Form_FlagID_Fix.json` uploaded to this repo is an important one: This fixes the Route B form availability bug by rewriting the Data_Change file and internal game logic for checking the ROUTE_B and Classic form flags before proceeding to update either character.

- Implement LayeredFS loading for idle sprites, field sprites (uniticon), and spirit data file resources. Replace these in the following folders.
  - For idle sprites, replace the files in data2-2.
  - For field sprites, replace the files in data8.
  - For spirit sprites, replace the files in data8.

- Implement custom drawn modding UI input screen instead of using the synchronous `get_string` and `get_integer` functions. This should eliminate any further infinite loop bugs from inputting new numerical/text values in the modding menu.

- Add FMW1 demo Half-ghost animation script. You can see this animation by overriding an animation for a weapon with the internal name `hanrei_old`.

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

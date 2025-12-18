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

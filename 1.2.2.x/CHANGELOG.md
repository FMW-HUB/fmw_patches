###1.2.2.6-Beta###

**This is a Beta version of the most recent patch leading to version 1.2.2.6. Changes are user-tested and playable, but there may be crashes for unexpected scenarios on the player end. More thorough testing is needed for the full 1.2.2.6 release. As always, please make sure to make frequent backups when playing on the latest mod versions.**

- Toggle: Enable LayeredFS-like custom loading of data file resources. This is done through the following:
  1. Create a `modData` folder in your local APPDATA FMW Folder: (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData`)
  2. Create another folder in `modData` that corresponds to the data archive that contains the files you wish to custom load.
     - For example, if you want to edit unit attributes, you would create a `data4` folder (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData\data4`) that will contain your custom `data_unit_all.txt` that you would like to load.
  3. Place your custom files that correspond to these data folders. The LayeredFS tooling will pick up these files and load them in place of the original files. Some files are loaded on game startup, so you may need to restart your game for your custom changes to be picked up by certain files.

- Text: Change the BGM that plays during the Intermission. You will need to input the internal name of the song (so everything before the left parenthesis starts the loop point). Reload your saves to apply BGM changes. This also requires the EnableLayeredFS mod to be active to load in the song you would like. (Default internal name is bgm_gen_intermission2)
  - Add custom functionality to load in custom songs to be played in the Intermission. Follow these steps:
    1. Prep your song as an OGG file. You will need to find the starting loop point for your song in seconds, and using an audio editing application like Audacity, you'll then crop your song so that the end becomes the ending loop point before your song repeats.
    2. With the starting loop point number in seconds, you'll name your song's OGG file in this format: <FILENAME>(<STARTING_LOOP_POINT_SECONDS>).ogg
    3. Once your file is ready, create a `data6-4` folder in the `modData` folder; the LayeredFS framework will read from this folder first for custom songs before looking in any of the other `data6` folders. Place your file in this folder (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData\data6-4`).
    4. Now, using the ChangeIntermissionBGM mod, input just the FILENAME of your ogg song file without the parentheses, loop point, or extension. Reload your saves and you should be able to hear your custom song.

- Song Internal Names:
**data6-1**
```
bgm_battle_AAsilent
bgm_battle_Akyu
bgm_battle_Alice
bgm_battle_Alice2
bgm_battle_Aya
bgm_battle_Aya2
bgm_battle_Byakuren
bgm_battle_Chen
bgm_battle_Cirno
bgm_battle_Daiyosei
bgm_battle_Eiki
bgm_battle_Eirin
bgm_battle_Elliy
bgm_battle_Elliy2
bgm_battle_Faries
bgm_battle_Flan
bgm_battle_Flan2
bgm_battle_Flan3
bgm_battle_Hatate
bgm_battle_Hina
bgm_battle_Hourai
bgm_battle_Ichirin
bgm_battle_Iku
bgm_battle_Kaguya
bgm_battle_Kanako
bgm_battle_Keine
bgm_battle_KeineH
bgm_battle_Kisume
bgm_battle_Koakuma
bgm_battle_Kogasa
bgm_battle_Koishi
bgm_battle_Komachi
bgm_battle_Kurumi
bgm_battle_Letty
bgm_battle_Letty2
bgm_battle_LilyB
bgm_battle_LilyW
bgm_battle_LilyW_NS
bgm_battle_Luna
bgm_battle_Lunasa
bgm_battle_Lyrica
bgm_battle_Makura
bgm_battle_Makura2
bgm_battle_Marisa
bgm_battle_MarisaEX
bgm_battle_MarisaR
bgm_battle_MarisaR_full
bgm_battle_Medicine
bgm_battle_Meiling
bgm_battle_Meko
bgm_battle_Meko2
bgm_battle_MekoK
bgm_battle_Merlin
bgm_battle_Mima
bgm_battle_Mima2
bgm_battle_Minoriko
bgm_battle_Mokou
bgm_battle_MokouEX
bgm_battle_Momiji
bgm_battle_Murasa
bgm_battle_Mystia
bgm_battle_Nazrin
bgm_battle_Nazrin_H
bgm_battle_Nitori
bgm_battle_Nitori_FA
bgm_battle_Nitori_FA2
bgm_battle_Nitori2
bgm_battle_Nue
bgm_battle_Nue2
```

**data6-2**
```
bgm_battle_Onamazu
bgm_battle_Orin
bgm_battle_Parsee
bgm_battle_Patchouli
bgm_battle_Prism
bgm_battle_Ran
bgm_battle_Ran2
bgm_battle_Reimu
bgm_battle_ReimuEX
bgm_battle_ReimuR
bgm_battle_ReimuR_full
bgm_battle_Reisen
bgm_battle_Remilia
bgm_battle_Rumia
bgm_battle_Sakuya
bgm_battle_Sakuya2
bgm_battle_Sanae
bgm_battle_Sanae2
bgm_battle_Sanae3
bgm_battle_Satori
bgm_battle_Seirensen
bgm_battle_Shanghai
bgm_battle_Shinki
bgm_battle_Shitone
bgm_battle_Shitone2
bgm_battle_Shizuha
bgm_battle_Sho
bgm_battle_Sho_H
bgm_battle_Star
bgm_battle_Suika
bgm_battle_Sunny
bgm_battle_Suwako
bgm_battle_Tenshi
bgm_battle_Tensoku
bgm_battle_Tensoku2
bgm_battle_Tewi
bgm_battle_Toyohime
bgm_battle_Udonge
bgm_battle_Unknown
bgm_battle_Utsuho
bgm_battle_UtsuhoB
bgm_battle_UtsuhoH
bgm_battle_UtsuhoH2
bgm_battle_Wriggle
bgm_battle_Yamame
bgm_battle_Yorihime
bgm_battle_Youmu
bgm_battle_Youmu2
bgm_battle_Yugi
bgm_battle_Yuka
bgm_battle_Yuka2
bgm_battle_Yukachan
bgm_battle_Yukari
bgm_battle_Yukari2
bgm_battle_Yukari3
bgm_battle_Yumeko
bgm_battle_Yuyuko
bgm_battle_Yuyuko2
bgm_weapon_AyaHata_DS
bgm_weapon_Cirno_Fbaka
bgm_weapon_Elliy_Reflector
bgm_weapon_Faries_FOD
bgm_weapon_Hina_Pain
bgm_weapon_Iku_Gigadrill
bgm_weapon_Keine_Zutsuki
bgm_weapon_Marisa_Maspa
bgm_weapon_Momiji_Bite
bgm_weapon_Mystia_Master
bgm_weapon_Mystia_Mysterious
bgm_weapon_Mystia_Owl
bgm_weapon_Mystia_Sparrow
bgm_weapon_ReiMari_SMiiru
bgm_weapon_Reimu_Miiru
bgm_weapon_Reimu_Musou
bgm_weapon_ReimuR_MT
bgm_weapon_Rumia_Dimmer
bgm_weapon_Sakuya_Meek
bgm_weapon_SatoKoi_KHB
bgm_weapon_SFormation
bgm_weapon_Suika_Yakou
bgm_weapon_Tenshi_Hisouten
bgm_weapon_Udonge_Lunatic
bgm_weapon_Wriggle_Kick
bgm_weapon_Yuka_Maspa
```

**data6-3**
```
bgm_ep_53min
bgm_ep_cafe
bgm_ep_ecomes
bgm_ep_eiya
bgm_ep_Kanako
bgm_gen_ED_Sakuya
bgm_gen_ED01
bgm_gen_ED02
bgm_gen_ED03
bgm_gen_ED04
bgm_gen_intermission
bgm_gen_intermission2
bgm_gen_Mekoroom
bgm_gen_musicroom
bgm_gen_OP_Meko
bgm_gen_op_theme
bgm_gen_OP01
bgm_gen_OP02
bgm_gen_staffroll_Meko
bgm_gen_staffroll01
bgm_gen_staffroll02
bgm_gen_staffroll03
bgm_gen_staffroll04
bgm_gen_staffroll04_loop
bgm_pp_1969
bgm_pp_1970
bgm_pp_agartha
bgm_pp_ayakashi
bgm_pp_ayakashiP
bgm_pp_circus
bgm_pp_dendera
bgm_pp_eiyasho
bgm_pp_ekg
bgm_pp_enigma
bgm_pp_final
bgm_pp_getsumen
bgm_pp_gfree
bgm_pp_greenwich
bgm_pp_GSW
bgm_pp_hokkai
bgm_pp_izanagi
bgm_pp_izanagi0
bgm_pp_jujigun
bgm_pp_Kanako
bgm_pp_kasho
bgm_pp_kikai
bgm_pp_kurenai
bgm_pp_kurenai_loop
bgm_pp_lastremote
bgm_pp_makai
bgm_pp_mantle
bgm_pp_michi
bgm_pp_mugen01
bgm_pp_mugen02
bgm_pp_mugen03
bgm_pp_mugen04
bgm_pp_mugen05
bgm_pp_mukui
bgm_pp_pcomes
bgm_pp_pinch
bgm_pp_prism01
bgm_pp_prism02
bgm_pp_prism03
bgm_pp_prism04
bgm_pp_pscore
bgm_pp_renmery
bgm_pp_tepes
bgm_pp_tokoshie
bgm_pp_toroya
bgm_pp_truth
bgm_pp_warabe
bgm_pp_warabe0
bgm_pp_wind
bgm_pp_Yukachan
bgm_talk_aircraft01
bgm_talk_aoki
bgm_talk_applause01
bgm_talk_applause02
bgm_talk_blizzard
bgm_talk_bomb
bgm_talk_cave
bgm_talk_dream
bgm_talk_emergency
bgm_talk_fire
bgm_talk_flanhelp1
bgm_talk_flanhelp2
bgm_talk_flanhelp3
bgm_talk_gag
bgm_talk_heartbeat
bgm_talk_heartfelt
bgm_talk_hiroshige
bgm_talk_inishie
bgm_talk_insect
bgm_talk_interlude01
bgm_talk_interlude02
bgm_talk_kagaku
bgm_talk_kaikidan
bgm_talk_korekara
bgm_talk_morning
bgm_talk_ningyo
bgm_talk_potion
bgm_talk_rain01
bgm_talk_rain02
bgm_talk_rain03
bgm_talk_shigan
bgm_talk_soratoumi
bgm_talk_summer01
bgm_talk_underwater
bgm_talk_unknown
bgm_talk_waterfall
bgm_talk_waterfall2
bgm_talk_wave01
bgm_talk_wind01
bgm_talk_yokoku
bgm_talk_yokoku2
bgm_talk_yozakura
bgm_talk_yuutsu1
bgm_talk_yuutsu2
jingle_flanhelp
jingle_gameover
jingle_levelup
jingle_levelup_short
jingle_stage_start
jingle_stage_start_bou
jingle_stage_start_Broute
jingle_stage_start_chi
jingle_stage_start_ei
jingle_stage_start_fin
jingle_stage_start_gen
jingle_stage_start_hoshi
jingle_stage_start_kaze
jingle_stage_start_kou
jingle_stage_start_Meko
jingle_stage_start_Sakuya
jingle_stage_start_you
```

- Toggle: Enable all player units to be selected for NG+ carryover. This is an experimental feature that has not been thoroughly tested; be wary of certain carryovers not behaving as you would expect. OTOH, the Palanquin Ship, Meeko, Makura are disabled, while combined units may crash the game due to undefined actions. Go wild at your caution.

- Toggle: Remove the exponential damage cap from player Yorihime's Takemikazuchi and set formula to Normal+ and above enemy version.

- Toggle: Restore Mystia's Song mechanics from FMW4. NOTE: FMW4 song buffs are limited to 1 type active at a time. Future songs will overwrite the previous buff, if applicable. Song effects are listed below (without the Valor/Songstress boost)
  - SotnS: Accuracy/Evade stats +30
    - MAP: Centered-radius, targets Team, Accuracy/Evade +20
  - HotHO: Defense stat +30/Skill stat +15
    - MAP: Centered-radius, Defense +20/Skill +10
  - MCM: Cqb/Range/Accuracy stats +40
    - MAP: Centered-radius, Cqb/Range/Accuracy +20
   
- Fix infinite loop bug in the Battle Info screen when effect tags + abbreviated spirit names exceeded beyond ~400 pixels. Text truncation was introduced on certain text fields to shorten the English translation text, which is much longer than the JPN text. The game hits an infinite loop when trying to truncate text in the Battle Info screen. Casting too many effects/Spirits and filling the battle info screen will cause the game to continuously shorten the text for Spirits until the text can fit on screen. However, in some cases, the game gets stuck shortening Spirit text even when it reaches a length of 0 since the text hasn't met the condition of being fit on screen. Thus, this fix takes into account those cases to allow the game to truncate safely and not hit an infinite loop when the text expands too much.

###1.2.2.5c hotfix###
- Fix crashes and incorrect reaction chance calculations in the reaction display mod due to incorrect unit position references. 

The game stores pointers for the canonical unit positions in a Team at the start of each chapter. For example, if Satori/Koishi are in a Team in that vanguard/rearguard order, Satori will be assigned a canonical unit position 0, while Koishi will be assigned position 1. Then, the game initializes the pointers that reference these canonical unit positions. The vanguard pointer will obtain a reference of 0, while the rearguard pointer will start with a reference of 1. 

Various actions can change the value stored in these pointers. If we switched Satori's and Koishi's positions in the previous example, the vanguard pointer would now store a canonical unit position of 1 to reference Koishi, while the rearguard pointer gets 0 to reference Satori. You can expect these pointers to change multiple times throughout the chapter, but it's important that we reference these pointers instead of hardcoding the canonical unit positions to avoid bugs that arise from an incorrect reference.

The previous code used the canonical unit position of 0 to represent the vanguard unit instead of using the vanguard pointer in the reaction calculation. Depending on how your units were intially placed in a team, it was possible to get the wrong unit reference, which on average would miscalculate the reaction chances based on the unit in canonical position 0, or crash the game because the canonical position 0 unit's weapon list exceeded the length of the current vanguard unit's weapon list returned using correct vanguard pointer. More specifically, the game would throw an array out-of-bounds error when referencing weapon ids that were greater than the length of the current vanguard unit's weapon list. 

- Translate the debug stage prompt. When the Debug Menu is enabled, entering chapter 77 on Route A from the Intermission will prompt the player to play the debug stage. The question was originally in Japanese, so this small patch translates that for the player.

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














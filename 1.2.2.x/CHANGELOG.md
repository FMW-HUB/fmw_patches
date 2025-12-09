###1.2.2.6b hotfix###
- Finally fix the looping modding menu bug when text/number edit mods were selected when in fullscreen with a controller. This is a strange bug that occurs with the get_string function, controller use, and the fullscreen function. With all active at the same time, the game will keep repeating controller select inputs to constantly enter the input window, thus causing the infinite loop. Perhaps there is an internal bug with get_string that's causing the controller inputs to be spammed constantly, but I have still not found the direct root cause, instead it's only the components.
  - Very rarely, I've seen the infinite loop bug come back once or twice, but I was able to get through those cases by clicking on the main game menu to refocus the window, then Alt+Enter to disable fullscreen, then tried pressing OK on the input window again. This can happen at times due to the unstable implmentation of the input window in Gamemaker's engine; there's definitely room to improve here.

- Fix Debug Menu bugs.
  - Fix the internal values for Upgrade Rate, Points, PP, WP, and Kills not being reset to the defaults or 0 after applying changes. This had caused unexpected increments for each option even when the display showed the defaults; after selecting confirm, the previously selected options would still apply to your current units.
  - Cap Debug Menu additions to Points, PP, WP, and Kills to their internal max limits. If any of the options would exceed their internal max limit after the add, the previous value for each value would remain the same, and no additions would take place. For kills, since the limit is 9999, adding 10000 would set the total kills to the max-1 at 9998, to prevent off-by-one errors.
    - Points max internal limit: 999999999
    - PP max internal limit:99999
    - EX max internal limit: 99999
    - Kills max internal limit: 9999

- Fix addOn system not being able to append weapons to characters that have hard-set weapons for cutscene/death animations in their weapon list. The addOn system increments the number of weapons a unit can have in their unit data, and then adds the new weapon to the end of their weapon list. However, weapons are still read sequentially, and because cutscene/death animations are located at the end of the list, those weapons will be added instead to the UI. The new change for addOns pinpoints the index for these cutscene/death weapons on these characters and inserts the new weapons before these cutscene/death weapons.

- Restore eternal meek animation. There are still some missing effects in data3 and data12 that need to be added for the animation to be complete.


###1.2.2.6a hotfix###
- Fix gamebreaking bug where event battles did not have a certain variable initialized for Boundary of Offense and Defense.

###1.2.2.6###
- PSes:
  - [NEW] Noblesse Oblige
  ```
  For one turn, grants the ability Salamander Shield to all adjacent units.
  This effect also applies to the unit's partner. (Usable 2 times.)
  ```
  - [NEW] Boundary of Offense and Defense
  ```
  For one turn, reverses the attack order for all battles between allied and enemy units.
  Additionally, Player Support Attacks still only occur during the Player Phase,
  while Player Support Defends only occur during the Enemy Phase. (Usable 2 times.)
  ```
  - [RESTORED] Boundary of Dreams and Bonds (Original)
  ```
  For one turn, all frontline allied units are considered adjacent to each other.
  This does not affect Support or Combined unit actions.
  ```
  - [RESTORED] Boundary of Vanguard and Rearguard
  ```
  Switches the frontline and backline positions of all other allied units in a team.
  This effect also applies to units that have already acted. (3 uses)
  ```
  - [RESTORED] Boundary of Focused and Unfocused
  ```
  Switches the Focused and Unfocused modes of all other allied units.
  This effect also applies to units that have already acted. (3 uses)
  ```

- Implement the `addOn` system. We now have a way to perform in-memory data file structure patching with this new system. The addOns for each data file allow you to add new json structure entries that correspond to individual spreadsheet rows for each data file. Think of this as letting you patch and add in-memory data file structures with your own custom fields. At the moment, this only supports adding new data, but in the future replacement will be possible as well. Use the LayeredFS mod tool to replace existing data rows for now.
  - Think of new data row entries as json structures now. The names mapping to values are fairly intuitive to read instead of parsing a CSV or plaintext file. For certain `addOns`, you can select whether to enable or disable the data row addition.
  - Currently, the system has support for certain data files in `data5-4` and dialog files in `data4`. Some data files have the structure laid out but are NOT_IMPLEMENTED at this time. They will be added later on.
  - This tool supports adding new weapons while taking into the account the numWeapons field in the unit data. You can add new weapons on top of other changes to weapons that have already been made through LayeredFS.
  - Will add additional documentation to help understand some of the required and optional fields that can help in `addOn` patching.

- Using the `addOn` system, restore the original Four of a Kind animation from FMW1, renamed as `Scarlet Four of a Kind`. This has the same stats as the current FOK; only difference is the animation. Battle dialog has been added through the dialog text and meta `addOns` for Flandre, and the weapon is added as an `Append Weapon`. This means it will be added on top of already existing changes made through LayeredFS or other modding means.
  - Download the addOns folder and place it inside your user FMW app data folder for `fmw_dosd` (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\`).

- Restore FMW1 dialogue for the Evil Eye enemy. This was accomplished again through the `addOn` system. All dialog from the original 1.1.2 FMW1 translation has been ported over.
   - Credits to Deranged/Gensokyo.org for translating these lines in FMW1.

- With the `addOn` system, I have added sample entries for enemy units that can be used on the player side. Added the `Kedama`, `Evil Eye`, `Kappa`, and `Makai Insect`. By default, enabling these units on the player side is disabled. To enable these units, open the `Data_IsIN` in `data5-4`, `data_unit_all` in `data4`, and `data_char_all` in `data4` addOn files, find each json entry that marks the patch entry as `"Enabled":false`, and change the false to true. 
  - A critical warning, because new units can be added, this will almost certain modify your saves in new, unintended ways. It shouldn't crash because the changes still follow the save format of the vanilla game; however, new data will be added to those saves that were not designed in mind. Always make sure to keep a backup of your saves.
  - Fix assist attack animations to work generically without relying on the animation scripts in the exe, if the assist attack is newly added for weapons outside of the expected set. The animation will play the FPM choreography without the UI, but this is necessary to stop the game from drawing unexpected elements or glitching out during the animations. As a result, dialog that is played is set to the FPM dialog.
  - Fix object deletion bug that would occur when the `Evil Light Charge` attack was used in FPM and the Evil Eye's partner attacked first. Deactivated the instance and reactivated it later on after the partner's attack to prevent the game from referencing a non-existent object.

- Fix Debug Menu oddities.
  - The `Unlock All Skills` has been clarified as `Unlock ALl Skills in Arc`. What this does is unlock all skills a unit can learn up to the level cap of the current arc the player is in.
  - Decouple the `Add PP` option and stop it from adding to kill total. There is now a separate `Add Kills` option to add Kills for all units.
  - The `Unlock All Skills in Arc`, `Add PP`, `Add Kills` options used to not update immediately after confirming the choices in the Debug Menu. This is now changed to reload the Intermission if any one or more of these options are selected to update the UI correctly.
  - Fix the internal value for the chapter select to reset to the `Default` option. Previously, after selecting another chapter to warp to, the internal value would be stuck at the previously selected chapter number. This could cause unexpected events to happen such as start of Intermission events repeating multiple times, like obtaining items.

- Added mods:
  - Text: Change the color of the displayed tiles for generic danmaku fields.
  - Text: Change the color of the displayed tiles for spellcard danmaku fields. Due to the way the colors are blended amongst the spellcard danmaku tiles, you will need to wait for the boss to regenerate the spellcard danmaku for the color changes to apply.
  - Text: Change the color of the displayed tiles for unit interactions, such as movement, attack range, PS cast, etc.
  - Toggle: Move the Parry/Shield Defense icons to the right of the unit name box. This prevents these icons from being covered by unit buffs/debuffs if present.
  - Toggle: Display the internal unit/character data ID in the unit/status UI screens respectively. This is useful for debugging and confirming assumptions for updating internal unit/character data between chapters.

- Read the current saved army name in the ChangeArmyName mod json and use this as the default value for the mandatory text input window during the Chapter 71 Intro scenes.

- Move the Reaction chance display UI further down to avoid conflicting with Support Attack/Support Defense UI elements.

- Use the platform-agnostic `string_width` function to get the length of truncation characters instead of harcoding the pixel width of those characters. This is necessary for the Spirit text truncation bug on the Battle Info screen.

- Extend the PS Levelup screen to display beyond the normally allowed 6 PSes during level up. Originally, the PS Levelup screen only took into account a unit getting at most 6 PSes throughout the game. If any more PSes are added, the subsequent PS entries in the level up screen will start overlapping with the existing PS entry descriptions. This change adds new paging UI that lets the player scroll through multiple screens of PSes if the unit has more than 6.

- Remove Palanquin Ship and Rinnosuke from the pool of selectable units enabled by the NG+ Carryover mod. These units had common unit interactions that crashed the game. More work will need to be done to make these units stable.

- Fix infinite loop bug when inputting values in the text/number editing mod input windows. The input windows no longer yield until user input. Certain Windows distributions seem to not synchronously hold a stable value for the user input, which causes the mod menu logic to read an invalid input and loop infinitely.

###1.2.2.6a-Beta hotfix###
- Fix LayeredFS bug not loading in the correct filename for sound effects when the LayeredFS mod is enabled.

###1.2.2.6-Beta###

**This is a Beta version of the most recent patch leading to version 1.2.2.6. Changes are user-tested and playable, but there may be crashes for unexpected scenarios on the player end. More thorough testing is needed for the full 1.2.2.6 release. As always, please make sure to make frequent backups when playing on the latest mod versions.**

- Toggle: Enable LayeredFS-like custom loading of data file resources. This is done through the following:
  1. Create a `modData` folder in your local APPDATA FMW Folder: (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData`)
  2. Create another folder in `modData` that corresponds to the data archive that contains the files you wish to custom load.
     - For example, if you want to edit unit attributes, you would create a `data4` folder (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData\data4`) that will contain your custom `data_unit_all.txt` that you would like to load.
  3. Place your custom files that correspond to these data folders. The LayeredFS tooling will pick up these files and load them in place of the original files. Some files are loaded on game startup, so you may need to restart your game for your custom changes to be picked up by certain files.
  4. Don't forget to enable the mod through the modding menu UI. Restart your game afterwards if needed.

- Text: Change the BGM that plays during the Intermission. You will need to input the internal name of the song (so everything before the left parenthesis starts the loop point). Reload your saves to apply BGM changes. This also requires the EnableLayeredFS mod to be active to load in the song you would like. (Default internal name is bgm_gen_intermission2)
  - Add custom functionality to load in custom songs to be played in the Intermission. Follow these steps:
    1. Prep your song as an OGG file. You will need to find the starting loop point for your song in seconds, and using an audio editing application like Audacity, you'll then crop your song so that the end becomes the ending loop point before your song repeats.
    2. With the starting loop point number in seconds, you'll name your song's OGG file in this format: `<FILENAME>(<STARTING_LOOP_POINT_SECONDS>).ogg`
    3. Once your file is ready, create a `data6-4` folder in the `modData` folder; the LayeredFS framework will read from this folder first for custom songs before looking in any of the other `data6` folders. Place your file in this folder (`C:\Users\<YOUR_USERNAME>\AppData\Local\fmw_dosd\modData\data6-4`).
    4. Now, using the ChangeIntermissionBGM mod, input just the FILENAME of your ogg song file without the parentheses, loop point, or extension. Reload your saves and you should be able to hear your custom song.
    5. In a way, you can think of the `data6-4` folder storing all of your custom songs, while `data6-1`, `data6-2`, `data6-3` folders can be the folders where you replace existing songs with the LayeredFS tooling.

- Song Internal Names:
**data6-1**
```
Silence Sound Effect - bgm_battle_AAsilent
The Brush-wielding Girl Weaves History - bgm_battle_Akyu
Dancing Doll - bgm_battle_Alice
Tied to Your Fingertips - bgm_battle_Alice2
Hurricane! Whirlwind! Aya Shameimaru! - bgm_battle_Aya
Black-Winged Wind God - bgm_battle_Aya2
Holy Resistance - bgm_battle_Byakuren
Orange Fancy - bgm_battle_Chen
Flap & Frappe & Flapper - bgm_battle_Cirno
Best Friends Atop the Silent Lake - bgm_battle_Daiyosei
Fantasy Judgment, Seventy Years Later - bgm_battle_Eiki
Mind of Space - bgm_battle_Eirin
Creeping Dreams - bgm_battle_Elliy
The Girl who Guards the Door to Dreams - bgm_battle_Elliy2
Our Hearts are Still Shining Brightly - bgm_battle_Faries
Frantic Destroyer - bgm_battle_Flan
Unbalanced Unknown - bgm_battle_Flan2
The Psychotic and Cute Guest - bgm_battle_Flan3
A Girl on the Tailwind of a Story - bgm_battle_Hatate
Misery Go Round - bgm_battle_Hina
Beloved Handmade Dolls - bgm_battle_Hourai
The Cloud's Fist - bgm_battle_Ichirin
Lightning Fish - bgm_battle_Iku
A Game that is Exceedingly Proper, if a Little Arrogant - bgm_battle_Kaguya
The Restless God and the Virtuous Winds - bgm_battle_Kanako
Brain of Steel - bgm_battle_Keine
Now is When the Moon Turns Full - bgm_battle_KeineH
Home is Where One Lays Their Bucket - bgm_battle_Kisume
With a Devilishly Innocent Heart - bgm_battle_Koakuma
Prism Parashooter - bgm_battle_Kogasa
Paranoia Step - bgm_battle_Koishi
Price of Life - bgm_battle_Komachi
Scarlet Phoneme, Rise Above the Lake - bgm_battle_Kurumi
Letty the Cool Lady - bgm_battle_Letty
Thawy Days - bgm_battle_Letty2
Black Lily III - bgm_battle_LilyB
Snow-White Lale - bgm_battle_LilyW
Song of an Unexpectedly Distant Spring - bgm_battle_LilyW_NS
Careless Even in Springtime - bgm_battle_Luna
Luna Crescente - bgm_battle_Lunasa
Your Sparkling Sound - bgm_battle_Lyrica
Dreaming Beauty ~ The Beauty of Dreaming - bgm_battle_Makura
Awaking Beauty - bgm_battle_Makura2
Be a Shooting Star - bgm_battle_Marisa
Thank You For Playing Side M - bgm_battle_MarisaEX
Stardust Hero - bgm_battle_MarisaR
Stardust Hero (Full ver.) - bgm_battle_MarisaR_full
Innocent Poison - bgm_battle_Medicine
Hold Fast, Maiden of the Continent! - bgm_battle_Meiling
Bottled Sheep ~ Fall Asleep - bgm_battle_Meko
Despair Sheep - bgm_battle_Meko2
Slumbering Encounter ~ Another Sheep - bgm_battle_MekoK
Shiny Transblue - bgm_battle_Merlin
Atop the Mobius Strip - bgm_battle_Mima
Enter the Aluren - bgm_battle_Mima2
Heated Harvest Festival - bgm_battle_Minoriko
Eternally Blazing Heart - bgm_battle_Mokou
Undying Flames - bgm_battle_MokouEX
Under Watch of the White Wolf - bgm_battle_Momiji
Crossanchor Murasa - bgm_battle_Murasa
Grilled Lamprey in the Moonlight - bgm_battle_Mystia
A Simple but Unrustable Family - bgm_battle_Nazrin
My Greatest Treasure - bgm_battle_Nazrin_H
Water-to-Air Super Youkai Warhead NITORI - bgm_battle_Nitori
A Sworn Friend's Bond - bgm_battle_Nitori_FA
FMW2 Chapter 22 Nitori Event Theme - bgm_battle_Nitori_FA2
From the Bottom of the Valleys and Rivers - bgm_battle_Nitori2
Heian Chimera Syndrome - bgm_battle_Nue
Trying to be Myself Once More - bgm_battle_Nue2
```

**data6-2**
```
The Unknown Object's Earthshaking Strike - bgm_battle_Onamazu
JAJAAAN ROCK!! - bgm_battle_Orin
Resounding Wailing in the Hidden Heart - bgm_battle_Parsee
The Witch of Aprisyra Metrosil - bgm_battle_Patchouli
The Netherworld's Prism Phantoms - bgm_battle_Prism
Cyano Fantasia - bgm_battle_Ran
Accel Fox - bgm_battle_Ran2
Specter Buster - bgm_battle_Reimu
Thank You For Playing Side R - bgm_battle_ReimuEX
Dream Balancer - bgm_battle_ReimuR
Dream Balancer (Full ver.) - bgm_battle_ReimuR_full
The Variable Yet Constant Zero Fighter - bgm_battle_Reisen
Emblazoned in an Eternally Young Scarlet - bgm_battle_Remilia
Stalking the Night with a Cross - bgm_battle_Rumia
The Elegant Flower that Blooms at Night - bgm_battle_Sakuya
Distortion Dial - bgm_battle_Sakuya2
Brand New Wind - bgm_battle_Sanae
The Wind is Ever at My Back - bgm_battle_Sanae2
Motherly Sea, One with the Wind - bgm_battle_Sanae3
The Eyeline - bgm_battle_Satori
Ark of the Spring Sky - bgm_battle_Seirensen
Shanghai - bgm_battle_Shanghai
Ain Soph Aur - bgm_battle_Shinki
Stranger in Black ~ Blacked Out - bgm_battle_Shitone
Cackling Black ~ Face Your Black - bgm_battle_Shitone2
Silent Autumn Breeze - bgm_battle_Shizuha
Hungry Tiger in the Scorching Heat - bgm_battle_Sho
Revival of the Golden Brave - bgm_battle_Sho_H
Trickster Girl - bgm_battle_Star
No Need for a Million Oni, Just One is an Army - bgm_battle_Suika
Unrefracting Curiosity - bgm_battle_Sunny
A God Plays with Their Whole Heart and Soul - bgm_battle_Suwako
Colorless Blade - bgm_battle_Tenshi
Our Hisoutensoku (FMW ver.) - bgm_battle_Tensoku
Our Hisoutensoku (OG ver.) - bgm_battle_Tensoku2
Pounded Lies and Mochi in the Moonlit Night - bgm_battle_Tewi
Lunatic Elegance - bgm_battle_Toyohime
Feel Eyes on You - bgm_battle_Udonge
Border of Life - bgm_battle_Unknown
The Crow who Swallowed the Sun - bgm_battle_Utsuho
Skygazer - bgm_battle_UtsuhoB
The Sun that Fell to Earth - bgm_battle_UtsuhoH
And then, we'll... - bgm_battle_UtsuhoH2
-Fleeting Flame- Firefly Soul - bgm_battle_Wriggle
Upbeat Spider - bgm_battle_Yamame
Lunatic Guardian - bgm_battle_Yorihime
Lightsword Flash - bgm_battle_Youmu
As Steadfast as a Shura - bgm_battle_Youmu2
A Single Oni is as Strong as a Thousand, No Help Needed - bgm_battle_Yugi
The Flower that Marks the Changing Seasons (Eternity Ver.) - bgm_battle_Yuka
Let's Bloom a Flower of Despair - bgm_battle_Yuka2
As a Flower - bgm_battle_Yukachan
Lapsing into Sleep, Recollections of the Boundary - bgm_battle_Yukari
Final Banquet of Boundaries and Recollection - bgm_battle_Yukari2
Guide Us, Oh Sage - bgm_battle_Yukari3
A Sword Dance of Love and Pity - bgm_battle_Yumeko
A Butterfly's Beautiful Death - bgm_battle_Yuyuko
The Dancing, Blooming, Butterfly Girl A!! - bgm_battle_Yuyuko2
Now Blooms the Tattered Word Flower - bgm_weapon_AyaHata_DS
Invincibility Session!! - bgm_weapon_Cirno_Fbaka
The Pair Accompanying the Flower - bgm_weapon_Elliy_Reflector
Three Hearts, Blazing like a Morning Star - bgm_weapon_Faries_FOD
A Certain Misfortune Goddess's Song - bgm_weapon_Hina_Pain
Drill Through The Clouds - bgm_weapon_Iku_Gigadrill
Punishment -Theme of Love- - bgm_weapon_Keine_Zutsuki
The Moment Dreams Reach the Stars - bgm_weapon_Marisa_Maspa
The Dashing, Falling Fall - bgm_weapon_Momiji_Bite
The Romantic Flavor of Westernization - bgm_weapon_Mystia_Master
Bye Bye, Chicken Heart - bgm_weapon_Mystia_Mysterious
Anti-griddle of Anger - bgm_weapon_Mystia_Owl
Opened Human Cage - bgm_weapon_Mystia_Sparrow
With All Our Fantasy on the Line - bgm_weapon_ReiMari_SMiiru
Trichromatic Danmaku Traumerei - bgm_weapon_Reimu_Miiru
Sealing Charm, Blessed Light - bgm_weapon_Reimu_Musou
Your Voice Won't Reach - bgm_weapon_ReimuR_MT
Fluttering Foodstuffs in the Night Sky - bgm_weapon_Rumia_Dimmer
Crumbling Silver Knife - bgm_weapon_Sakuya_Meek
Answ3rd LOVE!! - bgm_weapon_SatoKoi_KHB
Our Tiny Future Shines Brightly - bgm_weapon_SFormation
The Prosperous Oni, the Ancient Power - bgm_weapon_Suika_Yakou
Get Furious!! (Short ver.) - bgm_weapon_Tenshi_Hisouten
UDON-ZAM - bgm_weapon_Udonge_Lunatic
-Fixed Star- Twinkling Rigel - bgm_weapon_Wriggle_Kick
The Beauty of Nature - bgm_weapon_Yuka_Maspa
```

**data6-3**
```
As Time Stands Still - bgm_ep_53min
Danmaku Tactics - bgm_ep_cafe
Reinforcements - Theme of the Hated Youkai - bgm_ep_ecomes
Invasion of the Bewitching Spirits - bgm_ep_eiya
Footsteps of the War God's Army - bgm_ep_Kanako
The Opened Prison and Heart - bgm_gen_ED_Sakuya
The Rippling Scarlet Sea of Emotion - bgm_gen_ED01
Beginning and Ending of a Mystical Daydream - bgm_gen_ED02
The Sceneries Intersect in Purple - bgm_gen_ED03
And Thus the Flower of Fantasy Blooms - bgm_gen_ED04
Preparing for the Games to Come - bgm_gen_intermission
Preparing for the Games of the New Age - bgm_gen_intermission2
Blessed Brushing - bgm_gen_Mekoroom
(Duplicate) Preparing for the Games to Come - bgm_gen_musicroom
Meeko Route Opening Theme - bgm_gen_OP_Meko
Fantasy Maiden Wars - bgm_gen_op_theme
Scarlet Arc Opening Theme - bgm_gen_OP01
Mystic Arc Opening Theme - bgm_gen_OP02
Mehko Sognando (Short ver.) - bgm_gen_staffroll_Meko
Towards the Clear, Blue Skies - bgm_gen_staffroll01
With the Arrival of Spring, Cherry Blossoms Float in the Breeze - bgm_gen_staffroll02
Gazing Up at an Endless Space - bgm_gen_staffroll03
Awakening - bgm_gen_staffroll04
Awakening (Loop ver.) - bgm_gen_staffroll04_loop
The Arrows and Bullets that Enshrouded the Night - bgm_pp_1969
The Shining Moon Rises over this Absurd Night - bgm_pp_1970
Those Bound for Agartha - bgm_pp_agartha
The Ayakashi Sheds Spring - bgm_pp_ayakashi
FMW2 Chapter 34 Map Preparations Theme - bgm_pp_ayakashiP
Harmful Mystery - bgm_pp_circus
For the Gensokyo of Tomorrow - bgm_pp_dendera
Eternal Arc Opening Theme/FMW3 Chapter 43 Map Preparations Theme - bgm_pp_eiyasho
FMW4 Chapter 64 EKG Sound Effect - bgm_pp_ekg
The Dreams We Welcome and the Bonds that Tie Us to Tomorrow - bgm_pp_enigma
Imagining a Dream of Things to Come ~ Dawn of Hope - bgm_pp_final
Against the Endless Sea of Stars - bgm_pp_getsumen
EX[hi]Re:Vision - bgm_pp_gfree
Greenwich in the Battlefield - bgm_pp_greenwich
Fantasy Maiden Wars -Dreams- - bgm_pp_GSW
GET SAINT BACK - bgm_pp_hokkai
To the Distant Dream World - bgm_pp_izanagi
To the Distant Dream World (Cutscene ver.) - bgm_pp_izanagi0
Trick Your Dream - bgm_pp_jujigun
Advancing Headwinds - bgm_pp_Kanako
A Land in Perfect Silence - bgm_pp_kasho
Sinking Civilization - bgm_pp_kikai
Soul of Scarlet - bgm_pp_kurenai
Soul of Scarlet (Loop ver.)/FMW1 Chapter 15 Map Preparations Theme - bgm_pp_kurenai_loop
Smoldering Ash - bgm_pp_lastremote
The World Mom Knitted Together - bgm_pp_makai
Hell's Mantle - bgm_pp_mantle
Returning Along the Night Road - bgm_pp_michi
Face to Heart (1st Movement) - bgm_pp_mugen01
Subterranean Interlude - bgm_pp_mugen02
Face to Heart (2nd Movement) - bgm_pp_mugen03
Face to Heart (3rd Movement) - bgm_pp_mugen04
Face to Heart (4th Movement) - bgm_pp_mugen05
A Midnight Star Storm - bgm_pp_mukui
Fantasy Maidens, Move Out! - bgm_pp_pcomes
Surpass the Carnage! - bgm_pp_pinch
Wish Upon a Rainbow (Intro) - bgm_pp_prism01
Wish Upon a Rainbow - bgm_pp_prism02
Wish Upon a Rainbow (Bridge) - bgm_pp_prism03
Wish Upon a Rainbow (Final) - bgm_pp_prism04
FMW2 Chapter 23 Map Preparations Theme - bgm_pp_pscore
Confusion Beneath the Moonlight - bgm_pp_renmery
Scarlet Pressure - bgm_pp_tepes
Surpassing their Eternity - bgm_pp_tokoshie
A Light Found While Grasping in the Dark - bgm_pp_toroya
Above the Dazzling Cherry Blossoms - bgm_pp_truth
The Source of the Shared Dream - bgm_pp_warabe
Dream Arc Opening Theme - bgm_pp_warabe0
Map Wind Sound Effect - bgm_pp_wind
A Place Where the Seasons Converge - bgm_pp_Yukachan
Aircraft Sound Effect - bgm_talk_aircraft01
Boundary of Regular and Irregular Days - bgm_talk_aoki
Applause Sound Effect 1 - bgm_talk_applause01
Applause Sound Effect 2 - bgm_talk_applause02
Blizzard Sound Effect - bgm_talk_blizzard
Bomb Sound Effect - bgm_talk_bomb
Cave Sound Effect - bgm_talk_cave
The Dreams the Sheep See ~ Labyrinth of Nightmares - bgm_talk_dream
Assault - A Crisis Draws Near - bgm_talk_emergency
Fire Sound Effect - bgm_talk_fire
Flanhelp Op.1-496 (Intro) - bgm_talk_flanhelp1
Flanhelp Op.1-496 (Bridge) - bgm_talk_flanhelp2
Flanhelp Op.1-496 (Music Room) - bgm_talk_flanhelp3
Secret Mission! - bgm_talk_gag
Heartbeat Sound Effect - bgm_talk_heartbeat
Heart Fault - bgm_talk_heartfelt
The Dream is Here - bgm_talk_hiroshige
Dark Clouds - bgm_talk_inishie
Insect Sound Effect - bgm_talk_insect
Original Cutscene Theme 1 - bgm_talk_interlude01
Original Cutscene Theme 2 - bgm_talk_interlude02
Determination in the Chest - bgm_talk_kagaku
Bizarre Smile - bgm_talk_kaikidan
And Then, We'll... on piano - bgm_talk_korekara
Morning Sound Effect - bgm_talk_morning
What's the Strategy? - bgm_talk_ningyo
Fantasy Maiden Squadron - bgm_talk_potion
Rain Sound Effect 1 - bgm_talk_rain01
Rain Sound Effect 2 - bgm_talk_rain02
Rain Sound Effect 3 - bgm_talk_rain03
FMW4 Chapter 62 Eiki Prelude Theme/PoFV Pre-battle Theme: Mound of Shigan - bgm_talk_shigan
Those Unforgettable Days of Eternity - bgm_talk_soratoumi
Summer Sound Effect - bgm_talk_summer01
Underwater Sound Effect - bgm_talk_underwater
Is a Transparent Enemy Our Ally? - bgm_talk_unknown
Waterfall Sound Effect 1 - bgm_talk_waterfall
Waterfall Sound Effect 2 - bgm_talk_waterfall2
Wave Sound Effect - bgm_talk_wave01
Wind Sound Effect - bgm_talk_wind01
Fantasy Maiden Wars (Preview ver.) - bgm_talk_yokoku
Fantasy Maiden Wars (Longer ver.) - bgm_talk_yokoku2
Faint Whisperings - bgm_talk_yozakura
Night of the Wishing Star (Loop ver.) - bgm_talk_yuutsu1
Night of the Wishing Star - bgm_talk_yuutsu2
Chapter 44 Clear Jingle - jingle_flanhelp
Game Over Jingle - jingle_gameover
Level Up Jingle - jingle_levelup
Level Up Short Jingle - jingle_levelup_short
Generic Chapter Jingle - jingle_stage_start
SSiB Chapter Jingle- jingle_stage_start_bou
Route B Chapter Jingle - jingle_stage_start_Broute
SA Chapter Jingle - jingle_stage_start_chi
IN Chapter Jingle - jingle_stage_start_ei
Route A Final Chapter Jingle - jingle_stage_start_fin
(Duplicate) Generic Chapter Jingle - jingle_stage_start_gen
UFO Chapter Jingle - jingle_stage_start_hoshi
MoF Chapter Jingle - jingle_stage_start_kaze
EoSD Chapter Jingle - jingle_stage_start_kou
Meeko Chapter Jingle - jingle_stage_start_Meko
Sakuya Chapter Jingle - jingle_stage_start_Sakuya
PCB Chapter Jingle - jingle_stage_start_you
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






















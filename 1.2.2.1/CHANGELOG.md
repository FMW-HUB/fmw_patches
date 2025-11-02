###1.2.2.1###
- Init patch for prototype mod file framework with modding menu UI
- Toggle: Restore +5 initial Power bonus for 50 kills and #1 Ace kills
- Toggle: Display Friendship Level of current frontline and/or backline unit in Battle Info
- Toggle: Disable level up jingle SE
- Toggle: Translated Debug Menu, enable debug menu as option
- Fix backline unit effects not activating due to missing pilot/unit_code update, like Ran's 1.5x/2x multiplying PSes
- Restored FMW1 Private Square dodge animation
- Restored Sakuya's World animation:

  - Fully darkened background before spell ring appears as in the OG animation.
  - Reverted Switch change and reduced saturation of knife auras so that each knife appears clearly in set up.
  - Reverted Switch change and ensured Sakuya is drawn at a lower depth to appear in front of the knives.
  - Restored afterimage trails present in the original animation when Sakuya moves among the 5 locations for placing knives.Knife collapse animation portion used to prematurely draw opponent in the middle of knives. 
  - Reverted Switch change to draw opponent sprite behind knives and slash effects.
  - Inserted grayscale effect in animation. gpu_set_blendmode_ext is bugged when compiled in UTMT's GML compiler; 50% of the src/dest blending options do not work. Atm, I can't get the desired blending equation to preserve the present hue and alpha of the opponent sprite like in the old animation. Until this is fixed in the modding tool, the grayscale effect will need to be applied to the whole screen without the hue and alpha blending option.



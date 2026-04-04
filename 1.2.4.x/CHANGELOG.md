###1.2.4.1b###
- Remove experimental changes for save metadata writes that had previously corrupted the Library data. Please download and apply this patch to restore saving/loading to original metadata format.
- Remove debug message logging for Straw Doll Kamikaze animation.
- Add skeleton for FMW1 Beta Flower Shooting animation. Internal name: `fshooting_beta`

###1.2.4.1a###
- Fix addOn bug for adding new abilities in the Data_Specials group by removing extraneous `pos` argument for functions that append to the abilities database. 

###1.2.4.1###
- Migrate previous mod changes from 1.2.3.x

- Dynamically expand and draw the Abilities list if more than 4 abilities are present in the UI. This fixes previous text overflow UI bugs that did not take into account units (player or enemy) that had more than 4 abilities at a time.

- Fix UI bug where Distortion Barrier appears multiple times in the Abilities list if more than one Portable Gap is equipped.

- Remove Radiator Pack PS fix from modding changes as it is now natively implemented in the vanilla version starting from 1.2.4.

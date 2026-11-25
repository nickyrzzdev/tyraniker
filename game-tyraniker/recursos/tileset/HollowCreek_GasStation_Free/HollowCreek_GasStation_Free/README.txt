HOLLOW CREEK - GAS STATION (FREE)  v1.0
16x16 top-down pixel art | zombie outbreak / survival horror

The first free pack of the Hollow Creek series: a small town overrun by the dead.

CONTENTS
--------
tiles/
  wang_grass_dirt.png, wang_grass_asphalt.png, wang_dirt_asphalt.png
      16-tile corner-based (Wang) transition sets, 4x4 grid.
      Tile index = NW*1 + NE*2 + SW*4 + SE*8  (1 = second terrain).
      Works with Godot 4 Terrain "Match Corners" and Tiled wang sets (see tiled/).
  block_sidewalk_curb.png, block_concrete_on_grass.png
      6x3 grid: cols 0-2 = 3x3 block (edges+center), cols 3-4 rows 0-1 = inner corners
      (TL, TR / BL, BR), col 5 = extra center variants.
  ground_basic.png   grass/dirt/asphalt/concrete/sidewalk variants, cracked asphalt, potholes
decals/              road markings + blood, trails, oil, tire marks, litter, cracks, puddles
                     (transparent - place on a layer above the ground)
props/               41 separate PNGs: fuel pumps, cars (4 variants x 2 directions), dumpster,
                     barricades, lamps, vending/ice machines, fence, barrels, cones ...
buildings/           gas_mart (112x80), canopy_roof (96x64, draw above characters), pump_island
characters/          survivor_jake, zombie_civilian, zombie_attendant
                     16x16 frames, rows = down, left, right, up (RPG Maker order)
                     zombies also have attack (4 dirs x 3) and death (4 frames). See the .json files.
icons/               16 survival item icons (sheet + single files)
tiled/               .tsx tilesets with wang sets for Tiled

All sprites: 16x16 grid, transparent PNG, no scaling - scale by whole numbers (x2, x3, x4)
with nearest-neighbour filtering.

MORE HOLLOW CREEK PACKS
-----------------------
Survivors & Zombies, Main Street, Suburbs, Quarantine Zone, Abandoned Carnival,
Roadside Motel ... and the Mega Pack. Follow the page to get updates.

LICENSE: see LICENSE.txt


#include "BasePNGLoader.as";//needed for adding markers and what not

namespace CMap
{
	enum CustomTiles
	{
		//pick tile indices from here - indices > 256 are advised.
		tile_whatever = 300
	};
};


namespace dodgeball_mapcolors
{
	enum color
	{
		// TILES
		tile_ground           	   = 0xFF844715, // ARGB(255, 132, 71, 21);

		// SPAWNS
		ballg 					   = 0xFF3dec60,
		balld					   = 0xFF0f1b1f,  
		tradingpost_1 			   = 0xFF8888FF,
		tradingpost_2              = 0xFFFF8888
		//OTHER

	}
}

void HandleCustomTile(CMap@ map, int offset, SColor pixel)
{
	switch (pixel.color)
	{
		case dodgeball_mapcolors::ballg:					spawnBlob(map, "ballg", offset, -1, false); break;
		case dodgeball_mapcolors::balld:					spawnBlob(map, "balld", offset, -1, false);  break;
		case dodgeball_mapcolors::tradingpost_1: spawnBlob(map, "tradingpost", offset, 0); break;
		case dodgeball_mapcolors::tradingpost_2: spawnBlob(map, "tradingpost", offset, 1); break;

	}
}
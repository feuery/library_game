//
//  main.c
//  tilexploder
//
//  Created by Ilpo Lehtinen on 29.12.2022.
//

#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <SDL.h>
#include <SDL_image.h>

SDL_Surface* create_surface(int w, int h) {
  Uint32 rmask, gmask, bmask, amask;
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
  rmask = 0xff000000;
  gmask = 0x00ff0000;
  bmask = 0x0000ff00;
  amask = 0x000000ff;
#else
  rmask = 0x000000ff;
  gmask = 0x0000ff00;
  bmask = 0x00ff0000;
  amask = 0xff000000;
#endif

  return SDL_CreateRGBSurface(0, w, h, 32, rmask, gmask, bmask, amask);
}
  

void explode(const char *tileset_path, int tile_w, int tile_h) {
  SDL_Surface *tileset_surface = IMG_Load(tileset_path);
  assert(tileset_surface);

  int tileset_w = tileset_surface->w,
    tileset_h = tileset_surface->h;

  assert(tileset_w % tile_w == 0);
  assert(tileset_h % tile_h == 0);

  for (int x = 0; x < tileset_w; x += tile_w)
    for (int y = 0; y < tileset_h; y += tile_h) {
      SDL_Surface *tile = create_surface(tile_w, tile_h);
      assert(tile);

      SDL_Rect src = {x, y, tile_w, tile_h};

      printf("Taking a tile from %d,%d - %d x %d\n", x, y, tile_w, tile_h);
      
      if(SDL_BlitSurface(tileset_surface, &src, tile, NULL) != 0)
	printf("blisurface failed %s\n", SDL_GetError());


      char filename[1000];
      snprintf(filename, sizeof(filename), "./tile %d %d.png", x / tile_w, y / tile_h);

      printf("Saving file %s\n", filename);
      if(IMG_SavePNG(tile, filename) != 0)
	printf("IMG_SavePNG(\"%s\") failed\n", filename);
      SDL_FreeSurface(tile);
    }

  SDL_FreeSurface(tileset_surface);
    
}

int main(int argc, const char * argv[]) {
  int opt;
  int tile_w = 0,
    tile_h = 0;
  const char *tileset_path = NULL;
  while ((opt = getopt(argc, argv, "w:h:t:")) != -1) {
        switch (opt) {
        case 'w':
	  sscanf(optarg, "%d", &tile_w);
	  break;
	case 'h':
	  sscanf(optarg, "%d", &tile_h);
	  break;
	case 't':
	  tileset_path = optarg;
	  break;
    }
  }

  if (tile_w > 0 ||
      tile_h > 0 ||
      !tileset_path) {
    puts("This app explodes a png tileset into its tiles\n");
    puts("Usage: -w tile_w -h tile_h -t path_to_tileset_you're_exploding_into_tiles");
  }
      
    
  assert (tile_w > 0);
  assert (tile_h > 0);
  assert (tileset_path);

  SDL_Init(SDL_INIT_EVERYTHING);
  IMG_Init(IMG_INIT_PNG);
  atexit(IMG_Quit);
  atexit(SDL_Quit);
  
  printf("%d x %d tiles \n", tile_w, tile_h);
  printf("loading tileset from: %s\n", tileset_path);

  explode(tileset_path, tile_w, tile_h);
  
  return 0;
}

rm tile_*.png
convert "Rocky Grass.png" -crop 64x64 +repage tile_%02d.png

#!/usr/bin/env bash

projects=(
	sdl2
	image
	mixer
<<<<<<< HEAD
	freetype
	ttf
	gfx
=======
	ttf
>>>>>>> 89e0b8a (update scripts to be more generic)
)

for project in ${projects[@]}; do
	./build-${project}.sh
done

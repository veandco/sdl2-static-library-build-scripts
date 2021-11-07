#!/usr/bin/env bash

projects=(
	sdl2
	image
	mixer
	freetype
	ttf
	gfx
)

for project in ${projects[@]}; do
	./build-${project}.sh
done

#!/usr/bin/env bash

projects=(
	sdl2
	png
	jpeg
	image
	mpg123
	ogg
	vorbis
	mixer
	freetype
	ttf
)

for project in ${projects[@]}; do
	./build-${project}.sh
done

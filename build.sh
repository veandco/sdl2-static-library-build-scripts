#!/usr/bin/env bash

projects=(
	sdl2
	image
	mixer
	freetype
	ttf
)

for project in ${projects[@]}; do
	./build-${project}.sh
done

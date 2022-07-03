#!/usr/bin/env bash

projects=(
	sdl2
	image
	mixer
	ttf
	gfx
)

mkdir -p go-sdl2/.go-sdl2-libs

for project in ${projects[@]}; do
	./build-${project}.sh
done

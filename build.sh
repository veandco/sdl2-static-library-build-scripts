#!/usr/bin/env bash

projects=(
	sdl
	img
	mix
	ttf
	gfx
)

mkdir -p go-sdl2/.go-sdl2-libs

for project in ${projects[@]}; do
	./build-${project}.sh
done

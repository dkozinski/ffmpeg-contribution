#!/bin/bash

PKG_CONFIG_PATH=${HOME}/build_windows/lib/pkgconfig/ ./configure \
 --disable-static \
 --enable-shared \
 --prefix="$HOME/build_windows" \
 --arch=x86_64 \
 --target-os=mingw32 \
 --cross-prefix=x86_64-w64-mingw32- \
 --enable-sdl2 \
 --enable-liboapv \
 --enable-gpl \
 --enable-libx264 \
 --enable-ffplay \
 && make -j8 && make install

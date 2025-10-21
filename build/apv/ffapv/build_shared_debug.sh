#!/bin/bash

# This script builds FFmpeg with shared libraries and debug symbols.(with fate tests, debug symbols, and optimizations disabled)
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/build_ubuntu/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --samples=fate-suite/ \
 --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-ffplay \
 --enable-shared \
 --disable-static \
 --enable-liboapv \
 --enable-gpl \
 --enable-libx264 \
 --enable-libx265 \
 --enable-mmx \
 --disable-stripping \
 --extra-cflags="-Og -fno-omit-frame-pointer" \
 --enable-debug=3 \
 --extra-cflags=-fno-inline \
 && make -j $(nproc) && make install


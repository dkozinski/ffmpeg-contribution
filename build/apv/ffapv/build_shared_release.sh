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
 --enable-stripping \
 --extra-cflags="-O3 -fno-inline -fno-omit-frame-pointer" \
 --optflags="-O3" \
 --disable-debug \
 && make -j $(nproc) && make install

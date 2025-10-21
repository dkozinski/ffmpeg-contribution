#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffapv_build/lib/pkgconfig" ./configure --prefix="$HOME/ffapv_build" --pkg-config-flags="--static" --extra-libs="-lpthread -lm" --bindir="$HOME/ffapv_build/bin" --enable-ffplay --enable-gpl --enable-gnutls --enable-libfreetype --enable-liboapv --enable-libx264 --enable-libx265 --enable-nonfree --disable-optimizations --disable-mmx --disable-stripping --extra-cflags=-Og --extra-cflags=-fno-omit-frame-pointer --enable-debug=3 --extra-cflags=-fno-inline && PATH="$HOME/bin:$PATH" make -j $(nproc) && make install

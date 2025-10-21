#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffapv_build_static" --pkg-config-flags="--static" --extra-libs="-lpthread -lm" --enable-static --disable-shared --enable-ffplay --enable-libapv --enable-gpl --enable-libx264 && make -j $(nproc) && make install

#PKG_CONFIG_PATH=${HOME}/ffmpeg_build/lib/pkgconfig/ ./configure  --prefix="$HOME/ffapv_build" --enable-shared --enable-libapv --enable-ffplay && make -j8 && make install

#PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --extra-libs="-lpthread -lm" --bindir="$HOME/bin" --enable-ffplay --enable-gpl --enable-gnutls --enable-libfreetype --enable-libapv --enable-libx264 --enable-nonfree --disable-optimizations --disable-mmx --disable-stripping --extra-cflags=-Og --extra-cflags=-fno-omit-frame-pointer --enable-debug=3 --extra-cflags=-fno-inline && PATH="$HOME/bin:$PATH" make -j $(nproc) && make install

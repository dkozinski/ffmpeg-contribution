#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --pkg-config-flags="--static" \
 --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-static \
 --disable-shared \
 --enable-ffplay \
 --enable-gpl \
 --enable-gnutls \
 --enable-nonfree \
 --enable-liboapv \
 --enable-mmx \
 --enable-stripping \
 --extra-cflags="-O3" \
 --optflags="-O3"
 && make -j $(nproc) && make install

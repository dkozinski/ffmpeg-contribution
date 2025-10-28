#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffapv_build/lib/pkgconfig" ./configure \
 --prefix="$HOME/ffapv_build" \
 --pkg-config-flags="--static" \
 --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-static \
 --disable-shared \
 --enable-ffplay \
 --enable-gpl \
 --enable-gnutls \
 --enable-nonfree \
 --enable-libfreetype \
 --enable-liboapv \
 --enable-debug=3 \
 --disable-optimizations \
 --disable-stripping \
 --extra-cflags="-Og -fno-inline -fno-omit-frame-pointer" \
 --disable-mmx \
  && PATH="$HOME/bin:$PATH" make -j $(nproc) && make install
 && make -j $(nproc) && make install

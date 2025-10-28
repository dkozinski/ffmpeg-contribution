#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/build_ubuntu/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-ffplay \
 --enable-shared \
 --disable-static \
 --enable-liboapv \
 --enable-gpl \
 --disable-optimizations \
 --disable-mmx \
 --disable-stripping \
 --extra-cflags=-Og \
 --extra-cflags=-fno-omit-frame-pointer \
 --enable-debug=3 \
  && make -j $(nproc) && make install
 --extra-cflags=-fno-inline && make -j $(nproc) && make install

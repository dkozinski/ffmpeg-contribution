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
 --enable-mmx \
 --enable-stripping \
 --extra-cflags="-O3" \
 --optflags="-O3"
 && make -j $(nproc) && make install

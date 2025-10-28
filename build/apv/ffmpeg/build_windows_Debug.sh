#!/bin/bash

BUILD_DIR=build_windows_Debug

if [ ! -d "$BUILD_DIR" ]; then
  mkdir $BUILD_DIR
fi

cd $BUILD_DIR
cmake .. -DCMAKE_TOOLCHAIN_FILE=windows_x86_64_toolchain.cmake \
 -DCMAKE_BUILD_TYPE=Debug \
 -DCMAKE_INSTALL_PREFIX=${HOME}/build_windows/ \
 && make clean && make -j 8 && make install

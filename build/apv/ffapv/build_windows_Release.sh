#!/bin/bash

BUILD_DIR=build_windows_Release

if [ ! -d "$BUILD_DIR" ]; then
  mkdir $BUILD_DIR
fi

cd $BUILD_DIR

cmake .. -DCMAKE_TOOLCHAIN_FILE=windows_x86_64_toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/d.kozinski/windows_build/ && make clean && make -j 8 && make install
#cmake -S . -B build-windows-latest -DCMAKE_TOOLCHAIN_FILE=windows_x86_64_toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/d.kozinski/windows_build/

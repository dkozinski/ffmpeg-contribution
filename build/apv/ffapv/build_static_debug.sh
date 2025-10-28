#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/build_ubuntu/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --samples=fate-suite/ \
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

# Optimizatation:

# -Og:
#       Stands for "optimization for debugging", which means it optimizes the code to a lesser extent than -O2 or -O3, making it easier to trace the code in a debugger.

# --disable-optimizations: 
#       Disables optimizations built into FFmpeg itself, not those performed by the compiler.

# --disable-stripping: 
#       Prevents the removal of debugging symbols from the binary file.

# --enable-debug=3: 
#       Enables the highest level of debugging symbols.

# -fno-omit-frame-pointer: 
#       Forces the generation of frame pointers, which is essential for correct stack tracing in a debugger. 

# --pkg-config-flags="--static" 
#       Scope: 
#           External libraries
#       Purpose:
#           - Affects how FFmpeg searches for and links against external dependencies (like libx264, libfreetype).
#           - Tells the pkg-config utility to provide the linker flags for static libraries, including the usually hidden private dependencies required for a full static link.

# --enable-static	
#       Scope: 
#           Internal libraries. 
#       Purpose: 
#           - Controls whether FFmpeg builds its own internal libraries (libavcodec, libavformat, etc.) as static .a files.
#           - Ensures that FFmpeg's own components are built as static library files that can be included directly into the final executable.

# --disable-shared	
#       Scope: 
#           Internal libraries.
#       Purpose: 
#           - Controls whether FFmpeg builds its own internal libraries as shared .so or .dll files.
#           - This explicitly prevents the creation of shared libraries, ensuring that only static versions are generated when used with --enable-static.

# The flag --pkg-config-flags="--static" only controls how FFmpeg looks up external libraries. 
# It forces pkg-config to provide the paths to the static versions of these libraries. 
# However, it does not affect how FFmpeg's own internal libraries are compiled.

# The flag --pkg-config-flags="--static" 
# Scope: External libraries
# Purpose:
# - Affects how FFmpeg searches for and links against external dependencies (like libx264, libfreetype).
# - Tells the pkg-config utility to provide the linker flags for static libraries, including the usually hidden private dependencies required for a full static link.

# --enable-static	
# Scope: Internal libraries. 
# Purpose: 
# - Controls whether FFmpeg builds its own internal libraries (libavcodec, libavformat, etc.) as static .a files.
# - Ensures that FFmpeg's own components are built as static library files that can be included directly into the final executable.

# --disable-shared	
# Scope: Internal libraries. 
# Purpose: 
# - Controls whether FFmpeg builds its own internal libraries as shared .so or .dll files.
# This explicitly prevents the creation of shared libraries, ensuring that only static versions are generated when used with --enable-static.


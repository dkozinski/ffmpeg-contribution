#!/bin/bash

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/build_ubuntu/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --pkg-config-flags="--static" \
  --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-static \
 --disable-shared \
 --enable-ffplay \
 --enable-liboapv \
 --enable-gpl \
 --enable-gpl \
 --enable-mmx \
 --enable-stripping \
 --extra-cflags="-O3" \
 --optflags="-O3"
 && make -j $(nproc) && make install

# -----------------------------------------------------------------------------
# configure --enable-shared
# -----------------------------------------------------------------------------
#
#   Scope:
#       Internal FFmpeg libraries. 
#       This flag controls how FFmpeg's own internal libraries (e.g., libavcodec, libavformat) are compiled.
#   Purpose:
#       Enables compilation of shared libraries (.so or .dll). This means FFmpeg will create dynamically linked libraries that can be used by other programs on the system.
#       Reduces binary size. Dynamic linking allows for smaller executable file sizes, as the common libraries are stored separately.

# -----------------------------------------------------------------------------
# configure --disable-static
# -----------------------------------------------------------------------------
#
#   Scope:
#       Internal FFmpeg libraries. This flag affects the compilation of FFmpeg's internal libraries.
#   Purpose:
#       Disables compilation of static libraries (.a). This is the opposite of the --enable-static flag. When used with --enable-shared, it ensures that FFmpeg will only compile dynamically linked libraries.

# -----------------------------------------------------------------------------
# configure --enable-mmx
# -----------------------------------------------------------------------------
#
#   Scope:
#       Internal FFmpeg optimizations. This flag affects how the FFmpeg code is compiled to utilize specific processor instructions.
#   Purpose:
#       Enables MMX optimizations. MMX instructions are a set of processor extensions that accelerate multimedia operations. Using this flag allows FFmpeg to use these instructions for faster processing.
#       Often the default for most architectures. MMX is typically enabled by default unless explicitly disabled. Using this flag is often redundant but ensures the optimization is explicitly enabled.

# -----------------------------------------------------------------------------
# configure --enable-stripping
# -----------------------------------------------------------------------------
#
#   Scope:
#       Binary file post-processing. This flag affects the final stage of compilation.
#   Purpose:
#       Enables stripping debug symbols from binaries. This option removes debugging symbols, which reduces the size of the final FFmpeg executable files (e.g., ffmpeg, ffplay).
#       Size optimization. This is a standard practice for release builds where minimizing size is more important than debuggability.
#       The opposite of --disable-stripping.

# -----------------------------------------------------------------------------
# configure --extra-cflags="-O3 -fno-inline"
# -----------------------------------------------------------------------------
#
#   Scope:
#       C compiler. These flags are passed directly to the compiler.
#   Purpose:
#       -O3: Turns on the highest level of compiler optimization, maximizing performance at the cost of compile time and, potentially, debuggability.

# -----------------------------------------------------------------------------
# configure --optflags="-O3"
# -----------------------------------------------------------------------------
#
#   Scope:
#       FFmpeg's built-in optimizations. This flag influences the optimization configuration within FFmpeg.
#   Purpose:
#       Enables FFmpeg's internal optimizations at the -O3 level. 
#       This option can activate FFmpeg-specific optimizations that align with the -O3 level.
#       It works independently of the compiler's own flags.
#       Allows for two levels of optimization control: 
#       You can control optimizations at the compiler level (--extra-cflags) and at FFmpeg's internal logic level (--optflags).

# -----------------------------------------------------------------------------
# configure --disable-debug
# -----------------------------------------------------------------------------
#
#   Scope:
#       Compilation and linking. This flag controls whether debugging symbols are included in the compilation and linking process.
#   Purpose:
#       Disables debugging symbols. 
#       This results in smaller binary files and makes them harder to debug, which is desirable for production builds.
#       The inverse of --enable-debug.

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


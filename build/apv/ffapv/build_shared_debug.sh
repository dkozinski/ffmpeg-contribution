#!/bin/bash

# This script builds FFmpeg with shared libraries and debug symbols.(with fate tests, debug symbols, and optimizations disabled)
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/build_ubuntu/lib/pkgconfig" ./configure \
 --prefix="$HOME/build_ubuntu" \
 --samples=fate-suite/ \
 --extra-libs="-lpthread -lm" \
 --bindir="$HOME/build_ubuntu/bin" \
 --enable-ffplay \
 --enable-shared \
 --disable-static \
 --enable-liboapv \
 --enable-gpl \
 --disable-optimizations \
 --enable-mmx \
 --disable-stripping \
 --extra-cflags="-Og -fno-inline -fno-omit-frame-pointer" \
 --enable-debug=3 \
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
# configure --disable-stripping
# -----------------------------------------------------------------------------
#
#   Scope:
#       Internal FFmpeg optimizations.
#       This flag affects how the FFmpeg code is compiled to utilize specific processor instructions.
#   Purpose:
#       Disables the removal of debugging symbols from binaries. 
#           It prevents the strip utility from being run on the executables and shared libraries that FFmpeg builds.
#       Used for debugging. 
#           By keeping the debugging symbols, it's possible to debug the compiled FFmpeg binaries with tools like GDB, which is crucial for development and troubleshooting issues.
#       Increases binary size.
#           The resulting executables and libraries will be larger because they contain all the symbolic and debugging information.
#   The opposite of --enable-stripping, which is typically used for production builds to minimize the size of the final binaries. 

# -----------------------------------------------------------------------------
# configure --extra-cflags="-Og -fno-inline -fno-omit-frame-pointer"
# -----------------------------------------------------------------------------
#
#   Scope:
#       C compiler. These flags are passed directly to the compiler.
#   Purpose:
#       -Og (Optimization for Debugging): 
#           This is a lower level of optimization than -O2 or -O3. 
#           It performs some optimizations that don't hinder the debugging experience, making it easier to trace code in a debugger.
#       -fno-inline (Disable Inlining): 
#           This explicitly disables the compiler optimization known as function inlining. 
#           Inlining replaces function calls with the function's body, which can improve performance but makes debugging more difficult. 
#           Disabling it ensures a more straightforward stack trace.
#       -fno-omit-frame-pointer (Retain Frame Pointers): 
#           This forces the compiler to generate and preserve frame pointers.
#           Frame pointers are crucial for generating accurate stack backtraces, which are essential for effective debugging and profiling. 

# -----------------------------------------------------------------------------
# configure --enable-debug=3
# -----------------------------------------------------------------------------
#
#   Scope:
#       Compilation and Linking. 
#       This flag affects the level of debugging symbols included in the compiled FFmpeg libraries and executables.
#   Purpose:
#       Enables the highest level of debugging symbols (level 3).
#       This means that the resulting binaries will contain the most detailed debug information, such as:

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


#!/bin/bash

git add configure
git add libavcodec/Makefile
git add libavcodec/allcodecs.c
git add libavcodec/libxevd.c
git add doc/general_contents.texi
git add doc/decoders.texi

git commit -m "avcodec/evc_decoder: Provided support for EVC decoder

- Added EVC decoder wrapper
- Changes in project configuration file and libavcodec Makefile
- Added documentation for xevd wrapper"


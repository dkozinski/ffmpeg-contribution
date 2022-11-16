#!/bin/bash

git add configure
git add libavcodec/Makefile
git add libavcodec/allcodecs.c
git add libavcodec/libxeve.c
git add doc/general_contents.texi
git add doc/encoders.texi

git commit -m "avcodec/evc_encoder: Provided support for EVC encoder

- Added EVC encoder wrapper
- Changes in project configuration file and libavcodec Makefile
- Added documentation for xeve wrapper"

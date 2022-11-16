#!/bin/bash

git add libavformat/Makefile
git add libavformat/allformats.c
git add libavformat/rawenc.c
git add doc/muxers.texi

git commit -m "avformat/evc_muxer: Added muxer to handle writing EVC encoded data into file or output bytestream

- Provided AVOutputFormat structure describing EVC output format (ff_evc_muxer)
- Added documentation for EVC muxer"


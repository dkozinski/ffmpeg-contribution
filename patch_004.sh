#!/bin/bash

git add libavformat/Makefile
git add libavformat/allformats.c
git add libavformat/evcdec.c

git commit -m "avformat/evc_demuxer: Added demuxer to handle reading EVC video files

- Provided AVInputFormat struct describing EVC input format (ff_evc_demuxer)"


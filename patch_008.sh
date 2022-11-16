#!/bin/bash

git add libavformat/mov.c
git add libavformat/demux.c

git commit -m "avformat/mov_demuxer: Extended MOV demuxer to handle EVC video content

- Added evc extension to the list of extensions for ff_mov_demuxer"


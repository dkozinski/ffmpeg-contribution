#!/bin/bash

git add libavformat/Makefile
git add libavformat/isom_tags.c
git add libavformat/movenc.c
git add libavformat/evc.h
git add libavformat/evc.c

git commit -m "avformat/mov_muxer: Extended MOV muxer to handle EVC video content

- Changes in mov_write_video_tag function to handle EVC elementary stream
- Provided structure EVCDecoderConfigurationRecord that specifies the decoder configuration information for ISO/IEC 23094-1 video content"


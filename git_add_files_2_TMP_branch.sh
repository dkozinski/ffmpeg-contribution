#!/bin/bash

git add Changelog
git add MAINTAINERS
git add configure
git add doc/decoders.texi
git add doc/encoders.texi
git add doc/general_contents.texi
git add libavcodec/Makefile
git add libavcodec/allcodecs.c
git add libavcodec/avcodec.h
git add libavcodec/codec_desc.c
git add libavcodec/codec_id.h
git add libavcodec/evc_parser.c
git add libavcodec/libxevd.c
git add libavcodec/libxeve.c
git add libavcodec/parsers.c
git add libavcodec/profiles.c
git add libavcodec/profiles.h
git add libavcodec/version.h
git add libavcodec/evc.h

git add libavformat/Makefile
git add libavformat/allformats.c
git add libavformat/evc.c
git add libavformat/evc.h
git add libavformat/evcdec.c
git add libavformat/isom_tags.c
git add libavformat/mov.c
git add libavformat/movenc.c
git add libavformat/rawenc.c
git add libavformat/demux.c

git add doc/muxers.texi

git commit -m "Provided support for MPEG-5 EVC (Essential Video Coding) codec

- Added new entry to codec IDs list
- Added new entry to the codec descriptor list
- Bumped libavcodec minor version
- Changes in Changelog and MAINTAINERS files
- Added xeve encoder wrapper
- Added xevd dencoder wrapper
- Added documentation for xeve and xevd wrappers
- Added parser for EVC format
- Changes in project configuration file and libavcodec Makefilei
- Added muxer for EVC format (MP4, raw)
- Added demuxer for EVC format (MP4)
- Added evc extension to the list of extensions for ff_mov_demuxer
- Added information to moov atomi"



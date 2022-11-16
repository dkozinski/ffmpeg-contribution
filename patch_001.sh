#!/bin/bash

git add libavcodec/avcodec.h
git add libavcodec/codec_desc.c
git add libavcodec/codec_id.h
git add libavcodec/profiles.c
git add libavcodec/profiles.h
git add libavcodec/version.h

git commit -m "avcodec/evc: MPEG-5 EVC codec registration

Added prerequisites that must be met before providing support for the MPEG-5 EVC codec
- Added new entry to codec IDs list
- Added new entry to the codec descriptor list
- Bumped libavcodec minor version
- Added profiles for EVC codec"

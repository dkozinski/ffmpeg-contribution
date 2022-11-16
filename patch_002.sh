#!/bin/bash

git add libavcodec/Makefile
git add libavcodec/evc_parser.c
git add libavcodec/parsers.c
git add libavcodec/evc.h

git commit -m "avcodec/evc_parser: Added parser implementation for EVC format"


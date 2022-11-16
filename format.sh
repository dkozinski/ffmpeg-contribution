#!/bin/bash

FILENAME=$1
echo "--- Filename: $1"
astyle --style=kr --indent=spaces=4 $1

#!/bin/bash

# Copyright (C) 2023 Dawid Kozinski <d.kozinski@samsung.com>

RED='\e[31m'
BLUE='\e[34m'
GREEN='\e[32m'
RESET='\e[0m'

FFMPEG_PATH=$HOME/ffmpeg_build/bin
DATA_PATH=$HOME/d.kozinski/ffmpeg_build/bin
LIB_PATH=$HOME/d.kozinski/ffmpeg_build/lib

export LD_LIBRARY_PATH=$LIB_PATH

WIDTH=1920
HEIGHT=1080
BITRATE="10M"
FRAMERATE=30
TIME_LENGTH=10 # seconds
FORMAT="apv"
PLAY="on" 
CVR="--" # common video resolution

# Tworzenie tablicy asocjacyjnej z formatami i ich rozdzielczościami
declare -A formats
formats=(
    [CIF]="352 288"
    [SVGA]="800 600"
    [VGA]="640 480"
    [XGA]="1024 768"
    [HD]="1366 768"
    [FullHD]="1920 1080"
    [4K-UHD]="3840 2160"
    [4K]="4096 2160" # UHD (4K -> 4096 x 2160)
    [8K-UHD]="7680 4320"
    [8K]="8192 4320"
)

# Tablica z kluczami w odpowiedniej kolejności
ordered_keys=("CIF" "SVGA" "VGA" "XGA" "HD" "FullHD" "4K-UHD" "4K" "8K-UHD" "8K")

# Wyświetlenie wszystkich formatów i ich rozdzielczości w formie tabeli
function show_available_formats() {
    echo "Available formats and resolutions:"
    printf "%-10s\t%s\n" "Format" "Resolution"  # Nagłówki tabeli
    printf "%-10s\t%s\n" "-------" "----------"  # Separator

    # for format in "${ordered_keys[@]}"; do
    #     printf "%-10s\t%s\n" "$format" "${formats[$format]}"
    # done

    for format in "${ordered_keys[@]}"; do
        # Zamiana spacji na " x " w rozdzielczości
        resolution="${formats[$format]}"
        formatted_resolution="${resolution// / x }"
        printf "%-10s\t%s\n" "$format" "$formatted_resolution"
    done

    exit 0
}

# Function to display help
function help() {
  echo "Usage: $0 [-h height | --height height] [-w width | --width width] [-b bitrate | --bitrate bitrate] [-f framerate | --framerate framerate] [-t time | --time time] [ -o output format | --format output format | -p play encoded video | --play play encoded video]"
  echo
  echo "Options:"
  echo "  -h, --height       Height in pixels (default: $HEIGHT)"
  echo "  -w, --width        Width in pixels (default: $WIDTH)"
  echo "  -r, --resolution   Common Video Resolution (default: $CVR)"
  echo "  -b, --bitrate      Bitrate (default: $BITRATE)"
  echo "  -f, --framerate    Framerate (default: $FRAMERATE)"
  echo "  -t, --time         Time in seconds (default: $TIME_LENGTH)"
  echo "  -o, --format       Output format (default: $FORMAT; options: apv, mp4)"
  echo "  -p, --play         Play encoded video (default: $PLAY; options: on, off)"
  echo "  -?, --help         Display help"
  echo
  show_available_formats
}

# Check if parameters were provided
while [[ "$#" -gt 0 ]]; do
  case $1 in
    -h|--height) HEIGHT="$2"; shift ;;
    -w|--width) WIDTH="$2"; shift ;;
    -r|--resolution) CVR="$2"; shift ;;
    -b|--bitrate) BITRATE="$2"; shift ;;
    -f|--framerate) FRAMERATE="$2"; shift ;;
    -t|--time) TIME_LENGTH="$2"; shift ;;
    -o|--format) FORMAT="$2"; shift ;;
    -p|--play) PLAY="$2"; shift ;;
    -?|--help) help; exit 0 ;;
    *) echo -e "${RED}Unknown parameter: $1${RESET}"; help; exit 1 ;;
  esac
  shift
done

# Validate format
if [[ "$FORMAT" != "apv" && "$FORMAT" != "mp4" ]]; then
  echo "Invalid format: $FORMAT. Allowed values are 'apv' or 'mp4'."
  help
  exit 1
fi

if [[ "$PLAY" != "on" && "$PLAY" != "off" ]]; then
  echo "Invalid play option value: $PLAY. Allowed values are 'on' or 'off'."
  help
  exit 1
fi

# Sprawdzenie, czy format istnieje w tablicy
format_input="$CVR"
if [[ -z "${formats[$format_input]}" ]]; then
    echo -e "${RED}Error: Unsupported format${RESET} '$format_input'."
    #help
else
    # Rozdzielenie rozdzielczości na W i H
    read -r WIDTH HEIGHT <<< "${formats[$format_input]}"

    # Wyświetlenie wyników
    echo -e "${BLUE}Selected format:${RESET} $format_input"
    echo -e "${BLUE}Width:${RESET} $WIDTH, ${BLUE}Height:${RESET} $HEIGHT"
    echo
fi

echo "===== $WIDTH"
echo "===== $HEIGHT"

RESOLUTION="${WIDTH}x${HEIGHT}"
FILE_BASENAME="test_${RESOLUTION}_fps${FRAMERATE}_${TIME_LENGTH}s"
INPUT_FILE="${DATA_PATH}/${FILE_BASENAME}.yuv"

if [[ "$FORMAT" == "apv" ]]; then
  OUTPUT_FILE="${DATA_PATH}/${FILE_BASENAME}.yuv.apv"

elif [[ "$FORMAT" == "mp4" ]]; then
  OUTPUT_FILE="${DATA_PATH}/${FILE_BASENAME}.yuv.apv.mp4"
fi


# Wyświetlenie ustawień
echo -e "${GREEN}-- WIDTH:\t${RESET} $HEIGHT"
echo -e "${GREEN}-- HEIGHT:\t${RESET} $WIDTH"
echo -e "${GREEN}-- RSOLUTION:\t${RESET} $RESOLUTION"
echo -e "${GREEN}-- BITRATE:\t${RESET} $BITRATE"
echo -e "${GREEN}-- FRAMERATE:\t${RESET} $FRAMERATE fps"
echo -e "${GREEN}-- STREAM TIME LENGHT:\t${RESET} $TIME_LENGTH seconds"
echo -e "${GREEN}-- FORMAT:\t${RESET} $FORMAT"
echo -e "${GREEN}-- PLAY:\t${RESET} $PLAY"
echo ""
echo "-- input file: ${INPUT_FILE}"
echo "-- output file: ${OUTPUT_FILE}"
echo ""

echo ""
echo -e "${RED}================================================================================${RESET}"
echo -e "${BLUE}1. Create YUV 422 10LE${RESET}"
echo -e "${RED}================================================================================${RESET}"

${FFMPEG_PATH}/ffmpeg -y -f lavfi -i testsrc=size=${RESOLUTION}:rate=${FRAMERATE} -pix_fmt yuv422p10le -t ${TIME_LENGTH} ${INPUT_FILE}

echo ""
echo -e "${RED}================================================================================${RESET}"
echo -e "${BLUE}2. Encoding YUV -> APV${RESET}"
echo -e "${RED}================================================================================${RESET}"

# Example of conditional logic based on the output format
if [[ "$FORMAT" == "apv" ]]; then
  echo "Processing as RAW APV format..."
  ${FFMPEG_PATH}/ffmpeg -y -f rawvideo -pix_fmt yuv422p10le -s:v ${RESOLUTION} -r ${FRAMERATE} -i ${INPUT_FILE} -c:v liboapv -b:v ${BITRATE} ${OUTPUT_FILE}

elif [[ "$FORMAT" == "mp4" ]]; then
  echo "Processing as MP4 format..."
  ${FFMPEG_PATH}/ffmpeg -y -f rawvideo -pix_fmt yuv422p10le -s:v ${RESOLUTION} -r ${FRAMERATE} -i ${INPUT_FILE} -c:v liboapv -b:v ${BITRATE} ${OUTPUT_FILE}
fi

echo ""
echo -e "${RED}================================================================================${RESET}"
echo -e "${BLUE}3. Decoding APV -> YUV${RESET}"
echo -e "${RED}================================================================================${RESET}"

if [[ "$PLAY" == "on" ]]; then
  ${FFMPEG_PATH}/ffplay -autoexit ${OUTPUT_FILE}
else
echo ""
  echo -e "${BLUE}========== 3.1 Decode using liboapv  ==========${RESET}"
 
echo ""
  echo -e "${FFMPEG_PATH}/ffmpeg -c:v liboapv -i ${OUTPUT_FILE} -strict -1 -pix_fmt yuv422p10le -f yuv4mpegpipe ${OUTPUT_FILE}.y4m\n"
  ${FFMPEG_PATH}/ffmpeg -y -c:v liboapv -i ${OUTPUT_FILE} -strict -1 -pix_fmt yuv422p10le -f yuv4mpegpipe  ${OUTPUT_FILE}.y4m
 
  echo ""
  echo -e "${BLUE}=========== 3.2 Probe (liboapv decoding results)  ===========${RESET}"
 
  ${FFMPEG_PATH}/ffprobe ${OUTPUT_FILE}.y4m
  
  echo ""
  echo -e "\n\n${BLUE}========== 3.3 Decode using native apv decoder  ===========${RESET}"
  
  echo -e "${FFMPEG_PATH}/ffmpeg -y -i ${OUTPUT_FILE} -strict -1 -pix_fmt yuv422p10le -f yuv4mpegpipe -pix_fmt yuv422p10le ${OUTPUT_FILE}_nativeapvdec.y4m\n"
  ${FFMPEG_PATH}/ffmpeg -y -i ${OUTPUT_FILE} -strict -1 -pix_fmt yuv422p10le -f yuv4mpegpipe ${OUTPUT_FILE}_nativeapvdec.y4m
  
  
  echo ""
  echo -e "\n\n${BLUE}=========== 3.4 Probe ===========${RESET}"
  
  ${FFMPEG_PATH}/ffprobe -strict 1 ${OUTPUT_FILE}_nativeapvdec.y4m


fi



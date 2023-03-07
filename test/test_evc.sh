#!/bin/bash

On_IRed='\033[0;31m'
Color_Off='\033[0m' # No Color

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White


TEST_DIR=$(date +%Y%m%d)_test
INPUT_DATA_DIR="input_data"
OUTPUT_DATA_DIR="output_data"

FFMPEG_COMMAND="../ffmpeg"
FFPROBE_COMMAND="../ffprobe"
FFPLAY_COMMAND="../ffplay"

test_mulitresolution() {
    echo -e "${BIWhite}${On_Green}Testing input data ...${Color_Off}"	
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/decoder_input-20220114.evc
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/decoder_input-changing-stream.evc
}

test_0() {
    echo -e "${On_Purple}Testing input data ...${Color_Off}"	
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif_10le.yuv
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/Leon-cif.mp4
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/Tears_of_Steel_cif.mp4
}

test_1() {
    echo -e "${On_IRed}[1]${On_Blue} --- (YUV420P) -> (EVC)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc
}

test_2() {
    echo -e "${On_IRed}[2]${On_Blue} --- (YUV420P10LE) -> (EVC)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_10le.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_10le.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_10le.evc
}

test_3() {
    echo -e "${On_IRed}[3]${On_Blue} --- (EVC) -> (YUV420P)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc -pix_fmt yuv420p $OUTPUT_DATA_DIR/akiyo_cif.evc.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288  $OUTPUT_DATA_DIR/akiyo_cif.evc.yuv
}

test_4() {
    echo -e "${On_IRed}[4]${On_Blue} --- (EVC) -> (YUV420Pi10LE)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_10le.evc -pix_fmt yuv420p10le $OUTPUT_DATA_DIR/akiyo_cif_10le.evc.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288  $OUTPUT_DATA_DIR/akiyo_cif_10le.evc.yuv
}

test_5() {
    echo -e "${On_IRed}[5]${On_Blue} --- (YUV420P) -> (MP4)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.mp4
}

test_6() {
    echo -e "${On_IRed}[6]${On_Blue} --- (YUV420P10LE) -> (MP4)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_10le.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4
}

test_7() {
    echo -e "${On_IRed}[7]${On_Blue} --- (MP4) -> (YUV420P)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.mp4 -f rawvideo -pix_fmt yuv420p $OUTPUT_DATA_DIR/akiyo_cif.mp4.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288 $OUTPUT_DATA_DIR/akiyo_cif.mp4.yuv
}

test_8() {
    echo -e "${On_IRed}[8]${On_Blue} --- (MP4) ->  (YUV420P10LE)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4 -f rawvideo -pix_fmt yuv420p10le $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288 $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4.yuv
}

test_9() {
    echo -e "${On_IRed}[9]${On_Blue} --- (EVC) ->  (MP4)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc -c:v copy $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.mp4
}

test_10_A() {
    echo -e "${On_IRed}[10]${On_Blue} --- (MP4) ->  (EVC)${Color_Off}"
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -vcodec copy -an -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -c:v libxeve $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -an -vcodec libxeve $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
}

test_10_B() {
    echo -e "${On_IRed}[10]${On_Blue} --- (MP4) ->  (EVC)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -vcodec copy -an -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -c:v libxeve $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -an -vcodec libxeve $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
}

test_11() {
    echo -e "${On_IRed}[10]${On_Blue} --- (MP4 [h264,aac]) ->  (MP4 [evc,aac])${Color_Off}"
    $FFMPEG_COMMAND -i $INPUT_DATA_DIR/Leon-cif.mp4 -c:v libxeve $OUTPUT_DATA_DIR/Leon-cif.evc.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/Leon-cif.evc.mp4
}

test_params() {
    echo -e "${On_IRed}[1]${On_Blue} --- (YUV420P) -> (EVC)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif.yuv -xeve-params "rc_type=0:qp=45" -qp 10 -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc
}

if test -d "$TEST_DIR"; then
    echo -e "${BIGreen}The directory $TEST_DIR already exists${Color_Off}"
    echo -e "${BIGreen}Delete $TESTS_DIR [yes/no] ?${Color_Off}"
    read bDeleteDir
    if [ $bDeleteDir == 'yes' ]
    then
	echo -e "Deleting existing $TEST_DIR ..."	
	rm -rf $TEST_DIR
    else
       echo -e "Exitingi"
       exit -1
    fi    
fi

echo -e "${BIBlue}Creating $TEST_DIR ...${Color_Off}"
mkdir "${TEST_DIR}"
cd $TEST_DIR

mkdir $INPUT_DATA_DIR
mkdir $OUTPUT_DATA_DIR

for file in ../input_data/* 
do
    echo $file
    cp $file $INPUT_DATA_DIR
done

#test_0
#test_mulitresolution
#test_params
#exit(0)
test_1    # needed for test 10
test_2
test_3
test_4
test_5    # needed for test 10
test_6
test_7
test_8
test_9    # needed for test 10
test_10_A # needed for test 10
test_10_B # needed for test 10
test_11

cd -

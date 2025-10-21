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


TEST_DIR=$(date +%Y%m%d)_apv_test
INPUT_DATA_DIR="input_data"
OUTPUT_DATA_DIR="output_data"

FFMPEG_COMMAND="../ffmpeg"
FFPROBE_COMMAND="../ffprobe"
FFPLAY_COMMAND="../ffplay"

test_0() {
    echo -e "${On_Purple}Testing input data ...${Color_Off}"	
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif_10le.yuv
}

test_1() {
    echo -e "${On_IRed}[1]${On_Blue} --- (YUV422P10LE) -> (EVC)${Color_Off}"
    echo -e "${On_IRed}[1]${On_Blue} --- $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv.apv ${Color_Off}"
    echo -e "${On_IRed}[1]${On_Blue} --- $INPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv ${Color_Off}"
    
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv422p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv -c:v libapve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv.apv
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv.apv
}

test_2() {
    echo -e "${On_IRed}[2]${On_Blue} --- (YUV422P10LE) -> (MP4)${Color_Off}"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv422p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv -c:v libapve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.apv.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.apv.mp4
}

test_3() {
    echo -e "${On_IRed}[3]${On_Blue} --- (MP4) -> (YUV422P10LE)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.apv.mp4 -f rawvideo -pix_fmt yuv422p10le $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.apv.mp4.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv422p10le -video_size 352x288 $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.apv.mp4.yuv
}

test_4() {
    echo -e "${On_IRed}[4]${On_Blue} --- (APV) ->  (MP4)${Color_Off}"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv.apv -c:v libapve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4
 
    # $FFMPEG_COMMAND -framerate 30 -fflags +genpts -i $OUTPUT_DATA_DIR/akiyo_cif_yuv422p10.yuv.apv -c:v copy $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4
    # $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4
}

test_5() {
    echo -e "${On_IRed}[5]${On_Blue} --- (MP4) ->  (APV)${Color_Off}"
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -vcodec copy -an -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4 -c:v libapve $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4.apv
    #$FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4 -an -vcodec libapve $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4.apv
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.apv.mp4.apv
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

for file in ../input_data/apv/* 
do
    echo -e " Copying $file into $INPUT_DATA_DIR ... " 
    cp $file $INPUT_DATA_DIR
done

start=$(date +%s)
#test_0
#test_mulitresolution
#test_params

test_1
test_2
test_3
test_4
test_5

stop=$(date +%s)
duration=$(($stop-$start)) 
echo -e "${On_IRed}Elapsed time:${Color_Off} $(($duration / 60)) minutes and $(($duration % 60)) seconds"
#echo "Elapsed Time: $(($end-$start)) seconds"

cd -


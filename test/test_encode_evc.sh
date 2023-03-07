#!/bin/bash

TEST_DIR=$(date +%Y%m%d)_test
INPUT_DATA_DIR="input_data"
OUTPUT_DATA_DIR="output_data"

FFMPEG_COMMAND="../ffmpeg"
FFPROBE_COMMAND="../ffprobe"
FFPLAY_COMMAND="../ffplay"

test_mulitresolution() {
    echo "Testing input data ..."	
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/decoder_input-20220114.evc
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/decoder_input-changing-stream.evc
}

test_0() {
    echo "Testing input data ..."	
    $FFPLAY_COMMAND -f rawvideo -pixel_format yuv420p -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif.yuv
    $FFPLAY_COMMAND -f rawvideo -pixel_format yuv420p10le -video_size 352x288 $INPUT_DATA_DIR/akiyo_cif_10le.yuv
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/Leon-cif.mp4
    $FFPLAY_COMMAND -autoexit $INPUT_DATA_DIR/Tears_of_Steel_cif.mp4
}

test_1() {
    echo "[1] --- (YUV420P) -> (EVC)"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc
}

test_2() {
    echo "[2] --- (YUV420P10LE) -> (EVC)"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_10le.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_10le.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_10le.evc
}

test_3() {
    echo "[3] --- (EVC) -> (YUV420P)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc -pix_fmt yuv420p $OUTPUT_DATA_DIR/akiyo_cif.evc.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288  $OUTPUT_DATA_DIR/akiyo_cif.evc.yuv
}

test_4() {
    echo "[4] --- (EVC) -> (YUV420Pi10LE)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_10le.evc -pix_fmt yuv420p10le $OUTPUT_DATA_DIR/akiyo_cif_10le.evc.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288  $OUTPUT_DATA_DIR/akiyo_cif_10le.evc.yuv
}

test_5() {
    echo "[5] --- (YUV420P) -> (MP4)"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.mp4
}

test_6() {
    echo "[6] --- (YUV420P10LE) -> (MP4)"
    $FFMPEG_COMMAND -f rawvideo -pix_fmt yuv420p10le -s:v 352x288 -r 30 -i $INPUT_DATA_DIR/akiyo_cif_10le.yuv -c:v libxeve -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4
}

test_7() {
    echo "[7] --- (MP4) -> (YUV420P)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.mp4 -f rawvideo -pix_fmt yuv420p $OUTPUT_DATA_DIR/akiyo_cif.mp4.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p -video_size 352x288 $OUTPUT_DATA_DIR/akiyo_cif.mp4.yuv
}

test_8() {
    echo "[8] --- (MP4) ->  (YUV420P10LE)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4 -f rawvideo -pix_fmt yuv420p10le $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4.yuv
    $FFPLAY_COMMAND -autoexit -f rawvideo -pixel_format yuv420p10le -video_size 352x288 $OUTPUT_DATA_DIR/akiyo_cif_10le.mp4.yuv
}

test_9() {
    echo "[9] --- (EVC) ->  (MP4)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc -c:v copy $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.mp4
}

test_10() {
    echo "[10] --- (MP4) ->  (EVC)"
    $FFMPEG_COMMAND -i $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4 -vcodec copy -an -f rawvideo $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/akiyo_cif.evc.mp4.evc
}

test_11() {
    echo "[10] --- (MP4 [h264,aac]) ->  (MP4 [evc,aac])"
    $FFMPEG_COMMAND -i $INPUT_DATA_DIR/Leon-cif.mp4 -c:v libxeve $OUTPUT_DATA_DIR/Leon-cif.evc.mp4
    $FFPLAY_COMMAND -autoexit $OUTPUT_DATA_DIR/Leon-cif.evc.mp4
}

if test -d "$TEST_DIR"; then
    echo "The directory $TEST_DIR already exists"
    echo "Delete $TESTS_DIR [yes/no] ?"
    read bDeleteDir
    if [ $bDeleteDir == 'yes' ]
    then
	echo "Deleting existing $TEST_DIR ..."	
	rm -rf $TEST_DIR
    else
       echo "Exiting"	    
       exit -1
    fi    
fi

echo "Creating $TEST_DIR ..."
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
test_1
#test_2
#test_3
#test_4
#test_5
#test_6
#test_7
#test_8
#test_9
#test_10
#test_11

cd -

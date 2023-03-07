#./ffmpeg -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i input_data/akiyo_cif.yuv -c:v libxeve -profile:v baseline -preset fast -qp 20 -hash 0 -sei_info 0 -f rawvideo akiyo_cif.evc && ./ffplay akiyo_cif.evc
#./ffmpeg -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i input_data/akiyo_cif.yuv -c:v libxeve -qp 50 -f rawvideo akiyo_cif.evc && ./ffplay akiyo_cif.evc
#./ffmpeg -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i input_data/akiyo_cif.yuv -c:v libxeve -bufsize 1000000 -crf 40 -f rawvideo akiyo_cif.evc && ./ffplay akiyo_cif.evc
#./ffmpeg -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i input_data/akiyo_cif.yuv -c:v libxeve -crf 48 -f rawvideo akiyo_cif.evc && ./ffplay akiyo_cif.evc
./ffmpeg -f rawvideo -pix_fmt yuv420p -s:v 352x288 -r 30 -i input_data/akiyo_cif.yuv -c:v libxeve -rc_mode CRF -crf 32 -bufsize 10M -f rawvideo akiyo_cif.evc && ./ffplay akiyo_cif.evc


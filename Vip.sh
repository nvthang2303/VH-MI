# KAKATHIC

if [ "$Language" == "vi" ];then
kchonlhfd="Chọn ngôn ngữ muốn dịch sang ?"
else
kchonlhfd="Select the language you want to translate into ?"
fi


ui_print2 "  $kchonlhfd"
ui_print2
ui_print2 "  1. Tiếng Việt"
ui_print2 "  2. Test"
ui_print2
ui_print2 "  $kns"
ui_print2
ui_print2 "  1"

vl 1
chontv=$input

if [ "$chontv" == 1 ];then
# Tên ký tự vi-VN
OnlineL="vi-VN"

# Tên đầy đủ Tiếng Việt
OnlineTL="Tiếng Việt"

# Liên kết tới file zip
OnlineU="https://github.com/Belmont-Gabriel/MIUI-12-XML-Vietnamese/archive/refs/heads/master.zip"
elif [ "$chontv" == 2 ];then
OnlineL=
OnlineTL=
OnlineU=
else
ui_print2 "  Error: Language"
abort
fi

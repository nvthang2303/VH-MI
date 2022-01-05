# KAKATHIC


if [ "$Language" == "vi" ];then
kchonlhfd="Chọn ngôn ngữ muốn dịch sang ?"
else
kchonlhfd="Select the language you want to translate into ?"
fi


ui_print
ui_print "  $kchonlhfd"
ui_print
ui_print "  1. Tiếng Việt"
ui_print "  2. Test"
ui_print
ui_print "  $kns"
ui_print
ui_print "  1"

vl 2
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
echo "  Error: Language"
abort
fi

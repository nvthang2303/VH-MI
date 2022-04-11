Test=kakathic

# KAKATHIC

Caidat () {
if [ ! -e /data/data/com.miui.personalassistant/files/maml/res/Widget$1 ];then
echo "- Đang tải dữ liệu."
Taive "https://github.com/kakathic/VH-MI/releases/download/Widgets/Widget$1.zip" "/data/local/tmp/Appvault/Test.zip"
echo "- Cài đặt..."
unzip -qo /data/local/tmp/Appvault/Test.zip -d /data/data/com.miui.personalassistant/files/maml/res
fi
}

Caidat2 () {
if [ ! -e /data/data/com.miui.personalassistant/files/maml/res/0/Widget$1 ];then
echo "- Đang tải dữ liệu."
Taive "https://github.com/kakathic/VH-MI/releases/download/Widgets/Widget$1.zip" "/data/local/tmp/Appvault/Test.zip"
echo "- Cài đặt..."
unzip -qo /data/local/tmp/Appvault/Test.zip -d /data/data/com.miui.personalassistant/files/maml/res/0
fi
}

Caidat 1


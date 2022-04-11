Test=kakathic

if [ -e /system/bin/curl ];then
Taive () { curl -skL "$1" -o "$2"; }
Xem () { curl -skGL "$1"; }
else
Taive () { /data/adb/magisk/busybox wget -q --no-check-certificate "$1" -O "$2" >&2; }
Xem () { /data/adb/magisk/busybox wget -q --no-check-certificate -O - "$1"; }
fi

mkdir -p /data/data/com.miui.personalassistant/files/maml/res/0

# KAKATHIC

Caidat () {
if [ ! -e /data/data/com.miui.personalassistant/files/maml/res/Widget$1 ];then
echo "- Đang tải dữ liệu."
Taive "https://github.com/kakathic/VH-MI/releases/download/Widgets/Widget$1.zip" "/data/local/tmp/Appvault/Test.zip"
echo "- Cài đặt..."
unzip -qo /data/local/tmp/Appvault/Test.zip -d /data/data/com.miui.personalassistant/files/maml/res
rm -fr /data/local/tmp/Appvault/*.zip
fi
}

Caidat2 () {
if [ ! -e /data/data/com.miui.personalassistant/files/maml/res/0/Widget$1 ];then
echo "- Đang tải dữ liệu."
Taive "https://github.com/kakathic/VH-MI/releases/download/Widgets/Widget$1.zip" "/data/local/tmp/Appvault/Test.zip"
echo "- Cài đặt..."
unzip -qo /data/local/tmp/Appvault/Test.zip -d /data/data/com.miui.personalassistant/files/maml/res/0
rm -fr /data/local/tmp/Appvault/*.zip
fi
}

Caidat 1

rm -fr /data/local/tmp/Appvault

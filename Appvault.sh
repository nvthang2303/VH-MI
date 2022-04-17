Test=kakathic

if [ -e /system/bin/curl ];then
Taive () { curl -skL "$1" -o "$2"; }
Xem () { curl -skGL "$1"; }
else
Taive () { /data/adb/magisk/busybox wget -q --no-check-certificate "$1" -O "$2" >&2; }
Xem () { /data/adb/magisk/busybox wget -q --no-check-certificate -O - "$1"; }
fi

mkdir -p /data/data/com.miui.personalassistant/files/maml/res/0
mkdir -p /sdcard/Android/data/com.android.thememanager/files/maml.widget

# KAKATHIC

Caidat () {
if [ ! -e /data/data/com.miui.personalassistant/files/maml/res/0/$1/Vip ];then
echo "- Đang tải: $1"
Taive "https://raw.githubusercontent.com/kakathic/VH-MI/main/Appvault/$1.zip" "/data/local/tmp/Appvault/$1.zip"
echo "- Cài đặt..."
unzip -qo /data/local/tmp/Appvault/$1.zip -d /data/data/com.miui.personalassistant/files/maml/res/0
cp -rf /data/data/com.miui.personalassistant/files/maml/res/0/$1/*/* /sdcard/Android/data/com.android.thememanager/files/maml.widget
if [ "$1" == "b8006e83-c497-4642-9815-f674b82842b0" ] || [ "$1" == "a71db3f8-fc64-428c-8a80-5d11cf75be09" ];then
cp -rf /data/data/com.miui.personalassistant/files/maml/res/0/$1/*/* /data/data/com.miui.personalassistant/files/maml/res
fi
echo "- Xong."
echo > /data/data/com.miui.personalassistant/files/maml/res/0/$1/Vip
fi
}

Caidat f45ca1ae-5574-45d5-98da-f3601d07fab1
Caidat c48cd1fa-c71f-468e-823f-f417c7d8f4c0
Caidat a71db3f8-fc64-428c-8a80-5d11cf75be09
Caidat 31c9a11e-d376-49ce-afd0-945dd4d8aeeb
Caidat 0caa7aab-9e03-4ae8-9eaf-8540cf3550dc
Caidat fd6815cf-761d-444e-a090-7ff3d6c4eb90
Caidat b8006e83-c497-4642-9815-f674b82842b0
Caidat bc0f0cd2-43fd-4323-8061-55a8bc997e1f
Caidat c989887f-fa0d-4963-8c57-896c03e37efc

rm -fr /data/local/tmp/Appvault

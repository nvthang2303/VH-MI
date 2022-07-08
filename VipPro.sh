
# Giống như echo
ui_print2 () { echo "    $1"; sleep 0.05; }
ui_print () { echo "$1"; sleep 0.05; }

# Phím âm lượng
Vl () { 
input2="$1"; input=1
Kgg () { 
Key="$(getevent -qlc 1 | awk '{print $3}')"
if [ "$Key" == "KEY_POWER" ];then
abort
elif [ "$Key" == "KEY_VOLUMEUP" ];then
[ "$input" == "$input2" ] && input=1 || input=$(($input + 1))
ui_print2 "$input"
sleep 0.3
Kgg
elif [ "$Key" == "KEY_VOLUMEDOWN" ];then
ui_print2
ui_print2 "Chọn: $input"
ui_print2
sleep 0.3
else Kgg; fi; }
Kgg
}


# Lấy dữ liệu
Getp () { grep_prop $1 $TMPDIR/module.prop; }

if [ -e /sdcard/VH-MI.prop ];then
Testksks="
version=$(Getp version)
versionCode=$(Getp versionCode)
"
cp -rf /sdcard/VH-MI.prop $TMPDIR/module.prop
echo "$Testksks" >> $TMPDIR/module.prop
fi

Fix () {

Taive "https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/$(Getp Linknn)/Fix.sh" $TMPDIR/Fix.sh
chmod -R 777 $TMPDIR/Fix.sh
. $TMPDIR/Fix.sh

}


# Tìm kiếm
Timkiem () { find $2 -name '*.smali' -exec grep -Rl "$1" {} +; }

# Thay thế smali
Vsmali () {
Vtk="$(find $4 -type f -name '*.smali' -exec grep -Rl "$1" {} +)"
Vbd="$(echo "$3" | sed -z 's|\n|\\n|g')"
for Vka in $Vtk; do
ui_print "- MOD: $(echo "$1") >> $Vka" >&2
sed -i.bak -e "/^$1/,/$2/c $Vbd" "$Vka"
done
}

# Đóng băng
FREEZE () { for TARGET in $1; do mktouch $MODPATH$TARGET/.replace; done; }

# Apktool
apktool () { java -Djava.io.tmpdir=/data/tools/tmp -jar /data/tools/lib/apktool/apktool_2.4.1.jar -p /data/tools/framework -api $API "$@" >&2; }

baksmali () { java -Djava.io.tmpdir=/data/tools/tmp -jar /data/tools/lib/baksmali/baksmali-2.3.4.jar d --api $API "$@" >&2; }

smali () { java -Djava.io.tmpdir=/data/tools/tmp -jar /data/tools/lib/baksmali/smali-2.5.2.jar ass --api $API "$@" >&2; }

# Apksign
apksign () { java -Djava.io.tmpdir=/data/tools/tmp -jar /data/tools/lib/apksign/apksigner.jar sign --cert "/data/tools/lib/apksign/releasekey.x509.pem" --key "/data/tools/lib/apksign/releasekey.pk8" --out "$2" "$1" >&2; }

# unzip smali
unbaksmali () {
T1en="${1##*/}"
mkdir -p /data/tools/tmp/${T1en%.*}
unzip -qo "$1" -d /data/tools/tmp/${T1en%.*}
for vak in /data/tools/tmp/${T1en%.*}/*.dex; do
baksmali "$vak" -o "${vak%.*}"
rm -fr "$vak"
done
}

repmali () {
for vks in /data/tools/tmp/$1/classes*; do
smali "$vks" -o "$vks.dex"
rm -fr "$vks"
done
cd /data/tools/tmp/$1
zip -qr /data/tools/tmp/$1.$2 * >&2
}

unapk () {
[ "$(pm path $1 | grep -cm1 '/data/')" == 1 ] && cp -rf "$(pm path $1 | cut -d : -f2)" /data/tools/$1.apk
[ -e /data/tools/$1.apk ] && cp -rf /data/tools/$1.apk /data/tools/tmp/$1.apk || cp -rf "$(pm path $1 | cut -d : -f2)" /data/tools/tmp/$1.apk

Xtk=$(find /data/app -name *$1*)
[ -e $Xtk ] && rm -fr ${Xtk%/*}

pathapk="$(pm path $1 | cut -d : -f2)"
mkdir -p "$MODPATH${pathapk%/*}"
echo > "$MODPATH${pathapk%.*}.txt"
apktool d -qrf /data/tools/tmp/$1.apk -o /data/tools/tmp/$1

}

repapk () {
apktool b -qc /data/tools/tmp/$1 -f -o /data/tools/tmp/$1.apk
zipalign -f 4 "/data/tools/tmp/$1.apk" "$MODPATH$pathapk"
}


# Static
sed () { toybox sed "$@"; }
cut () { toybox cut "$@"; }


# Xoá dexoat
Xoamount () {
mount -o rw,remount "/" >&2
mount -o rw,remount "/system" >&2
mount -o rw,remount "/system_root" >&2
rm -fr /system/framework/oat
rm -fr /system/framework/arm64
rm -fr /system/framework/arm
for vahkf in $(find /system/framework/*.vdex); do
rm -fr "$vahkf"
done
mount -o ro,remount "/system_root" >&2
mount -o ro,remount "/system" >&2
mount -o ro,remount "/" >&2 || mount -o ro,remount "/" >&2
}

# Giới thiệu
print_modname() {

ui_print
ui_print2 "Tên: $(Getp name)"
ui_print
ui_print2 "Phiên bản: $(Getp version)"
ui_print
ui_print2 "Tác giả: $(Getp author)"
ui_print
ui_print2 "Kênh Telegram: @toolvi"
ui_print
}

# Bắt đầu cài đặt
on_install() {

Lituss="https://raw.githubusercontent.com/kakathic/VH-MI/main/User/$(getprop ro.product.device)"
for Vkdg in $(Xem "$Lituss"); do
kkihh=$(grep -acm1 $Vkdg /data/system/sync/accounts.xml)
[ $kkihh == 1 ] && break
done

[ "$(Xem "$Lituss" | grep -cm1 $kkihh)" == 1 ] || abort "    ! Phát hiện lỗi

    Tên máy: $(getprop ro.product.device)

    Tài khoản Mi: $(grep -m1 account_name /data/system/sync/*.* | tr ' ' '\n' | grep -m1 account_name | cut -d \" -f2)

    Lý do lỗi: Chưa ủng hộ nhà phát triển!
  
    Cách ủng hộ:
  
    Ủng hộ 10k trở nên vào

    Teckombank: 19034902604017
    
    Tên: NGUYEN MINH HIEU

    Nội dung gửi tiền kèm tài khoản mi và tên máy.
  
    Chụp ảnh màn hình này hoặc gửi log

    Cho người làm module.
"

ui_print "! Sử dụng phím âm lượng"
ui_print "! Vol- = Chọn, Vol+ = Chuyển số, Ấn nút nguồn để hủy."
ui_print

if [ "$(Getp VH)" == 1 ];then
Onlinekk=1
ui_print "- Chọn danh sách ứng dụng cần dịch ?"
ui_print
ui_print2 "1. Online"
ui_print2 "2. List có sẵn"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp dsonline)" ];then
litapp=$(Getp dsonline)
ui_print
ui_print2 "Chọn: $litapp"
ui_print
else
Vl 2
litapp=$input
fi
fi

ui_print "- Cài Gapps thêm các dịch vụ Google ?"
ui_print "! Nên dùng cho rom china gốc"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp gapp)" ];then
gapp=$(Getp gapp)
ui_print
ui_print2 "Chọn: $gapp"
ui_print
else
Vl 2
gapp=$input
fi

ui_print "- Cài đặt kho Widget đã Việt hóa ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp widget)" ];then
widget2=$(Getp widget)
ui_print
ui_print2 "Chọn: $widget2"
ui_print
else
Vl 2
widget2=$input
fi

ui_print "- Chuyển nền China thành Global ( beta ) ?"
ui_print "- Sửa lỗi thông báo chậm !"
ui_print "! Muốn quay lại nền china vui lòng gỡ module trước."
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp global)" ];then
globals=$(Getp global)
ui_print
ui_print2 "Chọn: $globals"
ui_print
else
Vl 2
globals=$input
fi

if [ "$globals" == 1 ];then
ui_print "- Tắt thông báo bộ nhớ tạm ở Rom DEV ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp modsecc)" ];then
modsecs=$(Getp modsecc)
ui_print
ui_print2 "Chọn: $modsecs"
ui_print
else
Vl 2
modsecs=$input
fi
fi


ui_print "- Gỡ cài đặt ứng dụng Getapps ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp gettapp)" ];then
getapps=$(Getp gettapp)
ui_print
ui_print2 "Chọn: $getapps"
ui_print
else
Vl 2
getapps=$input
fi


if [ "$globals" == 1 ];then
ui_print "- Hiển thị nhà mạng ở thông báo ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp Systemui)" ];then
Systemii=$(Getp Systemui)
ui_print
ui_print2 "Chọn: $Systemii"
ui_print
else
Vl 2
Systemii=$input
fi

ui_print "- Cho phép cài đặt chủ đề bên thứ ba ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp theme)" ];then
theme3=$(Getp theme)
ui_print
ui_print2 "Chọn: $theme3"
ui_print
else
Vl 2
theme3=$input
fi

fi

ui_print "- Mở khóa tính năng bàn phím nâng cao ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp banphim)" ];then
keyboard=$(Getp banphim)
ui_print
ui_print2 "Chọn: $keyboard"
ui_print
else
Vl 2
keyboard=$input
fi

ui_print "- Sử dụng Font chữ Việt hóa ?"
ui_print
ui_print2 "1. Font IOS"
ui_print2 "2. Font SF V4"
ui_print2 "3. MiSan VH MIUI 13"
ui_print2 "4. Không"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp fontchu)" ];then
fontvh=$(Getp fontchu)
ui_print
ui_print2 "Chọn: $fontvh"
ui_print
else
Vl 4
fontvh=$input
fi

ui_print "- Khi cài đặt xong sẽ khởi động lại máy ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

if [ "$(Getp khoidl)" ];then
rebootk=$(Getp khoidl)
ui_print
ui_print2 "Chọn: $rebootk"
ui_print
else
Vl 2
rebootk=$input
fi

ui_print2 "Tự động xử lý..."
ui_print

# Giải nén
mkdir -p /data/tools/tmp
rm -fr /data/tools/tmp/*

unzip -qo "$ZIPFILE" "system/*" -d $MODPATH >&2
unzip -qo "$ZIPFILE" "Test/*" -d /data/tools/tmp >&2
unzip -qo "$ZIPFILE" "Pack/*" -d /data/tools/tmp >&2

if [ ! -e /data/tools/bin/java ];then
Taive "$(Getp Linkdata)" $TMPDIR/Java.tar.xz
Taive "$(Getp Linktool)" $TMPDIR/Tool.zip
tar x -Jf $TMPDIR/Java.tar.xz -C /data/tools >&2
unzip -qo $TMPDIR/Tool.zip -d /data/tools >&2
fi

# Tải và giải nén tệp dịch

if [ "$Onlinekk" == 1 ];then
Taive "$(Getp Linkurl)" "$TMPDIR/Test.zip"
Taive https://github.com/kakathic/VH-MI/archive/refs/heads/main.zip "$TMPDIR/Testvh.zip"
[ -e "$TMPDIR/Test.zip" ] && unzip -qo "$TMPDIR/Test.zip" -d /data/tools/tmp >&2 || ui_print "- Lỗi tải dữ liệu thất bại !"
[ -e "$TMPDIR/Test.zip" ] || abort
unzip -qo "$TMPDIR/Testvh.zip" -d /data/tools/tmp >&2
cp -rf /data/tools/tmp/*/Language/*/* /data/tools/tmp/*/*/main
fi


# Quyền và đường dẫn
export PATH="/data/tools/bin:$PATH"
chmod -R 777 /data/tools

Tc=0
Tb=0

echo "$(getprop ro.system.build.version.incremental)" >> $MODPATH/OFF

if [ "$(Getp VH)" == 1 ];then

# Cài đặt ngôn ngữ

settings put system system_locales $(Getp Linknn)
ui_print2 "Ngôn ngữ: $(Getp LinkTn)"
ui_print
ui_print2 "Code: $(Getp Linknn)"
ui_print

if [ -e /system/media/VH-$(date +"%Y-%d-%m").txt ];then
ui_print2 "Cài VH thành công"
ui_print
if [ -e /system/product/overlay ];then
mkdir -p $MODPATH/system/product/overlay
cp -rf /system/product/overlay/Z.* $MODPATH/system/product/overlay
else
mkdir -p $MODPATH/system/vendor/overlay
cp -rf /system/vendor/overlay/Z.* $MODPATH/system/vendor/overlay
fi
cp -rf /system/media/theme/default/framework-miui-res $MODPATH/system/media/theme/default
cp -rf /system/media/VH-*.txt $MODPATH/system/media
else
echo > $MODPATH/system/media/VH-$(date +"%Y-%d-%m").txt
# Danh sách dịch
if [ "$litapp" == 1 ];then
Taive "https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/$(Getp Linknn)/List.md" "$TMPDIR/List.md"
List=$(cat "$TMPDIR/List.md")
stm=$(cat "$TMPDIR/List.md" | grep -c '=')
else
List=$(unzip -p "$ZIPFILE" "List.TxT")
stm=$(unzip -p "$ZIPFILE" "List.TxT" | grep -c '=')
fi

# Apktool 

ui_print2 "Tìm thấy: $stm ứng dụng cần dịch"
ui_print
ui_print2 "Tiến hành dịch..."
ui_print

# Hệ thống tự động
for vad in $(echo "$List" | grep "="); do

# Tên gói và apk
pkg=$(echo $vad | grep "=" | cut -d "=" -f1)
path=$(echo $vad | grep "=" | cut -d "=" -f2)
Park=$(echo /data/tools/tmp/*/*/main/$path)

if [ -e $Park ];then
# Sao chép và dán tên gói
cp -rf /data/tools/tmp/Test/* $Park
sed -i "s|Test.com.android|$pkg|g" $Park/AndroidManifest.xml

# Thêm chọn ngôn ngữ
if [ "$pkg" == "android" ];then
sed -i "s|special_locale_names|kakathic|g" $Park/res/*/arrays.xml
mkdir -p $Park/res/values
echo '<?xml version="1.0" encoding="utf-8"?>
<resources>
<string-array name="special_locale_names">
<item>العربية</item>
<item>中文 (简体)</item>
<item>中文 (繁體)</item>
<item>'$(Getp LinkTn)'</item>
</string-array>
<string-array name="special_locale_codes">
<item>ar_EG</item>
<item>zh_CN</item>
<item>zh_TW</item>
<item>'$(echo $(Getp Linknn) | tr '-' '_')'</item>
</string-array>
</resources>' > $Park/res/values/arrays.xml
fi

# Fix theo ngôn ngữ
Fix

# Đóng gói bằng apktool và ký

apktool b -q /data/tools/tmp/*/*/main/$path -f -o "/data/tools/tmp/Apk/tmp/Z.$pkg.apk"
mkdir -p "/data/tools/tmp/Apk/Z.$pkg"
apksign "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" "/data/tools/tmp/Apk/Z.$pkg/Z.$pkg.apk"
rm -fr "/data/tools/tmp/Apk/Z.$pkg/Z.$pkg.apk.idsig"

fi
# Đếm ứng dụng đã được dịch và thông báo
[ -s "/data/tools/tmp/Apk/Z.$pkg/Z.$pkg.apk" ] && Tc=$(($Tc + 1)) || Tb=$(($Tb + 1))
spt=$(($spt + 1))
ui_print2 "Xong $spt"
ui_print
done

# Dán apk vào MODPATH
if [ -e /system/product/overlay ];then
mkdir -p $MODPATH/system/product/overlay
cp -rf /data/tools/tmp/Apk/Z.* $MODPATH/system/product/overlay
else
mkdir -p $MODPATH/system/vendor/overlay
cp -rf /data/tools/tmp/Apk/Z.* $MODPATH/system/vendor/overlay
fi

if [ -e /system/product/overlay/GmsCnConfigOverlay.apk ] || [ -e /system/vendor/overlay/GmsCnConfigOverlay.apk ];then
[ -e /system/product/overlay ] && unzip -qo $TMPDIR/overlay.zip -d $MODPATH/system/product >&2 || unzip -qo $TMPDIR/overlay.zip -d $MODPATH/system/vendor/overlay >&2
fi

if [ "$(echo "$List" | grep -cm1 'com.miui.core=miui.apk')" == 1 ];then
ui_print2 "Dịch 3 ứng dụng hệ thống"
ui_print
# Dịch Miui framework v.v

for vad in $(grep "@string/" /data/tools/tmp/Pack/theme_values.xml); do
T1="$(echo "$vad" | cut -d "><" -f3 | sed 's|@string/||g')"
T2="$(grep 'name="'$T1'"' /data/tools/tmp/*/*/main/miui.apk/res/*/strings.xml | cut -d "><" -f3)"
sed -i "s|<item>@string/$T1</item>|<item>$T2</item>|g" /data/tools/tmp/Pack/theme_values.xml
done

sed -i -e 's|<?xml version="1.0" encoding="UTF-8" standalone="no"?>||g' -e 's|<resources>||g' -e 's|</resources>||g' -e 's|<?xml version="1.0" encoding="utf-8"?>||g' /data/tools/tmp/*/*/main/*/res/*/*.xml

cat /data/tools/tmp/*/*/main/miui.apk/res/*/*.xml >> /data/tools/tmp/Pack/theme_values.xml
cat /data/tools/tmp/*/*/main/framework-ext-res.apk/res/*/*.xml >> /data/tools/tmp/Pack/theme_values.xml
cat /data/tools/tmp/*/*/main/miuisystem.apk/res/*/*.xml >> /data/tools/tmp/Pack/theme_values.xml
echo "</resources>" >> /data/tools/tmp/Pack/theme_values.xml

sed -i -e 's|>" |> |g' -e 's| "<| <|g' -e 's|>"|>|g' -e 's|"<|<|g' -e 's|%%|%|g' -e 's|\\"|"|g' /data/tools/tmp/Pack/theme_values.xml
fi

mkdir -p /data/tools/tmp/Pack/nightmode
mkdir -p /data/tools/tmp/Pack
cp -rf /data/tools/tmp/Pack/theme_values.xml /data/tools/tmp/Pack/nightmode
unzip -qo /system/framework/framework-ext-res/framework-ext-res.apk "res/drawable/pop_camera_low_wave5.png" "res/drawable/pop_camera_high_wave5.png" -d /data/tools/tmp/Pack
mv -f /data/tools/tmp/Pack/res/drawable/pop_camera_high_wave5.png /data/tools/tmp/Pack/res/drawable/pop_camera_high_wave.png
mv -f /data/tools/tmp/Pack/res/drawable/pop_camera_low_wave5.png /data/tools/tmp/Pack/res/drawable/pop_camera_low_wave.png
cp -rf /data/tools/tmp/Pack/res /data/tools/tmp/Pack/nightmode

unzip -qo /system/framework/framework-ext-res/framework-ext-res.apk "res/drawable/pop_camera_low_wave.png" "res/drawable/pop_camera_high_wave.png" -d /data/tools/tmp
mv -f /data/tools/tmp/res/drawable/pop_camera_high_wave.png /data/tools/tmp/res/drawable/pop_camera_high_wave5.png
mv -f /data/tools/tmp/res/drawable/pop_camera_low_wave.png /data/tools/tmp/res/drawable/pop_camera_low_wave.png5.png
cp -rf /data/tools/tmp/res /data/tools/tmp/Pack/nightmode
cp -rf /data/tools/tmp/res /data/tools/tmp/Pack


cd /data/tools/tmp/Pack
zip -r $MODPATH/system/media/theme/default/framework-miui-res * >&2
mv $MODPATH/system/media/theme/default/framework-miui-res.zip $MODPATH/system/media/theme/default/framework-miui-res
fi

fi


# Tạo font
if [ "$fontvh" == 1 ];then
ui_print2 "Cài Font"
ui_print
cd $MODPATH/system/fonts
ln -sf MiLanProVF.ttf MiSansVF.ttf
ln -sf MiLanProVF.ttf RobotoVF.ttf
ln -sf MiLanProVF.ttf Roboto-Regular.ttf
elif [ "$fontvh" == 4 ];then
ui_print2 "Xoá Font"
ui_print
rm -fr $MODPATH/system/fonts
else
ui_print2 "Cài Font"
ui_print
Taive https://github.com/kakathic/VH-MI/releases/download/Font/Font$fontvh.zip $TMPDIR/Font.zip
[ -e "$TMPDIR/Font.zip" ] && unzip -qo $TMPDIR/Font.zip -d $MODPATH/system/fonts >&2 || ui_print "- Lỗi tải dữ liệu thất bại !"
[ -e "$TMPDIR/Font.zip" ] || abort
cd $MODPATH/system/fonts
ln -sf MiLanProVF.ttf MiSansVF.ttf
ln -sf MiLanProVF.ttf RobotoVF.ttf
ln -sf MiLanProVF.ttf Roboto-Regular.ttf
fi

if [ "$widget2" != 1 ];then
ui_print2 "Tải Widget"
ui_print
chmod 777 $MODPATH/system/bin/Appvault
. $MODPATH/system/bin/Appvault >&2
else
rm -fr $MODPATH/system/bin/Appvault
fi


if [ "$gapp" != 1 ];then
ui_print2 "Cài Gapps"
ui_print
[ -e "/data/tools/Testgapp_$(date +"%Y-%d-%m").zip" ] || rm -fr /data/tools/Testgapp_*.zip
[ -e "/data/tools/Testgapp_$(date +"%Y-%d-%m").zip" ] || Taive "https://github.com/kakathic/VH-MI/releases/download/Gapps/Gapp$API.zip" "/data/tools/Testgapp_$(date +"%Y-%d-%m").zip"
unzip -qo "/data/tools/Testgapp_$(date +"%Y-%d-%m").zip" -d $MODPATH >&2
if [ -e $MODPATH/system/product/app/LatinImeGoogle/LatinImeGoogle.apk ];then
mkdir -p /data/local/tmp/apks
cp -f $MODPATH/system/product/app/LatinImeGoogle/LatinImeGoogle.apk /data/local/tmp/apks
pm install -r /data/local/tmp/apks/LatinImeGoogle.apk >&2
sleep 2
ime enable com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME >&2
ime set com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME >&2
rm -fr /data/local/tmp/apks >&2

else
ui_print "- Lỗi tải dữ liệu thất bại !"
abort
fi

fi

if [ "$globals" != 1 ];then
ui_print2 "Chuyển nền Global"
ui_print

AutoTv () {
pm uninstall $1 >&2
mkdir -p /data/local/tmp/apks
bmmmm="$(pm path "$1" | cut -d : -f2)"
mkdir -p "$MODPATH${bmmmm%/*}"
Taive "$2" /data/local/tmp/apks/test.apk
if [ "$bmmmm" ];then
cp -rf /data/local/tmp/apks/test.apk "$MODPATH$bmmmm"
pm install -r /data/local/tmp/apks/test.apk >&2
else
pm install -r /data/local/tmp/apks/test.apk >&2
fi
rm -fr /data/local/tmp/apks/*
}

AutoTv com.android.thememanager "https://github.com/kakathic/VH-MI/releases/download/Apk/Theme.apk"
AutoTv com.miui.weather2 "https://github.com/kakathic/VH-MI/releases/download/Apk/Weather2.apk"
AutoTv com.xiaomi.discover "https://github.com/kakathic/VH-MI/releases/download/Apk/Updatemiui.apk"

rm -fr $MODPATH/system/etc
rm -fr $MODPATH/system/bin
rm -fr /data/local/tmp/apks

rm -fr $MODPATH/system/*/overlay/Z.com.miui.weather2
rm -fr $MODPATH/system/*/overlay/Z.com.android.thememanager

echo 'ro.product.mod_device=kakathic_global' >> $TMPDIR/system.prop

fi


if [ "$modsecs" == 1 ] && [ "$globals" == 1 ];then
ui_print2 "Tắt thông báo bộ nhớ tạm"
ui_print
pm uninstall com.miui.securitycenter >&2
mkdir -p /data/local/tmp/apks
Taive "https://github.com/kakathic/VH-MI/releases/download/Apk/SecurityCenter0.apk" /data/local/tmp/apks/test.apk

pm install -r /data/local/tmp/apks/test.apk >&2
rm -fr /data/local/tmp/apks
pm uninstall -k com.miui.securitycenter >&2
hhfgh="$(pm path "com.miui.securitycenter" | cut -d : -f2)"
mkdir -p "$MODPATH${hhfgh%/*}"
Taive "https://github.com/kakathic/VH-MI/releases/download/Apk/SecurityCenter.apk" $MODPATH$hhfgh

unzip -qo $MODPATH$hhfgh lib/arm64-v8a/* -d "$MODPATH${hhfgh%/*}"
mv -f "$MODPATH${hhfgh%/*}"/lib/arm64-v8a "$MODPATH${hhfgh%/*}"/lib/arm64
fi

# Fix lỗi gỡ getapps
if [ "$getapps" == 1 ];then
ui_print2 "Gỡ Getapps"
ui_print

[ -e /system/framework/oat ] && Xoamount
pm uninstall com.xiaomi.market >&2
Ssys=$(find /system/*/*Market*/ -name .replace)

if [ -e ${Ssys%/*}/.replace ];then

mkdir -p $MODPATH/system/framework
[ -e /system/framework/miui-services.jar ] && cp -rf /system/framework/miui-services.jar $MODPATH/system/framework
cp -rf /system/framework/services.jar $MODPATH/system/framework
FREEZE "${Ssys%/*}"
else
[ -e /system/framework/miui-services.jar ] && unbaksmali /system/framework/miui-services.jar
unbaksmali /system/framework/services.jar
Vsmali ".method private checkSystemSelfProtection(Z)V" \
".end method" \
'.method private checkSystemSelfProtection(Z)V
    .registers 3

    return-void
.end method' \
"/data/tools/tmp/*services/classes*/com/miui/server/*"
# Kết thúc
Timpkg=$(pm path com.xiaomi.market | cut -d : -f2)
FREEZE "${Timpkg%/*}"
fi
fi

if [ $Systemii == 1 ] && [ "$globals" == 1 ];then
ui_print2 "Hiện tên nhà mạng"
ui_print

modui () {
tk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;'
kk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;
const/4 v0, 0x0'
Tkllg="$(grep -Rl "$tk" /data/tools/tmp/$1/smali*)"
echo "Mod: $Tkllg" >&2
sed -i "s|$tk|$kk|g" $Tkllg
}

checkui="$(pm path "com.android.systemui" | cut -d : -f2)"
if [ "$(echo "$checkui" | grep -cm1 '/data/')" == 1 ] || [ ! -e "${checkui%.*}.txt" ];then
unapk com.android.systemui
modui com.android.systemui
repapk com.android.systemui
else
mkdir -p "$MODPATH${checkui%/*}"
cp -rf "${checkui%/*}"/*.apk "$MODPATH${checkui%/*}"
cp -rf "${checkui%/*}"/*.txt "$MODPATH${checkui%/*}"
fi
fi


if [ "$theme3" == 1 ] && [ "$globals" == 1 ];then
ui_print2 "Hack Theme"
ui_print2

modtheme () {
kzbddb="$(grep -Rl "IconCardView.java" /data/tools/tmp/$1/smali*)"
[ "$kzbddb" ] && sed -i 's/com.miui.player/com.android.camera/g' $kzbddb || ui_print2 "Lỗi: IconCardView.java" >&2

HTk4="$(grep -Rl "DRM_ERROR_UNKNOWN" /data/tools/tmp/$1/smali*)"
[ "$HTk4" ] && sed -i 's/DRM_ERROR_UNKNOWN/DRM_SUCCESS/g' $HTk4 || ui_print2 "Lỗi: DRM_ERROR_UNKNOWN" >&2

HTk1="$(find /data/tools/tmp/$1/smali* -type f -name 'OnlineResourceDetailPresenter.smali' | xargs grep -Rl '.OnlineResourceDetail;->bought:Z')"

[ "$HTk1" ] && sed -i -e '/OnlineResourceDetail;->bought:Z/i\    const/4 v0, 0x1' -e '/OnlineResourceDetail;->bought:Z/i\    return v0' $HTk1 || ui_print2 "Lỗi: OnlineResourceDetail" >&2

Vsmali ".method public isVideoAd()Z" \
".end method" \
'.method public isVideoAd()Z
    .registers 2

    const/4 v0, 0x0

    return v0
.end method' \
"/data/tools/tmp/$1/smali*/*"

Vsmali ".method private static isAdValid" \
".end method" \
'.method private static isAdValid(Lcom/android/thememanager/basemodule/ad/model/AdInfo;)Z
    .registers 2

    const/4 p0, 0x0

    return p0
.end method' \
"/data/tools/tmp/$1/smali*/*"

}

checktheme="$(pm path "com.android.thememanager" | cut -d : -f2)"
if [ "$(echo "$checktheme" | grep -cm1 '/data/')" == 1 ] || [ ! -e "${checktheme%.*}.txt" ];then
unapk com.android.thememanager
modtheme com.android.thememanager
repapk com.android.thememanager
else
mkdir -p "$MODPATH${checktheme%/*}"
cp -rf "${checktheme%/*}"/*.apk "$MODPATH${checktheme%/*}"
cp -rf "${checktheme%/*}"/*.txt "$MODPATH${checktheme%/*}"
fi
fi


if [ "$keyboard" == 1 ];then
ui_print2 "Bàn phím nâng cao"
ui_print

[ -e /system/framework/oat ] && Xoamount

if [ -e /system/framework/oat ];then
ui_print2 "Vui lòng xoá các mục sau nếu không sẽ bị bootloop !"
ui_print
ui_print2 "/system/framework/oat"
ui_print2 "/system/framework/arm64"
ui_print2 "/system/framework/arm"
ui_print "$(find /system/framework/*.vdex)" | awk '{print "    " $1}'
abort
fi



Listbp="$(ime list -s | cut -d '/' -f1 | sed -e '/com.iflytek.inputmethod.miui/d' -e '/com.sohu.inputmethod.sogou.xiaomi/d' -e '/com.baidu.input_mi/d' -e '/com.miui.securityinputmethod/d')"


if [ -e /system/media/Key.txt ];then
mkdir -p $MODPATH/system/framework
[ -e /system/framework/miui-services.jar ] && cp -rf /system/framework/miui-services.jar $MODPATH/system/framework
[ -e /system/framework/miui-framework.jar ] && cp -rf /system/framework/miui-framework.jar $MODPATH/system/framework

cp -rf /system/framework/framework.jar $MODPATH/system/framework/framework.jar
cp -rf /system/framework/services.jar $MODPATH/system/framework
echo > $MODPATH/system/media/Key.txt
else
echo > $MODPATH/system/media/Key.txt

if [ ! -e /data/tools/tmp/miui-services ];then
[ -e /system/framework/miui-services.jar ] && unbaksmali /system/framework/miui-services.jar
fi
[ -e /data/tools/tmp/services ] || unbaksmali /system/framework/services.jar

unbaksmali /system/framework/framework.jar
[ -e /system/framework/miui-framework.jar ] && unbaksmali /system/framework/miui-framework.jar

for Vaki in $Listbp; do
if [ "$Vaki" ];then
Dso1=$(($Dso1 + 1))
[ "$Dso1" == 1 ] && Keyk=com.iflytek.inputmethod.miui
[ "$Dso1" == 2 ] && Keyk=com.baidu.input_mi
[ "$Dso1" == 3 ] && Keyk=com.sohu.inputmethod.sogou.xiaomi
[ "$Dso1" == 4 ] && Keyk=com.android.cts.mockime

if [ "$Dso1" -le 4 ];then
sed -i "s|$Keyk|$Vaki|g" $(Timkiem "$Keyk" "/data/tools/tmp/*services/classes*/com/android/server/inputmethod/*")
sed -i "s|$Keyk|$Vaki|g" $(Timkiem "$Keyk" "/data/tools/tmp/*framework/classes*/android/inputmethodservice/*")
else
break
fi
fi
done
fi

modphrase () {
Dso1=0
for Vaki in $Listbp; do
if [ "$Vaki" ];then
Dso1=$(($Dso1 + 1))
[ "$Dso1" == 1 ] && Keyk=com.iflytek.inputmethod.miui
[ "$Dso1" == 2 ] && Keyk=com.baidu.input_mi
[ "$Dso1" == 3 ] && Keyk=com.sohu.inputmethod.sogou.xiaomi
[ "$Dso1" == 4 ] && Keyk=com.android.cts.mockime

if [ "$Dso1" -le 4 ];then
sed -i "s|$Keyk|$Vaki|g" $(Timkiem "$Keyk" "/data/tools/tmp/$1/smali*/com/miui/inputmethod/*")
else
break
fi
fi
done

}

checkphrase="$(pm path "com.miui.phrase" | cut -d : -f2)"
if [ "$(echo "$checkphrase" | grep -cm1 '/data/')" == 1 ] || [ ! -e "${checkphrase%.*}.txt" ];then
unapk com.miui.phrase
modphrase com.miui.phrase
repapk com.miui.phrase
else
mkdir -p "$MODPATH${checkphrase%/*}"
cp -rf "${checkphrase%/*}"/*.apk "$MODPATH${checkphrase%/*}"
cp -rf "${checkphrase%/*}"/*.txt "$MODPATH${checkphrase%/*}"
fi

modset () {
Dso1=0
for Vaki in $Listbp; do
if [ "$Vaki" ];then
Dso1=$(($Dso1 + 1))
[ "$Dso1" == 1 ] && Keyk=com.iflytek.inputmethod.miui
[ "$Dso1" == 2 ] && Keyk=com.baidu.input_mi
[ "$Dso1" == 3 ] && Keyk=com.sohu.inputmethod.sogou.xiaomi
[ "$Dso1" == 4 ] && Keyk=com.android.cts.mockime

if [ "$Dso1" -le 4 ];then
sed -i "s|$Keyk|$Vaki|g" $(Timkiem "$Keyk" "/data/tools/tmp/$1/smali*/com/android/settings/inputmethod/*")
else
break
fi
fi
done
Vsmali '.method public static isMiuiImeBottomSupport()Z' \
'.end method' \
'.method public static isMiuiImeBottomSupport()Z
    .registers 1

    const/4 v0, 0x1

    return v0
.end method' \
"/data/tools/tmp/$1/smali*/*"
}

checkset="$(pm path "com.android.settings" | cut -d : -f2)"
if [ "$(echo "$checkset" | grep -cm1 '/data/')" == 1 ] || [ ! -e "${checkset%.*}.txt" ];then
unapk com.android.settings
modset com.android.settings
repapk com.android.settings
else
mkdir -p "$MODPATH${checkset%/*}"
cp -rf "${checkset%/*}"/*.apk "$MODPATH${checkset%/*}"
cp -rf "${checkset%/*}"/*.txt "$MODPATH${checkset%/*}"
fi

fi


ui_print2 "Đóng gói lại tất cả..."
ui_print
# Nén lại

mkdir -p $MODPATH/system/framework
[ -e /data/tools/tmp/framework ] && repmali framework jar
[ -e /data/tools/tmp/framework.jar ] && cp -rf /data/tools/tmp/framework.jar $MODPATH/system/framework/framework.jar
[ -e /data/tools/tmp/miui-framework ] && repmali miui-framework jar
[ -e /data/tools/tmp/miui-framework.jar ] && cp -rf /data/tools/tmp/miui-framework.jar $MODPATH/system/framework

[ -e /data/tools/tmp/services ] && repmali services jar
[ -e /data/tools/tmp/miui-services ] && repmali miui-services jar

[ -e /data/tools/tmp/services.jar ] && cp -rf /data/tools/tmp/services.jar $MODPATH/system/framework
[ -e /data/tools/tmp/miui-services.jar ] && cp -rf /data/tools/tmp/miui-services.jar $MODPATH/system/framework

for Bala in product vendor system_ext; do
[ -e $MODPATH/$Bala ] && mv -f $MODPATH/$Bala $MODPATH/system
done

ui_print2 "OK: $Tc, Error: $Tb"
ui_print
}

# Cấp quyền
set_permissions() { 
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/system/bin 0 2000 0755 0755
}

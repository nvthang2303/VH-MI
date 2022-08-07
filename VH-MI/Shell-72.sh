# kakathic
[ "$version" ] || exit

# Sao lưu 
PAPP () { Lapp="$(pm path "$1" | cut -d : -f2)"; Lpkg="$1"; }
SLapp () {
mkdir -p "$MODPATH${Lapp%/*}"
[ "$(cat "${Lapp%.*}.$1")" ] && FREEZE "$(cat "${Lapp%.*}.$1")"
cp -af "${Lapp%/*}"/* "$MODPATH${Lapp%/*}"
[ -e "$MODPATH${Lapp%/*}/oat" ] && rm -fr "$MODPATH${Lapp%/*}/oat"
}

Log () {
[ "$1" ] && echo "$1" >> $TMPDIR/Ten.log
}

# Giải mã apk
unapk () {
if [ "$(echo "$Lapp" | grep -cm1 '/data/')" == 1 ];then
cp -rf $Lapp $Dtool/apks/$Lpkg.apk
else
[ -e $Lapp ] && cp -rf $Lapp $TMPDIR/rac/$Lpkg.apk
fi
[ -e $Dtool/apks/$Lpkg.apk ] && cp -rf $Dtool/apks/$Lpkg.apk $TMPDIR/rac/$Lpkg.apk
mkdir -p $TMPDIR/rac/$Lpkg
unzip -qo "$TMPDIR/rac/$Lpkg.apk" '*.dex' 'lib/*' -d $TMPDIR/rac/$Lpkg
for Uapk in $TMPDIR/rac/$Lpkg/*.dex; do
baksmali "$Uapk" -o "${Uapk%.*}"
done
pm uninstall -k $Lpkg >&2
[ "$( pm path $Lpkg )" ] && echo "$( pm path $Lpkg | cut -d : -f2 )" > "$TMPDIR/rac/$Lpkg.txt"
}

# Đóng gói lại apk
repapk () {
if [ -e $TMPDIR/rac/$1.txt ];then
Pathapk="$MODPATH$(cat $TMPDIR/rac/$1.txt)";
if [ -e "$TMPDIR/rac/$1/lib/$ABI" ];then
mkdir -p "${Pathapk%/*}/lib"
unzip -o -q "$TMPDIR/rac/$1.apk" "lib/$ABI/*" -d "${Pathapk%/*}/lib/$ARCH"
fi
Xan "APK: $1"
Likapk="$(echo "$Links" | grep "$1" | cut -d '/' -f2 | sort | uniq)"
for Rapk in $Likapk; do
Lksh="$TMPDIR/rac/$1/$Rapk.dex"
rm -fr "$Lksh"
smali "${Lksh%.*}" -o "$Lksh"
done
cd $TMPDIR/rac/$1
zip -qr -0 "$TMPDIR/rac/$1.apk" *.dex
zipalign -f -p 4 "$TMPDIR/rac/$1.apk" "$Pathapk"
fi
}

# Undex
undex () {
T1en="${1##*/}"
mkdir -p $TMPDIR/rac/${T1en%.*}
unzip -qo "$1" '*.dex' -d $TMPDIR/rac/${T1en%.*}
for SA in $TMPDIR/rac/${T1en%.*}/*.dex; do
baksmali "$SA" -o "${SA%.*}"
done
}

# Repdex
repdex () {
T2en="${1##*/}"
Xan "JAR: $T2en"
Likjar="$(echo "$Links" | grep "${T2en%.*}" | cut -d '/' -f2 | sort | uniq)"
for CH in $Likjar; do
Dkndsj="$TMPDIR/rac/${T2en%.*}/$CH.dex"
rm -fr "$Dkndsj"
smali "${Dkndsj%.*}" -o "$Dkndsj"
done
cp -rf "$1" "$TMPDIR/rac/$T2en"
cd $TMPDIR/rac/${T2en%.*}
zip -qr -0 "$TMPDIR/rac/$T2en" *.dex
zipalign -f -p 4 "$TMPDIR/rac/$T2en" "$MODPATH${framework%/*}/$T2en"
}

# Tìm kiếm
Timkiem () { find $2 -name "$3" -exec grep -Rl "$1" {} +; }

# Thay thế smali
Vsmali () {
[ "$5" ] && Teak="$5" || Teak="*.smali"
Vtk="$(Timkiem "$1" "$4" "$Teak")"
Vbd="$(echo "$3" | sed -z 's|\n|\\n|g')"
for Vka in $Vtk; do
ui_print "MOD: $(echo "$1" | sed 's|\\||g')" >&2
sed -i -e "/^$1/,/$2/c $Vbd" "$Vka"
Log "$Vka"
done
}

# Tự động thay
Autott () {
for vahhf in $(grep -Rl "$2" $TMPDIR/rac/$1); do
while true; do
DSOTK1="$(grep -c "$2" $vahhf)"
[ "$DSOTK1" == 0 ] && break
DVBTK="$(grep -m1 "$2" $vahhf)"
TTh1="$(echo "$DVBTK" | sed -e 's|sget-boolean|const|' -e "s|$2|$3|")"
jsbdbd="$(echo "$DVBTK" | grep -c 'sget-boolean')"
[ "$jsbdbd" == 1 ] && sed -i "s|$DVBTK|$TTh1|" $vahhf
Log "$vahhf"
[ "$jsbdbd" != 1 ] && break
done
done
}

Lisit () {
for Mak in $3; do
Autott "$1$Mak$2" "$4" "$5"
done
}

# Tự động thay
AutoAll () {
for gwgeh in $(Timkiem "$1" "$TMPDIR/rac/$3" "*.smali"); do
while true; do
rhhgh="$(grep -c "$1" $gwgeh)"
[ "$rhhgh" == 0 ] && break
rhheg="$(grep -m1 "$1" $gwgeh)"
ggege="$(echo "$rhheg" | sed -e 's|sget-boolean|const|' -e "s|$1|$2|")"
rhbrb="$(echo "$rhheg" | grep -c 'sget-boolean')"
[ "$rhbrb" == 1 ] && sed -i "s|$rhheg|$ggege|" $gwgeh
Log "$gwgeh"
[ "$rhbrb" != 1 ] && break
done
done
}

# Xoá odex
Xoamount () {
Lix="${services%/*}/oat
${framework%/*}/arm64
${framework%/*}/arm
$(find ${framework%/*}/*.vdex 2>/dev/null)
$(find ${framework%/*}/*.bprof 2>/dev/null)
$(find ${framework%/*}/*.prof 2>/dev/null)
"

if [ "$(find $(magisk --path)/.magisk/mirror/system_root${services%/*}/oat 2>/dev/null | head -n1)" ];then
echo '
[ -e /data/adb/modules/safetynet-fix ] && echo > /data/adb/modules/safetynet-fix/remove
' >> $TMPDIR/post-fs-data.sh
cd $TMPDIR
for kssfsc in $Lix; do
ln -sf module.prop "$MODPATH$kssfsc"
done
fi

if [ "$(find $(magisk --path)/.magisk/mirror/system_root${services%/*}/oat 2>/dev/null | head -n1)" ];then
mrw
for Kalo in $Lix; do
rm -fr "$Kalo"
done
sleep 1
mro
fi
}

Xservices () {
Lix="$(echo ${services%/*}/oat/*/$Sten*)
${framework%/*}/$Sten.jar.bprof
${framework%/*}/$Sten.jar.prof
"

if [ "$(find $(magisk --path)/.magisk/mirror/system_root$(echo ${services%/*}/oat/*/$Sten*) 2>/dev/null | head -n1)" ];then
cd $TMPDIR
for kssfsc in $Lix; do
ln -sf module.prop "$MODPATH$kssfsc"
done
fi

if [ "$(find $(magisk --path)/.magisk/mirror/system_root$(echo ${services%/*}/oat/*/$Sten*) 2>/dev/null | head -n1)" ];then
mrw
for Kalo in $Lix; do
rm -fr "$Kalo"
done
sleep 1
mro
fi
}

# Mod Apk 
VipApk () {
PAPP "$1"
if [ ! -e ${Lapp%.*}.$2 ];then
[ -e $TMPDIR/rac/$1 ] || unapk
$2
viptmz="$MODPATH$(cat $TMPDIR/rac/$Lpkg.txt)"
mkdir -p "${viptmz%/*}"
echo > "${viptmz%.*}.$2"
else
SLapp $2
fi
}

# Mod Framework
VipFW () { 
echo > $MODPATH${framework%/*}/tmp/$1
if [ -e ${framework%/*}/tmp/$1 ];then
cp -rf "$framework" $MODPATH${framework%/*}
else
[ -e $TMPDIR/rac/$Ften ] || undex "$framework"
$1
fi
}

# Mod Services
VipSV () {
echo > $MODPATH${services%/*}/tmp/$1
if [ -e ${services%/*}/tmp/$1 ];then
cp -rf "$services" $MODPATH${services%/*}
else
[ -e $TMPDIR/rac/$Sten ] || undex "$services"
$1
fi
}

AutoTv () {
pm uninstall $1 >&2
bmmmm="$(pm path "$1" | cut -d : -f2)"
mkdir -p "$MODPATH${bmmmm%/*}"
Taive "$2" $TMPDIR/rac/$1.apk
if [ "$bmmmm" ];then
cp -rf $TMPDIR/rac/$1.apk "$MODPATH$bmmmm"
unzip -oq "$MODPATH$bmmmm" lib/arm64-v8a/* -d "$MODPATH${bmmmm%/*}"
mv -f "$MODPATH${bmmmm%/*}"/lib/arm64-v8a "$MODPATH${bmmmm%/*}"/lib/arm64
else
pm install -r $TMPDIR/rac/$1.apk >&2
fi
}

Compress () { 
[ -e $TMPDIR/rac/$1 ] && repapk $1
[ -e $TMPDIR/rac/$1 ] && sleep 2
}

# Bắt đầu
Apilt=$(grep -m1 com.xiaomi /data/system/sync/*.* | tr ' ' '\n' | grep -m1 account= | cut -d \" -f2)
[ -z "$Apilt" ] && Apilt=$(grep -aB1 'type' /data/system/sync/accounts.xml | head -n1 | cut -d '/' -f1)
[ -z "$Apilt" ] && Apilt="Lỗi id TK Mi"

Lituss="$(Xem https://raw.githubusercontent.com/kakathic/VH-MI/main/User/$(getprop ro.product.device))"

for Vkdg in $Lituss; do
kkihh=$(grep -acm1 $Vkdg /data/system/sync/accounts.xml)
[ $kkihh == 1 ] && break
done

if [ "$kkihh" != 1 ];then
ui_print "! Thông báo
"
ui_print "  Tên máy: $(getprop ro.product.device)

  Tài khoản Mi: $Apilt
"  
ui_print "  Để sử dụng lâu dài bạn nên ủng hộ để sử dụng

  vĩnh viễn.

  Thử nghiệm sẽ có tác dụng trong ngày hôm đó.

  Hết thời gian sẽ tự động reboot máy.
"
[ -e /data/local/log/Log.txt ] && abort "- Bạn đã hết lượt dùng thử rùi.
"
am start -W -a android.intent.action.VIEW -d "http://kakathic.github.io/VH-MI/support.html" >&2

echo '
if [ "$(grep -cm1 "/data/local/log/Log.txt")" != 1 ];then
echo "d2hpbGUgdHJ1ZTsgZG8KaWYgWyAiJChjYXQgJHswJS8qfS9UZXN0KSIgIT0gIiQoZGF0ZSArIiVk
IikiIF07dGhlbgplY2hvICJI4bq/dCBUaW1lOiAkKGRhdGUpIiA+IC9kYXRhL2xvY2FsL2xvZy9M
b2cudHh0CmVjaG8gPiAkezAlLyp9L3JlbW92ZQplY2hvID4gL2RhdGEvYWRiL21vZHVsZXMvVkgv
cmVtb3ZlCnNsZWVwIDMwMApyZWJvb3QKZWxzZQplY2hvICI+ICQoZGF0ZSkiID4+ICR7MCUvKn0v
TG9nLnR4dApbIC1lICR7MCUvKn0vVGVzdCBdICYmIHNsZWVwIDMwMCB8fCBlY2hvID4gJHswJS8q
fS9yZW1vdmUKWyAtZSAkezAlLyp9L1Rlc3QgXSAmJiBzbGVlcCAzMDAgfHwgZWNobyA+IC9kYXRh
L2FkYi9tb2R1bGVzL1ZIL3JlbW92ZQpbIC1lICR7MCUvKn0vVGVzdCBdIHx8IHNsZWVwIDMwMApb
IC1lICR7MCUvKn0vVGVzdCBdIHx8IHJlYm9vdApmaQpkb25l" | base64 -d >> ${0%/*}/service.sh
chmod -R 777 ${0%/*}/service.sh
fi
' >> $TMPDIR/post-fs-data.sh
echo "$(date +"%d")" > $MODPATH/Test
else
ui_print2 "Chào bạn: $Apilt"
ui_print
ui_print2 "Cảm ơn bạn đã ủng hộ VH-MI"
ui_print
[ -e /data/local/log/Log.txt ] && rm -fr /data/local/log/Log.txt
fi

ui_print "! Sử dụng phím âm lượng"
ui_print "! Vol- = Chọn số hiện tại, Vol+ = Chuyển đổi số."
ui_print "! Ấn nút nguồn để hủy."
ui_print

ui_print "- Thêm ngôn ngữ Tiếng Việt vào Rom ?"
ui_print
ui_print2 "1. Có"
ui_print2 "2. Không"

if [ "$(Getp VH)" ];then
VHI=$(Getp VH)
ui_print
ui_print2 "Chọn: $VHI"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
VHI=$input
fi

if [ "$VHI" == 1 ];then
ui_print "- Chọn danh sách ứng dụng cần dịch ?"
ui_print
ui_print2 "1. Online"
ui_print2 "2. List tự sửa"

if [ "$(Getp dsonline)" ];then
litapp=$(Getp dsonline)
ui_print
ui_print2 "Chọn: $litapp"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
litapp=$input
fi

ui_print "- Thêm lịch âm ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp Licham2)" ];then
Licham=$(Getp Licham2)
ui_print
ui_print2 "Chọn: $Licham"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
Licham=$input
fi
fi

ui_print "- Sử dụng Font chữ Việt hóa ?"
ui_print
ui_print2 "1. Tắt"
ui_print2 "2. Font IOS"
ui_print2 "3. File"

if [ "$(Getp fontchu)" ];then
fontvh=$(Getp fontchu)
ui_print
ui_print2 "Chọn: $fontvh"
ui_print
else
ui_print
ui_print2 "1"
Vl 3
fontvh=$input
fi

ui_print "- Sửa thông báo chậm, hoặc chuyển nền Global ?"
ui_print
ui_print2 "1. Tắt"
ui_print2 "2. China Mod"
ui_print2 "3. Global"
ui_print2 "4. Global Mod"

if [ "$(Getp global)" ];then
globals=$(Getp global)
ui_print
ui_print2 "Chọn: $globals"
ui_print
else
ui_print
ui_print2 "1"
Vl 4
globals=$input
fi

ui_print "- Cho phép cập nhật ứng dụng hệ thống ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp caiapk)" ];then
Ucaiapk=$(Getp caiapk)
ui_print
ui_print2 "Chọn: $Ucaiapk"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
Ucaiapk=$input
fi


if [ "$globals" -le 2 ] && [ "$API" -ge 30 ];then
ui_print "- Hiển thị nhà mạng ở thông báo ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp Systemui)" ];then
Systemii=$(Getp Systemui)
ui_print
ui_print2 "Chọn: $Systemii"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
Systemii=$input
fi
fi

ui_print "- Cài Gapps thêm các dịch vụ Google ?"
ui_print "! Nên dùng cho rom china gốc"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp gapp)" ];then
gapp=$(Getp gapp)
ui_print
ui_print2 "Chọn: $gapp"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
gapp=$input
fi

ui_print "- Cài đặt kho Widget đã Việt hóa ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp widget)" ];then
widget2=$(Getp widget)
ui_print
ui_print2 "Chọn: $widget2"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
widget2=$input
fi


if [ "$globals" != 3 ];then
ui_print "- Cho phép cài đặt chủ đề bên thứ ba ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp theme)" ];then
theme3=$(Getp theme)
ui_print
ui_print2 "Chọn: $theme3"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
theme3=$input
fi
fi

ui_print "- Gỡ cài đặt ứng dụng Getapps ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp gettapp)" ];then
getapps=$(Getp gettapp)
ui_print
ui_print2 "Chọn: $getapps"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
getapps=$input
fi
ui_print "- Cài đặt ứng dụng thời tiết mod Global ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp Thoitiet)" ];then
Gthoitiet=$(Getp Thoitiet)
ui_print
ui_print2 "Chọn: $Gthoitiet"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
Gthoitiet=$input
fi

ui_print "- Mở khóa tính năng bàn phím nâng cao ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp banphim)" ];then
keyboard=$(Getp banphim)
ui_print
ui_print2 "Chọn: $keyboard"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
keyboard=$input
fi

ui_print "- Khi cài đặt xong sẽ khởi động lại máy ?"
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"

if [ "$(Getp khoidl)" ];then
rebootk=$(Getp khoidl)
ui_print
ui_print2 "Chọn: $rebootk"
ui_print
else
ui_print
ui_print2 "1"
Vl 2
rebootk=$input
fi

ui_print2 "Xử lý dữ liệu..."
ui_print

# Giải nén
unzip -qo "$ZIPFILE" "system/*" -d $MPATH
unzip -qo "$ZIPFILE" "Test/*" "Lapp/*" "Pack/*" -d $TMPDIR
unzip -qo "$TMPDIR/Clock.zip" -d /sdcard/MIUI
unzip -qo "$TMPDIR/Clock.zip" -d /sdcard/Android/data/com.android.thememanager/files/MIUI
[ -e "$VHMI/color/Sáng.ini" ] || unzip -qo -j "$ZIPFILE" "lib/*.ini" -d $VHMI/color
[ -e "$VHMI/color/Tối.ini" ] || unzip -qo -j "$ZIPFILE" "lib/*.ini" -d $VHMI/color

# jre 11
if [ ! -e "$Dtool/lib/$version" ];then
unzip -p "$ZIPFILE" "lib/Java.tar.xz" | tar x -J -C $Dtool
echo > "$Dtool/lib/$version"
fi

# Lịch âm
[ "$Licham" == 2 ] && Lichamkk='E, dd.MM - (e.N)' || Lichamkk='EEEE, dd/MM'

if [ "$VHI" == 1 ];then

# Cài đặt ngôn ngữ
settings put system system_locales $(Getp Linknn)
ui_print2 "Ngôn ngữ: $(Getp LinkTn)"
ui_print
ui_print2 "Code: $(Getp Linknn)"
ui_print

[ -e /system/product/overlay ] && Overlay=/system/product/overlay || Overlay=/system/vendor/overlay

if [ -e $Dbackup.txt ];then
ui_print2 "Đã thêm $(Getp LinkTn)"
ui_print
else

[ -e "$Dtool/backup/Test-$DATE.zip" ] || Taive https://github.com/Belmont-Gabriel/MIUI-12-XML-Vietnamese/archive/refs/heads/master.zip "$Dtool/backup/Test-$DATE.zip"

if [ -e "$Dtool/backup/Test-$DATE.zip" ];then
unzip -qo "$Dtool/backup/Test-$DATE.zip" -d $TMPDIR/rac >&2
cp -rf $TMPDIR/Lapp/* $TMPDIR/rac/*/*/main
else
abort "- Lỗi tải dữ liệu thất bại !
"
fi

# Danh sách dịch
if [ "$litapp" == 1 ];then
List="$(Xem https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/vi-VN/List.md)"
stm=$(echo "$List" | grep -c =)
[ -e $VHMI/List.md ] || echo "$List" > $VHMI/List.md
else
[ -e $VHMI/List.md ] || Xem https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/vi-VN/List.md > $VHMI/List.md
List=$(cat $VHMI/List.md)
stm=$(echo "$List" | grep -c =)
fi

ui_print2 "Tìm thấy: $stm ứng dụng cần dịch"
ui_print
ui_print2 "Tiến hành dịch..."
ui_print

Tc=0
Tb=0

# Hệ thống tự động
for vad in $(echo "$List" | grep =); do

# Tên gói và apk
pkg=$(echo $vad | grep "=" | cut -d "=" -f1)
path=$(echo $vad | grep "=" | cut -d "=" -f2)
Park=$(echo $TMPDIR/rac/*/*/main/$path)

if [ -e $Park ];then
# Sao chép và dán tên gói
cp -rf $TMPDIR/Test/* $Park
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
if [ ! -e "$TMPDIR/rac/Fix.sh" ];then
Taive https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/vi-VN/Fix.sh $TMPDIR/rac/Fix.sh
chmod 777 $TMPDIR/rac/Fix.sh
fi;
if [ -e "$TMPDIR/rac/Fix.sh" ];then
. "$TMPDIR/rac/Fix.sh"
else
Xan "- Lỗi: Thay thế văn bản! "
fi

# Đóng gói bằng apktool và ký
apktool b -q $TMPDIR/rac/*/*/main/$path -f -o "$TMPDIR/rac/Apk/Z.$pkg.apk" 2>/dev/null >/dev/null
apksign "$TMPDIR/rac/Apk/Z.$pkg.apk" "$Dbackup$Overlay/Z.$pkg.apk" 2>/dev/null >/dev/null

# Auto sửa lỗi
if [ ! -s "$Dbackup$Overlay/Z.$pkg.apk" ];then
if [ ! -e "$TMPDIR/rac/Fixrep.sh" ];then
Taive https://raw.githubusercontent.com/kakathic/VH-MI/main/Language/vi-VN/Fixrep.sh $TMPDIR/rac/Fixrep.sh
chmod 777 $TMPDIR/rac/Fixrep.sh
fi
if [ -e "$TMPDIR/rac/Fixrep.sh" ];then
. $TMPDIR/rac/Fixrep.sh
else
Xan "- Lỗi: Tự động sửa string!"
fi
fi
fi

# Đếm ứng dụng đã được dịch và thông báo
[ -s "$Dbackup$Overlay/Z.$pkg.apk" ] && Tc=$(($Tc + 1)) || Tb=$(($Tb + 1))
spt=$(($spt + 1))
Xan "$spt. $pkg"
done

[ "$Tc" != 0 ] && ui_print2 "OK: $Tc, Error: $Tb
"

if [ "$(echo "$List" | grep -cm1 'com.miui.core')" == 1 ];then
ui_print2 "Dịch 3 ứng dụng hệ thống"
ui_print
# Dịch Miui framework v.v

for vad in $(grep "@string/" $TMPDIR/Pack/theme_values.xml); do
T1="$(echo "$vad" | cut -d "><" -f3 | sed 's|@string/||g')"
T2="$(grep 'name="'$T1'"' $TMPDIR/rac/*/*/main/miui.apk/res/*/strings.xml | cut -d "><" -f3)"
sed -i "s|<item>@string/$T1</item>|<item>$T2</item>|g" $TMPDIR/Pack/theme_values.xml
done

Sedcl () {
sed -i -e 's|<?xml version="1.0" encoding="UTF-8" standalone="no"?>||g' -e 's|<resources>||g' -e 's|</resources>||g' -e 's|<?xml version="1.0" encoding="utf-8"?>||g' $TMPDIR/rac/*/*/main/$1/res/*/*.xml
}

Sedcl miui.apk
Sedcl miuisystem.apk
Sedcl framework-ext-res.apk

[ "$Licham" == 2 ] && sed -i -e "s|>EEEE dd/MM<|>$Lichamkk<|g" $TMPDIR/rac/*/*/main/miuisystem.apk/res/*/*.xml

cat $TMPDIR/rac/*/*/main/miui.apk/res/*/*.xml >> $TMPDIR/Pack/theme_values.xml
cat $TMPDIR/rac/*/*/main/framework-ext-res.apk/res/*/*.xml >> $TMPDIR/Pack/theme_values.xml
cat $TMPDIR/rac/*/*/main/miuisystem.apk/res/*/*.xml >> $TMPDIR/Pack/theme_values.xml
echo "</resources>" >> $TMPDIR/Pack/theme_values.xml

sed -i -e 's|>" |> |g' -e 's| "<| <|g' -e 's|>"|>|g' -e 's|"<|<|g' -e 's|%%|%|g' -e 's|\\"|"|g' $TMPDIR/Pack/theme_values.xml
fi

mkdir -p $TMPDIR/Pack/nightmode
mkdir -p $TMPDIR/Pack
cp -rf $TMPDIR/Pack/theme_values.xml $TMPDIR/Pack/nightmode

unzip -qo "$(pm path com.miui.rom | cut -d : -f2)" "res/drawable/pop_camera_low_wave5.png" "res/drawable/pop_camera_high_wave5.png" -d $TMPDIR/Pack
mv -f $TMPDIR/Pack/res/drawable/pop_camera_high_wave5.png $TMPDIR/Pack/res/drawable/pop_camera_high_wave.png
mv -f $TMPDIR/Pack/res/drawable/pop_camera_low_wave5.png $TMPDIR/Pack/res/drawable/pop_camera_low_wave.png

cp -rf $TMPDIR/Pack/res $TMPDIR/Pack/nightmode

unzip -qo "$(pm path com.miui.rom | cut -d : -f2)" "res/drawable/pop_camera_low_wave.png" "res/drawable/pop_camera_high_wave.png" -d $TMPDIR/rac
mv -f $TMPDIR/rac/res/drawable/pop_camera_high_wave.png $TMPDIR/rac/res/drawable/pop_camera_high_wave5.png
mv -f $TMPDIR/rac/res/drawable/pop_camera_low_wave.png $TMPDIR/rac/res/drawable/pop_camera_low_wave.png5.png

cp -rf $TMPDIR/rac/res $TMPDIR/Pack/nightmode
cp -rf $TMPDIR/rac/res $TMPDIR/Pack

cd $TMPDIR/Pack
zip -qr $Dbackup/system/media/theme/default/framework-miui-res.zip * >&2
mv $Dbackup/system/media/theme/default/framework-miui-res.zip $Dbackup/system/media/theme/default/framework-miui-res

echo > $Dbackup.txt

fi
# VHI
fi

Xan "Tạo nền màu phím nâng cao"
# Tạo màu bàn phím 
mkdir -p $TMPDIR/banphim/nightmode
# Sáng
echo '<?xml version="1.0" encoding="utf-8"?>
<MIUI_Theme_Values>
<color name="input_bottom_background_color">#'$(cat $VHMI/color/Sáng.ini)'</color>
</MIUI_Theme_Values>' > $TMPDIR/banphim/theme_values.xml
# Tối
echo '<?xml version="1.0" encoding="utf-8"?>
<MIUI_Theme_Values>
<color name="input_bottom_background_color">#'$(cat $VHMI/color/Tối.ini)'</color>
</MIUI_Theme_Values>' > $TMPDIR/banphim/nightmode/theme_values.xml
# Đóng gói 
cd $TMPDIR/banphim
zip -qr $Dbackup/system/media/theme/default/com.miui.phrase.zip * >&2
mv $Dbackup/system/media/theme/default/com.miui.phrase.zip $Dbackup/system/media/theme/default/com.miui.phrase

Xan
# Tạo font
if [ "$fontvh" == 2 ];then
ui_print2 "Cài Font"
ui_print
cd $MPATH/system/fonts
ln -sf MiLanProVF.ttf MiSansVF.ttf
ln -sf MiLanProVF.ttf RobotoVF.ttf
ln -sf MiLanProVF.ttf Roboto-Regular.ttf
elif [ "$fontvh" == 3 ];then
ui_print2 "Cài Font"
ui_print
[ -e "$VHMI/fonts/MiLanProVF.ttf" ] || abort "- Lỗi không tìm thấy tệp font MiLanProVF.ttf !
"
cp -rf $VHMI/fonts $MPATH/system
cd $MPATH/system/fonts
ln -sf MiLanProVF.ttf MiSansVF.ttf
ln -sf MiLanProVF.ttf RobotoVF.ttf
ln -sf MiLanProVF.ttf Roboto-Regular.ttf
else
ui_print2 "Xoá Font"
ui_print
rm -fr $MPATH/system/fonts
fi

Xan
if [ "$widget2" == 2 ];then
ui_print2 "Tải Widget"
ui_print
chmod 777 $MPATH/system/bin/Appvault
. $MPATH/system/bin/Appvault >&2
fi

Xan
if [ "$gapp" == 2 ];then
ui_print2 "Cài Gapps"
ui_print
if [ ! -e $Dbackup/system/product/app/LatinImeGoogle/LatinImeGoogle.apk ];then
Taive "https://github.com/kakathic/VH-MI/releases/download/Gapps/Gapp$API.zip" "$TMPDIR/gapp.zip"
unzip -qo "$TMPDIR/gapp.zip" -d $Dbackup >&2
[ -e $Dbackup/system/product/app/LatinImeGoogle/LatinImeGoogle.apk ] || abort "- Lỗi tải dữ liệu thất bại !
"
fi
if [ -e $Dbackup/system/product/priv-app/GooglePlayServicesUpdater ];then
cp -f $Dbackup/system/product/priv-app/GooglePlayServicesUpdater/GooglePlayServicesUpdater.apk /data/local/tmp
pm install -r /data/local/tmp/GooglePlayServicesUpdater.apk >&2
rm -fr $Dbackup/system/product/priv-app/GooglePlayServicesUpdater
rm -fr /data/local/tmp/GooglePlayServicesUpdater.apk
fi
if [ -z "$(pm path "com.google.android.inputmethod.latin")" ];then
cp -f $Dbackup/system/product/app/LatinImeGoogle/LatinImeGoogle.apk /data/local/tmp
pm install -r /data/local/tmp/LatinImeGoogle.apk >&2
rm -fr /data/local/tmp/LatinImeGoogle.apk
sleep 1
ime enable com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME >&2
ime set com.google.android.inputmethod.latin/com.android.inputmethod.latin.LatinIME >&2
fi
fi

Xan
# Lấy dữ liệu 
modpki () {
Tksm="$(Timkiem "iget p0, p0, Landroid\/content\/pm\/ApplicationInfo;->uid:I" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"

Vsmali ".method public static o(Landroid\/content\/pm\/ApplicationInfo;)Z" \
".end method" \
'.method public static o(Landroid/content/pm/ApplicationInfo;)Z
    .registers 3
    const/4 v1, 0x1
    return v1
.end method' \
"$Tksm"

Vsmali ".method public static a(Landroid\/content\/pm\/ApplicationInfo;)Z" \
".end method" \
'.method public static a(Landroid/content/pm/ApplicationInfo;)Z
    .registers 1
    const/4 v0, 0x0
    return v0
.end method' \
"$Tksm"
}

modtheme () {
kzbddb="$(Timkiem "IconCardView.java" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
[ "$kzbddb" ] && sed -i 's/com.miui.player/com.android.camera/g' $kzbddb || Xan "- Lỗi: IconCardView.java"
[ "$kzbddb" ] && Xan "MOD: Thay icon nhạc"

HTk4="$(Timkiem "DRM_ERROR_UNKNOWN" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
[ "$HTk4" ] && sed -i 's/DRM_ERROR_UNKNOWN/DRM_SUCCESS/g' $HTk4 || Xan "- Lỗi: DRM_ERROR_UNKNOWN"
[ "$HTk4" ] && Xan "MOD: DRM_SUCCESS"

HTk1="$(Timkiem ".OnlineResourceDetail;->bought:Z" "$TMPDIR/rac/$Lpkg/classes*" "OnlineResourceDetailPresenter.smali")"
[ "$HTk1" ] && sed -i -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    const/4 v0, 0x1' -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    return v0' $HTk1 || Xan "- Lỗi: OnlineResourceDetail"
[ "$HTk1" ] && Xan "MOD: OnlineResourceDetail"

HTk21="$(Timkiem ".OnlineResourceDetail;->bought:Z" "$TMPDIR/rac/$Lpkg/classes*" "j*.smali")"
[ "$HTk21" ] && sed -i -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    const/4 v0, 0x1' -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    return v0' $HTk21 || Xan "- Lỗi: j OnlineResourceDetail"
[ "$HTk21" ] && Xan "MOD: j* OnlineResourceDetail"

Vsmali ".method public isVideoAd()Z" \
".end method" \
'.method public isVideoAd()Z
    .registers 2
    const/4 v0, 0x0
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/classes*/*"

Vsmali ".method private static isAdValid" \
".end method" \
'.method private static isAdValid(Lcom/android/thememanager/basemodule/ad/model/AdInfo;)Z
    .registers 2
    const/4 p0, 0x0
    return p0
.end method' \
"$TMPDIR/rac/$Lpkg/classes*/*"
kkodh="$(Timkiem "ro.miui.region" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
[ "$kkodh" ] && Xan "MOD: Khu vực china"

for dhbe in $kkodh; do
[ "$dhbe" ] && sed -i 's|ro.miui.region|ro.khu.vuc.cn|g' $dhbe
done
Log "$HTk21
$HTk1
$Tksm
$HTk4
$kkodh
$kzbddb"
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/classes*"
}

modui () {
tk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;'
kk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;
const/4 v0, 0x0'

Tkllg="$(Timkiem "$tk" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
Log "$Tkllg"
[ "$Tkllg" ] && Xan "MOD: Tên nhà mạng"
[ "$Tkllg" ] && sed -i "s|$tk|$kk|g" $Tkllg || Xan "- Lỗi: mod hiện tên nhà mạng"
}

bebebebe () {
pm clear $Lpkg >&2
unzip -qo "$TMPDIR/rac/$Lpkg.apk" 'assets/ai_preload_conf' -d $TMPDIR
if [ -e $TMPDIR/assets/ai_preload_conf ];then
sed -i 's|"preload_activity": {|"preload_activity": {
      "com.facebook.katana": ".activity.FbMainTabActivity",
      "com.zing.zalo": ".ui.ZaloLauncherActivity",
      "com.google.android.gm": ".ui.MailActivityGmail",
      "com.facebook.messenger": ".neue.MainActivity",
      "org.telegram": ".ui.LaunchActivity",|g' $TMPDIR/assets/ai_preload_conf
cd $TMPDIR
zip -qr -0 "$TMPDIR/rac/$Lpkg.apk" assets/*
fi
AutoAll "Lmiui/os/Build;->IS_STABLE_VERSION:Z" "0x1" "$Lpkg/classes*"
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1" "$Lpkg/classes*"
jhfgg="$(Timkiem "ro.product.mod_device" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
Log "$jhfgg"
[ "$jhfgg" ] && Xan "MOD: Nền global"
for bjcfhh in $jhfgg; do
[ "$bjcfhh" ] && sed -i 's|ro.product.mod_device|ro.product.vip|g' $bjcfhh
done
}

Getapss () {
Vsmali ".method private checkSystemSelfProtection(Z)V" \
".end method" \
'.method private checkSystemSelfProtection(Z)V
    .locals 1
    return-void
.end method' \
"$TMPDIR/rac/$Sten/classes*/com/miui/server/*"

Vsmali ".method private onPostNotification()V" \
".end method" \
'.method private onPostNotification()V
    .locals 11
	return-void
.end method' \
"$TMPDIR/rac/$Sten/classes*/com/miui/server/*"

Vsmali ".method private checkSysAppCrack()Z" \
".end method" \
'.method private checkSysAppCrack()Z
    .registers 2
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Sten/classes*/com/miui/server/*"

Vsmali ".method private checkAppSignature(\[Landroid\/content\/pm\/Signature;Ljava\/lang\/String;Z)Z" \
".end method" \
'.method private checkAppSignature([Landroid/content/pm/Signature;Ljava/lang/String;Z)Z
    .registers 5
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Sten/classes*/com/miui/server/*"
}

modset () {
sjwg="$(echo $TMPDIR/rac/$Lpkg/classes*/com/android/settings/MiuiSettings.smali)"
sed -i -e '/Lcom\/android\/settings\/R$id;->location_settings:I/a\ const/4 v10, 0x1' -e '/Lcom\/android\/settings\/R$id;->privacy_settings:I/a\ const/4 v10, 0x1' -e 's|sget-boolean v1, Lmiui/os/Build;->IS_GLOBAL_BUILD:Z|const/4 v1, 0x1|' $sjwg
Log "$sjwg"
[ "$sjwg" ] && Xan "MOD: Hiện google trong cài đặtl"
Vsmali '.method public static supportPartialScreenShot()Z' \
'.end method' \
'.method public static supportPartialScreenShot()Z
    .registers 2
    const/4 v1, 0x1
    return v1
.end method' \
"$TMPDIR/rac/$Lpkg/classes*/*"
Vsmali '.method public static supportAnimateCheck()Z' \
'.end method' \
'.method public static supportAnimateCheck()Z
    .registers 2
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/classes*/*"
Vsmali '.method public static supportPaperEyeCare()Z' \
'.end method' \
'.method public static supportPaperEyeCare()Z
    .registers 2
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/classes*/*"
}

ehrhrb () {
Lisit "$Ften/classes*/" "/*.smali" "miui/security" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"
}

modsv () {
echo "ro.product.vip=$(getprop ro.product.device)_global" >> $TMPDIR/system.prop
Lisit "$Sten/classes*/" "/*.smali" "com/android/server/clipboard
com/android/server/am
com/android/server
com/android/server/notification" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"

kkodh="$(Timkiem "ro.product.mod_device" "$TMPDIR/rac/$Sten/classes*" "*.smali")"
Log "$kkodh"
[ "$kkodh" ] && Xan "MOD: Nền global"
for vgdfhh in $ttgffgg; do
[ "$vgdfhh" ] && sed -i 's|ro.product.mod_device|ro.product.vip|g' $vgdfhh
done
}

modsvk () {
echo > $MODPATH/Global.txt
AutoTv com.miui.securitycenter "https://github.com/kakathic/VH-MI/releases/download/Apk/SecurityCenter_global.apk"
AutoTv com.xiaomi.discover "https://github.com/kakathic/VH-MI/releases/download/Apk/Updatemiui.apk"
if [ "$globals" != 4 ];then
AutoTv com.android.thememanager "https://github.com/kakathic/VH-MI/releases/download/Apk/Theme.apk"
rm -fr $MODPATH/system/etc/precust_theme/theme/.data/content/launcher
rm -fr $MODPATH/system/bin
rm -fr $MPATH/system/*/overlay/Z.com.android.thememanager
fi
echo "ro.product.mod_device=$(getprop ro.product.device)_global" >> $TMPDIR/system.prop
}

modhomefw () {
Lisit "$Ften/classes*/" "/*.smali" "android/content/pm
android/app" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0"
}

modhomesv () {
Lisit "$Sten/classes*/" "/*.smali" "com/android/server/policy" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0"
}

modhome () {
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/classes*"
AutoAll "Lmiuix/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/classes*"
}

gdthbb () {
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1" "$Lpkg/classes*"
AutoAll "Lmiui/os/Build;->IS_STABLE_VERSION:Z" "0x1" "$Lpkg/classes*"
}

modbaomat () {
Lisit "$Lpkg/classes*/" "/*.smali" "com/miui/dock" "Lmiui/os/Build;->IS_DEVELOPMENT_VERSION:Z" "0x1"

Lisit "$Lpkg/classes*/" "/*.smali" "com/miui/securityscan
com/miui/securityscan/b0
com/miui/securityscan/cards
com/miui/securityscan/d0
com/miui/securityscan/fileobserver
com/miui/securityscan/model/manualitem
com/miui/securityscan/model/manualitem/defaultapp
com/miui/securityscan/s
com/miui/securityscan/scanner
com/miui/securityscan/u
com/miui/securityscan/ui/main
com/miui/securityscan/ui/settings" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"

bebrrh="$(Timkiem "mi_lab_ai_clipboard_enable" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
[ "$bebrrh" ] && sed -i "s|sget-boolean v0, Lmiui/os/Build;->IS_STABLE_VERSION:Z|const/4 v0, 0x1|g" $bebrrh || Xan "- Lỗi: mi_lab_ai_clipboard_enable"
[ "$bebrrh" ] && Xan "MOD: mi_lab_ai_clipboard_enable"

}

modkey () {
Listbp="$(ime list -s | cut -d '/' -f1 | sed -e '/com.iflytek.inputmethod.miui/d' -e '/com.sohu.inputmethod.sogou.xiaomi/d' -e '/com.android.cts.mockime/d' -e '/com.baidu.input_mi/d' -e '/com.miui.securityinputmethod/d')"
Dso1=0
for Vaki in $Listbp; do
if [ "$Vaki" ];then
Dso1=$(($Dso1 + 1))
[ "$Dso1" == 1 ] && Keyk=com.iflytek.inputmethod.miui
[ "$Dso1" == 2 ] && Keyk=com.baidu.input_mi
[ "$Dso1" == 3 ] && Keyk=com.sohu.inputmethod.sogou.xiaomi
[ "$Dso1" == 4 ] && Keyk=com.android.cts.mockime
if [ "$Dso1" -le 4 ];then
[ "$Lpkg" == 'com.android.settings' ] && Te1="$(Timkiem "$Keyk" "$TMPDIR/rac/com.android.settings/classes*/com/android/settings/inputmethod/*" "*.smali")"
[ "$Te1" ] && sed -i "s|$Keyk|$Vaki|g" $Te1
[ "$Lpkg" == 'com.miui.phrase' ] && Te2="$(Timkiem "$Keyk" "$TMPDIR/rac/com.miui.phrase/classes*/com/miui/inputmethod/*" "*.smali")"
[ "$Te2" ] && sed -i "s|$Keyk|$Vaki|g" $Te2
[ -e "$TMPDIR/rac/$Sten" ] && Te3="$(Timkiem "$Keyk" "$TMPDIR/rac/$Sten/classes*/com/android/server/*" "*.smali")"
[ "$Te3" ] && sed -i "s|$Keyk|$Vaki|g" $Te3
[ -e "$TMPDIR/rac/$Ften" ] && Te4="$(Timkiem "$Keyk" "$TMPDIR/rac/$Ften/classes*/android/*inputmethod*/*" "*.smali")"
[ "$Te4" ] && sed -i "s|$Keyk|$Vaki|g" $Te4

[ "$Te1" ] && Xan "MOD: com.android.settings"
[ "$Te2" ] && Xan "MOD: com.miui.phrase"
[ "$Te3" ] && Xan "MOD: $Sten"
[ "$Te4" ] && Xan "MOD: $Ften"

Log "
$Te1
$Te2
$Te3
$Te4
"
else
break
fi
fi
done
[ "$Lpkg" == 'com.android.settings' ] && Vsmali '.method public static isMiuiImeBottomSupport()Z' \
'.end method' \
'.method public static isMiuiImeBottomSupport()Z
    .registers 1
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/com.android.settings/classes*/*"
}

modthoitiet () {
[ "$( pm path $Lpkg )" ] || echo "/system/app/com.miui.weather2/com.miui.weather2.apk" > $TMPDIR/rac/com.miui.weather2.txt
evbhe="$(Timkiem "ro.miui.region" "$TMPDIR/rac/$Lpkg/classes*" "*.smali")"
Log "$evbhe"
[ "$evbhe" ] && Xan "MOD: Khu vực việt nam"
for rgeg in $evbhe; do
[ "$rgeg" ] && sed -i 's|ro.miui.region|ro.khu.vuc|g' $rgeg
done
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1" "$Lpkg/classes*"
AutoAll "Le/h/a;->a:Z" "0x1" "$Lpkg/classes*" "0x1" "$Lpkg/classes*"
}

Xan
if [ "$Gthoitiet" == 2 ];then
ui_print2 "Thời tiết mod"
ui_print
pm uninstall -k com.miui.weather2 >&2
if [ ! -e "$Dtool/apks/com.miui.weather2.apk" ];then
Taive "https://github.com/kakathic/VH-MI/releases/download/Apk/Weather2.apk" "$Dtool/apks/com.miui.weather2.apk"
cp -rf "$Dtool/apks/com.miui.weather2.apk" "$TMPDIR/rac/com.miui.weather2.apk"
fi
VipApk com.miui.weather2 modthoitiet
rm -fr $Dbackup/system/*/overlay/*com.miui.weather2
fi
Xan

# Các lựa chọn 
if [ "$getapps" == 2 ];then
ui_print2 "Gỡ Getapps"
ui_print
Xservices
pm uninstall com.xiaomi.market >&2
PAPP com.xiaomi.market
if [ -e ${framework%/*}/tmp/getapps ];then
FREEZE "$(cat ${framework%/*}/tmp/getapps)"
cp -rf "$services" $MODPATH${framework%/*}
cp -rf ${framework%/*}/tmp/getapps $MODPATH${framework%/*}/tmp
else
[ -e "$TMPDIR/rac/${Sten%.*}" ] || undex "$services"
Getapss
FREEZE "${Lapp%/*}"
echo "${Lapp%/*}" > $MODPATH${framework%/*}/tmp/getapps
fi; fi
Xan
if [ "$Ucaiapk" == 2 ];then
ui_print2 "Crack Apk"
ui_print
VipApk com.miui.packageinstaller modpki
fi
Xan
if [ "$theme3" == 2 ] && [ "$globals" != 3 ];then
ui_print2 "Hack Theme"
ui_print
VipApk com.android.thememanager modtheme
fi
Xan
if [ "$Systemii" == 2 ] && [ "$globals" -le 2 ];then
ui_print2 "Hiện nhà mạng"
ui_print
VipApk com.android.systemui modui
fi
Xan

if [ "$keyboard" == 2 ];then
ui_print2 "Bàn phím nâng cao"
ui_print
Xoamount
VipSV modkey
Xan
VipApk com.miui.phrase modkey
Xan
VipFW modkey
Xan
VipApk com.android.settings modkey
fi
Xan
if [ "$globals" == 2 ];then
ui_print2 "China Mod"
ui_print
Xoamount
VipSV modsv
Xan
VipFW ehrhrb
Xan
VipApk com.android.settings modset
Xan
VipApk com.miui.powerkeeper bebebebe
Xan
VipApk com.miui.securitycenter modbaomat
Xan
VipApk com.xiaomi.joyose gdthbb
elif [ "$globals" == 3 ] || [ "$globals" == 4 ];then
ui_print2 "Chuyển nền Global"
ui_print
modsvk
if [ "$globals" == 4 ];then
Xoamount
VipSV modhomesv
Xan
VipFW modhomefw
Xan
VipApk com.miui.home modhome
fi
else
sleep 1
fi
Xan

Links="$(cat $TMPDIR/Ten.log | sed -e "s|$TMPDIR/rac/||g")"

# Khu vực đóng gói 
# Apk
ui_print2 "Đóng gói tất cả..."
ui_print

Xan
Compress com.miui.weather2
Xan
Compress com.android.thememanager
Xan
Compress com.miui.packageinstaller
Xan
Compress com.android.systemui
Xan
Compress com.miui.powerkeeper
Xan
Compress com.miui.home
Xan
Compress com.miui.phrase
Xan
Compress com.xiaomi.joyose
Xan
Compress com.android.settings
Xan
Compress com.miui.securitycenter
Xan
# Framework 
[ -e $TMPDIR/rac/$Sten ] && repdex $services
Xan
[ -e $TMPDIR/rac/$Ften ] && repdex $framework
Xan

for Bala in product vendor system_ext; do
[ -e $MODPATH/$Bala ] && cp -rf $MODPATH/$Bala $MODPATH/system
[ -e $MODPATH/$Bala ] && rm -fr $MODPATH/$Bala
done

# Hết
cp -rf $Dbackup/* $MPATH
cp -rf $MODPATH/system/app/com.miui.weather2 $MPATH/system/app
rm -fr $MODPATH/system/app/com.miui.weather2

[ -e /data/adb/modules/VH-MI ] && rm -fr /data/adb/modules/VH-MI

ui_print2 "Hoàn thành"
ui_print
ETime
ui_print

Xan

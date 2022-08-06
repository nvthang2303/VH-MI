# kakathic

# Mod Apk 
VipApk () {
PAPP "$1"
if [ ! -e "${Lapp%.*}.$2" ];then
unapk
$2
else
SLapp
fi
}

# Mod Framework
VipFW () { 
echo > $MODPATH${framework%/*}/tmp/$1
if [ -e ${framework%/*}/$1 ];then
cp -rf "$framework" $MODPATH${framework%/*}
else
[ -e $TMPDIR/rac/$Ften ] || undex "$framework"
$1
fi
}

# Mod Services
VipSV () {
echo > $MODPATH${services%/*}/tmp/$1
if [ -e ${services%/*}/$1 ];then
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

Compress () { [ -e $TMPDIR/rac/$1 ] && repapk $1; }

# Tự động sửa chữa 
Fixrep () {

RepapkF () {
apktool b $TMPDIR/rac/*/*/main/$path -f -o "$TMPDIR/rac/Apk/tmp/Z.$pkg.apk" 2>>$TMPDIR/rac/$pkg.txt >>$TMPDIR/rac/$pkg.txt
[ -e $Dtool/log/$pkg.txt ] || cp -rf $TMPDIR/rac/$pkg.txt $Dtool/log/$pkg.txt
apksign "$TMPDIR/rac/Apk/Z.$pkg.apk" "$MPATH$Overlay/Z.$pkg.apk" 2>/dev/null >/dev/null
}
RepapkF

# Trùng string
if [ "$(grep -cm1 'is already defined.' $TMPDIR/rac/$pkg.txt)" == 1 ];then
while true; do
Linktk=$(grep -m1 'is already defined.' $TMPDIR/rac/$pkg.txt | cut -d : -f2)
Vbtk=$(grep -m1 'is already defined.' $TMPDIR/rac/$pkg.txt | awk '{print $6}')
sotk=$(grep -nm1 "$Vbtk" $Linktk | cut -d : -f1)
sed -i ''$sotk'd' $Linktk
sed -i '/'$Vbtk'/d' $TMPDIR/rac/$pkg.txt
[ "$(grep -cm1 'is already defined.' $TMPDIR/rac/$pkg.txt)" == 0 ] && break
done
RepapkF
fi

}

# Thay thế văn bản 
Fix () {
[ "$pkg" == "com.miui.securitycenter" ] && sed -i -e 's|`||g' -e '/name=\"allow_notify\"/d' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

if [ "$pkg" == "com.android.settings" ] && [ "$API" -ge 30 ];then
sed -i 's|privacy_settings_new">Sao lưu, khôi phục, hoặc đặt lại<|privacy_settings_new">Sao lưu, khôi phục<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml
rm -fr $TMPDIR/rac/*/*/main/$path/res/values-mcc460*
fi

[ "$pkg" == "com.android.calendar" ] && sed -i \
-e '/accessibility_month_page_selected_prefix/d' \
-e 's|: )||g' \
-e 's|: (||g' \
-e 's|lunar_nian">20<|lunar_nian">2<|g' \
-e 's|lunar_chu">Tết D.lịch<|lunar_chu">0<|g' \
-e 's|lunar_shi">10<|lunar_shi">1<|g' \
-e 's|event_lunar_month">Tháng<|event_lunar_month">/01<|g' \
-e 's|<string name="edit_event_reminder_summary_3_days_before">Trước %2$d ngày và vào ngày đó lúc %1$s</string>|<string name="edit_event_reminder_summary_3_days_before">Trước 3 ngày và vào ngày đó lúc %1$s</string>|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

[ "$pkg" == "com.miui.home" ] && sed -i \
-e 's/status_bar_recent_memory_info1">%1$s | %2$s</status_bar_recent_memory_info1">%1$s trống | %2$s</g' \
-e 's|recents_tv_small_window_text">Ứng dụng cửa sổ nhỏ<|recents_tv_small_window_text">Cửa sổ nhỏ<|g' \
-e 's|>Thông tin ứng dụng<|>Thông tin<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

[ "$pkg" == "com.miui.weather2" ] && sed -i 's|indices_title_feel">Cảm giác như<|indices_title_feel">Cảm giác<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml
}

# Bắt đầu
Apilt=$(grep -m1 com.xiaomi /data/system/sync/*.* | tr ' ' '\n' | grep -m1 account= | cut -d \" -f2)
[ -z "$Apilt" ] && Apilt=$(grep -am1 'type' /data/system/sync/accounts.xml | head -n1 | cut -d '/' -f1)
[ -z "$Apilt" ] && Apilt="Lỗi id"

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
# jre 11
if [ ! -e "$Dtool/lib/$version" ];then
unzip -p "$ZIPFILE" "lib/Java.tar.xz" | tar x -J -C $Dtool
echo > "$Dtool/lib/$version"
fi

if [ "$VHI" == 1 ];then

# Cài đặt ngôn ngữ
settings put system system_locales $(Getp Linknn)
ui_print2 "Ngôn ngữ: $(Getp LinkTn)"
ui_print
ui_print2 "Code: $(Getp Linknn)"
ui_print

[ -e /system/product/overlay ] && Overlay=/system/product/overlay || Overlay=/system/vendor/overlay

if [ -e $Dbackup.txt ];then
ui_print2 "Thêm Tiếng Việt"
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
Fix

# Thêm lịch âm và sửa đổi bộ đếm dữ liệu
if [ "$pkg" == "com.android.systemui" ] && [ "$Licham" == 2 ];then
sed -i \
-e 's|>EEEE dd/MM<|>E, dd.MM - (e.N)<|g' \
-e 's|fmt_time_12hour_minute_pm">h:mm a<|fmt_time_12hour_minute_pm">hh:mm aa<|g' \
-e 's|qs_control_customize_save_text">Đã xong<|qs_control_customize_save_text">Xong<|g' \
-e 's|<string name="status_bar_clock_date_weekday_format">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format">E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_weekday_format_12">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format_12">aa E, dd - MM</string>|g' \
-e 's|<string name="status_bar_clock_date_time_format">H:mm E, d MMM</string>|<string name="status_bar_clock_date_time_format">HH:mm - E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_time_format_12">h:mm aa, E, d MMM</string>|<string name="status_bar_clock_date_time_format_12">hh:mm aa - E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="kilobyte_per_second">KB/s</string>|<string name="megabyte_per_second">M/s </string>|g' \
-e 's|<string name="megabyte_per_second">MB/s</string>|<string name="kilobyte_per_second">K/s </string>|g' \
-e 's|<string name="status_bar_clock_date_format">E, d MMM</string>|<string name="status_bar_clock_date_format">E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_format_12">E, d MMM</string>|<string name="status_bar_clock_date_format_12">aa E, dd - MM</string>|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml
fi

# Đóng gói bằng apktool và ký
apktool b -q $TMPDIR/rac/*/*/main/$path -f -o "$TMPDIR/rac/Apk/Z.$pkg.apk" 2>/dev/null >/dev/null
apksign "$TMPDIR/rac/Apk/Z.$pkg.apk" "$Dbackup$Overlay/Z.$pkg.apk" 2>/dev/null >/dev/null
# Auto sửa lỗi
[ -s "$Dbackup$Overlay/Z.$pkg.apk" ] || Fixrep
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

[ "$Licham" == 2 ] && sed -i -e 's|>EEEE dd/MM<|>E, dd.MM - (e.N)<|g' $TMPDIR/rac/*/*/main/miuisystem.apk/res/*/*.xml

sed -i -e 's|midnight">SA<|midnight">Đêm<|' \
-e 's|early_morning">SA<|early_morning">Sáng<|' \
-e 's|morning">SA<|morning">Sáng<|' \
-e 's|afternoon">CH<|afternoon">Chiều<|' \
-e 's|noon">CH<|noon">Trưa<|' \
-e 's|evening">CH<|evening">Tối<|' \
-e 's|night">CH<|night">Đêm<|' \
-e 's|am">SA<|am">AM<|' \
-e 's|pm">CH<|am">PM<|' \
$TMPDIR/rac/*/*/main/miui.apk/res/*/*.xml

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
chmod 777 $MODPATH/system/bin/Appvault
. $MODPATH/system/bin/Appvault >&2
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
if [ "$Gthoitiet" == 2 ];then
ui_print2 "Thời tiết mod"
ui_print
pm uninstall com.miui.weather2 >&2
PAPP com.miui.weather2
if [ ! -e "$Dbackup/system/app/$Lpkg/$Lpkg.txt" ];then
[ "$(cat ${Lapp%.*}.txt)" ] && mktouch $MPATH${Lapp%/*}/.replace
Taive "https://github.com/kakathic/VH-MI/releases/download/Apk/Weather2.apk" "$TMPDIR/rac/$Lpkg.apk"
apktool d -q -r -f $TMPDIR/rac/$Lpkg.apk -o $TMPDIR/rac/$Lpkg
echo "$Dbackup/system/app/$Lpkg/$Lpkg.apk" > "$TMPDIR/rac/$Lpkg.txt"
evbhe="$(Timkiem "ro.miui.region" "$TMPDIR/rac/$Lpkg/smali*" "*.smali")"
for rgeg in $evbhe; do
[ "$rgeg" ] && sed -i 's|ro.miui.region|ro.khu.vuc|g' $rgeg
done
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1" "$Lpkg/smali*"
AutoAll "Le/h/a;->a:Z" "0x1" "$Lpkg/smali*" "0x1" "$Lpkg/smali*"
rm -fr $Dbackup/system/*/overlay/*$Lpkg
repapk $Lpkg
[ -e "/system/app/$Lpkg/$Lpkg.apk" ] || echo "${Lapp%/*}" > "$Dbackup/system/app/$Lpkg/$Lpkg.txt"
else
[ "$(cat ${Lapp%.*}.txt)" ] && mktouch $MPATH$(cat ${Lapp%.*}.txt)/.replace
mkdir -p "$Dbackup${Lapp%/*}"
cp -rf "${Lapp%/*}"/* "$Dbackup${Lapp%/*}"
fi
fi

Xan
# Lấy dữ liệu 
modpki () {
Tksm="$(Timkiem "iget p0, p0, Landroid\/content\/pm\/ApplicationInfo;->uid:I" "$TMPDIR/rac/$Lpkg/smali*" "*.smali")"

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
kzbddb="$(grep -Rl "IconCardView.java" $TMPDIR/rac/$Lpkg/smali*)"
[ "$kzbddb" ] && sed -i 's/com.miui.player/com.android.camera/g' $kzbddb || Xan "- Lỗi: IconCardView.java"

HTk4="$(grep -Rl "DRM_ERROR_UNKNOWN" $TMPDIR/rac/$Lpkg/smali*)"
[ "$HTk4" ] && sed -i 's/DRM_ERROR_UNKNOWN/DRM_SUCCESS/g' $HTk4 || Xan "- Lỗi: DRM_ERROR_UNKNOWN"

HTk1="$(Timkiem ".OnlineResourceDetail;->bought:Z" "$TMPDIR/rac/$Lpkg/smali*" "OnlineResourceDetailPresenter.smali")"
[ "$HTk1" ] && sed -i -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    const/4 v0, 0x1' -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    return v0' $HTk1 || Xan "- Lỗi: OnlineResourceDetail"

HTk21="$(Timkiem ".OnlineResourceDetail;->bought:Z" "$TMPDIR/rac/$Lpkg/smali*" "j*.smali")"
[ "$HTk21" ] && sed -i -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    const/4 v0, 0x1' -e '/iget-boolean v1, v0, Lcom\/android\/thememanager\/detail\/theme\/model\/OnlineResourceDetail;->bought:Z/i\    return v0' $HTk21 || Xan "- Lỗi: j OnlineResourceDetail"

Vsmali ".method public isVideoAd()Z" \
".end method" \
'.method public isVideoAd()Z
    .registers 2
    const/4 v0, 0x0
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"

Vsmali ".method private static isAdValid" \
".end method" \
'.method private static isAdValid(Lcom/android/thememanager/basemodule/ad/model/AdInfo;)Z
    .registers 2
    const/4 p0, 0x0
    return p0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"
kkodh="$(Timkiem "ro.miui.region" "$TMPDIR/rac/$Lpkg/smali*" "*.smali")"
for dhbe in $kkodh; do
[ "$dhbe" ] && sed -i 's|ro.miui.region|ro.khu.vuc.cn|g' $dhbe
done
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/smali*"
}

modui () {
tk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;'
kk='iput-object v0, p0, Lcom/android/systemui/qs/MiuiNotificationHeaderView;->mCarrierText:Lcom/android/keyguard/CarrierText;
const/4 v0, 0x0'
Tkllg="$(grep -Rl "$tk" $TMPDIR/rac/$Lpkg/smali*)"
[ "$Tkllg" ] && sed -i "s|$tk|$kk|g" $Tkllg || Xan "- Lỗi: mod hiện tên nhà mạng"
}

bebebebe () {
Lisit "$Lpkg/smali*/" "/*.smali" "com/miui/powerkeeper/ai
com/miui/powerkeeper/statemachine
com/miui/powerkeeper/utils" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"

jhfgg="$(Timkiem "ro.product.mod_device" "$TMPDIR/rac/$Lpkg/smali*" "*.smali")"
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
sed -i 's|sget-boolean v1, Lmiui/os/Build;->IS_GLOBAL_BUILD:Z|const/4 v1, 0x1|' $TMPDIR/rac/$Lpkg/smali*/com/android/settings/MiuiSettings.smali

Vsmali '.method public static supportPartialScreenShot()Z' \
'.end method' \
'.method public static supportPartialScreenShot()Z
    .registers 2
    const/4 v1, 0x1
    return v1
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"
Vsmali '.method public static isAgpsEnabled()Z' \
'.end method' \
'.method public static isAgpsEnabled()Z
    .registers 2
    const/4 v1, 0x1
    return v1
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"
Vsmali '.method public static supportAnimateCheck()Z' \
'.end method' \
'.method public static supportAnimateCheck()Z
    .registers 2
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"
Vsmali '.method public static supportPaperEyeCare()Z' \
'.end method' \
'.method public static supportPaperEyeCare()Z
    .registers 2
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/*"
Vsmali '.method public static isNotSupported()Z' \
'.end method' \
'.method public static isNotSupported()Z
    .registers 1
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/com/android/settings/lab" \
"MiuiFlashbackController.smali"

Vsmali '.method public static isNotSupported()Z' \
'.end method' \
'.method public static isNotSupported()Z
    .registers 1
    const/4 v0, 0x1
    return v0
.end method' \
"$TMPDIR/rac/$Lpkg/smali*/com/android/settings/lab" \
"MiuiLabGestureController.smali"
}

modsv () {
echo "ro.product.vip=$(getprop ro.product.device)_global" >> $TMPDIR/system.prop
Lisit "$Sten/classes*/" "/*.smali" "com/android/server/clipboard
com/android/server/am
com/android/server
com/android/server/notification" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"

kkodh="$(Timkiem "ro.product.mod_device" "$TMPDIR/rac/$Sten/classes*" "*.smali")"
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
AutoAll "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/smali*"
AutoAll "Lmiuix/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x0" "$Lpkg/smali*"
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
[ "$Lpkg" == 'com.android.settings' ] && Te1="$(Timkiem "$Keyk" "$TMPDIR/rac/com.android.settings/smali*/com/android/settings/inputmethod/*" "*.smali")"
[ "$Te1" ] && sed -i "s|$Keyk|$Vaki|g" $Te1
[ "$Lpkg" == 'com.miui.phrase' ] && Te2="$(Timkiem "$Keyk" "$TMPDIR/rac/com.miui.phrase/smali*/com/miui/inputmethod/*" "*.smali")"
[ "$Te2" ] && sed -i "s|$Keyk|$Vaki|g" $Te2
[ -e "$TMPDIR/rac/$Sten" ] && Te3="$(Timkiem "$Keyk" "$TMPDIR/rac/$Sten/classes*/com/android/server/*" "*.smali")"
[ "$Te3" ] && sed -i "s|$Keyk|$Vaki|g" $Te3
[ -e "$TMPDIR/rac/$Ften" ] && Te4="$(Timkiem "$Keyk" "$TMPDIR/rac/$Ften/classes*/android/*" "*.smali")"
[ "$Te4" ] && sed -i "s|$Keyk|$Vaki|g" $Te4
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
"$TMPDIR/rac/com.android.settings/smali*/*"
[ -e "$TMPDIR/rac/$Ften" ] && Lisit "$Ften/classes*/" "/*.smali" "miui/security" "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "0x1"
}

Xan
# Các lựa chọn 
if [ "$getapps" == 2 ];then
ui_print2 "Gỡ Getapps"
ui_print
pm uninstall com.xiaomi.market >&2
PAPP com.xiaomi.market
if [ -e ${framework%/*}/tmp/getapps ];then
FREEZE "$(cat ${framework%/*}/tmp/getapps)"
cp -rf "$services" $MODPATH${framework%/*}
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
Xservices
VipSV modsv
Xan
VipApk com.android.settings modset
Xan
VipApk com.miui.powerkeeper bebebebe
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

# Khu vực đóng gói 
# Apk
ui_print2 "Đóng gói tất cả..."
ui_print

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
Compress com.android.settings
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
[ -e /data/adb/modules/VH-MI ] && rm -fr /data/adb/modules/VH-MI

ui_print2 "Hoàn thành"
ui_print
ETime
ui_print

Xan

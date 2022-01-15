# KAKATHIC


Test=Kakathic


# Thêm lịch âm và sửa đổi bộ đếm dữ liệu

if [ "$pkg" == "com.android.systemui" ];then
sed -i -e 's|<string name="status_bar_clock_date_weekday_format">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format">E, dd.MM - (e.N)</string>|g' -e 's|<string name="status_bar_clock_date_weekday_format_12">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format_12">a E, dd - MM</string>|g' -e 's|<string name="status_bar_clock_date_time_format">H:mm E, d MMM</string>|<string name="status_bar_clock_date_time_format">H:mm - E, dd.MM - (e.N)</string>|g' -e 's|<string name="status_bar_clock_date_time_format_12">h:mm aa, E, d MMM</string>|<string name="status_bar_clock_date_time_format_12">h:mm a - E, dd.MM - (e.N)</string>|g' -e 's|<string name="kilobyte_per_second">KB/s</string>|<string name="megabyte_per_second">M/s </string>|g' -e 's|<string name="megabyte_per_second">MB/s</string>|<string name="kilobyte_per_second">K/s </string>|g' -e 's|<string name="status_bar_clock_date_format">E, d MMM</string>|<string name="status_bar_clock_date_format">E, dd.MM - (e.N)</string>|g' -e 's|<string name="status_bar_clock_date_format_12">E, d MMM</string>|<string name="status_bar_clock_date_format_12">a E, dd - MM</string>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.miui.securitycenter" ];then
sed -i 's|`||g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
sed -i "s/once_settings_title/wdcvh123/" /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.browser" ];then
sed -i 's|>>|>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.settings" ];then
rm -fr /data/tools/tmp/*/*/main/$path/res/values-mcc460*
fi


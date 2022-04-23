# Kakathic
# Thêm lịch âm và sửa đổi bộ đếm dữ liệu

if [ "$pkg" == "com.android.systemui" ];then
sed -i \
-e 's|qs_control_customize_save_text">Đã xong<|qs_control_customize_save_text">Xong<|g' \
-e 's|<string name="status_bar_clock_date_weekday_format">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format">E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_weekday_format_12">EEE, d MMM</string>|<string name="status_bar_clock_date_weekday_format_12">a E, dd - MM</string>|g' \
-e 's|<string name="status_bar_clock_date_time_format">H:mm E, d MMM</string>|<string name="status_bar_clock_date_time_format">H:mm - E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_time_format_12">h:mm aa, E, d MMM</string>|<string name="status_bar_clock_date_time_format_12">h:mm a - E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="kilobyte_per_second">KB/s</string>|<string name="megabyte_per_second">M/s </string>|g' \
-e 's|<string name="megabyte_per_second">MB/s</string>|<string name="kilobyte_per_second">K/s </string>|g' \
-e 's|<string name="status_bar_clock_date_format">E, d MMM</string>|<string name="status_bar_clock_date_format">E, dd.MM - (e.N)</string>|g' \
-e 's|<string name="status_bar_clock_date_format_12">E, d MMM</string>|<string name="status_bar_clock_date_format_12">a E, dd - MM</string>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.miui.securitycenter" ];then
sed -i 's|`||g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.browser" ];then
sed -i 's|>>|>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.settings" ];then
rm -fr /data/tools/tmp/*/*/main/$path/res/values-mcc460*
fi

if [ "$pkg" == "com.android.calendar" ];then
sed -i \
-e 's|: )||g' \
-e 's|: (||g' \
-e 's|lunar_nian">20<|lunar_nian">2<|g' \
-e 's|lunar_chu">Tết D.lịch<|lunar_chu">0<|g' \
-e 's|lunar_shi">10<|lunar_shi">1<|g' \
-e 's|event_lunar_month">Tháng<|event_lunar_month">/01<|g' \
-e 's|<string name="edit_event_reminder_summary_3_days_before">Trước %2$d ngày và vào ngày đó lúc %1$s</string>|<string name="edit_event_reminder_summary_3_days_before">Trước 3 ngày và vào ngày đó lúc %1$s</string>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.miui.home" ];then
sed -i \
-e 's/status_bar_recent_memory_info1">%1$s | %2$s</status_bar_recent_memory_info1">%1$s trống | %2$s\nkhả dụng</g' \
-e 's|recents_tv_small_window_text">Ứng dụng cửa sổ nhỏ<|recents_tv_small_window_text">Cửa sổ nhỏ<|g' \
-e 's|>Thông tin ứng dụng<|>Thông tin<|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

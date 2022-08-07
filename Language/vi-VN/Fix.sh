[ "$pkg" == "com.miui.securitycenter" ] && sed -i -e 's|`||g' -e '/name=\"allow_notify\"/d' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

if [ "$pkg" == "com.android.settings" ] && [ "$API" -ge 30 ];then
sed -i 's|privacy_settings_new">Sao lưu, khôi phục, hoặc đặt lại<|privacy_settings_new">Sao lưu, khôi phục<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml
rm -fr $TMPDIR/rac/*/*/main/$path/res/values-mcc460*
fi

sed -i \
-e 's|"midnight">SA<|"midnight">Đêm<|' \
-e 's|"early_morning">SA<|"early_morning">Sáng<|' \
-e 's|"morning">SA<|"morning">Sáng<|' \
-e 's|"afternoon">CH<|"afternoon">Chiều<|' \
-e 's|"noon">CH<|"noon">Trưa<|' \
-e 's|"evening">CH<|"evening">Tối<|' \
-e 's|"night">CH<|"night">Đêm<|' \
-e 's|"am">SA<|"am">AM<|' \
-e 's|"pm">CH<|"pm">PM<|' \
-e 's|lunar_nian">20<|lunar_nian">2<|g' \
-e 's|lunar_chu">Tết D.lịch<|lunar_chu">0<|g' \
-e 's|lunar_shi">10<|lunar_shi">1<|g' \
-e 's|event_lunar_month">Tháng<|event_lunar_month">/01<|g' \
$TMPDIR/rac/*/*/main/$path/res/*/*.xml

[ "$pkg" == "com.android.calendar" ] && sed -i \
-e '/accessibility_month_page_selected_prefix/d' \
-e 's|: )||g' \
-e 's|: (||g' \
-e 's|edit_event_reminder_summary_3_days_before">Trước %2$d ngày và vào ngày đó lúc %1$s<|edit_event_reminder_summary_3_days_before">Trước 3 ngày và vào ngày đó lúc %1$s<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

[ "$pkg" == "com.miui.home" ] && sed -i \
-e 's/status_bar_recent_memory_info1">%1$s | %2$s</status_bar_recent_memory_info1">%1$s trống | %2$s</g' \
-e 's|recents_tv_small_window_text">Ứng dụng cửa sổ nhỏ<|recents_tv_small_window_text">Cửa sổ nhỏ<|g' \
-e 's|>Thông tin ứng dụng<|>Thông tin<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

[ "$pkg" == "com.miui.weather2" ] && sed -i 's|indices_title_feel">Cảm giác như<|indices_title_feel">Cảm giác<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml
[ "$pkg" == "com.android.systemui" ] && sed -i \
-e "s|>EEEE dd/MM<|>$Lichamkk<|g" \
-e 's|fmt_time_12hour_minute">HH:mm<|fmt_time_12hour_minute">hh:mm<|g' \
-e 's|fmt_time_12hour_minute_pm">h:mm a<|fmt_time_12hour_minute_pm">hh:mm aa<|g' \
-e 's|qs_control_customize_save_text">Đã xong<|qs_control_customize_save_text">Xong<|g' \
-e "s|status_bar_clock_date_weekday_format\">EEE, d MMM<|status_bar_clock_date_weekday_format\">$Lichamkk<|g" \
-e "s|status_bar_clock_date_weekday_format_12\">EEE, d MMM<|status_bar_clock_date_weekday_format_12\">$Lichamkk<|g" \
-e "s|status_bar_clock_date_time_format\">H:mm E, d MMM<|status_bar_clock_date_time_format\">HH:mm - $Lichamkk<|g" \
-e "s|status_bar_clock_date_time_format_12\">h:mm aa, E, d MMM<|status_bar_clock_date_time_format_12\">hh:mm aa - $Lichamkk<|g" \
-e 's|kilobyte_per_second">KB/s<|megabyte_per_second">M/s <|g' \
-e 's|megabyte_per_second">MB/s<|kilobyte_per_second">K/s <|g' \
-e "s|status_bar_clock_date_format\">E, d MMM<|status_bar_clock_date_format\">$Lichamkk<|g" \
-e 's|status_bar_clock_date_format_12">E, d MMM<|status_bar_clock_date_format_12">aa E, dd - MM<|g' $TMPDIR/rac/*/*/main/$path/res/*/*.xml

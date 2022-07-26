# Kakathic

if [ "$pkg" == "com.miui.securitycenter" ];then
sed -i 's|`||g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.browser" ];then
sed -i 's|>>|>|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.android.settings" ];then
sed -i 's|privacy_settings_new">Sao lưu, khôi phục, hoặc đặt lại<|privacy_settings_new">Sao lưu, khôi phục<|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
rm -fr /data/tools/tmp/*/*/main/$path/res/values-mcc460*
fi

if [ "$pkg" == "com.android.calendar" ];then
sed -i \
-e '/accessibility_month_page_selected_prefix/d' \
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
-e 's/status_bar_recent_memory_info1">%1$s | %2$s</status_bar_recent_memory_info1">%1$s trống | %2$s</g' \
-e 's|recents_tv_small_window_text">Ứng dụng cửa sổ nhỏ<|recents_tv_small_window_text">Cửa sổ nhỏ<|g' \
-e 's|>Thông tin ứng dụng<|>Thông tin<|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.miui.weather2" ];then
sed -i 's|indices_title_feel">Cảm giác như<|indices_title_feel">Cảm giác<|g' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

if [ "$pkg" == "com.miui.personalassistant" ];then
sed -i 's|<string name="pa_picker_tab_title_recommend">Khuyến khích</string|<string name="pa_picker_tab_title_recommend">Khuyến khích</string>|' /data/tools/tmp/*/*/main/$path/res/*/*.xml
fi

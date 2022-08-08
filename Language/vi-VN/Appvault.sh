sed -i -e "s|'北京市'|'Vị trí'|g" -e "s|MM-dd|dd-MM|g" \
-e "s|'北京市'|'Vị trí'|g" -e "s|'晴'|'Quang'|g" -e "s|'空气质量|'Aqi|g" -e "s|'重度污'|'Ô nhiễm nặng'|g" -e "s|'严重污染'|'Quá ô nhiễm'|g" -e "s|'轻度污染'|'Ô nhiễm nhẹ'|g" -e "s|'中度污染'|'Ô nhiễm Vừa'|g" -e "s|'良好'|'Tốt'|g" -e "s|'优'|'Trong lành'|g" -e "s|'日落'|'Hoàng hôn'|g" -e "s|'日出'|'Bình minh'|g" \
"${Lik%/*}/tmp/${qhqtnq##*/}/manifest.xml"

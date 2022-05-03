Vip=Kakathic
ui_print2 "Ủng hộ: Teckombank: 19034902604017"
ui_print
ui_print2 "Momo, Viettel Pay: 0344413159"
ui_print

if [ "$(Getp VH)" == 1 ];then
if [ "$(Getp online)" ];then
Onlinekk=$(Getp online)
else
ui_print "! Sử dụng phím âm lượng"
ui_print "! Vol- = Chọn, Vol+ = Chuyển số, Chạm để hủy."
ui_print
ui_print "- Chọn chế độ cài đặt Việt hóa rom ?"
ui_print
ui_print2 "1. Online"
ui_print2 "2. Offline"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

Vl 2
Onlinekk=$input
fi

if [ "$(Getp dsonline)" ];then
litapp=$(Getp dsonline)
else
ui_print "- Chọn danh sách ứng dụng cần dịch ?"
ui_print
ui_print2 "1. Online"
ui_print2 "2. List có sẵn"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

Vl 2
litapp=$input
fi
fi

if [ "$(Getp gapp)" ];then
gapp=$(Getp gapp)
else
ui_print "- Cài Gapps thêm các dịch vụ Google ?"
ui_print "! Nên dùng cho các rom china gốc"
ui_print "! Có thể bị treo và tự tắt module."
ui_print
ui_print2 "1. Không"
ui_print2 "2. Có"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"

Vl 2
gapp=$input
fi

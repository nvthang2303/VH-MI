Vip=Kakathic


[ "$(Xem "$Lituss" | grep -cm1 $kkihh)" == 1 ] || abort "
! Phát hiện lỗi

  Thiết bị: $(getprop ro.product.device)

  id: $kkihh

  Lý do lỗi: Chưa đăng ký tài khoản!
  
  Cách đăng ký tài khoản:
  
  Gửi 10k vào Teckombank: 19034902604017

  Nội dung gửi tiền kèm id và tên thiết bị.
  
  Chụp ảnh màn hình này hoặc gửi log

  Cho người làm module.
"

ui_print "! Sử dụng phím âm lượng"
ui_print "! Vol- = Chọn, Vol+ = Chuyển số, Ấn nút nguồn để hủy."
ui_print

if [ "$(Getp VH)" == 1 ];then
ui_print "- Chọn chế độ cài đặt Việt hóa rom ?"
ui_print
ui_print2 "1. Online"
ui_print2 "2. Offline"
ui_print
ui_print2 "Nhập số:"
ui_print
ui_print2 "1"
if [ "$(Getp online)" ];then
Onlinekk=$(Getp online)
ui_print
ui_print2 "Chọn: $Onlinekk"
ui_print
else
Vl 2
Onlinekk=$input
fi

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
ui_print "! Nên dùng cho các rom china gốc"
ui_print "! Có thể bị treo và tự tắt module."
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
ui_print2 "1. Có"
ui_print2 "2. Không"
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

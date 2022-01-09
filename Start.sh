Test=kakathic

Continue () {
if [ "$Language" == "vi" ];then
Vol1="- Sử dụng phím âm lượng !"
Vol2="- Vol- = Chọn, Vol+ = Chuyển đổi, Chạm để hủy !"
Vol3="Vui lòng chọn ngôn ngữ của bạn ?"
Vol4="Nhập số:"
Vol5="Chọn:"
else
Vol1="- Use volume keys !"
Vol2="- Vol- = Choose, Vol+ = Options, Tap to cancel !"
Vol3="Please select your language ?"
Vol4="Enter number:"
Vol5="Choose:"
fi

echo
echo "$Vol1"
echo "$Vol2"
echo
ui_print2 "  $Vol3"
ui_print2
ui_print2 "  1. Việt Nam"
ui_print2 "  2. English"
ui_print2
ui_print2 "  $Vol4"
ui_print2
ui_print2 "  1"

Vl 2
Vi=$input

if [ "$Vi" == 1 ];then
Vol4="Nhập số:"
Vol5="Chọn:"

kname="Tên:"
kversion="Phiên bản"
kauthor="Tác giả"
kdescription="Mô tả:"
knv1="Lựa chọn dữ liệu để dịch ứng dụng?"
kdsd8="Chọn danh sách ứng dụng để dịch ?"
kdscs="Danh sách có sẵn"
getaps="Xoá ứng dụng GetApps ?"
kdunf="Đang giải nén..."
kht="Hoàn thành:"
kdth="Đang đóng gói:"
kdt="Đang tải:"
ngonhdf="Ngôn ngữ:"
kstkdg="Tìm thấy:"
kstkdg2="ứng dụng cần dịch"
Themek="Mở khóa chủ đề"
ktheme="Cho phép cài đặt chủ đề bên thứ ba !"
kgcd="Gỡ cài đặt GetApps"
kclear="Dọn dẹp..."
tienh="Tiến hành dịch..."
fontxbgdf="Thay đổi font chữ hệ thống ?"
miuigegeg="Dịch miui framework..."
else
Vol4="Enter number:"
Vol5="Choose:"

kname="Name:"
kversion="Version"
kauthor="Author"
kdescription="Description:"
knv1="Select data for application translation?"
kdsd8="Select a list of applications to translate?"
kdscs="Available list"
getaps="Delete GetApps App?"
kdunf="Unpacking..."
kht="Complete:"
kdth="Packing:"
kdt="Loading:"
ngohdf="Language:"
kstkdg="Found:"
kstkdg2="application to be translated"
Themek="Unlock theme"
ktheme="Allow installation of third-party themes !"
kgcd="Uninstall GetApps"
kclear="Clean up..."
tienh="Translating..."
fontxbgdf="Change system font?"
miuigegeg="Translate miui framework..."
fi

}

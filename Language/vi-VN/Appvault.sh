sed -i -e "s|yyyy年M月  E|EEEE, MM yyyy|g" -e "s|@weekText\[#_i\]|ifelse(#_i==1,'T2',#_i==2,'T3',#_i==3,'T4',#_i==4,'T5',#_i==5,'T6',#_i==6,'T7','CN)|g" -e "s|'已经搬砖这么久','眼睛一闭一睁'|'Ánh sáng trong lành','Quên đi bóng tối'|g" -e "s|'怎么才','怎么就'|'Ahhhh!','Kohhh!'|g" -e "s|'呀','了'|'Sáng','Tối'|g" -e "s|MM/dd E|E dd/MM|g" -e "s|'你真棒'|'Thật tuyệt vời'|g" -e "s|'饮水目标\\\n'+#targetI+'ml\\\n—\\\n'+'单次饮水量\\\n'+#increase+'ml'|'Mục tiêu nước\\\n'+#targetI+'ml\\\n—\\\n'+'Lượng nước\\\n'+#increase+'ml'|g" -e "s|'单击增加\\\n今日喝水量\\\n—','喝水\\\n太少啦\\\n—','是时候\\\n喝水啦\\\n—','今日饮水\\\n目标达成\\\n—'|'Nhấp để uống thêm\\\nnước hôm nay\\\n—','Uống một chút\\\n—','Đến lúc để uống\\\nít nước\\\n—','Uống hôm nay\\\nĐạt mục tiêu\\\n—'|g" \
-e "s|'写OKR'|'Viết OKR'|g" -e "s|'买回家的火车票'|'Nơi yên bình'|g" -e "s|'已经'|'Sẵn sàng'|g" -e "s|'今天'|'Hôm nay'|g" -e "s|M/d|d/M|g" -e "s|YYA年|'Giờ: 'II|g" -e "s|N月e|e.N|g" -e "s|'元旦节'|'Số trong năm'|g" -e "s|' 天'|' Ngày'|g" -e 's|M月/EEEE|EEE, dd/MM yyyy|g' -e 's|"dd"|"D"|g' -e "s|'今天没啥事儿'|'Không có gì!'|g" -e "s|'摸鱼就完了！'|'Kết thúc! '|g" \
-e "s|substr('日一二三四五六',#__i,1)|ifelse(#__i==1,'T2',#__i==2,'T3',#__i==3,'T4',#__i==4,'T5',#__i==5,'T6',#__i==6,'T7','CN)|g" -e 's|MMM月|yyyy|g' -e "s|substr('日一二三四五六',#_i,1)|ifelse(#_i==1,'T2',#_i==2,'T3',#_i==3,'T4',#_i==4,'T5',#_i==5,'T6',#_i==6,'T7','CN)|g" -e "s|'JANUARY'|'Tháng Một'|g" -e "s|'FEBRUARY'|'Tháng Hai'|g" -e "s|'MARCH'|'Tháng Ba'|g" -e "s|'APRIL'|'Tháng Tư'|g" -e "s|'MAY'|'Tháng Năm'|g" -e "s|'JUNE'|'Tháng Sáu'|g" -e "s|'JULY'|'Tháng Bảy'|g" -e "s|'AUGUST'|'Tháng Tám'|g" -e "s|'SEPTEMBER'|'Tháng Chín'|g" -e "s|'OCTOBER'|'Tháng Mười'|g" -e "s|'NOVEMBER'|'Tháng 11'|g" -e "s|'DECEMBER'|'THÁNG 12'|g" \
-e "s|'先定个小目标哦～'|'Đặt mục tiêu nhỏ trước ~'|g" -e "s|'站起来活动活动吧~'|'Đứng lên và di chuyển ~'|g" -e "s|'听说运动会变得更好看呢'|'Tôi nghe nói rằng thể thao sẽ tốt hơn'|g" -e "s|'加油，运动下吧！'|'Nào, chúng ta hãy tập thể dục! '|g" -e "s|'加油！已经消耗了相当于一个冰淇淋的热量！'|'Thôi nào! Đã tiêu thụ một lượng calo tương đương với một cây kem! '|g" -e "s|'消耗了一个鸡腿的热量，再努力一下。'|'Sau khi tiêu thụ hết lượng calo của một chiếc dùi trống, hãy cố gắng nhiều hơn nữa. '|g" -e "s|'一个汉堡的热量不过如此，继续燃烧卡路里吧！'|'Không có gì hơn thế trong một chiếc bánh mì kẹp thịt, hãy tiếp tục đốt cháy calo!'|g" -e "s|'恭喜！已经成功消耗了一顿火锅的热量。'|'Xin chúc mừng! Đã tiêu hao thành công lượng calo của một nồi lẩu. '|g" -e "s|'等减肥成功，一定要去吃一顿大餐。'|'Khi giảm cân thành công, hãy nhớ ăn một bữa lớn. '|g" -e "s|'步'|'bước'|g" -e "s|'今日步数'|'Các bước hôm nay'|g" -e "s|'北京市'|'Vị trí'|g" -e "s|MM-dd|dd-MM|g" \
-e "s|'北京市'|'Vị trí'|g" -e "s|'晴'|'Quang'|g" -e "s|'空气质量：'|'Aqi: '|g" -e "s|'重度污'|'Ô nhiễm nặng'|g" -e "s|'严重污染'|'Quá ô nhiễm'|g" -e "s|'轻度污染'|'Ô nhiễm nhẹ'|g" -e "s|'中度污染'|'Ô nhiễm Vừa'|g" -e "s|'良好'|'Tốt'|g" -e "s|'优'|'Trong lành'|g" -e "s|'日落'|'Hoàng hôn'|g" -e "s|'日出'|'Bình minh'|g" \
"${Lik%/*}/tmp/${qhqtnq##*/}/manifest.xml"

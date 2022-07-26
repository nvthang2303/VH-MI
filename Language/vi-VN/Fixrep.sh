
RepapkF () {
apktool b /data/tools/tmp/*/*/main/$path -f -o "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" 2>>/data/tools/tmp/$pkg.txt >>/data/tools/tmp/$pkg.txt
[ -e /data/tools/$pkg.txt ] || cp -rf /data/tools/tmp/$pkg.txt /data/tools/$pkg.txt
mkdir -p "$MPATH$Overlay"
apksign "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" "$MPATH$Overlay/Z.$pkg.apk"
rm -fr "$MPATH$Overlay/Z.$pkg.apk.idsig"

}

RepapkF

# Trùng string
if [ "$(grep -cm1 'is already defined.' /data/tools/tmp/$pkg.txt)" == 1 ];then
while true; do
Linktk=$(grep -m1 'is already defined.' /data/tools/tmp/$pkg.txt | cut -d : -f2)
Vbtk=$(grep -m1 'is already defined.' /data/tools/tmp/$pkg.txt | awk '{print $6}')
sotk=$(grep -nm1 "$Vbtk" $Linktk | cut -d : -f1)
sed -i ''$sotk'd' $Linktk
sed -i '/'$Vbtk'/d' /data/tools/tmp/$pkg.txt
[ "$(grep -cm1 'is already defined.' /data/tools/tmp/$pkg.txt)" == 0 ] && break
done
RepapkF
fi

# String lỗi thiếu ký tự
if [ "$(grep -cm1 'well-formed' /data/tools/tmp/$pkg.txt)" == 1 ];then
while true; do
jtt5uu=$(grep -m1 'well-formed' /data/tools/tmp/$pkg.txt | cut -d : -f2)
vrgrh=$(grep -m1 'well-formed' /data/tools/tmp/$pkg.txt | cut -d : -f3)
sed -i "/$vrgrh/c \ " $jtt5uu
sed -i '/'$vrgrh'/d' /data/tools/tmp/$pkg.txt
[ "$(grep -cm1 'well-formed' /data/tools/tmp/$pkg.txt)" == 0 ] && break
done
RepapkF
fi

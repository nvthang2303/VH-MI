
RepapkF () {
apktool b /data/tools/tmp/*/*/main/$path -f -o "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" 2>&1 >/data/tools/tmp/$pkg.txt
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

if [ "$(grep -cm1 'invalid token' /data/tools/tmp/$pkg.txt)" == 1 ];then
vrgrh=$(grep -m1 'invalid token' /data/tools/tmp/$pkg.txt | cut -d : -f2)
sed -i ''$vrgrh'd' $Park/res/*/strings.xml
RepapkF
fi


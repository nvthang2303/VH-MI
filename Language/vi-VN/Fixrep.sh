RepapkF () {
apktool b /data/tools/tmp/*/*/main/$path -f -o "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" >/data/tools/tmp/Fix.txt 2>>/data/tools/tmp/Fix.txt
mkdir -p "$MPATH$Overlay"
apksign "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" "$MPATH$Overlay/Z.$pkg.apk"
rm -fr "$MPATH$Overlay/Z.$pkg.apk.idsig"

}

RepapkF

# Trùng string
if [ "$(grep -cm1 'is already defined.' /data/tools/tmp/Fix.txt)" == 1 ];then
while true; do
Linktk=$(grep -m1 'is already defined.' /data/tools/tmp/Fix.txt | cut -d : -f2)
Vbtk=$(grep -m1 'is already defined.' /data/tools/tmp/Fix.txt | awk '{print $6}')
sotk=$(grep -nm1 "$Vbtk" $Linktk | cut -d : -f1)
sed -i ''$sotk'd' $Linktk
sed -i '/'$Vbtk'/d' /data/tools/tmp/Fix.txt
[ "$(grep -cm1 'is already defined.' /data/tools/tmp/Fix.txt)" == 0 ] && break
done
RepapkF
fi












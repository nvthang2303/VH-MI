RepapkF () {
apktool b /data/tools/tmp/*/*/main/$path -f -o "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" >/data/tools/tmp/Fix.txt 2>>/data/tools/tmp/Fix.txt
mkdir -p "$MPATH$Overlay"
apksign "/data/tools/tmp/Apk/tmp/Z.$pkg.apk" "$MPATH$Overlay/Z.$pkg.apk"
rm -fr "$MPATH$Overlay/Z.$pkg.apk.idsig"
}
RepapkF


# Trùng string
if [ "$(grep -cm1 'is already defined.' /data/tools/tmp/Fix.txt)" == 1 ];then
while $(grep -c 'is already defined.' /data/tools/tmp/Fix.txt); do
Sotk=$(grep -m1 'is already defined.' /data/tools/tmp/Fix.txt | cut -d : -f3)
sed -i ''$Sotk'd' $Park/res/*/*.xml
sed -i '/'$Sotk'/d' /data/tools/tmp/Fix.txt
done
fi











RepapkF
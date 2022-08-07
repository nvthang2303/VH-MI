RepapkF () {
apktool b $TMPDIR/rac/*/*/main/$path -f -o "$TMPDIR/rac/Apk/tmp/Z.$pkg.apk" 2>> $TMPDIR/rac/$pkg.txt >> $TMPDIR/rac/$pkg.txt
[ -e $TMPDIR/rac/$pkg.txt ] && cp -rf $TMPDIR/rac/$pkg.txt $Dtool/error/$pkg.txt
apksign "$TMPDIR/rac/Apk/Z.$pkg.apk" "$MPATH$Overlay/Z.$pkg.apk" 2>/dev/null >/dev/null
}

RepapkF

# Trùng string
if [ "$(grep -cm1 'is already defined.' $TMPDIR/rac/$pkg.txt)" == 1 ];then
while true; do
Linktk=$(grep -m1 'is already defined.' $TMPDIR/rac/$pkg.txt | cut -d : -f2)
Vbtk=$(grep -m1 'is already defined.' $TMPDIR/rac/$pkg.txt | awk '{print $6}')
sotk=$(grep -nm1 "$Vbtk" $Linktk | cut -d : -f1)
sed -i ''$sotk'd' $Linktk
sed -i '/'$Vbtk'/d' $TMPDIR/rac/$pkg.txt
[ "$(grep -cm1 'is already defined.' $TMPDIR/rac/$pkg.txt)" == 0 ] && break
done
RepapkF
fi

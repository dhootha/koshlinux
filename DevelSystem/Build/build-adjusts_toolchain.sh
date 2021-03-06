# Kosh Linux Build Adjust Script.
# Specification at: http://koshlinux.com/

SPECS=`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/specs
$LFS_TGT-gcc -dumpspecs | sed \
  -e 's@/lib\(64\)\?/ld@/tools&@g' \
  -e "/^\*cpp:$/{n;s,$, -isystem /tools/include,}" > $SPECS 
echo "New specs file is: $SPECS"
unset SPECS

echo 'main(){}' > dummy.c
$LFS_TGT-gcc -B/tools/lib dummy.c
(readelf -l a.out | grep ': /tools') || exit 1
rm -v dummy.c a.out

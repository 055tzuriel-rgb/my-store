#!/bin/bash
INDEX_FILE="index.xml"
echo '<?xml version="1.0" encoding="UTF-8"?>' > $INDEX_FILE
echo '<repository name="HaEsh Sheli Store">' >> $INDEX_FILE
echo '  <applications>' >> $INDEX_FILE
for apk in *.apk; do
    if [ -f "$apk" ]; then
        BADGING=$(aapt dump badging "$apk")
        PACKAGE_NAME=$(echo "$BADGING" | grep "package" | sed -n "s/.*name='\([^']*\)'.*/\1/p")
        VERSION_CODE=$(echo "$BADGING" | grep "package" | sed -n "s/.*versionCode='\([^']*\)'.*/\1/p")
        VERSION_NAME=$(echo "$BADGING" | grep "package" | sed -n "s/.*versionName='\([^']*\)'.*/\1/p")
        APP_NAME=$(echo "$BADGING" | grep "application-label:" | sed -n "s/.*application-label:'\([^']*\)'.*/\1/p")
        echo "    <application>" >> $INDEX_FILE
        echo "        <id>$PACKAGE_NAME</id>" >> $INDEX_FILE
        echo "        <name>$APP_NAME</name>" >> $INDEX_FILE
        echo "        <versionCode>$VERSION_CODE</versionCode>" >> $INDEX_FILE
        echo "        <versionName>$VERSION_NAME</versionName>" >> $INDEX_FILE
        echo "        <apkname>$apk</apkname>" >> $INDEX_FILE
        echo "    </application>" >> $INDEX_FILE
    fi
done
echo '  </applications>' >> $INDEX_FILE
echo '</repository>' >> $INDEX_FILE

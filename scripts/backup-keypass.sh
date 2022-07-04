#!/bin/bash

DATE=$(date +%FT%H-%M-%S)
# TODO: Enter filename of gpg OUTPUT
FILENAME=""
# TODO: Enter encryption local user (key id)
GPG_USER=""
# TODO: Enter recipient key user
GPG_REC=""

# TODO: Enter directory of files to backup, filename and b2 bucket name
KEYPASS_LOCATION=""
KEYPASS_FILENAME=""
BUCKET_NAME=""

[ ! -f "$KEYPASS_LOCATION$KEYPASS_FILENAME" ] && { echo "Keypass Location Not Found"; exit 1; }

type gpg > /dev/null 2>&1 || {
    printf "Couldn't find gpg, make sure it's installed.\n";
    exit 1
}
type b2 > /dev/null 2>&1 || {
    printf "Couldn't find b2 tool.\n";
    exit 1
}

gpg -e -u "$GPG_USER" -r "$GPG_REC" -o "$KEYPASS_LOCATION$FILENAME" "$KEYPASS_LOCATION$KEYPASS_FILENAME"


FILE_INFO=$(b2 upload-file --noProgress --quiet "$BUCKET_NAME" "$KEYPASS_LOCATION$FILENAME" "$FILENAME")

FILESIZE=$(echo $FILE_INFO | jq '.size');
FILEMD5=$(echo $FILE_INFO | jq -r '.contentMd5');
MD5SUM=$(md5sum "$KEYPASS_LOCATION$FILENAME" | awk '{print $1}') 
# Ensure size of file uploaded and one on disk match 
[[ $(stat -c%s "$KEYPASS_LOCATION$FILENAME") -eq "$FILESIZE" ]] && {
    printf "Filesize match. (%s)\n" $FILESIZE;
}

# Ensure stated Md5 and Md5sum on disk match

[[ "$MD5SUM" == $FILEMD5 ]] && {
    printf "MD5sum match. (%s)\n" $FILEMD5;
}

echo $FILE_INFO;

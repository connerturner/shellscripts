FILEID=$(cat /proc/sys/kernel/random/uuid);


if [ $# -eq 2 ]; then
    echo "Two args, "
    echo "File ID: $FILEID";
else
    echo "Two args needed, file to change to asset and the asset register \n genAssets.sh [/path/to/file] [/path/to/assetRegister]";
fi

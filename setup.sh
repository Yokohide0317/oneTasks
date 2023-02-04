#!/bin/bash

source ./oneTask.conf

# 親ディレクトリ
if [ ! -d ${ONEDRIVE_PATH} ]; then
    echo "Making dir.. ${ONEDRIVE_PATH}"
    mkdir ${ONEDRIVE_PATH}
fi

# 同期するDir
if [ ! -d ${SYNC_DIR} ]; then
    echo "Making dir.. ${SYNC_DIR}"
    mkdir ${SYNC_DIR}
fi

# 作業Dir
if [ ! -d "./working" ]; then
    mkdir "./working"
fi


echo "一回目の同期中...数分かかります。"
onedrive --synchronize --single-directory ${SYNC_DIR}

echo "作業用ディレクトリを作成"
touch ${ONEDRIVE_PATH}/${SYNC_DIR}/setupTest.txt
mkdir ${ONEDRIVE_PATH}/${SYNC_DIR}/input
mkdir ${ONEDRIVE_PATH}/${SYNC_DIR}/output
echo "Uploading..."
onedrive --synchronize --single-directory ${SYNC_DIR}

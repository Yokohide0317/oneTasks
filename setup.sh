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


touch ${SYNC_DIR}/setupTest.txt
onedrive --synchronize --single-directory ${SYNC_DIR}

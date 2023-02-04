#!/bin/bash

# エラーが起こったら異常終了させる
set -E

function failure(){
    echo "error end!!"
    rm -f ${ONEDRIVE_PATH}/${SYNC_DIR}/input/command.sh
    onedrive --synchronize --upload-only --no-remote-delete --single-directory ${SYNC_DIR}/output
    onedrive --synchronize --upload-only --single-directory ${SYNC_DIR}/input
    exit 1
}

# エラー発生時にコールする関数を設定
trap failure ERR

# 設定ファイルの読み込み
SETTING_CONF="./oneTask.conf"
if [ ! -e ${SETTING_CONF} ];then
  echo "File not exists."
  exit 1
fi
source ${SETTING_CONF}


# input内を更新
onedrive --synchronize --download-only --single-directory ${SYNC_DIR}/input

# command.shがあったらmain関数実行
if [ ! -e "${ONEDRIVE_PATH}/${SYNC_DIR}/input/command.sh" ];then
  echo "command.sh is not exit. exit."
  exit 0
fi

PROCESS_ID=`date +'%Y%m%d_%H%M%S'`
if [ ! -d "./working" ];then
  mkdir "./working"
fi
mkdir ./working/${PROCESS_ID}
mv "${ONEDRIVE_PATH}/${SYNC_DIR}/input/command.sh" ./working/${PROCESS_ID}/
cp -r ${ONEDRIVE_PATH}/${SYNC_DIR}/input/* ./working/${PROCESS_ID}/


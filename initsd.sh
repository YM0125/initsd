#!/usr/bin/env bash
SDCARD_PATH=/media/user/bootfs
CONFIG_TXT=config.txt
CMDLINE_TXT=cmdline.txt
IPADDR=192.168.111.1


date

# sd카드를 인식한다
function detectSD(){
	while true;do
		if [ -d "${SDCARD_PATH}" ];then
			echo "SD 카드가 발견되었습니다."
			return
		fi
		sleep 1
	done
}
echo before detectSD
detectSD
echo after detectSD

#find config.txt cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINE_TXT}txt" ];then
		#echo -n "cmdline이 발견되었습니다."
		echo 0 #find
		return
	else
		echo 1 # not found
	fi
}

isCMDLINE=`detectCMDLINE`


#2 cmdline.txt 파일을 찾는다.
echo "cmdline.txt `detectCMDLINE`"
if [ $isCMDLINE -eq 0 ];then
	#find 192.168.111.1 & modify
	sed -i "s/111.111.111.111/${IPADDR}/" "${SDCARD_PATH}/${CMDLINE_TXT}"
	if [ $? -eq 0 ];then
		echo "${CMDLINE_TXT} 문서가 수정되었습니다. 성공"
	else
		echo "${CMDLINE_TXT} 문서가 수정x. 실패"
	fi

fi


#unmount /media/user/bootfs
umount /media/user/bootfs
echo "장치를 분리하셔도 됩니다"
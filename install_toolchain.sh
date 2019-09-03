#!/bin/bash
set -e
#####################################
##
## Install cross toolchain
#####################################

if [ -z $TOOT ]; then
	ROOT=`cd .. && pwd`
fi

TOOLS="$ROOT/toolchain"
TOOLTARXZ="$ROOT/toolchain/toolchain_tar/toolchain"
TOOLTAR="$ROOT/toolchain/toolchain.tar.gz"
UBOOTTAR="$ROOT/toolchain/uboot-tools.tar.gz"
UBOOTTARXZ="$ROOT/toolchain/toolchain_tar/u-boot-compile-tools"
UBOOTS="$TOOLS/gcc-linaro-aarch"

whiptail --title "OrangePi Build System" --msgbox "Installing Cross-Tools. Pls wait a mount." --ok-button Continue 10 40 0
clear
if [ ! -d $TOOLS/gcc-linaro-aarch ]; then
	echo -e "\e[1;31m Uncompress toolchain.. \e[0m"
	if [ -n "`find "$TOOLS"/toolchain_tar -maxdepth 1 -name 'toolchain*'`" ]; then
		cat ${TOOLTARXZ}* > ${TOOLTAR}
		tar xzvf $TOOLTAR -C $TOOLS
		rm -rf $TOOLTAR
		mv $TOOLS/toolchain/gcc-linaro-aarch $TOOLS
                rm -rf $TOOLS/toolchain
	elif [ -e $TOOLTAR ]; then
		tar xzvf $TOOLTAR -C $TOOLS
		rm -rf $TOOLTAR
    		mv $TOOLS/toolchain/gcc-linaro-aarch $TOOLS
    		rm -rf $TOOLS/toolchain
	else
		whiptail --title "OrangePi Build System" --msgbox "Error! These file of toolchian is not found!\n"${TOOLTARXZ}"*\n"$TOOLTAR 10 60 0
		echo -e "\e[1;31m Install Failed. \e[0m"
		exit 1
	fi
#	rm -rf $TOOLS/gcc-linaro-aarch/gcc-linaro
fi

if [ -d $ROOT/toolchain/gcc-linaro-aarch/gcc-linaro/arm-linux-gnueabihf ]; then
	rm -rf $ROOT/toolchain/gcc-linaro-aarch/gcc-linaro
fi

if [ ! -d $TOOLS/gcc-linaro-aarch/gcc-linaro/arm-linux-gnueabi ]; then
	if [ -n "`find "$TOOLS"/toolchain_tar -maxdepth 1 -name 'u-boot-compile-tools*'`" ]; then
		cat ${UBOOTTARXZ}* > ${UBOOTTAR}
		tar xzvf $UBOOTTAR -C $UBOOTS
                rm -rf $UBOOTTAR
	elif [ -e $UBOOTTAR ]; then
		tar xzvf $UBOOTTAR -C $UBOOTS
		rm -rf $UBOOTTAR
	else
		whiptail --title "OrangePi Build System" --msgbox "Error! These file of toolchian is not found!\n"${UBOOTTARXZ}"*\n"$UBOOTTAR 10 60 0
		echo -e "\e[1;31m Install Failed. \e[0m"
		exit 1
	fi
fi

whiptail --title "OrangePi Build System" --msgbox "Cross-Tools has installed." 10 40 0


#!/bin/bash
fun_set_text_color(){
    COLOR_RED='\E[1;31m'
    COLOR_GREEN='\E[1;32m'
    COLOR_YELOW='\E[1;33m'
    COLOR_BLUE='\E[1;34m'
    COLOR_PINK='\E[1;35m'
    COLOR_PINKBACK_WHITEFONT='\033[45;37m'
    COLOR_GREEN_LIGHTNING='\033[32m \033[05m'
    COLOR_END='\E[0m'
}
main(){
    echo -e "${COLOR_YELOW}============== Initialized build environment ==============${COLOR_END}"
    if [ -d "/home/asuswrt-merlin/tools/brcm" ] && [ -d "/home/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3" ]; then
        if [ ! -L /opt/brcm-arm ] || [ ! -L /opt/brcm ]; then
            echo -e -n "${COLOR_PINK}link brcm & brcm-arm${COLOR_END}"
            ln -s /home/asuswrt-merlin/tools/brcm /opt/brcm
            ln -s /home/asuswrt-merlin/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3 /opt/brcm-arm
            if [ -L /opt/brcm-arm ] && [ -L /opt/brcm ];then
                echo -e " ${COLOR_GREEN}done${COLOR_END}"
            else
                echo -e " ${COLOR_RED}failed${COLOR_END}"
                return 1
            fi
        fi
    else
        echo -e "${COLOR_RED}[error] /home/asuswrt-merlin/ not found${COLOR_END}"
        return 1
    fi
    echo -e -n "${COLOR_PINK}setting Environment...${COLOR_END}"
    CROSS_TOOLCHAINS_DIR=/opt/brcm-arm
    export PATH=$PATH:/opt/brcm/hndtools-mipsel-linux/bin:/opt/brcm/hndtools-mipsel-uclibc/bin:/opt/brcm-arm/bin
    export LD_LIBRARY_PATH=$CROSS_TOOLCHAINS_DIR/lib
    echo -e " ${COLOR_GREEN}done${COLOR_END}"
    #echo "$PATH"
}
fun_set_text_color
main


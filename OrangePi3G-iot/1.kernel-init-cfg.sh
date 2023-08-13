#!/bin/bash

build_dir=$(pwd)/output/obj/KERNEL_OBJ

echo $build_dir

CROSS=/mnt/data/HW/ARM/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

MTK_PROJECT=hexing72_cwet_lca
export MTK_PROJECT
export TARGET_PRODUCT=$MTK_PROJECT

BUILD=./output
EXTER=./external
OBJ=${BUILD}/obj
if [ ! -d $OBJ ]; then
    mkdir -p $OBJ
    echo "$MTK_PROJECT" > ${BUILD}/project
    cp -rfa ${EXTER}/${MTK_PROJECT}/* $OBJ
    if [ $MTK_PROJECT = "hexing72_cwet_lca" ]; then
        cp $EXTER/project/a/config/common/custom.conf $EXTER/mediatek/config/common/
        cp $EXTER/project/a/kernel/drivers/keypad/kpd.c $EXTER/mediatek/kernel/drivers/keypad/
        cp $EXTER/project/a/ddp_rdma.c $EXTER/mediatek/platform/mt6572/kernel/drivers/dispsys/
        cp $EXTER/project/a/lk/* $EXTER/mediatek/platform/mt6572/lk/
    else
        cp $EXTER/project/b/config/common/custom.conf $EXTER/mediatek/config/common/
        cp $EXTER/project/b/kernel/drivers/keypad/kpd.c $EXTER/mediatek/kernel/drivers/keypad/
        rm -rf $EXTER/mediatek/platform/mt6572/kernel/drivers/dispsys/ddp_rdma.c
        cp $EXTER/project/b/lk/* $EXTER/mediatek/platform/mt6572/lk/
    fi
fi

#export PATH=../external/make:$PATH

rm -r output/obj/CUSTGEN/custom/kernel/touchpanel

cp config $build_dir/.config

pushd kernel
#make O=$build_dir  ARCH=arm CROSS_COMPILE=$CROSS 3g-iot-A_linux_defconfig
make O=$build_dir  ARCH=arm CROSS_COMPILE=$CROSS silentoldconfig
popd

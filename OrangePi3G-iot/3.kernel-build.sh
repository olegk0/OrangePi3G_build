#!/bin/bash

build_dir=$(pwd)/output/obj/KERNEL_OBJ

echo $build_dir

CROSS=/mnt/data/HW/ARM/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

MTK_PROJECT=hexing72_cwet_lca
export MTK_PROJECT
export TARGET_PRODUCT=$MTK_PROJECT
#export PATH=../external/make:$PATH

pushd kernel
make O=$build_dir  ARCH=arm CROSS_COMPILE=$CROSS silentoldconfig
make O=$build_dir ARCH=arm CROSS_COMPILE=$CROSS -j10
popd

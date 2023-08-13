#!/bin/bash

build_dir=$(pwd)/output/obj/KERNEL_OBJ
mod_dir=$(pwd)/output

echo $mod_dir

rm -r $mod_dir/lib
mkdir -p $mod_dir

CROSS=/mnt/data/HW/ARM/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

MTK_PROJECT=hexing72_cwet_lca
export MTK_PROJECT
export TARGET_PRODUCT=$MTK_PROJECT

pushd kernel
make O=$build_dir ARCH=arm CROSS_COMPILE=$CROSS -j10 INSTALL_MOD_PATH=$mod_dir modules

make O=$build_dir ARCH=arm CROSS_COMPILE=$CROSS -j10 INSTALL_MOD_PATH=$mod_dir modules_install
popd

function build_mod {
    mod_dir=$1
    pushd $mod_dir
    make -j10 ARCH=arm CROSS_COMPILE=$CROSS KSRC=../../build
    popd
    cp $mod_dir/*.ko modules/lib/modules/*/kernel/drivers/
}

#build_mod ext_modules/rtl8189ES_linux-rtl8189fs
#build_mod ext_modules/rtl8189ES_linux-master

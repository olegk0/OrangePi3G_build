#!/bin/bash

build_dir=$(pwd)/output/obj/KERNEL_OBJ

echo $build_dir

MTK_PROJECT=hexing72_cwet_lca
EXTER=./external
BUILD=./output
KERNELBIN=$build_dir/arch/arm/boot/zImage

mkimg=${EXTER}/mediatek/build/tools/mkimage

${mkimg} ${KERNELBIN} KERNEL > $build_dir/kernel_${MTK_PROJECT}.bin

mkdir -p ${BUILD}/kernel
${EXTER}/mkbootimg --kernel ${BUILD}/obj/KERNEL_OBJ/kernel_${MTK_PROJECT}.bin --board 2016.07.04  --output ${BUILD}/kernel/boot.img
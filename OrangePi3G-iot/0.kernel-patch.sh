#!/bin/bash

cp patch/*.h  kernel/include/linux/

patch -p1 < patch/printk.c.patch


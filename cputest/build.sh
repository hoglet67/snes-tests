#!/bin/bash -e

BUILD=build
SSD=${BUILD}/cputest.ssd

SFC=cputest-full.sfc
rm -f ${SFC}
make -B

mkdir -p ${BUILD}
rm -f ${BUILD}/*


dd if=${SFC} of=${BUILD}/8000  bs=16384 count=1 skip=0
dd if=${SFC} of=${BUILD}/C000  bs=16384 count=1 skip=1
dd if=${SFC} of=${BUILD}/18000 bs=16384 count=2 skip=2
dd if=${SFC} of=${BUILD}/28000 bs=16384 count=2 skip=4
dd if=${SFC} of=${BUILD}/38000 bs=16384 count=2 skip=6
dd if=${SFC} of=${BUILD}/48000 bs=16384 count=2 skip=8
#dd if=${SFC} of=${BUILD}/58000 bs=16384 count=2 skip=10
#dd if=${SFC} of=${BUILD}/68000 bs=16384 count=2 skip=12
#dd if=${SFC} of=${BUILD}/78000 bs=16384 count=2 skip=14
#md5sum ${BUILD}/*000


beeb blank_ssd ${SSD}
beeb title ${SSD} "65816 TEST"
beeb opt4 ${SSD} 3
beeb putfile ${SSD} \!BOOT
beeb putfile ${SSD} ${BUILD}/8000
beeb putfile ${SSD} ${BUILD}/C000
beeb putfile ${SSD} ${BUILD}/18000
beeb putfile ${SSD} ${BUILD}/28000
beeb putfile ${SSD} ${BUILD}/38000
beeb putfile ${SSD} ${BUILD}/48000
beeb info ${SSD}

if [ -f /media/$USER/MMFS/BEEB.MMB ]
then
beeb dkill -y 1202
beeb dput_ssd 1202 ${SSD}
fi

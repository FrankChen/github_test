#!/bin/sh
############################################################################
#                      NXP PROPRIETARY AND CONFIDENTIAL                    #
#                        SOFTWARE FILE/MODULE HEADER                       #
#                      Copyright NXP Semiconductors 2009                   #
#                            All Rights Reserved                           #
############################################################################
#
# Filename:        stb_sys_startup.sh
#
# Description:     Simple script to startup a development system
#
# Author:          Nitin Garg
#
############################################################################
# $Id: S10_stb_sys_startup.sh 167978 2010-07-22 07:25:34Z asethi $
############################################################################

#set -x

PATH=/sbin:/bin:/usr/sbin:/usr/bin
KERNEL_VERSION=`uname -r`

if [ -f /opt/.appfs ] ; then
echo "Running insmod now ......."

if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxplatnativeDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxplatnativeDrv.ko
fi
insmod /lib/modules/$KERNEL_VERSION/extra/lnxKKALDrv.ko
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxnotifyqDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxnotifyqDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxplatDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxplatDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxscsDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxscsDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxfssDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxfssDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxcssDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxcssDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxtmasDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxtmasDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxtmvssDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxtmvssDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxpvrDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxpvrDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/vpmfbDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/vpmfbDrv.ko
fi
if [ -f /lib/modules/$KERNEL_VERSION/extra/lnxIPfeDrv.ko ]; then
insmod /lib/modules/$KERNEL_VERSION/extra/lnxIPfeDrv.ko
fi

echo "Driver mouldes loaded, please start the app now"
fi

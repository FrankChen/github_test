#!/bin/sh
############################################################################
#                      NXP PROPRIETARY AND CONFIDENTIAL                    #
#                        SOFTWARE FILE/MODULE HEADER                       #
#                      Copyright NXP Semiconductors 2009                   #
#                            All Rights Reserved                           #
############################################################################
#
# Filename:        stb_dev_node.sh
#
# Description:     Simple script to search for Major numbers assigned to dev
#                  and to create the nodes for various devices
#
# Author:          Harsh Kumar
#
############################################################################
# $Id: S15_stb_dev_node.sh 145549 2010-02-10 10:50:19Z asethi $
############################################################################

PATH=/bin:/usr/bin:/sbin:/usr/sbin

create_node()
{
  device=$1
  
  rm -f /dev/${device}
  major=`awk "\\$2==\"$device\" {print \\$1}" /proc/devices`
  
  if [ ${major} ]; then
     echo Creating device node for $1
                mknod /dev/${device} c $major 0
  fi

}

echo "Running mknod now ......."

create_node "KAL"
create_node "notifyq"
create_node "platform"
create_node "Content"
create_node "standby"
create_node "Audio"
create_node "Video"
create_node "PVR"
create_node "fb"
create_node "FrontEnd"
create_node "ipfe"

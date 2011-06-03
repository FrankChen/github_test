#!/bin/sh

PATH=/sbin:/bin:/usr/sbin:/usr/bin
STOP_TIMEOUT=1

do_mtd_appfs()
{

   #
   # The appfs device
   #
   #   Comment out the following envar to not attempt mounting the
   #   appfs from flash.
   #
   #   Note: Conexants default flash partitioning scheme is
   #     /dev/mtdblock0  uldr
   #     /dev/mtdblock1  u-boot
   #     /dev/mtdblock2  kernel
   #     /dev/mtdblock3  rootfs
   #     /dev/mtdblock4  appfs
   #
   APPFS_DEV=`sed -n -e '/appfs/p' /proc/mtd | cut -d : -f 0 | sed -e 's!mtd\([0-9]\)!mtdblock\1!'`

    if [ "x$APPFS_DEV" == "x" ] ; then
        echo "Error determining MTD device to use for APPFS"
        return 1
    fi

    if [ ! -b /dev/$APPFS_DEV ] ; then
        echo "Not a valid block device (/dev/$APPFS_DEV)"
        return 1
    fi

    echo "Trying to mount the appfs from flash (if the MTD partition is empty this could take a while)..."
    mount -t jffs2 /dev/$APPFS_DEV /opt

    return 0
}

do_nfs_appfs()
{
    # just because the appfs is coming from NFS doesn't mean the rootfs
    # is too.  Therefore, eth0 may not be up yet.
    ifconfig eth0 | grep UP > /dev/null 2>&1
    if [ $? == 1 ]; then
        if ! ifup eth0 ; then
            # Not fatal, continue but print a message
            echo  "Unable to start networking"
        fi
    fi

    APPFS_NFS=$APPFS
    echo "Trying to mount the appfs via NFS ..."
    if ! (mount -t nfs -o nolock,tcp,rw,nfsvers=3 $APPFS_NFS /opt) ; then
        echo "Failed to mount appfs via NFS"
        return 1
    fi

    return 0
}

echo "Starting Network now ......."
ifup -a -f

if [ -f /opt/.appfs ] ; then
    echo "Using appfs within rootfs"
else
if [ "x$APPFS" == "x" ]; then
   do_mtd_appfs
else
   do_nfs_appfs
fi
fi

if [ $? == 1 ]; then
    echo "Error encountered"
    exit $status
fi

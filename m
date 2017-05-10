From: Paul Bongaerts <pauluzs@gmail.com>
Subject: J1939 kernel for Raspberry Pi
Date: Wed, 10 May 2017 13:50:25 +0200
Message-ID: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34488 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdEJLu0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 May 2017 07:50:26 -0400
Received: by mail-yb0-f195.google.com with SMTP id l192so1042313ybl.1
        for <linux-can@vger.kernel.org>; Wed, 10 May 2017 04:50:26 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

After struggling for the last 5 days i keep failing in building a
working custom  jessie lite based j1939 arm kernel. for a raspberrypi
(b.t.w. i'm certainly no expert on kernel building)

Tried  local and  crosscompiled builds with different setting

Goal is to build a kernel according to the Raspberrypi kernel building guide
https://www.raspberrypi.org/documentation/linux/kernel/building.md

And merge this with a J1939 kernel according to this elinux j1939 guide.
http://elinux.org/J1939

Because this takes several hours per build and over a day on the pi i
could use some help in the right direction



Br, Paul




Failed attempts summary :

Compile a working kernel with no j1939 support on rpi locally
(modprobe can-j1939 Fails)
Crosscompile unbootable kernels with j1939 support on ubuntu (Fails to boot)


#########################################################################
Native compile
rapsberry pi zero w    16 GB SD Card
#########################################################################


Setup the build environment

sudo apt-get install git bc
git clone --depth=1 https://github.com/raspberrypi/linux
cd linux
    git remote add j1939 git://github.com/kurt-vd/linux
    git remote update j1939 |& tee -a ~/j1939update.log


Merge j1939-v4.7 with rpi-master takes several hours

    git merge j1939/j1939d-v4.7 |& tee -a ~/j1939merge.log
    (jessie image uses uname -r 4.9.24+  so 4.7 is closest lower version)

cd ~/linux
KERNEL=kernel
make bcmrpi_defconfig

Build the kernel, modules and devicetree overlays.  time ~ 24h

make zImage modules dtbs

Install the modules

sudo make modules_install

Copy the files to the right locations

sudo cp arch/arm/boot/dts/*.dtb /boot/
sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
sudo cp arch/arm/boot/zImage /boot/$KERNEL.img
sudo reboot
sudo modprobe can-j1939
modprobe: FATAL: Module can-j1939 not found.


#########################################################################
Crosscompile j1939-v4.7 > rpi kernel
ubuntu-16.04.2-server-amd64.iso
#########################################################################

cd /usr/src

Get crosscompile Toolchain

git clone git://github.com/raspberrypi/tools.git --depth=1

Get j1939-v4.7 branch kernel sources

git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux --depth=1

cd /usr/src/linux

export PATH

export PATH=$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin

Clean the kernel source

make mrproper



Now login to a running rpi (Clean raspbian-jessie-lite, uname -a r 4.9.24+ )

Create config.gz

pi@raspberrypi:~ $ sudo modprobe configs

Copy the config.gz to build server

pi@raspberrypi:~ $ scp /proc/config.gz user@server.local:/usr/src/linux



Back on Server

gunzip -c config.gz > .config

Set kernel varialble

KERNEL=kernel


Build Kernel Image, Modules and Devicetreeoverlays (select: SAE J1939
as module, debug SAE J1939 yes, CAN_IFI_CANFD as module)

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs


copy files to SD according to raspberry's kernelbuildingguide and boot
(fails to boot)

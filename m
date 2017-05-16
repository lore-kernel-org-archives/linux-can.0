From: Paul Bongaerts <pauluzs@gmail.com>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Tue, 16 May 2017 22:40:55 +0200
Message-ID: <CAGJdXcH83=tD3uW84Mf-szc5VUsg2gjP6j+gZKUwd+RZGW5hnA@mail.gmail.com>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
 <20170511192936.GB15112@airbook.vandijck-laurijssen.be> <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
 <CAGJdXcEP4ry-LDE5ZtM+00mBgQM3gB1M5rETTXJ2rdHNnw=Wfw@mail.gmail.com>
 <20170515071420.GA2533@airbook.vandijck-laurijssen.be> <CAGJdXcHk2qJxMnxjPTCVTFFSr-mdorGS+gzn8qVW-o+dX1vt3Q@mail.gmail.com>
 <CAGJdXcFPye1VUwaSkDLKNf_apXud3Qnj_wYXv1PzsypbmvCdXQ@mail.gmail.com>
 <20170515124359.GA10149@airbook.vandijck-laurijssen.be> <20170516130217.GA1126@airbook.vandijck-laurijssen.be>
 <20170516131342.GB1126@airbook.vandijck-laurijssen.be> <CAGJdXcH3qsaDRjfwiOadpO794z8fuaNyiGCowmLA_TVGc5xxTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35153 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdEPUk4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2017 16:40:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id p144so8690419ywp.2
        for <linux-can@vger.kernel.org>; Tue, 16 May 2017 13:40:56 -0700 (PDT)
In-Reply-To: <CAGJdXcH3qsaDRjfwiOadpO794z8fuaNyiGCowmLA_TVGc5xxTw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>, linux-can@vger.kernel.org

Working, cleaned up howto
Mailinglist messes up tabbed indentation for nice reading i'm afraid.

#######################################################################################
Cross Compile J1939 - Raspberrypi rpi-4.9.y
Compiled on
Linux 4.4.0-77-generic #98-Ubuntu SMP x86_64 x86_64 x86_64 GNU/Linux
Tested hardware setup
Raspberry pi zero wireless 16 GB SD Card
2 mcp2515 8mhz xtal spi canschields modified for 3.3V
cs0 on BCM pin 8 cs1 on BCM pin 7 interupts on BCM pins 24 and 25
#######################################################################################

Update and upgrade

sudo apt-get update
sudo apt-get upgrade

Install  build-essentials, bc, git, ncurses and unzip

sudo apt-get install build-essential bc git-core libncurses5-dev unzip

Make a src dir in user directory

mkdir ~/src

Go into src dir

cd ~/src

Get crosscompile Toolchain

git clone git://github.com/raspberrypi/tools.git

Export crosscompile toolchain path

To crosscompile on 32 bit system
export PATH=$PATH:~/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
To crosscompile on 64 bits system
export PATH=$PATH:~/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin

Next get raspberry 4.9 branch sources

git clone -b rpi-4.9.y --single-branch git://github.com/raspberrypi/linux

Go into linux dir

cd ~/src/linux

Add the J1939 v4.9.10 remote sources

git remote add -t j1939d-v4.9.10 j1939 git://github.com/kurt-vd/linux

Update J1939 remote

git remote update j1939

Merge j1939-v4.9.10 with rpi-4.9.y

git merge j1939/j1939d-v4.9.10

Set kernel type

For Raspberry Pi 1/compute/zero (w)
KERNEL=kernel
For Raspberry Pi 2/3
KERNEL=kernel7

Use default config

For Raspberry Pi 1/compute/zero(w)
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
For Raspberry Pi 2/3
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig

Enable j1939 can kernel modeles

make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig

Go into [*] Networking support  --->
Go into <M>   CAN bus subsystem support  --->
Select SAE J1939 as module, enable debug
<M>   SAE J1939
[*]     debug SAE J1939
Go into CAN Device Drivers  --->
Select the desired device drivers
Exit menuconfig and save the new kernel configuration

Build Kernel Image, Modules and Devicetreeoverlays (remove the -j4
option when building on 32 bit system)

make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs

Get latest Raspbian Image

For Raspbian lite
wget https://downloads.raspberrypi.org/raspbian_lite_latest -P ~/src/
For Raspbian with pixel
wget https://downloads.raspberrypi.org/raspbian_latest -P ~/src/

Unzip and write image to SD card (assuming /dev/sdb is the SD)

For Raspbian lite
unzip -p ~/src/raspbian_lite_latest | sudo dd of=/dev/sdb bs=4096
For Raspbian with pixel
unzip -p ~/src/raspbian_latest | sudo dd of=/dev/sdb bs=4096

Create mount locations and mount SD card
mkdir ~/mnt
mkdir ~/mnt/fat32
mkdir ~/mnt/ext4
sudo mount /dev/sdb1 ~/mnt/fat32
sudo mount /dev/sdb2 ~/mnt/ext4

Install the modules to SD:

sudo make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
INSTALL_MOD_PATH=~/mnt/ext4 modules_install

Backup original Kernel, Copy new Kernel and Device Tree blobs to SD card

sudo cp ~/mnt/fat32/$KERNEL.img ~/mnt/fat32/$KERNEL-backup.img
sudo cp ~/src/linux/arch/arm/boot/zImage ~/mnt/fat32/$KERNEL.img
sudo cp ~/src/linux/arch/arm/boot/dts/*.dtb ~/mnt/fat32/
sudo cp ~/src/linux/arch/arm/boot/dts/overlays/*.dtb* ~/mnt/fat32/overlays/
sudo cp ~/src/linux/arch/arm/boot/dts/overlays/README ~/mnt/fat32/overlays/

Enable ssh on boot

sudo touch ~/mnt/fat32/ssh

Setup Wireless(add lines below)

sudo nano ~/mnt/ext4/etc/wpa_supplicant/wpa_supplicant.conf

network={
ssid="YOURWIRELESSNETWORK"
psk="YOURWIRELESSPASSWORD"
}

Enable spi and mcp2515 overlays(add lines below) for 16Mhz shields use
oscillator=16000000

sudo nano ~/mnt/fat32/config.txt

dtparam=spi=on
dtoverlay=spi-bcm2835-overlay
dtoverlay=mcp2515-can0,oscillator=8000000,interrupt=24
dtoverlay=mcp2515-can1,oscillator=8000000,interrupt=25

Set can interfaces to start at boot (add lines below)

sudo nano ~/mnt/ext4/etc/network/interfaces

auto can0
iface can0 inet manual
pre-up /sbin/ip link set $IFACE type can bitrate 250000
up /sbin/ifconfig $IFACE up
down /sbin/ifconfig $IFACE down

auto can1
iface can1 inet manual
pre-up /sbin/ip link set $IFACE type can bitrate 250000
up /sbin/ifconfig $IFACE up
down /sbin/ifconfig $IFACE down

Unmount SD

sudo umount ~/mnt/fat32
sudo umount ~/mnt/ext4

Put SD card in Raspberry Pi and give it about a minute to boot

Ssh into Raspberry Pi

ssh pi@raspberrypi.local

Install build depencies

pi@raspberrypi:~ $ sudo apt-get install git bc

Install linux-can

pi@raspberrypi:~ $ git clone https://github.com/linux-can/can-utils.git
pi@raspberrypi:~ $ cd can-utils
pi@raspberrypi:~ $ make
pi@raspberrypi:~ $ sudo make install

Install testj1939

pi@raspberrypi:~ $ cd ~
pi@raspberrypi:~ $ git clone https://github.com/kurt-vd/test-can-j1939.git
pi@raspberrypi:~ $ cd test-can-j1939/
pi@raspberrypi:~ $ make
pi@raspberrypi:~ $ sudo make install

Open a second Ssh into Raspberry Pi

ssh pi@raspberrypi.local

Test your can interfaces, (can0 needs to be wired to can1)
On the first ssh session

pi@raspberrypi:~ $ candump can0

Op the second ssh sesion and send some data

pi@raspberrypi:~ $ cansend can1 7DF#0201050000000000

Check the output in first ssh session

Repeat test vise versa to ensure both interupts are working

On the first ssh session

pi@raspberrypi:~ $ candump can1

Op the second ssh sesion and send some data

pi@raspberrypi:~ $ cansend can0 7DF#0201050000000000

Check the output in first ssh session

Test J1939
On the first ssh session

pi@raspberrypi:~ $ testj1939 -r can0

Op the second ssh sesion and send some data

pi@raspberrypi:~ $ testj1939 -s can1:0x90,0x3ffff

Check the output in first ssh session

All Done!!

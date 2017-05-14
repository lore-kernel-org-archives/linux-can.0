From: Paul Bongaerts <pauluzs@gmail.com>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Mon, 15 May 2017 00:30:55 +0200
Message-ID: <CAGJdXcEP4ry-LDE5ZtM+00mBgQM3gB1M5rETTXJ2rdHNnw=Wfw@mail.gmail.com>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
 <20170511192936.GB15112@airbook.vandijck-laurijssen.be> <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36338 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdENWa4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 14 May 2017 18:30:56 -0400
Received: by mail-yw0-f193.google.com with SMTP id h82so2707426ywb.3
        for <linux-can@vger.kernel.org>; Sun, 14 May 2017 15:30:56 -0700 (PDT)
In-Reply-To: <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>, linux-can@vger.kernel.org

Still getting a error when trying to cross compile



Go into src dir

cd /usr/src

Get crosscompile Toolchain

git clone git://github.com/raspberrypi/tools.git

Next get raspberry sources

git clone git://github.com/raspberrypi/linux.git

Go into linux dir

cd /usr/src/linux

Remote add the j1939 sources

git remote add j1939 git://github.com/kurt-vd/linux

Update j1939 remote

git remote update j1939

Merge j1939-v4.7 with rpi-master

    git merge j1939/j1939d-v4.7
    (Rpi jessie image uses uname -r 4.9.24+  so 4.7 is closest lower
J1939 version)

export crosscompile toolchain path

To build on 32 bit system
export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabi=
hf-raspbian/bin
To build on 64 bits system
export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabi=
hf-raspbian-x64/bin

Clean the kernel source

make mrproper

Set kernel type

For Rapberry Pi 1/compute/zero (w)
KERNEL=3Dkernel
For Raspberry Pi 2/3
KERNEL=3Dkernel7

Use default config

For Rapberry Pi 1/compute/zero(w)
make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcmrpi_defconfig
For Raspberry Pi 2/3
make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcm2709_defconfig

Enable j1939 can kernel modeles

make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- menuconfig

Go into Networking Support Select SAE J1939 as module, enable debug.
Go into CAN Device Drivers and select your device drivers

<M>   CAN bus subsystem support  --->
--- CAN bus subsystem support
<M>   Raw CAN Protocol (raw access with CAN-ID filtering)
<M>   Broadcast Manager CAN Protocol (with content filtering)
<M>   CAN Gateway/Router (with netlink configuration)
<M>   SAE J1939
[*]     debug SAE J1939
CAN Device Drivers  --->

Exit menuconfig and save the config

Build Kernel Image, Modules and Devicetreeoverlays

make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtb

  ......
  CC [M]  net/bridge/br_netfilter_hooks.o
  CC [M]  net/bridge/br_netfilter_ipv6.o
  LD [M]  net/bridge/br_netfilter.o
  LD      net/can/built-in.o
  CC [M]  net/can/af_can.o
  CC [M]  net/can/proc.o
  LD [M]  net/can/can.o
  CC [M]  net/can/raw.o
  LD [M]  net/can/can-raw.o
  CC [M]  net/can/bcm.o
  LD [M]  net/can/can-bcm.o
  CC [M]  net/can/gw.o
  LD [M]  net/can/can-gw.o
  LD      net/can/j1939/built-in.o
  CC [M]  net/can/j1939/address-claim.o
  CC [M]  net/can/j1939/bus.o
  CC [M]  net/can/j1939/main.o
net/can/j1939/main.c: In function =E2=80=98j1939_netdev_start=E2=80=99:
net/can/j1939/main.c:238:10: error: too few arguments to function
=E2=80=98can_rx_register=E2=80=99
          j1939_can_recv, priv, "j1939");
          ^
In file included from net/can/j1939/main.c:25:0:
./include/linux/can/core.h:57:5: note: declared here
 int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
     ^
scripts/Makefile.build:293: recipe for target 'net/can/j1939/main.o' failed
make[3]: *** [net/can/j1939/main.o] Error 1
scripts/Makefile.build:544: recipe for target 'net/can/j1939' failed
make[2]: *** [net/can/j1939] Error 2
scripts/Makefile.build:544: recipe for target 'net/can' failed
make[1]: *** [net/can] Error 2
Makefile:988: recipe for target 'net' failed
make: *** [net] Error 2
user@jessie:/usr/src/linux$


2017-05-14 19:57 GMT+02:00 Paul Bongaerts <pauluzs@gmail.com>:
> Hi Kurt
>
> Found some tiime to look into this again,
>
> Just to be sure:
>
>>> git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux --depth=3D1
>
>>(1) You should not clone 2 repo's, but use remotes
>>(2) using '--depth=3D1' ignores history, but you will need the history fo=
r
>>the merge. 'git clone' takes time once, spending it enables you to
>>benefit of the git features.
>
> (1) Should I clone the kernel repo and and remote add your repo or
> remote add both?
> (2) Because that history do i clone/add the whole repo or would just
> using the 4.9 kernel branch and your 4.7 branch be sufficient?
>
>>>
>>> cd /usr/src/linux
>
>
> ......
>
>>Which files did you copy?
>
> Copy the files to the right locations:
>
> sudo cp arch/arm/boot/dts/*.dtb /boot/
> sudo cp arch/arm/boot/dts/overlays/*.dtb* /boot/overlays/
> sudo cp arch/arm/boot/dts/overlays/README /boot/overlays/
> sudo cp arch/arm/boot/zImage /boot/$KERNEL.img
>
> Btw the can hardware to answer patricks question:
>
>> just for the record, socketcan itself works on your pi, yes?
>
> Yes the hardware and socketcan are working candump and cansend work
> like they should
>
> Br Paul
>
> 2017-05-11 21:29 GMT+02:00 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.b=
e>:
>>> Because this takes several hours per build and over a day on the pi i
>>> could use some help in the right direction
>>
>> My principle is that I need indeed to decrease the
>> 'modify-build-reload' time before problems get solved.
>>
>>> Merge j1939-v4.7 with rpi-master takes several hours
>>
>> restrict yourself to cross-compile then. git merge should take 1.2.3
>> seconds. A minute at most.
>>
>> See my further comments inline below:
>>
>> --- Original message ---
>>> Date:   Wed, 10 May 2017 13:50:25 +0200
>>> From: Paul Bongaerts <pauluzs@gmail.com>
>>> To: linux-can@vger.kernel.org
>>> Subject: J1939 kernel for Raspberry Pi
>>>
>>> After struggling for the last 5 days i keep failing in building a
>>> working custom  jessie lite based j1939 arm kernel. for a raspberrypi
>>> (b.t.w. i'm certainly no expert on kernel building)
>>>
>>> Tried  local and  crosscompiled builds with different setting
>>>
>>> Goal is to build a kernel according to the Raspberrypi kernel building =
guide
>>> https://www.raspberrypi.org/documentation/linux/kernel/building.md
>>>
>>> And merge this with a J1939 kernel according to this elinux j1939 guide=
.
>>> http://elinux.org/J1939
>>>
>>> Because this takes several hours per build and over a day on the pi i
>>> could use some help in the right direction
>>>
>>>
>>>
>>> Br, Paul
>>>
>>>
>>>
>>>
>>> Failed attempts summary :
>>>
>>> Compile a working kernel with no j1939 support on rpi locally
>>> (modprobe can-j1939 Fails)
>>> Crosscompile unbootable kernels with j1939 support on ubuntu (Fails to =
boot)
>>>
>>>
>>> #######################################################################=
##
>>> Native compile
>>> rapsberry pi zero w    16 GB SD Card
>>> #######################################################################=
##
>>
>> I stripped the native compile, it takes too much time, but should not be
>> different.
>>
>>> #######################################################################=
##
>>> Crosscompile j1939-v4.7 > rpi kernel
>>> ubuntu-16.04.2-server-amd64.iso
>>> #######################################################################=
##
>>>
>>> cd /usr/src
>>>
>>> Get crosscompile Toolchain
>>>
>>> git clone git://github.com/raspberrypi/tools.git --depth=3D1
>>>
>>> Get j1939-v4.7 branch kernel sources
>>>
>>> git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux --depth=3D1
>>
>> (1) You should not clone 2 repo's, but use remotes
>> (2) using '--depth=3D1' ignores history, but you will need the history f=
or
>> the merge. 'git clone' takes time once, spending it enables you to
>> benefit of the git features.
>>
>>>
>>> cd /usr/src/linux
>>>
>>> export PATH
>>>
>>> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnu=
eabihf-raspbian-x64/bin
>>>
>>> Clean the kernel source
>>>
>>> make mrproper
>>>
>>>
>>>
>>> Now login to a running rpi (Clean raspbian-jessie-lite, uname -a r 4.9.=
24+ )
>>>
>>> Create config.gz
>>>
>>> pi@raspberrypi:~ $ sudo modprobe configs
>>>
>>> Copy the config.gz to build server
>>>
>>> pi@raspberrypi:~ $ scp /proc/config.gz user@server.local:/usr/src/linux
>>>
>>>
>>>
>>> Back on Server
>>>
>>> gunzip -c config.gz > .config
>>>
>>> Set kernel varialble
>>>
>>> KERNEL=3Dkernel
>>>
>>>
>>> Build Kernel Image, Modules and Devicetreeoverlays (select: SAE J1939
>>> as module, debug SAE J1939 yes, CAN_IFI_CANFD as module)
>>>
>>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtb=
s
>>>
>>>
>>> copy files to SD according to raspberry's kernelbuildingguide and boot
>>> (fails to boot)
>>
>> Which files did you copy?
>>
>> I suspect you should make a (temporary) directory where you install
>> kernel & modules to. That directory is to be copies recursively to the
>> RPI.
>>
>> Kind regards,
>> Kurt

From: Paul Bongaerts <pauluzs@gmail.com>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Mon, 15 May 2017 12:53:38 +0200
Message-ID: <CAGJdXcFPye1VUwaSkDLKNf_apXud3Qnj_wYXv1PzsypbmvCdXQ@mail.gmail.com>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
 <20170511192936.GB15112@airbook.vandijck-laurijssen.be> <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
 <CAGJdXcEP4ry-LDE5ZtM+00mBgQM3gB1M5rETTXJ2rdHNnw=Wfw@mail.gmail.com>
 <20170515071420.GA2533@airbook.vandijck-laurijssen.be> <CAGJdXcHk2qJxMnxjPTCVTFFSr-mdorGS+gzn8qVW-o+dX1vt3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34757 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932268AbdEOKxp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2017 06:53:45 -0400
Received: by mail-yb0-f194.google.com with SMTP id l192so3977860ybl.1
        for <linux-can@vger.kernel.org>; Mon, 15 May 2017 03:53:45 -0700 (PDT)
In-Reply-To: <CAGJdXcHk2qJxMnxjPTCVTFFSr-mdorGS+gzn8qVW-o+dX1vt3Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>, linux-can@vger.kernel.org

ment
Like:
git remote add -b j1939d-v4.7 j1939 git://github.com/kurt-vd/linux
or
git remote add  j1939 git://github.com/kurt-vd/linux/tree/j1939d-v4.7
instead
git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux

2017-05-15 12:50 GMT+02:00 Paul Bongaerts <pauluzs@gmail.com>:
> Hi,
>
> I'll wait for your 4.9 fix.
>
> My own kernel is 4.9.24. only without the J1939
> That's what the question about branching was about.
>
> Is it possible to use the 4.7 branch?
> Like :
> git clone git://github.com/raspberrypi/linux/tree/rpi-4.7.y
> Or:
> git clone -b rpi-4.7.y git://github.com/raspberrypi/linux
>
> Instead of :
> git clone git://github.com/raspberrypi/linux.git
>
> Or does this mess up the history as well?
>
> Same goes for adding your remote
> would just the 4.7 branch be enough?
> Like:
> git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux
> Or does this mess up the history as well?
>
> 2017-05-15 9:14 GMT+02:00 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be=
>:
>> Hey,
>>
>> I was just looking your previous email, but I see here below that you
>> all got it right.
>>>
>>> Still getting a error when trying to cross compile
>>>
>>>
>>>
>>> Go into src dir
>>>
>>> cd /usr/src
>>>
>>> Get crosscompile Toolchain
>>>
>>> git clone git://github.com/raspberrypi/tools.git
>>>
>>> Next get raspberry sources
>>>
>>> git clone git://github.com/raspberrypi/linux.git
>>>
>>> Go into linux dir
>>>
>>> cd /usr/src/linux
>>>
>>> Remote add the j1939 sources
>>>
>>> git remote add j1939 git://github.com/kurt-vd/linux
>>>
>>> Update j1939 remote
>>>
>>> git remote update j1939
>>>
>>> Merge j1939-v4.7 with rpi-master
>>>
>>>     git merge j1939/j1939d-v4.7
>>>     (Rpi jessie image uses uname -r 4.9.24+  so 4.7 is closest lower
>>> J1939 version)
>>>
>>> export crosscompile toolchain path
>>>
>>> To build on 32 bit system
>>> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnu=
eabihf-raspbian/bin
>>> To build on 64 bits system
>>> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnu=
eabihf-raspbian-x64/bin
>>>
>>> Clean the kernel source
>>>
>>> make mrproper
>>>
>>> Set kernel type
>>>
>>> For Rapberry Pi 1/compute/zero (w)
>>> KERNEL=3Dkernel
>>> For Raspberry Pi 2/3
>>> KERNEL=3Dkernel7
>>>
>>> Use default config
>>>
>>> For Rapberry Pi 1/compute/zero(w)
>>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcmrpi_defconfig
>>> For Raspberry Pi 2/3
>>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcm2709_defconfig
>>>
>>> Enable j1939 can kernel modeles
>>>
>>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- menuconfig
>>>
>>> Go into Networking Support Select SAE J1939 as module, enable debug.
>>> Go into CAN Device Drivers and select your device drivers
>>>
>>> <M>   CAN bus subsystem support  --->
>>> --- CAN bus subsystem support
>>> <M>   Raw CAN Protocol (raw access with CAN-ID filtering)
>>> <M>   Broadcast Manager CAN Protocol (with content filtering)
>>> <M>   CAN Gateway/Router (with netlink configuration)
>>> <M>   SAE J1939
>>> [*]     debug SAE J1939
>>> CAN Device Drivers  --->
>>>
>>> Exit menuconfig and save the config
>>>
>>> Build Kernel Image, Modules and Devicetreeoverlays
>>>
>>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modules dtb
>>>
>>>   ......
>>>   CC [M]  net/bridge/br_netfilter_hooks.o
>>>   CC [M]  net/bridge/br_netfilter_ipv6.o
>>>   LD [M]  net/bridge/br_netfilter.o
>>>   LD      net/can/built-in.o
>>>   CC [M]  net/can/af_can.o
>>>   CC [M]  net/can/proc.o
>>>   LD [M]  net/can/can.o
>>>   CC [M]  net/can/raw.o
>>>   LD [M]  net/can/can-raw.o
>>>   CC [M]  net/can/bcm.o
>>>   LD [M]  net/can/can-bcm.o
>>>   CC [M]  net/can/gw.o
>>>   LD [M]  net/can/can-gw.o
>>>   LD      net/can/j1939/built-in.o
>>>   CC [M]  net/can/j1939/address-claim.o
>>>   CC [M]  net/can/j1939/bus.o
>>>   CC [M]  net/can/j1939/main.o
>>> net/can/j1939/main.c: In function =E2=80=98j1939_netdev_start=E2=80=99:
>>> net/can/j1939/main.c:238:10: error: too few arguments to function
>>> =E2=80=98can_rx_register=E2=80=99
>>>           j1939_can_recv, priv, "j1939");
>>>           ^
>>> In file included from net/can/j1939/main.c:25:0:
>>> ./include/linux/can/core.h:57:5: note: declared here
>>>  int can_rx_register(struct net_device *dev, canid_t can_id, canid_t ma=
sk,
>>>      ^
>>> scripts/Makefile.build:293: recipe for target 'net/can/j1939/main.o' fa=
iled
>>
>> This is a code problem, not a git problem.
>> Between 4.7 & 4.9, can_rx_register may have changed prototype.
>> You didn't do anything wrong.
>> I'll have to prepare a 4.9 branch with a small fix ...
>>
>>> make[3]: *** [net/can/j1939/main.o] Error 1
>>> scripts/Makefile.build:544: recipe for target 'net/can/j1939' failed
>>> make[2]: *** [net/can/j1939] Error 2
>>> scripts/Makefile.build:544: recipe for target 'net/can' failed
>>> make[1]: *** [net/can] Error 2
>>> Makefile:988: recipe for target 'net' failed
>>> make: *** [net] Error 2
>>> user@jessie:/usr/src/linux$
>>
>> To continue in between, when you don't add j1939 to the kernel, are you
>> able to boot you own kernel? You can grab the version with 'uname -a'.
>>
>> Kurt

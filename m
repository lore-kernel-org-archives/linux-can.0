From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Tue, 16 May 2017 15:02:17 +0200
Message-ID: <20170516130217.GA1126@airbook.vandijck-laurijssen.be>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
 <20170511192936.GB15112@airbook.vandijck-laurijssen.be>
 <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
 <CAGJdXcEP4ry-LDE5ZtM+00mBgQM3gB1M5rETTXJ2rdHNnw=Wfw@mail.gmail.com>
 <20170515071420.GA2533@airbook.vandijck-laurijssen.be>
 <CAGJdXcHk2qJxMnxjPTCVTFFSr-mdorGS+gzn8qVW-o+dX1vt3Q@mail.gmail.com>
 <CAGJdXcFPye1VUwaSkDLKNf_apXud3Qnj_wYXv1PzsypbmvCdXQ@mail.gmail.com>
 <20170515124359.GA10149@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:42297 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdEPNCW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2017 09:02:22 -0400
Content-Disposition: inline
In-Reply-To: <20170515124359.GA10149@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Paul Bongaerts <pauluzs@gmail.com>

Hey all,

I was looking into this change in can_rx_register.
I stumbled upon commit

adf86d59bb9b08d9eb67054251d29484c5ec102c can: Fix kernel panic at security_sock_rcv_skb

This is the 1st reason that Paul didn't succeed in compiling the RPI kernel.
I'm just asking myself: is this a temporary hack, will it stay, what
will I do with it?

@Paul, in the meantime, you could add ", NULL" in the call to
can_rx_register (on net/can/j1939/main.c:238) to compile the kernel.
I'm not sure if this is a good thing in the long run?

Kind regards,
Kurt

--- Original message ---
> Date:   Mon, 15 May 2017 14:43:59 +0200
> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> To: Paul Bongaerts <pauluzs@gmail.com>
> Cc: linux-can@vger.kernel.org
> Subject: Re: J1939 kernel for Raspberry Pi
> User-Agent: Mutt/1.5.22 (2013-10-16)
> 
> > 
> > ment
> > Like:
> > git remote add -b j1939d-v4.7 j1939 git://github.com/kurt-vd/linux
> > or
> > git remote add  j1939 git://github.com/kurt-vd/linux/tree/j1939d-v4.7
> > instead
> > git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux
> > 
> 
> I believe you should then
> 
> 	git clone -b rpi-4.7.y --single-branch git://github.com/raspberrypi/linux
> 	git remote add -t j1939d-v4.7 j1939 git://github.com/kurt-vd/linux
> 
> This would be ok wrt. retaining history.
> 
> > 2017-05-15 12:50 GMT+02:00 Paul Bongaerts <pauluzs@gmail.com>:
> > > Hi,
> > >
> > > I'll wait for your 4.9 fix.
> 
> today or tomorrow :-)
> 
> > >
> > > My own kernel is 4.9.24. only without the J1939
> > > That's what the question about branching was about.
> > >
> > > Is it possible to use the 4.7 branch?
> 
> yes.
> 
> Can you make sure that the newly compiled kernel boots, before adding
> j1939? One step at a time :-)
> 
> Kurt
> 
> > > Like :
> > > git clone git://github.com/raspberrypi/linux/tree/rpi-4.7.y
> > > Or:
> > > git clone -b rpi-4.7.y git://github.com/raspberrypi/linux
> > >
> > > Instead of :
> > > git clone git://github.com/raspberrypi/linux.git
> > >
> > > Or does this mess up the history as well?
> > >
> > > Same goes for adding your remote
> > > would just the 4.7 branch be enough?
> > > Like:
> > > git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux
> > > Or does this mess up the history as well?
> > >
> > > 2017-05-15 9:14 GMT+02:00 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>:
> > >> Hey,
> > >>
> > >> I was just looking your previous email, but I see here below that you
> > >> all got it right.
> > >>>
> > >>> Still getting a error when trying to cross compile
> > >>>
> > >>>
> > >>>
> > >>> Go into src dir
> > >>>
> > >>> cd /usr/src
> > >>>
> > >>> Get crosscompile Toolchain
> > >>>
> > >>> git clone git://github.com/raspberrypi/tools.git
> > >>>
> > >>> Next get raspberry sources
> > >>>
> > >>> git clone git://github.com/raspberrypi/linux.git
> > >>>
> > >>> Go into linux dir
> > >>>
> > >>> cd /usr/src/linux
> > >>>
> > >>> Remote add the j1939 sources
> > >>>
> > >>> git remote add j1939 git://github.com/kurt-vd/linux
> > >>>
> > >>> Update j1939 remote
> > >>>
> > >>> git remote update j1939
> > >>>
> > >>> Merge j1939-v4.7 with rpi-master
> > >>>
> > >>>     git merge j1939/j1939d-v4.7
> > >>>     (Rpi jessie image uses uname -r 4.9.24+  so 4.7 is closest lower
> > >>> J1939 version)
> > >>>
> > >>> export crosscompile toolchain path
> > >>>
> > >>> To build on 32 bit system
> > >>> export PATH=$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin
> > >>> To build on 64 bits system
> > >>> export PATH=$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
> > >>>
> > >>> Clean the kernel source
> > >>>
> > >>> make mrproper
> > >>>
> > >>> Set kernel type
> > >>>
> > >>> For Rapberry Pi 1/compute/zero (w)
> > >>> KERNEL=kernel
> > >>> For Raspberry Pi 2/3
> > >>> KERNEL=kernel7
> > >>>
> > >>> Use default config
> > >>>
> > >>> For Rapberry Pi 1/compute/zero(w)
> > >>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
> > >>> For Raspberry Pi 2/3
> > >>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
> > >>>
> > >>> Enable j1939 can kernel modeles
> > >>>
> > >>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
> > >>>
> > >>> Go into Networking Support Select SAE J1939 as module, enable debug.
> > >>> Go into CAN Device Drivers and select your device drivers
> > >>>
> > >>> <M>   CAN bus subsystem support  --->
> > >>> --- CAN bus subsystem support
> > >>> <M>   Raw CAN Protocol (raw access with CAN-ID filtering)
> > >>> <M>   Broadcast Manager CAN Protocol (with content filtering)
> > >>> <M>   CAN Gateway/Router (with netlink configuration)
> > >>> <M>   SAE J1939
> > >>> [*]     debug SAE J1939
> > >>> CAN Device Drivers  --->
> > >>>
> > >>> Exit menuconfig and save the config
> > >>>
> > >>> Build Kernel Image, Modules and Devicetreeoverlays
> > >>>
> > >>> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtb
> > >>>
> > >>>   ......
> > >>>   CC [M]  net/bridge/br_netfilter_hooks.o
> > >>>   CC [M]  net/bridge/br_netfilter_ipv6.o
> > >>>   LD [M]  net/bridge/br_netfilter.o
> > >>>   LD      net/can/built-in.o
> > >>>   CC [M]  net/can/af_can.o
> > >>>   CC [M]  net/can/proc.o
> > >>>   LD [M]  net/can/can.o
> > >>>   CC [M]  net/can/raw.o
> > >>>   LD [M]  net/can/can-raw.o
> > >>>   CC [M]  net/can/bcm.o
> > >>>   LD [M]  net/can/can-bcm.o
> > >>>   CC [M]  net/can/gw.o
> > >>>   LD [M]  net/can/can-gw.o
> > >>>   LD      net/can/j1939/built-in.o
> > >>>   CC [M]  net/can/j1939/address-claim.o
> > >>>   CC [M]  net/can/j1939/bus.o
> > >>>   CC [M]  net/can/j1939/main.o
> > >>> net/can/j1939/main.c: In function ‘j1939_netdev_start’:
> > >>> net/can/j1939/main.c:238:10: error: too few arguments to function
> > >>> ‘can_rx_register’
> > >>>           j1939_can_recv, priv, "j1939");
> > >>>           ^
> > >>> In file included from net/can/j1939/main.c:25:0:
> > >>> ./include/linux/can/core.h:57:5: note: declared here
> > >>>  int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
> > >>>      ^
> > >>> scripts/Makefile.build:293: recipe for target 'net/can/j1939/main.o' failed
> > >>
> > >> This is a code problem, not a git problem.
> > >> Between 4.7 & 4.9, can_rx_register may have changed prototype.
> > >> You didn't do anything wrong.
> > >> I'll have to prepare a 4.9 branch with a small fix ...
> > >>
> > >>> make[3]: *** [net/can/j1939/main.o] Error 1
> > >>> scripts/Makefile.build:544: recipe for target 'net/can/j1939' failed
> > >>> make[2]: *** [net/can/j1939] Error 2
> > >>> scripts/Makefile.build:544: recipe for target 'net/can' failed
> > >>> make[1]: *** [net/can] Error 2
> > >>> Makefile:988: recipe for target 'net' failed
> > >>> make: *** [net] Error 2
> > >>> user@jessie:/usr/src/linux$
> > >>
> > >> To continue in between, when you don't add j1939 to the kernel, are you
> > >> able to boot you own kernel? You can grab the version with 'uname -a'.
> > >>
> > >> Kurt
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

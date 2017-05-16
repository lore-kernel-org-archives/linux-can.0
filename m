From: Paul Bongaerts <pauluzs@gmail.com>
Subject: Re: J1939 kernel for Raspberry Pi
Date: Tue, 16 May 2017 19:22:54 +0200
Message-ID: <CAGJdXcH3qsaDRjfwiOadpO794z8fuaNyiGCowmLA_TVGc5xxTw@mail.gmail.com>
References: <CAGJdXcFRUB=xLSdFkwadTkdd=OAvgkGgrOYRAxy0RkjpHGoCDQ@mail.gmail.com>
 <20170511192936.GB15112@airbook.vandijck-laurijssen.be> <CAGJdXcGg_8+cxi3Zn-iRgEci8TsCjrSs1q4pq4GscyQ+vBynVg@mail.gmail.com>
 <CAGJdXcEP4ry-LDE5ZtM+00mBgQM3gB1M5rETTXJ2rdHNnw=Wfw@mail.gmail.com>
 <20170515071420.GA2533@airbook.vandijck-laurijssen.be> <CAGJdXcHk2qJxMnxjPTCVTFFSr-mdorGS+gzn8qVW-o+dX1vt3Q@mail.gmail.com>
 <CAGJdXcFPye1VUwaSkDLKNf_apXud3Qnj_wYXv1PzsypbmvCdXQ@mail.gmail.com>
 <20170515124359.GA10149@airbook.vandijck-laurijssen.be> <20170516130217.GA1126@airbook.vandijck-laurijssen.be>
 <20170516131342.GB1126@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36861 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdEPRWz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 16 May 2017 13:22:55 -0400
Received: by mail-yw0-f195.google.com with SMTP id h82so6365135ywb.3
        for <linux-can@vger.kernel.org>; Tue, 16 May 2017 10:22:55 -0700 (PDT)
In-Reply-To: <20170516131342.GB1126@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Bongaerts <pauluzs@gmail.com>, linux-can@vger.kernel.org

Kurt,

Compiled with just a warning:
Tested and works (j1939-v4.9.10 with rpi-4.9.y)
Need to do some cleanup on the howto and will post it then

  CC [M]  net/can/j1939/socket.o
  CC [M]  net/can/j1939/transport.o
net/can/j1939/transport.c: In function =E2=80=98j1939xtp_rx_abort=E2=80=99:
net/can/j1939/transport.c:616:27: warning: unused variable =E2=80=98cb=E2=
=80=99
[-Wunused-variable]
  struct j1939_sk_buff_cb *cb =3D (void *)skb->cb;
                           ^
  LD [M]  net/can/j1939/can-j1939.o
  CC      net/core/sock.o


David

Indeed i want to be able to receive and in the future send J1939 and
ISO11783 message's

Patrick

Nope, i build just for one kernel, this is working now

2017-05-16 15:13 GMT+02:00 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>=
:
> Paul,
>
> I did find the particular commit in v4.10 and up, so
> I created branch j1939d-v4.9.10.
>
> You can use it for your v4.9 kernel.
> I haven't tested it really, since nothing really changed.
>
> Kind regards,
> Kurt
>
> --- Original message ---
>> Date:   Tue, 16 May 2017 15:02:17 +0200
>> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> To: linux-can@vger.kernel.org
>> Cc: Paul Bongaerts <pauluzs@gmail.com>
>> Subject: Re: J1939 kernel for Raspberry Pi
>> User-Agent: Mutt/1.5.22 (2013-10-16)
>>
>> Hey all,
>>
>> I was looking into this change in can_rx_register.
>> I stumbled upon commit
>>
>> adf86d59bb9b08d9eb67054251d29484c5ec102c can: Fix kernel panic at securi=
ty_sock_rcv_skb
>>
>> This is the 1st reason that Paul didn't succeed in compiling the RPI ker=
nel.
>> I'm just asking myself: is this a temporary hack, will it stay, what
>> will I do with it?
>>
>> @Paul, in the meantime, you could add ", NULL" in the call to
>> can_rx_register (on net/can/j1939/main.c:238) to compile the kernel.
>> I'm not sure if this is a good thing in the long run?
>>
>> Kind regards,
>> Kurt
>>
>> --- Original message ---
>> > Date:   Mon, 15 May 2017 14:43:59 +0200
>> > From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> > To: Paul Bongaerts <pauluzs@gmail.com>
>> > Cc: linux-can@vger.kernel.org
>> > Subject: Re: J1939 kernel for Raspberry Pi
>> > User-Agent: Mutt/1.5.22 (2013-10-16)
>> >
>> > >
>> > > ment
>> > > Like:
>> > > git remote add -b j1939d-v4.7 j1939 git://github.com/kurt-vd/linux
>> > > or
>> > > git remote add  j1939 git://github.com/kurt-vd/linux/tree/j1939d-v4.=
7
>> > > instead
>> > > git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux
>> > >
>> >
>> > I believe you should then
>> >
>> >     git clone -b rpi-4.7.y --single-branch git://github.com/raspberryp=
i/linux
>> >     git remote add -t j1939d-v4.7 j1939 git://github.com/kurt-vd/linux
>> >
>> > This would be ok wrt. retaining history.
>> >
>> > > 2017-05-15 12:50 GMT+02:00 Paul Bongaerts <pauluzs@gmail.com>:
>> > > > Hi,
>> > > >
>> > > > I'll wait for your 4.9 fix.
>> >
>> > today or tomorrow :-)
>> >
>> > > >
>> > > > My own kernel is 4.9.24. only without the J1939
>> > > > That's what the question about branching was about.
>> > > >
>> > > > Is it possible to use the 4.7 branch?
>> >
>> > yes.
>> >
>> > Can you make sure that the newly compiled kernel boots, before adding
>> > j1939? One step at a time :-)
>> >
>> > Kurt
>> >
>> > > > Like :
>> > > > git clone git://github.com/raspberrypi/linux/tree/rpi-4.7.y
>> > > > Or:
>> > > > git clone -b rpi-4.7.y git://github.com/raspberrypi/linux
>> > > >
>> > > > Instead of :
>> > > > git clone git://github.com/raspberrypi/linux.git
>> > > >
>> > > > Or does this mess up the history as well?
>> > > >
>> > > > Same goes for adding your remote
>> > > > would just the 4.7 branch be enough?
>> > > > Like:
>> > > > git clone -b j1939d-v4.7 git://github.com/kurt-vd/linux
>> > > > Or does this mess up the history as well?
>> > > >
>> > > > 2017-05-15 9:14 GMT+02:00 Kurt Van Dijck <dev.kurt@vandijck-laurij=
ssen.be>:
>> > > >> Hey,
>> > > >>
>> > > >> I was just looking your previous email, but I see here below that=
 you
>> > > >> all got it right.
>> > > >>>
>> > > >>> Still getting a error when trying to cross compile
>> > > >>>
>> > > >>>
>> > > >>>
>> > > >>> Go into src dir
>> > > >>>
>> > > >>> cd /usr/src
>> > > >>>
>> > > >>> Get crosscompile Toolchain
>> > > >>>
>> > > >>> git clone git://github.com/raspberrypi/tools.git
>> > > >>>
>> > > >>> Next get raspberry sources
>> > > >>>
>> > > >>> git clone git://github.com/raspberrypi/linux.git
>> > > >>>
>> > > >>> Go into linux dir
>> > > >>>
>> > > >>> cd /usr/src/linux
>> > > >>>
>> > > >>> Remote add the j1939 sources
>> > > >>>
>> > > >>> git remote add j1939 git://github.com/kurt-vd/linux
>> > > >>>
>> > > >>> Update j1939 remote
>> > > >>>
>> > > >>> git remote update j1939
>> > > >>>
>> > > >>> Merge j1939-v4.7 with rpi-master
>> > > >>>
>> > > >>>     git merge j1939/j1939d-v4.7
>> > > >>>     (Rpi jessie image uses uname -r 4.9.24+  so 4.7 is closest l=
ower
>> > > >>> J1939 version)
>> > > >>>
>> > > >>> export crosscompile toolchain path
>> > > >>>
>> > > >>> To build on 32 bit system
>> > > >>> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-li=
nux-gnueabihf-raspbian/bin
>> > > >>> To build on 64 bits system
>> > > >>> export PATH=3D$PATH:/usr/src/tools/arm-bcm2708/gcc-linaro-arm-li=
nux-gnueabihf-raspbian-x64/bin
>> > > >>>
>> > > >>> Clean the kernel source
>> > > >>>
>> > > >>> make mrproper
>> > > >>>
>> > > >>> Set kernel type
>> > > >>>
>> > > >>> For Rapberry Pi 1/compute/zero (w)
>> > > >>> KERNEL=3Dkernel
>> > > >>> For Raspberry Pi 2/3
>> > > >>> KERNEL=3Dkernel7
>> > > >>>
>> > > >>> Use default config
>> > > >>>
>> > > >>> For Rapberry Pi 1/compute/zero(w)
>> > > >>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcmrpi_defc=
onfig
>> > > >>> For Raspberry Pi 2/3
>> > > >>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- bcm2709_def=
config
>> > > >>>
>> > > >>> Enable j1939 can kernel modeles
>> > > >>>
>> > > >>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- menuconfig
>> > > >>>
>> > > >>> Go into Networking Support Select SAE J1939 as module, enable de=
bug.
>> > > >>> Go into CAN Device Drivers and select your device drivers
>> > > >>>
>> > > >>> <M>   CAN bus subsystem support  --->
>> > > >>> --- CAN bus subsystem support
>> > > >>> <M>   Raw CAN Protocol (raw access with CAN-ID filtering)
>> > > >>> <M>   Broadcast Manager CAN Protocol (with content filtering)
>> > > >>> <M>   CAN Gateway/Router (with netlink configuration)
>> > > >>> <M>   SAE J1939
>> > > >>> [*]     debug SAE J1939
>> > > >>> CAN Device Drivers  --->
>> > > >>>
>> > > >>> Exit menuconfig and save the config
>> > > >>>
>> > > >>> Build Kernel Image, Modules and Devicetreeoverlays
>> > > >>>
>> > > >>> make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- zImage modu=
les dtb
>> > > >>>
>> > > >>>   ......
>> > > >>>   CC [M]  net/bridge/br_netfilter_hooks.o
>> > > >>>   CC [M]  net/bridge/br_netfilter_ipv6.o
>> > > >>>   LD [M]  net/bridge/br_netfilter.o
>> > > >>>   LD      net/can/built-in.o
>> > > >>>   CC [M]  net/can/af_can.o
>> > > >>>   CC [M]  net/can/proc.o
>> > > >>>   LD [M]  net/can/can.o
>> > > >>>   CC [M]  net/can/raw.o
>> > > >>>   LD [M]  net/can/can-raw.o
>> > > >>>   CC [M]  net/can/bcm.o
>> > > >>>   LD [M]  net/can/can-bcm.o
>> > > >>>   CC [M]  net/can/gw.o
>> > > >>>   LD [M]  net/can/can-gw.o
>> > > >>>   LD      net/can/j1939/built-in.o
>> > > >>>   CC [M]  net/can/j1939/address-claim.o
>> > > >>>   CC [M]  net/can/j1939/bus.o
>> > > >>>   CC [M]  net/can/j1939/main.o
>> > > >>> net/can/j1939/main.c: In function =E2=80=98j1939_netdev_start=E2=
=80=99:
>> > > >>> net/can/j1939/main.c:238:10: error: too few arguments to functio=
n
>> > > >>> =E2=80=98can_rx_register=E2=80=99
>> > > >>>           j1939_can_recv, priv, "j1939");
>> > > >>>           ^
>> > > >>> In file included from net/can/j1939/main.c:25:0:
>> > > >>> ./include/linux/can/core.h:57:5: note: declared here
>> > > >>>  int can_rx_register(struct net_device *dev, canid_t can_id, can=
id_t mask,
>> > > >>>      ^
>> > > >>> scripts/Makefile.build:293: recipe for target 'net/can/j1939/mai=
n.o' failed
>> > > >>
>> > > >> This is a code problem, not a git problem.
>> > > >> Between 4.7 & 4.9, can_rx_register may have changed prototype.
>> > > >> You didn't do anything wrong.
>> > > >> I'll have to prepare a 4.9 branch with a small fix ...
>> > > >>
>> > > >>> make[3]: *** [net/can/j1939/main.o] Error 1
>> > > >>> scripts/Makefile.build:544: recipe for target 'net/can/j1939' fa=
iled
>> > > >>> make[2]: *** [net/can/j1939] Error 2
>> > > >>> scripts/Makefile.build:544: recipe for target 'net/can' failed
>> > > >>> make[1]: *** [net/can] Error 2
>> > > >>> Makefile:988: recipe for target 'net' failed
>> > > >>> make: *** [net] Error 2
>> > > >>> user@jessie:/usr/src/linux$
>> > > >>
>> > > >> To continue in between, when you don't add j1939 to the kernel, a=
re you
>> > > >> able to boot you own kernel? You can grab the version with 'uname=
 -a'.
>> > > >>
>> > > >> Kurt
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-can" i=
n
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

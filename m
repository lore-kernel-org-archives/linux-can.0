From: Mirza Krak <mirza.krak@gmail.com>
Subject: Re: AW: AW: CAN Interface on Toradex Board
Date: Fri, 25 Oct 2013 00:50:58 +0200
Message-ID: <5269A452.5060306@gmail.com>
References: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de> <526805E9.1060702@hartkopp.net> <F1A135976112904197F6276B89309FEF2603E1@sgexc1.bfft.de> <35798e892fe0606d15b87c9b366199dc@grandegger.com> <F1A135976112904197F6276B89309FEF26040B@sgexc1.bfft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:52000 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3JXWvC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Oct 2013 18:51:02 -0400
Received: by mail-wg0-f54.google.com with SMTP id c11so2973399wgh.21
        for <linux-can@vger.kernel.org>; Thu, 24 Oct 2013 15:51:00 -0700 (PDT)
In-Reply-To: <F1A135976112904197F6276B89309FEF26040B@sgexc1.bfft.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Spies, Raphael | BFFT GmbH" <raphael.spies@bfft.de>, 'Wolfgang Grandegger' <wg@grandegger.com>
Cc: "'linux-can@vger.kernel.org'" <linux-can@vger.kernel.org>

Hi.

I am also an user of Tegra 2 module from toradex and I haven't had any=20
similar issues. Which eval board are you running? Have you tried the=20
canconfig tool? Have you tried building iproute2 with the bitbake, this=
=20
is what I have used without any issues. Don't know the state of the=20
packages available for download.

And also why don't ask toradex support for this?

mvh
Mirza

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
www.hostmobility.com <http://www.hostmobility.com>
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************


On 2013-10-24 09:39, Spies, Raphael | BFFT GmbH wrote:
>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] Im Auftrag von Wolfgang Grandegger
>> Gesendet: Donnerstag, 24. Oktober 2013 09:28
>> An: Spies, Raphael | BFFT GmbH
>> Cc: Oliver Hartkopp; linux-can@vger.kernel.org
>> Betreff: Re: AW: CAN Interface on Toradex Board
>>
>> On Thu, 24 Oct 2013 06:44:30 +0000, "Spies, Raphael | BFFT GmbH"
>>
>> <raphael.spies@bfft.de> wrote:
>>
>>> Hello everyone,
>>
>>>
>>
>>> thanks for the help so far..
>>
>>>
>>
>>>
>>
>>>> 	Can you see the can0 interface itself?
>>
>>>
>>
>>> Yes, I Can see the can interface. IP Link shows:
>>
>>>
>>
>>> 2: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT
>> qlen
>>> 10
>>
>>>      link/can
>>
>>>      can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>>
>>>      bitrate 0 sample-point 0.000
>>
>>>      tq 0 prop-seg 0 phase-seg1 0 phase-seg2 0 sjw 0
>>
>>>      sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>>
>>>      clock 12000000
>>
>>>
>>
>>>> 	when invoking 'dmesg' ?
>>
>>>
>>
>>> [    2.067414] CAN device driver interface
>>
>>> [    2.079435] sja1000 CAN netdevice driver
>>
>>> [    2.092644] sja1000_platform sja1000_platform.0: sja1000_platfor=
m
>>
>>> device registered (reg_base=3Dc9800000, irq=3D192)
>>
>>> ...
>>
>>> [    5.051783] can: controller area network core (rev 20090105 abi =
8)
>>
>>> [    5.063383] NET: Registered protocol family 29
>>
>>> [    5.072990] can: raw protocol (rev 20090105)
>>
>>> [    5.082193] can: broadcast manager protocol (rev 20090105 t)
>>
>>>
>>
>>>
>>
>>>> 	This looks like the installed iproute2 package is broken.
>>
>>>
>>
>>> I downloaded them from the given link in the documentation:
>>
>>>
>>
>> http://developer.toradex.com/files/toradex-
>> dev/uploads/media/Colibri/Linux/Extra/can-packages.tar.bz2
>>
>>> on the distribution in the image V2 of Toradex there is due to the
>>
>>> hardfloat architecture no working package manager, so I have to
>>> install
>>
>>> them manually
>>
>>>
>>
>>>
>>
>>>> 	 ls -l `which ip`
>>
>>>> 	 to check if 'ip' is linked to the busybox binary.
>>
>>>
>>
>>> "Which ip" gives "/bin/ip" and is in my opinion linked to iproute2
>>
>>
>>
>> What does "ip link help" list?
>
> sh-4.2# ip link help
> Usage: ip link add [link DEV] [ name ] NAME
>                     [ txqueuelen PACKETS ]
>                     [ address LLADDR ]
>                     [ broadcast LLADDR ]
>                     [ mtu MTU ]
>                     type TYPE [ ARGS ]
>         ip link delete DEV type TYPE [ ARGS ]
>
>         ip link set { dev DEVICE | group DEVGROUP } [ { up | down } ]
> 	                  [ arp { on | off } ]
> 	                  [ dynamic { on | off } ]
> 	                  [ multicast { on | off } ]
> 	                  [ allmulticast { on | off } ]
> 	                  [ promisc { on | off } ]
> 	                  [ trailers { on | off } ]
> 	                  [ txqueuelen PACKETS ]
> 	                  [ name NEWNAME ]
> 	                  [ address LLADDR ]
> 	                  [ broadcast LLADDR ]
> 	                  [ mtu MTU ]
> 	                  [ netns PID ]
> 	                  [ netns NAME ]
> 			  [ alias NAME ]
> 	                  [ vf NUM [ mac LLADDR ]
> 				   [ vlan VLANID [ qos VLAN-QOS ] ]
> 				   [ rate TXRATE ] ]
> 				   [ spoofchk { on | off} ] ]
> 			  [ master DEVICE ]
> 			  [ nomaster ]
>         ip link show [ DEVICE | group GROUP ]
>
> TYPE :=3D { vlan | veth | vcan | dummy | ifb | macvlan | can | bridge=
 }
>
>
> Raphael
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
q=EF=BF=BD=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=
=BF=BD=1A=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=
=BD=EF=BF=BD=1E=EF=BF=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=03(=EF=BF=
=BD=E9=9A=8E=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=1Bm=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=
=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BD=
mml=3D=3D
>

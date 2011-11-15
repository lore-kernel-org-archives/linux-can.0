From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Using sja1000_isa on a 64b system
Date: Tue, 15 Nov 2011 09:06:45 +0100
Message-ID: <4EC21D95.5070508@grandegger.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>	<4E64B6CB.8010505@grandegger.com>	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>	<4E653775.4030503@grandegger.com>	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>	<4EBB8CFD.3050602@grandegger.com>	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>	<4EBEE043.6070601@grandegger.com>	<4EBEE1D8.7040407@grandegger.com>	<CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>	<CAKvQZ_3anOf1SbE5TK6gvJf4v3gw1MBae0hw5JGr__szt7KoQQ@mail.gmail.com>	<4EC01B12.5050404@grandegger.com>	<4EC0E4BE.4010101@grandegger.com
 >	<CAKvQZ_2GkTqFrp-9quut0f33KL9tdD9NSTZ3btDHLZNP=a2VwQ@mail.gmail.com>	<4EC13191.6070901@grandegger.com> <CAKvQZ_24-FqBHcyZAtf+kR26TaU-Uhji50Q6uQUvOiM=txPCiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59766 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab1KOIGs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Nov 2011 03:06:48 -0500
In-Reply-To: <CAKvQZ_24-FqBHcyZAtf+kR26TaU-Uhji50Q6uQUvOiM=txPCiQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, linux-can@vger.kernel.org

On 11/14/2011 04:57 PM, Willy Lambert wrote:
> 2011/11/14 Wolfgang Grandegger <wg@grandegger.com>:
>> On 11/14/2011 03:51 PM, Willy Lambert wrote:
>>> 2011/11/14 Wolfgang Grandegger <wg@grandegger.com>:
>>>> On 11/13/2011 08:31 PM, Wolfgang Grandegger wrote:
>>>>> On 11/13/2011 10:15 AM, Willy Lambert wrote:
>>>>>> 2011/11/13 Willy Lambert <lambert.willy@gmail.com>:
>>>>>>> 2011/11/12 Wolfgang Grandegger <wg@grandegger.com>:
>>>>>>>> On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
>>>>>>>>> On 11/12/2011 10:55 AM, Willy Lambert wrote:
>>>>>>>> ...
>>>>>>>>>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
>>>>>>>>>
>>>>>>>>> No, it's for up-to-date *mainline* linux version 3.1.x. Any c=
hance to
>>>>>>>>> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm g=
oing to
>>>>>>>>> adapt the patch to 2.6.38.8.
>>>>>>>>
>>>>>>>> Well, the patch also applies to 2.6.38.8. Maybe you have some =
problems
>>>>>>>> extracting the patch. Therefore I have attached it as attachme=
nt this
>>>>>>>> time. Good luck.
>>>>>>>
>>>>>>> It's ok now :
>>>>>>> ard@ard-host:~/src/linux-2.6.38.8$ patch -p1 < wg_platform.patc=
h
>>>>>>> patching file drivers/net/can/sja1000/Kconfig
>>>>>>> patching file drivers/net/can/sja1000/sja1000_isa.c
>>>>>>>
>>>>>>> I must have done something wrong. I am going to test it now
>>>>>>>
>>>>>>
>>>>>> arg, it doesn't compile I had a look a sources but I don't see t=
he error :
>>>>>>
>>>>>>   CC [M]  drivers/xenomai/can/rtcan_raw_dev.o
>>>>>> drivers/net/can/sja1000/sja1000_isa.c: In function =91sja1000_is=
a_init=92:
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:297: error: invalid storag=
e
>>>>>> class for function =91sja1000_isa_exit=92
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:296: warning: ISO C90 forb=
ids
>>>>>> mixed declarations and code
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:307: error: invalid storag=
e
>>>>>> class for function =91__inittest=92
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:307: warning: =91alias=92 =
attribute ignored
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: invalid storag=
e
>>>>>> class for function =91__exittest=92
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: ISO C90 forb=
ids
>>>>>> mixed declarations and code
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: =91alias=92 =
attribute ignored
>>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: expected decla=
ration
>>>>>> or statement at end of input
>>>>>> make[5]: *** [drivers/net/can/sja1000/sja1000_isa.o] Error 1
>>>>>
>>>>> Argh, a "}" is missing, sorry. I will test the patch more careful=
ly
>>>>> before re-sending.
>>>>
>>>> See attachment.
>>>
>>> Thanks, the compilation is now ok, but when I load them on my targe=
t I
>>> have this in dmesg :
>>> CAN device driver interface
>>> sja1000 CAN netdevice driver
>>> sja1000_isa: insufficient parameters supplied
>>>
>>> The loading command is :
>>> modprobe sja1000_isa irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0=
x5e cdr=3D0,0
>>> And I am sure it is the same than before, so I think there is a
>>> problem when you read the parameters
>>
>> Again, my fault., sorry
>=20
> Don't be sorry, it is dev aleas and I am glad to have your time for
> this feature :)
>=20
>> Could you please retry with the attached patch.
>=20
> It seems to work :
> CAN device driver interface
> sja1000 CAN netdevice driver
> sja1000_isa sja1000_isa.0: sja1000_isa device registered
> (reg_base=3D0xc00d0000, irq=3D10)
> sja1000_isa sja1000_isa.1: sja1000_isa device registered
> (reg_base=3D0xc00d0200, irq=3D10)
> Legacy sja1000_isa driver for max. 8 devices registered
> sja1000_isa sja1000_isa.0: setting BTR0=3D0x00 BTR1=3D0x14
> sja1000_isa sja1000_isa.1: setting BTR0=3D0x00 BTR1=3D0x14
>=20
>=20
> I did :
> cansend can1 000#81.00
> cansend can1 000#01.00
>=20
> My device "Operationnal" Led switch state and candump tells :
>  (1321289653.149877)  can1    0  [2] 81 00                     '..'
>  (1321289653.177209)  can1  705  [1] 00                        '.'
>  (1321289653.177267)  can1  706  [1] 00                        '.'
>  (1321289660.349837)  can1    0  [2] 01 00                     '..'
>  (1321289660.350785)  can1  186  [2] 00 00                     '..'
>  (1321289660.350846)  can1  185  [2] 02 00                     '..'
>=20
>=20
> Do you wish any further tests ?

Does the following command work as well?

 modprobe sja1000_isa irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e cdr=3D=
0

Does re-loading of the driver work properly?

 rmmod sja1000_isa; insmod sja1000_isa ...

Similar tests on a x86_64 system and with a recent kernel version would
be nice to have.

Thanks,

Wolfgang.


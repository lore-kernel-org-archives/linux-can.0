From: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Mon, 14 Nov 2011 16:57:25 +0100
Message-ID: <CAKvQZ_24-FqBHcyZAtf+kR26TaU-Uhji50Q6uQUvOiM=txPCiQ@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
	<CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
	<4EBB8CFD.3050602@grandegger.com>
	<CAKvQZ_3d=2-0+RrxkjCe7Nxvtgn42uYOS4f4B7_6TmaxEji7UQ@mail.gmail.com>
	<CAKvQZ_0Ymdy1f6oUPHVxqEVp42z+OcfygQL1z_FR1aQ5Cwwmbw@mail.gmail.com>
	<4EBEE043.6070601@grandegger.com> <4EBEE1D8.7040407@grandegger.com>
	<CAKvQZ_1QmJAPUZAEvV-2FSo2HR4byApoEqWPnOts9up90U4BVg@mail.gmail.com>
	<CAKvQZ_3anOf1SbE5TK6gvJf4v3gw1MBae0hw5JGr__szt7KoQQ@mail.gmail.com>
	<4EC01B12.5050404@grandegger.com> <4EC0E4BE.4010101@grandegger.com>
	<CAKvQZ_2GkTqFrp-9quut0f33KL9tdD9NSTZ3btDHLZNP=a2VwQ@mail.gmail.com>
	<4EC13191.6070901@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4EC13191.6070901-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

2011/11/14 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
> On 11/14/2011 03:51 PM, Willy Lambert wrote:
>> 2011/11/14 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>>> On 11/13/2011 08:31 PM, Wolfgang Grandegger wrote:
>>>> On 11/13/2011 10:15 AM, Willy Lambert wrote:
>>>>> 2011/11/13 Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>>>>> 2011/11/12 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>:
>>>>>>> On 11/12/2011 10:08 PM, Wolfgang Grandegger wrote:
>>>>>>>> On 11/12/2011 10:55 AM, Willy Lambert wrote:
>>>>>>> ...
>>>>>>>>>> I failed to apply the patch, is it for 2.6.38.8 kernels ?
>>>>>>>>
>>>>>>>> No, it's for up-to-date *mainline* linux version 3.1.x. Any chance=
 to
>>>>>>>> switch to David Miller's "net-nex-2.6" tree?. Otherwise I'm going =
to
>>>>>>>> adapt the patch to 2.6.38.8.
>>>>>>>
>>>>>>> Well, the patch also applies to 2.6.38.8. Maybe you have some probl=
ems
>>>>>>> extracting the patch. Therefore I have attached it as attachment th=
is
>>>>>>> time. Good luck.
>>>>>>
>>>>>> It's ok now :
>>>>>> ard@ard-host:~/src/linux-2.6.38.8$ patch -p1 < wg_platform.patch
>>>>>> patching file drivers/net/can/sja1000/Kconfig
>>>>>> patching file drivers/net/can/sja1000/sja1000_isa.c
>>>>>>
>>>>>> I must have done something wrong. I am going to test it now
>>>>>>
>>>>>
>>>>> arg, it doesn't compile I had a look a sources but I don't see the er=
ror :
>>>>>
>>>>> =A0 CC [M] =A0drivers/xenomai/can/rtcan_raw_dev.o
>>>>> drivers/net/can/sja1000/sja1000_isa.c: In function =91sja1000_isa_ini=
t=92:
>>>>> drivers/net/can/sja1000/sja1000_isa.c:297: error: invalid storage
>>>>> class for function =91sja1000_isa_exit=92
>>>>> drivers/net/can/sja1000/sja1000_isa.c:296: warning: ISO C90 forbids
>>>>> mixed declarations and code
>>>>> drivers/net/can/sja1000/sja1000_isa.c:307: error: invalid storage
>>>>> class for function =91__inittest=92
>>>>> drivers/net/can/sja1000/sja1000_isa.c:307: warning: =91alias=92 attri=
bute ignored
>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: invalid storage
>>>>> class for function =91__exittest=92
>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: ISO C90 forbids
>>>>> mixed declarations and code
>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: warning: =91alias=92 attri=
bute ignored
>>>>> drivers/net/can/sja1000/sja1000_isa.c:308: error: expected declaration
>>>>> or statement at end of input
>>>>> make[5]: *** [drivers/net/can/sja1000/sja1000_isa.o] Error 1
>>>>
>>>> Argh, a "}" is missing, sorry. I will test the patch more carefully
>>>> before re-sending.
>>>
>>> See attachment.
>>
>> Thanks, the compilation is now ok, but when I load them on my target I
>> have this in dmesg :
>> CAN device driver interface
>> sja1000 CAN netdevice driver
>> sja1000_isa: insufficient parameters supplied
>>
>> The loading command is :
>> modprobe sja1000_isa irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e c=
dr=3D0,0
>> And I am sure it is the same than before, so I think there is a
>> problem when you read the parameters
>
> Again, my fault., sorry

Don't be sorry, it is dev aleas and I am glad to have your time for
this feature :)

> Could you please retry with the attached patch.

It seems to work :
CAN device driver interface
sja1000 CAN netdevice driver
sja1000_isa sja1000_isa.0: sja1000_isa device registered
(reg_base=3D0xc00d0000, irq=3D10)
sja1000_isa sja1000_isa.1: sja1000_isa device registered
(reg_base=3D0xc00d0200, irq=3D10)
Legacy sja1000_isa driver for max. 8 devices registered
sja1000_isa sja1000_isa.0: setting BTR0=3D0x00 BTR1=3D0x14
sja1000_isa sja1000_isa.1: setting BTR0=3D0x00 BTR1=3D0x14


I did :
cansend can1 000#81.00
cansend can1 000#01.00

My device "Operationnal" Led switch state and candump tells :
 (1321289653.149877)  can1    0  [2] 81 00                     '..'
 (1321289653.177209)  can1  705  [1] 00                        '.'
 (1321289653.177267)  can1  706  [1] 00                        '.'
 (1321289660.349837)  can1    0  [2] 01 00                     '..'
 (1321289660.350785)  can1  186  [2] 00 00                     '..'
 (1321289660.350846)  can1  185  [2] 02 00                     '..'


Do you wish any further tests ?


> Could you please also enable CAN device debugging
> (CONFIG_CAN_DEBUG_DEVICES=3Dy).
>
> Thanks,
>
> Wolfgang.
>

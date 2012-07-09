From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 10:20:54 +0200
Message-ID: <4FFA9466.3040600@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com> <4FF8102C.8030609@grandegger.com> <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com> <4FF9E9E4.4090602@grandegger.com> <CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com> <4FFA85B3.5080800@grandegger.com> <CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38085 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab2GIIU6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 04:20:58 -0400
In-Reply-To: <CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 07/09/2012 10:14 AM, Mohamed HAMZAOUI wrote:
> I cannot use the 2.6.33 kernel version because it's not support my
> board and, until this moment only, the kernel version 2.6.32*  can be
> found for my board for which i can not find any adeos patch or
> preempt-rt patch

I was thinking about Linux > 3.4. Anyway, I understand your problem.
Xenomai will not help without extra effort because there is no RT-CAN
driver for the TI HECC. What are your real-time requirements?

> I will test the patch for ti_hecc.c and i will return for you.
> * (TI provide a 2.6.37 kernel version but with problem Kernel PANIC !=
)

:(

Wolfgang.

> On Mon, Jul 9, 2012 at 9:18 AM, Wolfgang Grandegger <wg@grandegger.co=
m> wrote:
>> On 07/08/2012 10:30 PM, Mohamed HAMZAOUI wrote:
>>> The other transeiver is a KVASER USBCan II (HS,HS) it's an usb gate=
way
>>> CAN and it's accurate because i use it with other CAN transeiver
>>> (IXXAT PCI or Vector CanboardXL) and i have always the same result.
>>
>> Well, I would not use a USB CAN controller for accurate timing (if i=
t
>> does not use hardware time stamps). Anyway, I think that's not the
>> problem, as Kurt already pointed out.
>>
>>> My board is Craneboard "AM3517-crane" and i compiled my system with
>>> OpenEmbedded which done : (cat /proc/version) Linux version 2.6.32
>>> (requinham@pearl) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) =
#1
>>> PREEMPT Fri Jul 6 21:46:07 CEST 2012
>>
>> OK, then you use the ti_hecc driver, which hit mainline in 2.6.33! C=
ould
>> you show as the source of your "drivers/net/can/ti_hecc.c"? There is=
 at
>> least one issue in the early driver version, which makes sense to fi=
x:
>>
>> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dc=
ommit;h=3De3f240f460a36b158217944b52a85f304914c1a6
>>
>> If that doesn't help, you should use ftrace to understand what's goi=
ng
>> on. Well, not sure if ftrace already works with 2.6.32 on ARM... tha=
t
>> would be another good reason to update to a more recent version of t=
he
>> kernel. Would that be an option for you?
>>
>> Wolfgang.
>>
>>> On Sun, Jul 8, 2012 at 10:13 PM, Wolfgang Grandegger <wg@grandegger=
=2Ecom> wrote:
>>>> On 07/08/2012 09:43 PM, Mohamed HAMZAOUI wrote:
>>>>> Hi,
>>>>>
>>>>>> This problem is not CAN related. Anyway, you can read/try/check:
>>>>>>
>>>>>> - are high-resolution timers enabled in your kernel?
>>>>>
>>>>> My high resolution timers is enabled in Kernel and i activate
>>>>> Preemptible kernel (low latency desktop)
>>>>>
>>>>>> - use cyclictest [1] to measure user-space timing accuracy.
>>>>>
>>>>> the cyclictest mesure with 0% load is 307 in maximum
>>>>
>>>> You mean 302 us? Did you generate some load? That normally makes a=
 big
>>>> difference.
>>>>
>>>>>
>>>>>> - use clock_nanosleep for periodic tasks.
>>>>>
>>>>> i use clock_nanosleep with (1000000 ns =3D 1ms) and the result me=
sured
>>>>> with another CAN transeiver is an average of 1.30 ms (delta =3D 3=
00 =E7=9B=9C)
>>>>> !
>>>>
>>>> That means that you see a period of 1.3ms instead of 1ms? That's r=
eally
>>>> strange. I assume that the timing on the system with the other CAN
>>>> transceiver is accurate.
>>>>
>>>>>> - try to start cangen with "chrt -f 10 cangen can0".
>>>>>
>>>>> no effect.
>>>>>
>>>>>> - read "man sched_setscheduler" for a description of the Linux
>>>>>>   scheduling scheme.
>>>>>
>>>>> I test with two type of SCHED : RR and FIFO but the result is sam=
e
>>>>>
>>>>> Maybe i need to pass to Xenomai or PREEMPT-RT ?
>>>>
>>>> What system, kernel and CAN controller do you use? Is it an MCP25x=
x?
>>>>
>>>> Wolfgang.
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>=20
>=20



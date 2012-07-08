From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Sun, 8 Jul 2012 22:30:27 +0200
Message-ID: <CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<4FF55274.3030006@volkswagen.de>
	<CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
	<4FF8102C.8030609@grandegger.com>
	<CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
	<4FF9E9E4.4090602@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65067 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab2GHUa2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Jul 2012 16:30:28 -0400
Received: by obbuo13 with SMTP id uo13so19363509obb.19
        for <linux-can@vger.kernel.org>; Sun, 08 Jul 2012 13:30:28 -0700 (PDT)
In-Reply-To: <4FF9E9E4.4090602@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

The other transeiver is a KVASER USBCan II (HS,HS) it's an usb gateway
CAN and it's accurate because i use it with other CAN transeiver
(IXXAT PCI or Vector CanboardXL) and i have always the same result.

My board is Craneboard "AM3517-crane" and i compiled my system with
OpenEmbedded which done : (cat /proc/version) Linux version 2.6.32
(requinham@pearl) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1
PREEMPT Fri Jul 6 21:46:07 CEST 2012

My CAN Controller is the TI CAN controller provide with the
microcontroller TI Cortex A8 (cat /proc/net/can/version) rev 20090105
abi 8

Regards,
Mohamed

On Sun, Jul 8, 2012 at 10:13 PM, Wolfgang Grandegger <wg@grandegger.com=
> wrote:
> On 07/08/2012 09:43 PM, Mohamed HAMZAOUI wrote:
>> Hi,
>>
>>> This problem is not CAN related. Anyway, you can read/try/check:
>>>
>>> - are high-resolution timers enabled in your kernel?
>>
>> My high resolution timers is enabled in Kernel and i activate
>> Preemptible kernel (low latency desktop)
>>
>>> - use cyclictest [1] to measure user-space timing accuracy.
>>
>> the cyclictest mesure with 0% load is 307 in maximum
>
> You mean 302 us? Did you generate some load? That normally makes a bi=
g
> difference.
>
>>
>>> - use clock_nanosleep for periodic tasks.
>>
>> i use clock_nanosleep with (1000000 ns =3D 1ms) and the result mesur=
ed
>> with another CAN transeiver is an average of 1.30 ms (delta =3D 300 =
=E7=9B=9C)
>> !
>
> That means that you see a period of 1.3ms instead of 1ms? That's real=
ly
> strange. I assume that the timing on the system with the other CAN
> transceiver is accurate.
>
>>> - try to start cangen with "chrt -f 10 cangen can0".
>>
>> no effect.
>>
>>> - read "man sched_setscheduler" for a description of the Linux
>>>   scheduling scheme.
>>
>> I test with two type of SCHED : RR and FIFO but the result is same
>>
>> Maybe i need to pass to Xenomai or PREEMPT-RT ?
>
> What system, kernel and CAN controller do you use? Is it an MCP25xx?
>
> Wolfgang.
>

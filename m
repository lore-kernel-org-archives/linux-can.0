From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Sat, 07 Jul 2012 12:32:12 +0200
Message-ID: <4FF8102C.8030609@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33465 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2GGKcQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Jul 2012 06:32:16 -0400
In-Reply-To: <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 07/07/2012 12:02 PM, Mohamed HAMZAOUI wrote:
> Hi,
>=20
> I recompiled the Kernel with activate preemption. I test cangen and
> tst-bcm-cycle but i have the same result around accuracy. I tried to
> change the application priority with nice command to high priority bu=
t
> the problem persist  !

This problem is not CAN related. Anyway, you can read/try/check:

- are high-resolution timers enabled in your kernel?
- use cyclictest [1] to measure user-space timing accuracy.
- use clock_nanosleep for periodic tasks.
- try to start cangen with "chrt -f 10 cangen can0".
- read "man sched_setscheduler" for a description of the Linux
  scheduling scheme.

[1] https://rt.wiki.kernel.org/index.php/Cyclictest

Wolfgang.

> Le jeudi 5 juillet 2012, Oliver Hartkopp a =E9crit :
>>
>> On 05.07.2012 10:12, Mohamed HAMZAOUI wrote:
>>>
>>> Hi,
>>>
>>> i'm a new user of socketcan and, i cross compile can-utils for my c=
raneboard
>>> card (a card with CAN).
>>> When i run cangen with 1 ms period, the period is not respected (1,=
407, 1.399,
>>> ...) !
>>>
>>> How can i fix this problem ?
>>>
>>> my can version in /proc/net/can/version is "rev 20090105 abi 8" and=
 i'm on
>>> : Linux am3517-crane 2.6.32 #1 Mon Apr 23 00:13:28 CEST 2012 armv7l=
 GNU/Linux
>>>
>>
>> Hello Mohamed,
>>
>> first please move to the new CAN mailing list (see CC) - and don't u=
se HTML-mails (text-only is better) ;-)
>>
>> Regarding your problem:
>>
>> Usually i get smaller derivations on my system - but your Linux box =
is probably not very fast, so that you can see these scheduling influen=
ces with cangen ...
>>
>> cangen is a userpace app and therefore it is usually not that precis=
e as hrtimers inside the Linux kernel (if you don't use any realtime Li=
nux).
>>
>> But you may try the Broadcast-Manager to place a 'cyclic sending job=
' inside the Linux kernel. See an example here:
>>
>> http://svn.berlios.de/wsvn/socketcan/trunk/test/tst-bcm-cycle.c
>>
>> Regards,
>> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20



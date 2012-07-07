From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Sat, 7 Jul 2012 12:02:46 +0200
Message-ID: <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<4FF55274.3030006@volkswagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48859 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GGKCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Jul 2012 06:02:47 -0400
Received: by obbuo13 with SMTP id uo13so16588831obb.19
        for <linux-can@vger.kernel.org>; Sat, 07 Jul 2012 03:02:46 -0700 (PDT)
In-Reply-To: <4FF55274.3030006@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi,

I recompiled the Kernel with activate preemption. I test cangen and
tst-bcm-cycle but i have the same result around accuracy. I tried to
change the application priority with nice command to high priority but
the problem persist  !

Regards,
Mohamed

Le jeudi 5 juillet 2012, Oliver Hartkopp a =E9crit :
>
> On 05.07.2012 10:12, Mohamed HAMZAOUI wrote:
>>
>> Hi,
>>
>> i'm a new user of socketcan and, i cross compile can-utils for my cr=
aneboard
>> card (a card with CAN).
>> When i run cangen with 1 ms period, the period is not respected (1,4=
07, 1.399,
>> ...) !
>>
>> How can i fix this problem ?
>>
>> my can version in /proc/net/can/version is "rev 20090105 abi 8" and =
i'm on
>> : Linux am3517-crane 2.6.32 #1 Mon Apr 23 00:13:28 CEST 2012 armv7l =
GNU/Linux
>>
>
> Hello Mohamed,
>
> first please move to the new CAN mailing list (see CC) - and don't us=
e HTML-mails (text-only is better) ;-)
>
> Regarding your problem:
>
> Usually i get smaller derivations on my system - but your Linux box i=
s probably not very fast, so that you can see these scheduling influenc=
es with cangen ...
>
> cangen is a userpace app and therefore it is usually not that precise=
 as hrtimers inside the Linux kernel (if you don't use any realtime Lin=
ux).
>
> But you may try the Broadcast-Manager to place a 'cyclic sending job'=
 inside the Linux kernel. See an example here:
>
> http://svn.berlios.de/wsvn/socketcan/trunk/test/tst-bcm-cycle.c
>
> Regards,
> Oliver

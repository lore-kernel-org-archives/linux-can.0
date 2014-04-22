From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Tue, 22 Apr 2014 07:54:31 +0200
Message-ID: <CAGm1_kuvZx7uoGTYbwDkWh1NAHNxUeDpn=2nnojvaOH17eh7pA@mail.gmail.com>
References: <535559FC.70506@hartkopp.net> <5355ba9a.705c8c0a.a2a6.28aa@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56043 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaDVFyw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Apr 2014 01:54:52 -0400
Received: by mail-pb0-f52.google.com with SMTP id rq2so577020pbb.25
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2014 22:54:52 -0700 (PDT)
In-Reply-To: <5355ba9a.705c8c0a.a2a6.28aa@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kvaser Support <support@kvaser.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

On Tue, Apr 22, 2014 at 2:40 AM, Kvaser Support <support@kvaser.com> wr=
ote:
> Thanks for the information Oliver.
>
> Is there a good location for us to point to that would list the curre=
nt hardware supported by Socketcan and the version of Linux needed for =
that support?  A site that is kept up to date?
>
> I am looking for something that we could put in a FAQ on our website =
that point people using socketcan in the correct direction.

Try http://elinux.org/CAN_Bus

The wiki could definitely get more care, but from time to time we updat=
e it.

Regards,
Yegor

> ---------------------------------------------------------------------=
------
>
>
>
> -----Original Message-----
> From: "Oliver Hartkopp" <socketcan@hartkopp.net>
> Reply-To: "Oliver Hartkopp" <socketcan@hartkopp.net>
> Date: Mon, 21 Apr 2014 19:48:44 +0200
> To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
> Cc: "Kvaser Support (support@kvaser.com)" <support@kvaser.com>, "linu=
x-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Olivier Sobrie" <o=
livier@sobrie.be>
> Subject: Re: Kvaser socketCAN support
>
>>Hello Christopher,
>>
>>the Kvaser Leaf USB driver has been contributed by Olivier Sobrie (se=
e CC).
>>
>>See log messages of the driver in the Linux Mainline repository:
>>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/dr=
ivers/net/can/usb/kvaser_usb.c
>>
>>The initial support was added at 2012-11-27 and emerged in Linux 3.8.
>>
>>Regards,
>>Oliver
>>
>>ps. feel free to ask this kind of questions on the linux-can mailing =
list
>>which I added in CC. Tnx
>>
>>On 17.04.2014 03:31, Smith, Christopher - 0999 - MITLL wrote:
>>> Hi, I was just looking to get confirmation and a few points for get=
ting the
>>> initial install figured out.
>>>
>>>
>>>
>>> I have a kvaser leaf device that I'd like to use with socketCAN.  I=
s this in
>>> fact supported?
>>>
>>>
>>>
>>> I noticed the general process for setting up socketCAN documented o=
n wikipedia
>>> <http://en.wikipedia.org/wiki/SocketCAN>.  When I issue the followi=
ng command:
>>>
>>>
>>>
>>> ip link add dev vcan0 type vcan
>>>
>>>
>>>
>>> What do I replace vcan0 with?  I=E2=80=99ve tried can0 with no luck=
=2E  Is there a way
>>> to check which devices are registered?  I=E2=80=99m not entirely su=
re that when I
>>> plugged in the USB device the proper drivers were recognized.  I ma=
y need some
>>> of the lower level drivers distributed by Kvaser.
>>>
>>>
>>>
>>> Thank you,
>>>
>>>
>>>
>>> Chris
>>>
>>>
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

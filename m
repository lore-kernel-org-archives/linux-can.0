From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: Re: CAN bus transmission timeout
Date: Tue, 29 Oct 2013 01:36:26 +0100
Message-ID: <201310290136.27229.pisa@cmp.felk.cvut.cz>
References: <CAGfq0uuk-7ihMaYvgEGUvnMaNLcxQc6LrvizuFG2g_KHga7iCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:27806 "EHLO
	relay.felk.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab3J2Ago convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 20:36:44 -0400
In-Reply-To: <CAGfq0uuk-7ihMaYvgEGUvnMaNLcxQc6LrvizuFG2g_KHga7iCw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Kirienko <pavel.kirienko.list@gmail.com>, linux-can@vger.kernel.org, Rostislav Lisovy <lisovy@gmail.com>

Hello Pavel,

On Monday 28 of October 2013 14:59:02 Pavel Kirienko wrote:
> Consider the following scenario:
>
> There is a Linux-powered device connected to a CAN bus. The device
> periodically transmits the CAN message. The nature of the data carrie=
d
> by this message is like measurement rather than command, i.e. only th=
e
> most recent one is actually valid, and if some messages are lost that
> is not an issue as long as the latest one was received successfully.

you can achieve the required behavior (keep only the most recent messag=
e
in the queue) by use of Linux socket implementation QoS mechanism.

Look at paragraph "3.1.3. p=EF=AC=81fo_head_drop" our report

  SocketCAN and queueing disciplines
  http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

You probably do not want to drop all send CAN messages
except the last one when different IDs are sent.
The canid ematch classifier is your friend in this case

  3.2.3. The canid ematch

If you have reasonably recent Linux kernel (v3.6+) and the
corresponding iproute2 package (v3.6.0+) then all required
support is included.

You need something like our prio_0  setup used for our timing report.

I am at conference now so I do not have access to exact
setup example for that case. So I am sending copy
to Rostislav Lisovy who was main developer of ematch canid
filter/classifier.

But generally something like next example (for sure not
fully correct, you need to somehow specify pfifo_fast
for other traffic)=20

tc filter add dev can0 parent 1:0 basic \
    match canid\(sff 0x123 sff 0x500:0x700 eff 0x00:0xff\) \
    flowid 1:1

tc qdisc add dev eth0 parent 1:1 handle 10 pfifo_head_drop limit 1

If you have older kernel and cannot upgrade then you can try
to figure out how to use u32 ematch classifier. You need to
switch CAN ID endianness for little-endian systems when
you specify it for u32 (it matches network order - big endian).

tc filter add dev can0 parent 1:0 basic \
    u32 match u32 0x01000000 0xffffffff at 0 flowid 1:1

tc qdisc add dev eth0 parent 1:1 handle 10 pfifo_head_drop limit 1


Best vishes,

                Pavel

--
                Pavel Pisa
    e-mail:     pisa@cmp.felk.cvut.cz
    www:        http://cmp.felk.cvut.cz/~pisa
    university: http://dce.fel.cvut.cz/

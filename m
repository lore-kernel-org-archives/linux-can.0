From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: fix rx wrong sequence issue
Date: Mon, 08 Oct 2012 11:12:27 +0200
Message-ID: <1349687547.3444.7.camel@coredoba.hi.pengutronix.de>
References: <1349678436-747-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33355 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2JHJMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 05:12:35 -0400
In-Reply-To: <1349678436-747-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

On Mon, 2012-10-08 at 12:10 +0530, AnilKumar Ch wrote:
> Fix "received wrong sequence count. expected: x, got: y" errors
> reported by cansequence in a stress test (--verbose).

I tested this on a AM3505 with cansequence 4.0.6. For 500kbit, I see no
reordering anymore.

When testing at 1Mbit, it seems to be worse than before:
~ # ifconfig can0 down; canconfig can0 bitrate 1000000; ifconfig can0 up
can0 bitrate: 1000000, sample-point: 0.692
[ 1627.995574] ti_hecc ti_hecc: can0: setting CANBTC=0x3b
~ # cansequence -r -vv can0
interface = can0, family = 29, type = 3, proto = 1
received frame. sequence number: 0
received frame. sequence number: 1
received frame. sequence number: 2
received frame. sequence number: 3
received frame. sequence number: 4
received frame. sequence number: 5
received frame. sequence number: 6
received frame. sequence number: 7
received frame. sequence number: 8
received frame. sequence number: 9
received frame. sequence number: 10
received frame. sequence number: 11
received frame. sequence number: 12
received frame. sequence number: 13
received frame. sequence number: 14
received frame. sequence number: 15
received frame. sequence number: 16
received frame. sequence number: 17
received frame. sequence number: 18
received frame. sequence number: 19
received frame. sequence number: 20
received frame. sequence number: 21
received frame. sequence number: 21
received wrong sequence count. expected: 22, got: 21
received frame. sequence number: 21
received wrong sequence count. expected: 22, got: 21
received frame. sequence number: 22
received frame. sequence number: 22
received wrong sequence count. expected: 23, got: 22
received frame. sequence number: 23
received frame. sequence number: 23
received wrong sequence count. expected: 24, got: 23
received frame. sequence number: 24
received frame. sequence number: 24
received wrong sequence count. expected: 25, got: 24
received frame. sequence number: 24
received wrong sequence count. expected: 25, got: 24
received frame. sequence number: 25
received frame. sequence number: 25
received wrong sequence count. expected: 26, got: 25
received frame. sequence number: 26
received frame. sequence number: 27
received frame. sequence number: 27
received wrong sequence count. expected: 28, got: 27
received frame. sequence number: 28
received frame. sequence number: 28
received wrong sequence count. expected: 29, got: 28
received frame. sequence number: 28
received wrong sequence count. expected: 29, got: 28
received frame. sequence number: 29
...

Here we can see that after the initial frames, most frames are received
twice (some even thrice).

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


From: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Thu, 26 Sep 2013 14:04:59 -0500
Message-ID: <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:63101 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab3IZTFA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Sep 2013 15:05:00 -0400
Received: by mail-qe0-f46.google.com with SMTP id x7so1110837qeu.19
        for <linux-can@vger.kernel.org>; Thu, 26 Sep 2013 12:04:59 -0700 (PDT)
In-Reply-To: <20130926155422.GQ12758@n2100.arm.linux.org.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>

Hi Russel,

On Thu, Sep 26, 2013 at 10:54 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> The code here is:
>
>    0:   f57ff04e        dsb     st
>    4:   e3a01000        mov     r1, #0
>    8:   e5820000        str     r0, [r2]
>    c:   f57ff04e        dsb     st
>   10:   e5820004        str     r0, [r2, #4]
>
> Given the dsbs there, it's probably the str r0, [r2] which provoked it,
> and we can see from the register dump, r2 is not NULL.

For reference, that was:

|r7 : 04000000  r6 : c0a18088  r5 : be168000  r4 : c0a18000
|r3 : 00000001  r2 : c0a18090  r1 : 00000000  r0 : 00000000

If r2 is indeed the address of the access, then this is entirely down
to a misuse of the hardware; from the manual:

~
When the FEN bit is set in the MCR, the memory area from 0x80 to 0xFF (which is
normally occupied by MB0 to MB7) is used by the reception FIFO engine.
Table 34-6
shows the Rx FIFO data structure. The region 0x80-0x8F contains an
message buffer
structure which is the port through which the ARM core reads data from
the FIFO (the
oldest frame received and not read yet). The region 0x90-0xDF is
reserved for internal
use of the FIFO engine.
^^^^^^^^^^^^^^^^^^^^
~

In this case, yes, we're trying to write to 0x90. And in
flexcan_chip_start, above the location where it dumps the array to
hardware, FEN is set; this is reflected by the debug (mcr=0x79a2020f).

I'm surprised this ever worked.. if the area 0x90-0xDF is being used
by the FIFO internally then the difference between i.MX53 ('working')
and i.MX6Q ('imprecise abort') is that the i.MX6Q is causing the
proper bus response. We can only hope that the i.MX53 is ONLY not
causing the proper bus response and not actually letting you write
into a FIFO internal data area..

--
Matt Sealey <neko@bakuhatsu.net>

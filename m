From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: sja1000 interrupt problem
Date: Tue, 10 Dec 2013 00:05:35 -0800
Message-ID: <CANGgnMbXt66Wh-yC6TsKmxy5OffKRvHi6L9-M19529r8rm-6gw@mail.gmail.com>
References: <CANGgnMZTugYEZDi5wrmFVP5K=ZMhKsgZJ5VQLP6Y0nxbCsDZ7w@mail.gmail.com>
	<52831FC7.3040509@hartkopp.net>
	<f323c29b9730c877729322453b9e4ec9@grandegger.com>
	<201311131008.55018.pisa@cmp.felk.cvut.cz>
	<5287E6B2.8020709@hartkopp.net>
	<85256584a266750b1330cfae8bebd55c@grandegger.com>
	<5288D236.403@hartkopp.net>
	<5288FB91.9050703@grandegger.com>
	<52892B21.9000501@grandegger.com>
	<CANGgnMa1NXWCtRCWEp3O+c614OyxD=E9mpr55FZNtLkoDrrxMw@mail.gmail.com>
	<CANGgnMa=Kri=ede28bB1fdB9YVsDMMwQpwQTUpheQdqwWaUnVg@mail.gmail.com>
	<333c0fd4238558062478212eb0704b04@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:37598 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3LJIFg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Dec 2013 03:05:36 -0500
Received: by mail-ie0-f181.google.com with SMTP id e14so8108815iej.12
        for <linux-can@vger.kernel.org>; Tue, 10 Dec 2013 00:05:35 -0800 (PST)
In-Reply-To: <333c0fd4238558062478212eb0704b04@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-can@vger.kernel.org

Hi Wolfgang,

On Mon, Dec 9, 2013 at 11:49 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Hi Austin,
>
> On Mon, 9 Dec 2013 13:54:24 -0800, Austin Schuh <austin@peloton-tech.com>
> wrote:
>> Ok.  I succeeded in getting a trace from when the IRQ gets disabled.
>> It took ~2.5 days to trigger it with tracing enabled, and it takes
>> much less time (typically under a day) with tracing disabled.  The
>> trace is at http://98.207.84.11/sja1000_crash.trace.bz2  It is 42 MB
>> compressed and 1 GB uncompressed.
>
> Could you please tell use what trigger you used (how and when did you
> stop the trace) and what the test scenario was (TX on CAN0, RX on CAN1,
> etc.).
>
> Wolfgang.

Whoops, forgot that critical detail...

can0 is connected to a can bus at 250k with a bunch of other can
devices, but for this test, they are all off and nothing is happening
on that bus.

can1 is connected to a can bus at 500k with 2 other can devices.  They
are filling the bus up to about 50% bus load.  I am sending nothing on
can1 for this test.  There is very little load on the system at the
time besides running candump on can1 and streaming that back over ssh.

The trigger is in kernel/irq/spurrious.c and triggers when IRQ 18 gets
disabled.  That is the only modification to the kernel.

Austin

From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 22:50:07 +0200
Message-ID: <4FFB43FF.8060305@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <201207091519.04235.pisa@cmp.felk.cvut.cz> <20120709144042.GA2671@vandijck-laurijssen.be> <23562188.349Ls0e8RT@ws-stein> <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55225 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2GIUuL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 16:50:11 -0400
In-Reply-To: <CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Linux-CAN <linux-can@vger.kernel.org>

On 07/09/2012 05:39 PM, Mohamed HAMZAOUI wrote:
>> I compared itimer with clock_nanosleep on an ARM board and noticed the signal
>> overhead of itimer is much bigger, resulting in a higher CPU usage, than
>> clock_nanosleep upon hrtimer.
>> So I ended up using clock_nanosleep adding a constant to the last timeout.
> 
> but my problem is that when i specify 1 ms of period i have 1.3ms and

So far, you did not specify 1 ms of period. You used a delay of 1 ms
(using nanosleep).

> the problem is how to eliminate the 0.3ms. If i substitute 0.3 ms from
> all payload, what's the assurance that it does not change with CPU
> load  change ?

To understand the real-time capabilities of your system run cyclictest
again, but this time with real system load and running for more than an
hour:

  # cyclictest -t1 -p80 -n -i1000

What do you achieve?

Modify your CAN test program using clock_nanosleep() handling the period
properly, e.g. as suggested by Pavel. Here is another example:


http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/rtdm/profiles/can/rtcan_rtt.c#092

What do you get with such a program?

Still, the 300us for the asynchronous write is bogus. But maybe your
system is that slow.

Wolfgang.




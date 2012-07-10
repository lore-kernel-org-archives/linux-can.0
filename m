From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Wed, 11 Jul 2012 00:11:04 +0200
Message-ID: <CABMxt4iM=nKdZVwvq-13ByBYUyJv_s07fWBgYe3MdfTSRg-OaA@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<201207091519.04235.pisa@cmp.felk.cvut.cz>
	<20120709144042.GA2671@vandijck-laurijssen.be>
	<23562188.349Ls0e8RT@ws-stein>
	<CABMxt4iBB4aP6STAbYcgCYyvOx-JAPnP48P1k=EMGsjQPmWN-Q@mail.gmail.com>
	<4FFB43FF.8060305@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45678 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab2GJWRp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 18:17:45 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so598134ggl.19
        for <linux-can@vger.kernel.org>; Tue, 10 Jul 2012 15:17:45 -0700 (PDT)
In-Reply-To: <4FFB43FF.8060305@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Linux-CAN <linux-can@vger.kernel.org>

Hi,

i run cyclictest command like your description with system load at 90%
(i use stress command  stress -t 3600 -c 1 --io 2 --vm-bytes 256M) and
i have :
Min 0 Avg 158 Max 334

then i create a program with timer (set to zero for increasing to
maximum CPU load) who call periodically an empty function. This
program have a priority 99 set using sched_setscheduler(0, SCHED_RR,
&p);
when i call this program cyclictest freeze and display me after a
moment a very bigger value in Max, then i concluded that the OS
schedule correctly the process according to the priority order.

I will send you the result of the second test and the result of the
patch as soon as possible to advise me on the best solution.
I will measure the really period in sending frame with an oscilloscope
to have the exact value.

Thank you.

On Mon, Jul 9, 2012 at 10:50 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 07/09/2012 05:39 PM, Mohamed HAMZAOUI wrote:
>>> I compared itimer with clock_nanosleep on an ARM board and noticed the signal
>>> overhead of itimer is much bigger, resulting in a higher CPU usage, than
>>> clock_nanosleep upon hrtimer.
>>> So I ended up using clock_nanosleep adding a constant to the last timeout.
>>
>> but my problem is that when i specify 1 ms of period i have 1.3ms and
>
> So far, you did not specify 1 ms of period. You used a delay of 1 ms
> (using nanosleep).
>
>> the problem is how to eliminate the 0.3ms. If i substitute 0.3 ms from
>> all payload, what's the assurance that it does not change with CPU
>> load  change ?
>
> To understand the real-time capabilities of your system run cyclictest
> again, but this time with real system load and running for more than an
> hour:
>
>   # cyclictest -t1 -p80 -n -i1000
>
> What do you achieve?
>
> Modify your CAN test program using clock_nanosleep() handling the period
> properly, e.g. as suggested by Pavel. Here is another example:
>
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/rtdm/profiles/can/rtcan_rtt.c#092
>
> What do you get with such a program?
>
> Still, the 300us for the asynchronous write is bogus. But maybe your
> system is that slow.
>
> Wolfgang.
>
>
>

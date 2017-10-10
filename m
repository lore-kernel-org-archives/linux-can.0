From: Elenita Hinds <elenita.hinds@climate.com>
Subject: Re: Request-for-testing: j1939
Date: Tue, 10 Oct 2017 16:54:42 -0500
Message-ID: <D6ADCA1B-58FD-4037-BA08-2219BD96B4B6@climate.com>
References: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
 <20171008131300.GA24772@airbook.vandijck-laurijssen.be>
 <20171008134441.GA13065@airbook.vandijck-laurijssen.be>
 <20171010164203.GA4297@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:55994 "EHLO
        cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbdJJWmA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Oct 2017 18:42:00 -0400
Received: from mail-it0-f72.google.com (mail-it0-f72.google.com [209.85.214.72])
        by rly18g.srv.mailcontrol.com (MailControl) with ESMTPS id v9ALsi52111100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-can@vger.kernel.org>; Tue, 10 Oct 2017 22:54:45 +0100
Received: by mail-it0-f72.google.com with SMTP id x187so241371itf.2
        for <linux-can@vger.kernel.org>; Tue, 10 Oct 2017 14:54:45 -0700 (PDT)
In-Reply-To: <20171010164203.GA4297@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita Hinds <ecathinds@gmail.com>

Hi Kurt,

I’ve been testing on my end, including the latest commits below, and here are a couple of feedback:

1) [Very minor]  In net/can/j1939/main.c, line 315: I wonder if the ‘printk’ statement is still necessary for a final release.

2) I’m currently encountering a problem where the receiving of packets stops at some point. My test source is still sending the J1939 packets and the device is receiving these packets (verified through an oscilloscope) but both ‘candump’ and ‘testj1939’ tools stop printing data at some point (same packet termination). If I run without the j1939 and just raw CAN using ‘candump', the tool runs infinitely. I’m still digging through the code but I wonder if this is something you’ve seen before and may have some advice.

Thanks,
Elenita



> On Oct 10, 2017, at 11:44 AM, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> 
> Marc et al.,
> 
> I finalized a working branch (only static addressing tested so far).
> Device management behaves well at this point, transport protocol send &
> recv, ...
> 
> I pushed a new https://github.com/kurt-vd/linux/tree/can-next-j1939
> (well, I was a bit supprised I could push this one, without --force
> even).
> Unfortunately, I must postpone tests with dynamic addressing at least a
> week now.
> 
> @Marc,
> I suppose that when the tiny bits are fixed, then this can easily be
> rebased to today's can-next without major impact, isn't it?
> 
> Kind regards,
> Kurt
> 
> --- Original message ---
>> Date:   Sun, 8 Oct 2017 15:44:41 +0200
>> From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>> To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org"
>> <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Elenita
>> Hinds <ecathinds@gmail.com>
>> Subject: Re: Request-for-testing: j1939
>> User-Agent: Mutt/1.5.22 (2013-10-16)
>> 
>> Small update: unplugging the hardware produces a problem with open
>> sockets. I think this is what you tried to solve, and I reverted since
>> it dealt with iface down ...
>> You probably needed to tests against 'ENODEV' rather than ENETDOWN to
>> satisfy my tests :-)
>> I'll work on this ...
>> 
>> Kurt
>> 
>>>> Hello,
>>>> 
>>>> I've worked my way a bit through the lower layers of the j1939 stack.
>>>> While there I cleaned up the livetime handling of the j1939 object and
>>>> the bind() and connect() functions. Unplugging a USB network device
>>>> while a application is running should now be possible.
>>>> 
>>>> The patch stack consists of ~100 patches, ~15 of them are cleanups for
>>>> the af_can. I'm not going to post the patches here for review, testing
>>>> is much more welcome. Maybe we can put together a testsuite.
>>>> 
>>>> The branch is available at my kernel.org linux-can-next repo in the
>>>> j1939 branch.
>>>> 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
>>> 
>>> Marc,
>>> 
>>> I completed some tests on your branch.
>>> I did amend some tiny patches, please find them
>>> at https://github.com/kurt-vd/linux/tree/can-next-j1939
>>> 
>>> I did revert 1 patch which I mentioned already some days ago,
>>> I did 2 optimizations, eliminating locks, and added 2 fixes.
>>> 
>>> I did take the effort to test with 2 CAN adapters this time, since
>>> Elenita had pointed me to a mistake that wasn't revealed doing tests
>>> locally using vcan :-)
>>> 
>>> The stack seems operational, ready for more tests.
>>> 
>>> Kurt
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


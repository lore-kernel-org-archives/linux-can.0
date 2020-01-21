From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: general protection fault in can_rx_register
Date: Tue, 21 Jan 2020 21:39:54 +0100
Message-ID: <20200121203954.GG13462@x1.vandijck-laurijssen.be>
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
 <20200121192248.GC13462@x1.vandijck-laurijssen.be>
 <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:42893 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUUkC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2020 15:40:02 -0500
Content-Disposition: inline
In-Reply-To: <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Dmitry Vyukov <dvyukov@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, o.rempel@pengutronix.de, syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>, linux-can@vger.kernel.org

Oliver,

On di, 21 jan 2020 21:03:42 +0100, Oliver Hartkopp wrote:
> Hi Kurt,
> 
> On 21/01/2020 20.22, Kurt Van Dijck wrote:
> 
> >I decreased the CC list a bit, as I'm more like thinking in the wild
> >now:
> 
> Good choice!
> 
> >Since the problems happens only rarely, and with vxcan, I assume not
> >vcan, I started to think to locking issues.
> >
> >1. What surprised me a bit is 'rtnl_dereference()' calls, without
> >rcu_read_lock() around it? is that supposed to be ok?
> 
> Don't know. This code was just copied from veth.c
> 
> But veth doesn't fiddle with ml_priv like us.
> 
> >2. is it possible to call vxcan_dellink in between the 2
> >rcu_assign_pointer() calls in vxcan_newlink(), resulting in a dead end,
> >i.e. one end is referenced, but already deleted?
> >I'd expect a kind of rcu_write_lock around the cross-linking at least.
> 
> Will look into this too. When there's a comment this might be a
> justification for doing "hacky" things ;-)

Maybe move the crosslinking to before the register, then they're
inaccessible from userspace.

and a little comment, indeed.
Kurt

From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Fri, 6 Dec 2013 10:57:01 +0000 (UTC)
Message-ID: <loom.20131206T114831-779@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34148 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757612Ab3LFK5X (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 6 Dec 2013 05:57:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Vot62-0005id-20
	for linux-can@vger.kernel.org; Fri, 06 Dec 2013 11:57:22 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 11:57:22 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 06 Dec 2013 11:57:22 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> You can send a diff, to illustrate your changes.

$ diff /cygdrive/X/bug1/sja1000.c /cygdrive/X/modified_sja1000.c

151a152
>                         /* RAN 5.12.2013: Disable arbitration IRQ */
153c154
<                               priv->write_reg(priv, SJA1000_IER, IRQ_ALL);
---
>                               priv->write_reg(priv, SJA1000_IER, IRQ_ALL &
~IRQ_ALI);
156c157
<                                               IRQ_ALL & ~IRQ_BEI);
---
>                                               IRQ_ALL & ~(IRQ_BEI | IRQ_ALI));


> > But I prefare to make some kind of "ioctl" support for that. There are
> > applications, where it shall not happend. Concurrently I've played with
> > taskset and priorities.
> 
> ioctl() is not a option here, but there are two options:
> 1) We can put the arbitration lost error to the bus errors,
>    but I think that's wrong.
> 2) You can add another ctrlmode to disable arbitration lost error
>    reporting.

> ...
> > 4: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode
> > DEFAULT qlen 10
> >     link/can
> >     can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
> >     bitrate 1000000 sample-point 0.750
> >     tq 250 prop-seg 1 phase-seg1 1 phase-seg2 1 sjw 1
> >     sja1000: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> >     clock 8000000
> >     re-started bus-errors arbit-lost error-warn error-pass bus-off
> >     0          0          0          0          0          0
> >     RX: bytes  packets  errors  dropped overrun mcast
> >     384541802  59160277 0       0       0       0
> >     TX: bytes  packets  errors  dropped carrier collsns
> >     77591108   9843156  0       0       0       0
> > 
> > 
> > Please keep in mind arbit-lost is now zero forever.
> 
> Because you disabled it, right?

Yes, that's right.

> 
> Marc

As Wolgang mentioned it has nothing to do with the patch v6.
Enabling/diabling IRQs is a new feature. So I don't know, if here it is a
right place to continue about that.

By

Richard






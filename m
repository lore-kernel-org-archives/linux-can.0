From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net-next v2 2/4] can: cc770: add legacy ISA bus driver for the CC770 and AN82527
Date: Thu, 5 Jan 2012 12:00:37 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AF31@saturn3.aculab.com>
References: <4F058ED5.2000407@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:42734 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756352Ab2AEMCY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2012 07:02:24 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 23741-03 for <linux-can@vger.kernel.org>;
 Thu,  5 Jan 2012 12:02:20 +0000 (GMT)
Content-class: urn:content-classes:message
In-Reply-To: <4F058ED5.2000407@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, info@essax.com
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org, linux-can@vger.kernel.org, socketcan-users@lists.berlios.de, IreneV <boir1@yandex.ru>, Stanislav Yelenskiy <stanislavelensky@yahoo.com>

> >>> -    outb(reg, base);
> >>> -    outb(val, base + 1);
> >>> +    outw( reg + ( val<<  8), base);
> >>
> >> That modification does fix your problem, right? The others above
don't
> >> help nor harm but we don't know if it's really realted to the same
> >> problem. I wll dig a bit deeper.
> > 
> > Exactly. The others above I removed because facing the opposite,
even
> > missing interrupts but then just to avoid other possible side
effects
> > and then assuming that they might be related.
> 
> OK. My concern: Can we be sure that 16bit accesses are always
supported
> by the hardware? Does a spinlock_irqsave/spinlock_irqrestore around
the
> 8bit accesses already help?

Hmmm... are there any register reads that need the
same 'double cycle' sequence ??
If so you need to stop reads being interleaved (with
themselves and writes) so requesting a 16bit access
doesn't help.

Which means you need a spinlock...

	David



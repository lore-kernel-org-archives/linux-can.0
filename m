From: Alexander GQ Gerasiov <gq@cs.msu.su>
Subject: Re: SJA1000 loopback feature
Date: Thu, 19 Jun 2014 22:07:10 +0400
Message-ID: <20140619220710.580a0879@snail>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>
	<539F3DDF.70007@hartkopp.net>
	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>
	<20140617161347.25cb639e@snail>
	<53A1EDA7.7040504@hartkopp.net>
	<20140619164424.244e5634@snail>
	<53A2F9EC.4060107@hartkopp.net>
	<20140619200110.7427bdfe@snail>
	<53A32133.7050300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eol.lvk.cs.msu.su ([158.250.17.73]:37849 "EHLO
	eol.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933474AbaFSSGY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 14:06:24 -0400
Received: from snail (unknown [192.168.131.93])
	by eol.lvk.cs.msu.su (Postfix) with ESMTPSA id E43FB1407EF
	for <linux-can@vger.kernel.org>; Thu, 19 Jun 2014 22:06:21 +0400 (MSK)
In-Reply-To: <53A32133.7050300@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Thu, 19 Jun 2014 19:43:15 +0200
Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> So your hosts are absolutely synchronized (via ntp)??
Offtopic: yes, ntp for dirty synchronization and then LinuxPPS
for +/-5 microseconds precision.

> > On vcan you will see A (on T+dt1), B (on T+dt1+dt2).
> 
> How do you get the timestamp information then?

I put timestamps here just for example.

I just need that events traced by testbench software (on vcan in your
example) should go in the same order as events real hardware (we are
testing) will see on its interface.

> E.g. you can configute the routing rule with '-t' option to preserve
> the src_dev rx timestamp. You would see the timestamp from the real
> CAN tnen.
> 
> > On bus you will see B (on T+dt3), A (on T+dt3+dt4).
> 
> Hm - i wonder if you would really see a difference as the networking
> stack is not real-time anyway.

Timestamps are not a problem (in real life they are :) ). I'm speaking
about event's order 

> When sending on vcan (which has no
> receive queue) the rx is performed instantly which leads to en-queue
> the frame into the real CAN interface immediately.

Yes, after frame will be transmitted via vcan our soft will trace
successfull send, but then this frame will go into tx-queue and here it
could stuck because another (e.g. high prio) frame is transmitted by
other host (real hardware) the same time.


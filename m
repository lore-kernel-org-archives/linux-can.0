From: Jason White <white_jason_r1@cat.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Thu, 15 Nov 2012 19:07:58 +0000 (UTC)
Message-ID: <loom.20121115T200742-282@post.gmane.org>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org> <50A4E5FC.5020103@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47920 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423636Ab2KOTIT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Nov 2012 14:08:19 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZ4nU-0002L9-Cx
	for linux-can@vger.kernel.org; Thu, 15 Nov 2012 20:08:20 +0100
Received: from bc1.cat.com ([12.2.142.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 20:08:20 +0100
Received: from white_jason_r1 by bc1.cat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 20:08:20 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> wrote on 11/15/2012 06:54:20 AM:

> > Right now we are taking the interface down and then back up and while this 
> > works for a single process using CAN, I don't think it will work well with 
> > multi-process support.  Would the other processes know that the interface 
> > was taken down?  I haven't decided the route we will go, but maybe an 
> 
> If the other process is doing a read, the read will return. I'm not sure
> what happens to a write after ifdown/ifup, I think it will fail.
> 

But you wouldn't want all processes to implement this timeout, otherwise 
they would all timeout at the same time and bring the interface down 
hence having something lower down in the stack implement it. 


> > Ideally a packet timeout would be implemented in the driver since it knows 
> > when the last message was transmitted (tx interrupt) and could perform the 
> > flush properly.  Has there been any more thought to this scenario?
> 
> This is a scenario, I think the first step will be to implement an
> "abort currently transmitted frame" callback. Note that not all hardware
> supports a tx-complete interrupt. A timeout mechanism can then be
> implemented in the framework in a hardware independent way, e.g. if you
> extend the currently used can_echo mechanism.
> 
> Marc

Every piece of CAN hardware I've seen (10+ devices) has a tx interrupt 
that indicates when the message is transmitted.  If the current message 
being transmitted has been in the buffer XX amount of time, then it 
and probably the entire queue should be flushed.  Obviously not all 
hardware supports aborting the current frame, but there are work arounds. 
Usually if a CAN message can't transmit within this time it's data is way 
too old to be sent.  The actual time might be up for discussion and 
depends on what is being sent, but for controls its not that long. 

Jason



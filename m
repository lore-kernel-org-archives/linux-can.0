From: Jason White <white_jason_r1@cat.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 14 Nov 2012 20:48:39 +0000 (UTC)
Message-ID: <loom.20121114T213201-791@post.gmane.org>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44437 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933100Ab2KNUy5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 14 Nov 2012 15:54:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TYjzE-0007aq-KJ
	for linux-can@vger.kernel.org; Wed, 14 Nov 2012 21:55:04 +0100
Received: from bc1.cat.com ([12.2.142.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 21:55:04 +0100
Received: from white_jason_r1 by bc1.cat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 14 Nov 2012 21:55:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> 
> 
> We have several customers who asked how to abort pending TX messages,
> too. Which involves:
> a) clear the TX-queue in Linux
> b) clear queue in hardware
> c) abort currently transmitting CAN frame
> 
> I think c) would be a usecase of its own, too.
> 
> Marc
> 


Has there been any more investigation into this tx buffer overflow scenario?

I've been working on using SocketCAN interface for the past several months.  
I have quite a bit of experience with CAN from an embedded perspective 
(outside of Linux) and even multiple clients accessing a single CAN port.  
We have to have a method of flushing the transmit queue because if an ECU is 
initially alone on the network and goes error passive (no ack), then we want
to be able to flush the tx queue periodically to prevent stale data on the bus.
Other scenarios have also been listed.

Right now we are taking the interface down and then back up and while this 
works for a single process using CAN, I don't think it will work well with 
multi-process support.  Would the other processes know that the interface 
was taken down?  I haven't decided the route we will go, but maybe an 
intermediate layer between SocketCAN and user processes to monitor the 
flushing.  Does the socket itself have any buffering or are messages 
forwarded directly to the driver?

Ideally a packet timeout would be implemented in the driver since it knows 
when the last message was transmitted (tx interrupt) and could perform the 
flush properly.  Has there been any more thought to this scenario?

Thanks,
Jason



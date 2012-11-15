From: Jason White <white_jason_r1@cat.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Thu, 15 Nov 2012 19:11:33 +0000 (UTC)
Message-ID: <loom.20121115T201037-567@post.gmane.org>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org> <50A4E5FC.5020103@pengutronix.de> <50A52266.8030301@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768697Ab2KOTOz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Nov 2012 14:14:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZ4u0-00083c-8t
	for linux-can@vger.kernel.org; Thu, 15 Nov 2012 20:15:04 +0100
Received: from bc1.cat.com ([12.2.142.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 20:15:04 +0100
Received: from white_jason_r1 by bc1.cat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 20:15:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan@hartkopp.net> wrote on 11/15/2012 11:12:06 AM:

> 
> The can-gw frame router is part of mainline Linux 3.2+
> 
> 

I'm not sure I entirely follow what you are doing.  Here is what I think you
mean.  Please correct me if I'm wrong.  You have implemented a network
management layer that interfaces directly with can0.  All other applications
interact with can0v, which is always up.  When you know the communication
is stable you route between can0 and can0v.  Did I get that right?

So do you take can0 down/up when timeouts occur with messaging?  Is there
any kind of startup delay associated with this?  Is there any kind of
delays going to can0v?
 
> Officially the TX-timeout has been removed as the controller just sends out
> the CAN frames, when it comes back to life ...
> 
> The question is, if the controller gets into the BUS_OFF state and if the
> restart-ms option (see ip tool) would help here.
> 
> Regards,
> Oliver

What do you mean by the TX-timeout or restart-ms option?

Jason



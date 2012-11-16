From: Jason White <white_jason_r1@cat.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Fri, 16 Nov 2012 17:09:37 +0000 (UTC)
Message-ID: <loom.20121116T180707-803@post.gmane.org>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org> <50A4E5FC.5020103@pengutronix.de> <50A52266.8030301@hartkopp.net> <20121116151315.GB93742@airbook.eia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36208 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab2KPRKB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 16 Nov 2012 12:10:01 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZPQc-0004RR-J1
	for linux-can@vger.kernel.org; Fri, 16 Nov 2012 18:10:08 +0100
Received: from bc1.cat.com ([12.2.142.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Nov 2012 18:10:06 +0100
Received: from white_jason_r1 by bc1.cat.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 16 Nov 2012 18:10:06 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <kurt.van.dijck <at> eia.be> writes:

> > 
> > Officially the TX-timeout has been removed as the controller just sends out
> > the CAN frames, when it comes back to life ...
> > 
> > The question is, if the controller gets into the BUS_OFF state and if the
> > restart-ms option (see ip tool) would help here.
> FYI:
> A CAN chip that sits alone on a proper bus, trying to transmit a frame,
> will never go into BUS_OFF. It can only go in BUS_OFF when a bad network
> is encountered, i.e. the chip does not see it's TX activity on its RX.
> 
> I think this scenario (chip alone, going in BUS_OFF) is no different
> than regular BUS_OFF, and should be treated likewise.
> > 

This sounds like something I would be interested in.  Just a couple of
questions.  What do you mean TX-timeout has been removed?  Also does
it work in error passive state (scenario where the ECU is alone on
the bus - no ack from another ECU).  Does it just reset the CAN
hardware or does the queues get flushed as well?

Jason




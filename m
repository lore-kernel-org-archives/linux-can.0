From: Richard Andrysek <richard.andrysek@rg-mechatronics.com>
Subject: Re: [PATCH v6] can: sja1000: fix =?utf-8?b?e3ByZSxwb3N0fV9pcnEoKQ==?= handling and IRQ handler return value
Date: Thu, 5 Dec 2013 19:37:58 +0000 (UTC)
Message-ID: <loom.20131205T202627-307@post.gmane.org>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42322 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3LETiX (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Dec 2013 14:38:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Voekc-0004nQ-OV
	for linux-can@vger.kernel.org; Thu, 05 Dec 2013 20:38:19 +0100
Received: from apollon.rg-mechatronics.com ([62.225.122.120])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2013 20:38:18 +0100
Received: from richard.andrysek by apollon.rg-mechatronics.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 05 Dec 2013 20:38:18 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 	2) How the data overrun can happen, if the can bus load  is ~25%?
> 
> If a bunch of messages is sent in a short time. The 25% is an average
> load, I assume.
> 
> > 	 
> > 	$ sudo cat /proc/net/can/stats
> > 	[sudo] password for ran:
> >  
> >   1421819 transmitted frames (TXF)
> >   2606493 received frames (RXF)
> >    473873 matched frames (RXMF)
> >  
> >        18 % total match ratio (RXMR)
> >      2400 frames/s total tx rate (TXR)
> >      4400 frames/s total rx rate (RXR)
> >  
> >        18 % current match ratio (CRXMR)
> >      2400 frames/s current tx rate (CTXR)
> >      4400 frames/s current rx rate (CRXR)
> >  
> >        18 % max match ratio (MRXMR)
> >      2427 frames/s max tx rate (MTXR)
> >      4427 frames/s max rx rate (MRXR)
> >  
> >         4 current receive list entries (CRCV)
> >         9 maximum receive list entries (MRCV)
> >  
> > 	        2 statistic resets (STR)
> 
>   # ip -d -s link show can0
> 
> will list the CAN statistics.
> 
> Wolfgang.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Hi Wolfgang,

thank you for help. I've recognized that these two lines comes from a
network world:

RX packets:12462166 errors:121380 dropped:0 overruns:0 frame:121380
TX packets:11604619 errors:678 dropped:0 overruns:0 carrier:0

Then each event "arbitration lost" generates an IRQ.
Is it OK to disable it, just now for tests. With that I want to reduce an
amount of IRQs. Is it possible to disable it without a new compilation of a
kernel?

We are running quite fast, in few ms. So we test your driver quite well:)

by

Richard



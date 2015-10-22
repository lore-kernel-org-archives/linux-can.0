From: wouter van herpen <wouter.van.herpen@prodrive-technologies.com>
Subject: Re: =?utf-8?b?Y19jYW46?= wrong frame order reception
Date: Thu, 22 Oct 2015 09:50:59 +0000 (UTC)
Message-ID: <loom.20151022T114518-579@post.gmane.org>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein> <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein> <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com> <loom.20151021T111146-165@post.gmane.org> <5627A245.50401@pengutronix.de> <56286E9F.7040909@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45935 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756468AbbJVJvP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Oct 2015 05:51:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1ZpCWf-0006Hg-9u
	for linux-can@vger.kernel.org; Thu, 22 Oct 2015 11:51:13 +0200
Received: from prodrive.fiberspeed.claranet.nl ([prodrive.fiberspeed.claranet.nl])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2015 11:51:13 +0200
Received: from wouter.van.herpen by prodrive.fiberspeed.claranet.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 22 Oct 2015 11:51:13 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> you can try to use the SMP-affinity to pin the innterrupt to a specific CPU:
> 
> 	https://www.kernel.org/doc/Documentation/IRQ-affinity.txt
> 
> But we're currently also checking the usability of receive packet steering 
> (RPS) on SMP systems. Please check
> 
> 	http://marc.info/?l=linux-can&m=144251788500555&w=2
> 
> whether just using
> 
> 	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus
> 
> helps in you case or whether you need to set the skb hash which is suggested 
> there too.
> 
> 

Hi Oliver,

I have tried SMP affinity, in combination with adjusting
/sys/class/net/can0/queues/rx-0/rps_cpus. These changes did not solve the
out of order reception.
Also adding skb_set_hash(skb, dev->ifindex, PKT_HASH_TYPE_L2); did not make
a difference.

Do you have any other suggestions?

I have also done some testing with the pch_can driver. I noticed there the
out of order receptions are less frequent. Using the pch_can driver, OOO
reception only occurs if we stress the CPU over e.g. UART.
Using c_can driver, the OOO replies occur more often.







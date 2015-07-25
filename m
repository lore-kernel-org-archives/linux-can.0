From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem using Linux CAN
Date: Sat, 25 Jul 2015 15:45:38 +0200
Message-ID: <55B39302.70505@hartkopp.net>
References: <CD02850D-3BF4-4AE3-B1A3-72E34D09C061@osdr.org> <55AFD5DA.7010601@hartkopp.net> <A0E5883A-3FBB-4060-8A38-A32DA743B16B@osdr.org> <55AFE356.9070906@hartkopp.net> <0948A186-060F-4A31-8359-755DE78647A0@osdr.org> <928F9D91-F184-4CEF-850E-899A84D444A1@osdr.org> <55B123B9.1090306@hartkopp.net> <839E49C8-4EA6-4DE5-8901-3AAECD1435CA@osdr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:42059 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbbGYNpn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jul 2015 09:45:43 -0400
In-Reply-To: <839E49C8-4EA6-4DE5-8901-3AAECD1435CA@osdr.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tim Hotfilter <thotfilter@osdr.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Tim,

On 24.07.2015 09:53, Tim Hotfilter wrote:

> 1. 500kBaud results in the same problem.
> 2. The problem also occurs with the final configuration (about 5 can nodes). As i mentioned in the first mail, one node has a can-frame watchdog and turns off.
> 3. I had kernel 3.17. before. For testing I upgraded to 3.19

Hm.

> I think the problem is the stopped tx queue.

How did you get this information that the queue is stopped?

The sja1000 queue is stopped in sja1000_start_xmit() and is enabled in 
sja1000_interrupt() again when the tx-ok interrupt (IRQ_TI) occurred.

So when the sja1000 has a stopped queue after some successful time of 
operation the tx-ok interrupt obviously got lost.

As you have two sja1000 cores (from opencores?) in you FPGA: Do you have them 
connected to separate irq lines?

> Is there any chance to implement something like a timeout function, which wakes the queue if the buffer fill level is over a threshold.

We should better try to fix the real issue than implementing workarounds like 
this. There is a timeout recovery for bus-off states (restart-ms option) - but 
your device does not get into bus-off.

Regards,
Oliver

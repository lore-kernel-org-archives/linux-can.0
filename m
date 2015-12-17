From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: Ancient Freescale Reference FlexCAN Driver and bug
 fixes so it works.
Date: Thu, 17 Dec 2015 15:22:01 +1100
Message-ID: <56723869.5060900@optusnet.com.au>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696582.7020503@optusnet.com.au> <566973A4.5000703@pengutronix.de>
 <566A0267.2080809@optusnet.com.au>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:39355 "EHLO
	mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbbLQEWO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Dec 2015 23:22:14 -0500
In-Reply-To: <566A0267.2080809@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Sharma Bhupesh <bhupesh.sharma@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>

On 11/12/15 09:53, Tom Evans wrote:
> On 10/12/2015 11:44 PM, Marc Kleine-Budde wrote:
>> On 12/10/2015 12:44 PM, Tom Evans wrote:
>>> I've just had to delve back into the deep murky past and try to get
>>> Freescale's Kernel 2.6.35 FlexCAN driver working...
>
> On an i.MX53. That's the last supported kernel Freescale ever released for
> that series of parts.

> The simplest path was to fix the
> simple and stupidly obvious bugs in the existing driver rather
 > than add new complicated bugs.

There seems to be no end of bugs in this driver. It is a lesson in something.

What's the dumbest driver bug ever? Interrupt hazard. Yes, this one has that too.

The mainline sends a Message Buffer (or tries to) and DISABLES the netif queue 
if it can't send [1]. The transmit interrupt service routine ENABLES the netif 
queue. And when the interrupt routine happens in the middle of the mainline 
transmit routine? It locks forever. You have to power-cycle to get it back. 
Normally taking the interface "down" and "up" should fix it, as the "start" 
and "stop" functions normally stop and start the netif queue. Not these ones. 
They do now.

Note 1: This is in the case where the transmit queues and MBs are full. The 
transmit function is always called twice. The first time it is called it sends 
the MB, leaves the queue running and return "OK". The second time it finds out 
it is full, stops the queue and returns "BUSY". Even better, with the default 
32 transmit MBs it has to scan through all 32 MBs to find out it is full, and 
it may have also had to scan the same 32 to find an empty one. The FlexCAN 
registers are on a slow bus and take 180ns to read or write. So it can take 
the driver up to 12us to send one buffer. Or proportionally longer if you have 
more Transmit MBs (you might have 56).

If you never send enough data to flow-control the driver this won't happen. If 
you have more than one Transmit MB (and can handle out of order transmissions) 
then the subsequent transmit interrupts will repair the damage and you won't 
see it either. That's probably why it passed whatever testing it had.

Bug detailed here:

https://community.freescale.com/message/597952

Patch to fix here:

https://community.freescale.com/message/597951#597951
Tom


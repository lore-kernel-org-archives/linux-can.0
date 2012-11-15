From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Thu, 15 Nov 2012 18:12:06 +0100
Message-ID: <50A52266.8030301@hartkopp.net>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org> <50A4E5FC.5020103@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:60369 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768440Ab2KORMK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 12:12:10 -0500
In-Reply-To: <50A4E5FC.5020103@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Jason White <white_jason_r1@cat.com>
Cc: linux-can@vger.kernel.org

On 15.11.2012 13:54, Marc Kleine-Budde wrote:

> On 11/14/2012 09:48 PM, Jason White wrote:

>> Right now we are taking the interface down and then back up and while this 
>> works for a single process using CAN, I don't think it will work well with 
>> multi-process support.  Would the other processes know that the interface 
>> was taken down?  I haven't decided the route we will go, but maybe an 
> 
> If the other process is doing a read, the read will return. I'm not sure
> what happens to a write after ifdown/ifup, I think it will fail.


Yes. It fails with -ENETDOWN ...

Btw. we had a similar use-case:

Only allow the applications to work in the CAN bus, once the CAN network
management established a stable state.

To do so, i implemented the network management e.g. on 'can0'. But the other
applications have been working on a virtual CAN interface 'can0v'.

Once the network management was ok, i cross-linked 'can0' and 'can0v' with two
can-gw rules:

	cangw -A -s can0 -d can0v -e
	cangw -A -s can0v -d can0 -e

I did not use the 'cangw' tool but created the netlink messages myself.

The advantage of this solution is that the can0v interface is always up and
stable - while the can0 interface can be set to up/down.

The traffic is routed on demand only.

The can-gw frame router is part of mainline Linux 3.2+


>> intermediate layer between SocketCAN and user processes to monitor the 
>> flushing.  Does the socket itself have any buffering or are messages 
>> forwarded directly to the driver?
>>
>> Ideally a packet timeout would be implemented in the driver since it knows 
>> when the last message was transmitted (tx interrupt) and could perform the 
>> flush properly.  Has there been any more thought to this scenario?
> 
> This is a scenario, I think the first step will be to implement an
> "abort currently transmitted frame" callback. Note that not all hardware
> supports a tx-complete interrupt. A timeout mechanism can then be
> implemented in the framework in a hardware independent way, e.g. if you
> extend the currently used can_echo mechanism.


Officially the TX-timeout has been removed as the controller just sends out
the CAN frames, when it comes back to life ...

The question is, if the controller gets into the BUS_OFF state and if the
restart-ms option (see ip tool) would help here.

Regards,
Oliver

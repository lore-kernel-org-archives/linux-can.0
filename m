From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socket can receive order
Date: Thu, 17 Sep 2015 21:18:28 +0200
Message-ID: <55FB1204.5090908@hartkopp.net>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk> <55EF133E.8070105@hartkopp.net> <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com> <55F05AFE.8070203@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:51251 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbIQTYk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2015 15:24:40 -0400
In-Reply-To: <55F05AFE.8070203@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, Austin Schuh <austin@peloton-tech.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello Daniel,

On 09.09.2015 18:14, Daniel Squires wrote:
> The Hack seems to work, its been a short test of a half hour so far, but
> before it happened reliably after a few seconds.
>
>> On Tue, Sep 8, 2015 at 9:56 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>>>
>>> See http://marc.info/?l=linux-netdev&m=143689694125450&w=2
>>>
>>> If so, please try the 'hack' I suggested on the netdev ML if it fixes your
>>> problem. It might help for the discussion too.

In the referenced posting above I suggested to set

	skb_set_hash(skb, dev->ifindex, PKT_HASH_TYPE_L2);

to create a interface specific hash for the socket buffer.

And then to enable the receive packet steering (RPS) with

	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus

To create a proper patch and description I evaluated some more skb_set_hash() 
parameters and finally discovered that setting the skb hash seems to be 
obsolete ... %-)

Can you confirm that

	echo f > /sys/class/net/can0/queues/rx-0/rps_cpus

already fixes the out-of-order issue even without setting the skb hash?

If so we could give a general recommendation for multi-core CPU system users 
to enable RPS for CAN interfaces by setting the specific sysfs entry.

Regards,
Oliver



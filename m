From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Sun, 5 Jun 2016 14:07:17 +0200
Message-ID: <575415F5.3070306@hartkopp.net>
References: <573E491E.1000906@denx.de>
 <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
 <573EAE9D.20006@hartkopp.net> <573EFC23.2040906@denx.de>
 <574E47C8.4000709@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:50768 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbcFEMHf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jun 2016 08:07:35 -0400
In-Reply-To: <574E47C8.4000709@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, Mirza Krak <mirza.krak@hostmobility.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 06/01/2016 04:26 AM, Marek Vasut wrote:

>>> What would be the advantages to put this into kernel space (or into the
>>> CAN networking infrastructure)?
>>
>> I see two for putting this into the kernel:
>> - At faster bus speeds, you can achieve more precise timing if this is
>>    in the kernel, both of the inter-byte delay and also for the
>>    timestamps. Having this in the kernel even allows usage of the
>>    realtime extensions if needed.

A topic for the serial driver infrastructure?

>> - Dedicated hardware driver can plug into such K-Line infrastructure.
>>    Such hardware might be needed to support the faster modes to further
>>    increase the timing precision.

Which K-Line infrastructure?

>> And two for using socketcan/network interface:
>> - The addressing support of the network stack can be mapped to K-Line
>>    bus addresses.

The K-Line addressing is totally different from CAN addressing. Why do 
you think the stuff in linux/net/can has any conjunction to K-Line 
addressing?

>> - The rtnl can be used as an extensible interface for configuring the
>>    K-Line parameters.

The idea of SocketCAN using the Linux networking infrastructure and 
network interfaces is the multi-user capability which is enabled through 
this layering.

IIRC K-Line is ONE point-to-point connection which is not multi-user 
capable - so what would be the benefit to implement a K-Line serial 
driver as network device and then configure it via rtnl?

> What do you think about putting the KLine support into socketcan stack ?

If I would think about your mentioned requirements and ideas I would 
start with pyOBD http://www.obdtester.com/pyobd and probably move this 
to be a PREEMPT_RT task and I would add an interface to specify 
inter-byte delays into the serial driver infrastructure.

Even when trying to think very positively about your question I don't 
see any conjunction to SocketCAN.

Best regards,
Oliver

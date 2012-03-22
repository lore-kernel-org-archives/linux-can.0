From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 13:25:47 +0100
Message-ID: <4F6B1A4B.1030601@hartkopp.net>
References: <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EC19.7090205@grandegger.com> <4F69EE38.9000904@hartkopp.net> <20120322095730.GC426@vandijck-laurijssen.be> <4F6AF9B4.2020002@grandegger.com> <20120322103515.GE426@vandijck-laurijssen.be> <4F6B0663.1080405@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:21455 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab2CVMZv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 08:25:51 -0400
In-Reply-To: <4F6B0663.1080405@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On 22.03.2012 12:00, Wolfgang Grandegger wrote:

> On 03/22/2012 11:35 AM, Kurt Van Dijck wrote:

>> The remaining 1% may or may not work. In case of proper coded programs,
>> I'm sure they work. In other cases, I'm not sure.
>> Thus the question is:
>> Does the remaining 1% that we don't know, justify an alternate approach?


Yes it does. As pointed out yesterday breaking ABI is a no go.
I won't like to come into focus with Linus discussing a pointless ABI item.

> Well, I do not yet know. I first would like to see the data sheet of a
> CANFD controller to understand better the possible use cases. And
> without real use case, we will not add any CANFD support to the mainline
> kernel anyway. There is still some time to think and discuss.


That's also my impression.

> 
>> My initial patch mainly illustrates that this may be a reasonable question.
>>
>> As ethernet user, on a socket level, I also do not care about low-level
>> technology (100Mbit, 1GBit, UTP, ...).
> 
> But that's because we use higher-level protocols like UDP and TCP which
> do not care about the hardware frame size.


Indeed this is what i wanted to express, when writing this:

When there's a defined socket API that makes use of struct can_frame (like
can_raw, can_bcm, can_gw - but not isotp! \o/ ) we need to

- duplicate the socket API - like CAN_RAWFD (ugly)
- switch the frame size (e.g. via sockopt)
- a third unknown idea ...

ISOTP is off this discussion as it does not deal with struct can_frame.

Any other of the CAN protocol definitions does.

Regards,
Oliver

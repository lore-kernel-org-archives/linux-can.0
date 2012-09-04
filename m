From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN device filterting
Date: Tue, 04 Sep 2012 18:53:25 +0200
Message-ID: <50463205.8050705@hartkopp.net>
References: <1346765466.5440.3.camel@punsfloyd-desktop> <504604E3.1040305@hartkopp.net> <504608CB.9080709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:45015 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443Ab2IDQx3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 12:53:29 -0400
In-Reply-To: <504608CB.9080709@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: puneet.sharma@moschip.com, linux-can@vger.kernel.org

On 04.09.2012 15:57, Marc Kleine-Budde wrote:

> On 09/04/2012 03:40 PM, Oliver Hartkopp wrote:
>> On 04.09.2012 15:31, Puneet Sharma wrote:
>>
>>> I need some guidance on implementing the CAN filtering of identifier in
>>> the driver code of CAN for atmel AT91SAM9263 board. Please guide me how
>>> to proceed with it..
>>
>>
>> Hm - i wrote that some days ago:
> 
> I talked to Puneet in private before, if I understand him correctly he
> wants to implement hardware filtering, although software filtering is
> available.


Ah, ok.

> 
> From my point of view it should become a per device callback, which you
> (admin, i.e. the root user) can set when the device is down. You have to
> extend the CAN netlink interface [1].


Good idea.

> Each device should identify what kind and how many hardware filters it
> supports:
> a) mask+id
> b) just id
> c) ...
> Analogue to ctrlmode [2][3].


Yes. Could be ambitious. E.g. a 2048 bit bitfield is an option too :-)

The question is, if the usual mailbox configurations in CAN controller
IP-cores can be stripped down to 2-3 standard types of filters, so that a good
interface can be specified.

> 
> The requested filers are transferred into the kernel via netlink, but
> you have to figure out how to encode a variable length list (netfilter
> has probably a solution for this). Then the code in can_changelink() [4]
> should check if the transferred filter is supported on that hardware.
> Then, during open the driver should code the filters into hardware, on
> at91 it should be done in at91_setup_mailboxes [5][6].


Yep. I'm looking forward to a patch :-)

Regards,
Oliver

> 
> Marc
> 
> [1] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L585
> [2] http://lxr.free-electrons.com/source/include/linux/can/netlink.h#L81
> [3] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L691
> [4] http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L600
> [5] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L418
> [6] http://lxr.free-electrons.com/source/drivers/net/can/at91_can.c#L336



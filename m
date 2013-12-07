From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: arbitration lost error reporting
Date: Sat, 07 Dec 2013 14:13:39 +0100
Message-ID: <52A31F03.1050701@hartkopp.net>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de> <loom.20131205T164221-222@post.gmane.org> <52A0BCD9.4090309@grandegger.com> <loom.20131205T202627-307@post.gmane.org> <52A0E185.1080402@grandegger.com> <loom.20131206T100036-664@post.gmane.org> <52A1A323.1030605@pengutronix.de> <loom.20131206T114831-779@post.gmane.org> <52A1B8DA.1030700@pengutronix.de> <52A1BCEE.5070101@hartkopp.net> <52A21082.9010102@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:33576 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3LGNNl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Dec 2013 08:13:41 -0500
In-Reply-To: <52A21082.9010102@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Richard Andrysek <richard.andrysek@rg-mechatronics.com>, linux-can@vger.kernel.org

On 06.12.2013 18:59, Wolfgang Grandegger wrote:
> On 12/06/2013 01:02 PM, Oliver Hartkopp wrote:
>> On 06.12.2013 12:45, Marc Kleine-Budde wrote:

>>> As I outlined above you have two options. I prefer option 2 and it has a
>>> big change of going mainline. The implementation is similar to
>>> CAN_CTRLMODE_BERR_REPORTING, just look for it in the kernel source tree
>>> and add a new define for arbitration lost error reporting.
>>>
>>> Do you have a preferred name for the define?
>>> - CAN_CTRLMODE_AERR_REPORTING
>>> - CAN_CTRLMODE_ARBITRATIONERR_REPORTING to
>>
>> Loosing the arbitration is not an error. It just can happen from time to time.
> 
> Well, if it does not happen often, why do we want to suppress reporting
> this error? I still do not see what it's good for.

Sometimes it's good to let it settle.

Indeed the CAN_CTRLMODE_BERR_REPORTING was introduced to reduce the irq storms
that can occur when bus errors happen on the bus.

All other states are promoted by the driver when this information can be
retrieved from the hardware.

Btw. it seems reasonable to ask whether it makes sense to create error message
skbs when there's no consumer of the information.
E.g. the networking timestamps are only enabled when (at least) one
application requires timestamps on the host.

Therefore I would suggest to create the error message skb only when someone is
requesting this information (== an error message filter is enabled).

I'll send a RFC patch for that ...

Oliver

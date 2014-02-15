From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 5/5] can: allow to change the device mtu for CAN FD
 capable devices
Date: Sat, 15 Feb 2014 18:29:15 +0100
Message-ID: <52FFA3EB.7060902@hartkopp.net>
References: <1392481934-12569-1-git-send-email-socketcan@hartkopp.net> <1392481934-12569-5-git-send-email-socketcan@hartkopp.net> <52FF9D0C.30406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:17942 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbaBOR3R (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Feb 2014 12:29:17 -0500
In-Reply-To: <52FF9D0C.30406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 15.02.2014 17:59, Marc Kleine-Budde wrote:

> please add a cover letter (--compose option to git send-email) when
> sending a new version of the series, briefly listing your changes (one
> line per change).

Will try :-)


> Please add a patch description to patch 4, as in the kernel it's
> considered bad style to have patches without a description.

Will do.


> On 02/15/2014 05:32 PM, Oliver Hartkopp wrote:
>> The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in the driver
>> specific ctrlmode_supported capabilities.
>>
>> The configuration can be done either with the 'fd { on | off }' option in the
>> 'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
>> to CANFD_MTU (72).
> 
> Please don't add two possibilities to activate canfd on a CAN network
> card. There should only be one.

Yes it /should/ be like this.
I thought about it some time but I didn't find a better solution.

The problem is that dev->mtu is the switch for the skb->len whether CAN frames
or CAN FD frames are generated or received.

The MTU can be modified by 'ip' (independently from CAN specific settings).

OTOH the only way the CAN devices provide their capabilities is the
ctrlmode_supported bitfield - and it does not make sense to provide
CAN_CTRLMODE_FD in ctrlmode_supported and do not provide the configuration for it.

If you would skip the CAN_CTRLMODE_FD bit in ctrlmode_supported there's no way
to identify a CAN FD capable device. You could only try to set the MTU to
CANFD_MTU and see, if it fails. Not a good solution either.


>> +EXPORT_SYMBOL_GPL(can_change_mtu);
> 
> Who will be the user of this function? The individual network drivers?
> 

Yes. It manages the MTU and CAN_CTRLMODE_FD consistency and only allows the
CANFD_MTU when the driver supports it.

Any other things to look at - or is the rest ok so far?

Regards,
Oliver


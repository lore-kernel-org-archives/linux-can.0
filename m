From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 5/5] can: allow to change the device mtu for CAN FD
 capable devices
Date: Tue, 18 Feb 2014 14:08:18 +0100
Message-ID: <53035B42.8030802@hartkopp.net>
References: <1392481934-12569-1-git-send-email-socketcan@hartkopp.net> <1392481934-12569-5-git-send-email-socketcan@hartkopp.net> <52FF9D0C.30406@pengutronix.de> <52FFA3EB.7060902@hartkopp.net> <53033F7D.9090805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:9092 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbaBRNIh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Feb 2014 08:08:37 -0500
In-Reply-To: <53033F7D.9090805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 02/18/2014 12:09 PM, Marc Kleine-Budde wrote:
> On 02/15/2014 06:29 PM, Oliver Hartkopp wrote:
>>> On 02/15/2014 05:32 PM, Oliver Hartkopp wrote:
>>>> The configuration for CAN FD depends on CAN_CTRLMODE_FD enabled in the driver
>>>> specific ctrlmode_supported capabilities.
>>>>
>>>> The configuration can be done either with the 'fd { on | off }' option in the
>>>> 'ip' tool from iproute2 or by setting the CAN netdevice MTU to CAN_MTU (16) or
>>>> to CANFD_MTU (72).
>>>
>>> Please don't add two possibilities to activate canfd on a CAN network
>>> card. There should only be one.
>>
>> Yes it /should/ be like this.
>> I thought about it some time but I didn't find a better solution.
>>
>> The problem is that dev->mtu is the switch for the skb->len whether CAN frames
>> or CAN FD frames are generated or received.
>>
>> The MTU can be modified by 'ip' (independently from CAN specific settings).
>
> It _can_ be modified (directly by the userspace) _if_ the change mtu
> callback is implemented. Maybe we don't need the callback?

We need the callback to check if the setting is allowed.
E.g. to set the MTU to 72 is only allowed for CAN FD capable devices.

Or do you think about *only* switching the MTU via

ip link set can0 type can fd on
ip link set can0 type can fd off

??

This could be an idea too.

Currently the vcan can only be switched via mtu setting to identify CAN 
or CAN FD. But this could be a single and only exception to do it like 
this - as the vcan does not use the CAN driver infrastructure.

>
>> OTOH the only way the CAN devices provide their capabilities is the
>> ctrlmode_supported bitfield - and it does not make sense to provide
>> CAN_CTRLMODE_FD in ctrlmode_supported and do not provide the configuration for it.
>>
>> If you would skip the CAN_CTRLMODE_FD bit in ctrlmode_supported there's no way
>> to identify a CAN FD capable device. You could only try to set the MTU to
>> CANFD_MTU and see, if it fails. Not a good solution either.
>>
>>
>>>> +EXPORT_SYMBOL_GPL(can_change_mtu);
>>>
>>> Who will be the user of this function? The individual network drivers?
>>>
>>
>> Yes. It manages the MTU and CAN_CTRLMODE_FD consistency and only allows the
>> CANFD_MTU when the driver supports it.
>
> And it has to be assigned by a FD capable driver to the net_device_ops,
> right?
>

Yes.

Regards,
Oliver


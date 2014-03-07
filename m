From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: Unify MTU settings for CAN interfaces
Date: Fri, 07 Mar 2014 13:53:18 +0100
Message-ID: <5319C13E.5080103@hartkopp.net>
References: <5319820D.6060104@hartkopp.net> <5319B033.10705@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:15036 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbaCGMxY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Mar 2014 07:53:24 -0500
In-Reply-To: <5319B033.10705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 07.03.2014 12:40, Marc Kleine-Budde wrote:
> On 03/07/2014 09:23 AM, Oliver Hartkopp wrote:
>> CAN interfaces only support MTU values of 16 (CAN 2.0) and 72 (CAN FD).
>> Setting the MTU to other values is pointless but it does not really hurt.
>> With the introduction of the CAN FD support in drivers/net/can a new
>> function to switch the MTU for CAN FD has been introduced.
>>
>> This patch makes use of this can_change_mtu() function to check for correct
>> MTU settings also in legacy CAN (2.0) devices.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
>> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
>> index 3fcdae2..f5b16e0 100644
>> --- a/drivers/net/can/slcan.c
>> +++ b/drivers/net/can/slcan.c
>> @@ -411,10 +411,16 @@ static void slc_free_netdev(struct net_device *dev)
>>  	slcan_devs[i] = NULL;
>>  }
>>  
>> +static int slcan_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +	return -EINVAL;
>> +}
>> +
> 
> Why is the slcan special?

slcan as well as vcan are no users of the CAN driver infrastructure.
No include of dev.h, no bitrate settings, etc.
The only drivers that do not depend from 'config CAN_DEV' in Kconfig.

The -EINVAL error is only thrown when someone tries to move the slcan MTU away
from the only valid CAN_MTU, see:

	http://lxr.free-electrons.com/source/net/core/dev.c#L5324


Regards,
Oliver


From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] [PATCH] can: fix handling of unmodifiable configuration
 options
Date: Wed, 9 Mar 2016 15:28:20 +0100
Message-ID: <56E03304.6020904@hartkopp.net>
References: <1457457221-25068-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB1038C1DC8B2319A22ED7CDB6C3B30@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:54178 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692AbcCIO22 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Mar 2016 09:28:28 -0500
In-Reply-To: <SG2PR06MB1038C1DC8B2319A22ED7CDB6C3B30@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 03/09/2016 10:27 AM, Ramesh Shanmugasundaram wrote:
> Hi Oliver,
> 
> Thanks for the patch.
> 
>> -----Original Message-----
>> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
>> Sent: 08 March 2016 17:14
>> To: linux-can@vger.kernel.org
>> Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>;
>> Oliver Hartkopp <socketcan@hartkopp.net>; linux-stable 3 . 16+
>> <stable@vger.kernel.org>
>> Subject: [RFC] [PATCH] can: fix handling of unmodifiable configuration
>> options
>>
>> As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
>> (6cfda7fbebe) it is possible to define fixed configuration options by
>> setting the according bit in 'ctrlmode' and clear it in
>> 'ctrlmode_supported'.
> 
> Shouldn't we document this? A comment to these variable definitions perhaps?

Yes. Good idea. Will do this in the updated patch.

> 
>> This leads to the incovenience that the fixed configuration can not be
>> passed by netlink (ip tool) even when it has the correct value (e.g. non-
>> ISO, FD).
>>
>> This patch fixes that issue and allows fixed set bit values to be set
>> again which does not change the unmodifiable content.
>>
>> Additionally it fixes the inconsitency that was prohibiting the support of
>> 'CANFD-only' controller drivers.
>>
>> Reported-by: Ramesh Shanmugasundaram
>> <ramesh.shanmugasundaram@bp.renesas.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Cc: linux-stable <stable@vger.kernel.org> 3.16+
>> ---
>>  drivers/net/can/dev.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>> 141c2a4..b084cfd 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -696,11 +696,18 @@ int can_change_mtu(struct net_device *dev, int
>> new_mtu)
>>  	/* allow change of MTU according to the CANFD ability of the device
>> */
>>  	switch (new_mtu) {
>>  	case CAN_MTU:
>> +		/* take care of 'CANFD-only' controllers */
>> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
>> +		    (priv->ctrlmode & CAN_CTRLMODE_FD))
>> +			return -EINVAL;
>> +
>>  		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
>>  		break;
>>
>>  	case CANFD_MTU:
>> -		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
>> +		/* check for CANFD capability */
>> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
>> +		    !(priv->ctrlmode & CAN_CTRLMODE_FD))
>>  			return -EINVAL;
>>
>>  		priv->ctrlmode |= CAN_CTRLMODE_FD;
>> @@ -819,10 +826,13 @@ static int can_changelink(struct net_device *dev,
>>  			return -EBUSY;
>>  		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>>
>> -		/* check whether changed bits are allowed to be modified */
>> -		if (cm->mask & ~priv->ctrlmode_supported)
>> +		/* check whether provided bits are allowed to be passed */
>> +		if (cm->mask & ~(priv->ctrlmode_supported | priv->ctrlmode))
>>  			return -EOPNOTSUPP;
> 
> I think we need to separate this check into two. Otherwise, it will still return success for "fd off" config even though the configuration is not really applied.

Yes. I'll re-think this check. Your "fd off" use-case is a good case to take
care about.

> 
>>
>> +		/* reduce to bits that are allowed to be modified */
>> +		cm->mask &= priv->ctrlmode_supported;
> 
> If we separate the above check, I think we don't have to do this.

At least I'll make it a separate variable, so that the netlink data remains
read-only.

Thanks,
Oliver


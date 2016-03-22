From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5] can: fix handling of unmodifiable configuration
 options
Date: Tue, 22 Mar 2016 16:07:15 +0100
Message-ID: <56F15FA3.7050605@hartkopp.net>
References: <1458587901-7565-1-git-send-email-socketcan@hartkopp.net>
 <SG2PR06MB103893EEDAF071B73AA6D062C3800@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:61699 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCVPHd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Mar 2016 11:07:33 -0400
In-Reply-To: <SG2PR06MB103893EEDAF071B73AA6D062C3800@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

please add

Reviewed-by: Ramesh Shanmugasundaram 
<ramesh.shanmugasundaram@bp.renesas.com>

and keep

Cc: <stable@vger.kernel.org> # >= 3.18

as we already had for the v3 version of this patch:
http://marc.info/?l=linux-can&m=145803377520236&w=2

Best regards,
Oliver

ps. I'm also fine with the CAN FD specific stuff of the latest (v4) RCar 
CAN FD driver - but it's too little review from my side to add a 
reviewed-by IMO.


On 03/22/2016 08:52 AM, Ramesh Shanmugasundaram wrote:
> Hi Oliver,
>
> Thanks for the patch. It looks good to me.
>
> Thanks,
> Ramesh
>
>> -----Original Message-----
>> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
>> Sent: 21 March 2016 19:18
>> To: linux-can@vger.kernel.org
>> Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>;
>> Oliver Hartkopp <socketcan@hartkopp.net>
>> Subject: [PATCH v5] can: fix handling of unmodifiable configuration
>> options
>>
>> As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
>> (6cfda7fbebe) it is possible to define fixed configuration options by
>> setting the according bit in 'ctrlmode' and clear it in
>> 'ctrlmode_supported'.
>> This leads to the incovenience that the fixed configuration bits can not
>> be passed by netlink even when they have the correct values (e.g. non-ISO,
>> FD).
>>
>> This patch fixes that issue and not only allows fixed set bit values to be
>> set again but now requires(!) to provide these fixed values at
>> configuration time.
>> A valid CAN FD configuration consists of a nominal/arbitration bittiming,
>> a data bittiming and a control mode with CAN_CTRLMODE_FD set - which is
>> now enforced by a new can_validate() function. This fix additionally
>> removed the inconsistency that was prohibiting the support of 'CANFD-only'
>> controller drivers, like the RCar CAN FD.
>>
>> For this reason a new helper can_set_static_ctrlmode() has been introduced
>> to provide a proper interface to handle static enabled CAN controller
>> options.
>>
>> Reported-by: Ramesh Shanmugasundaram
>> <ramesh.shanmugasundaram@bp.renesas.com>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   drivers/net/can/dev.c         | 56
>> +++++++++++++++++++++++++++++++++++++++----
>>   drivers/net/can/m_can/m_can.c |  2 +-
>>   include/linux/can/dev.h       | 22 +++++++++++++++--
>>   3 files changed, 73 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>> 141c2a4..9bec2cd 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -696,11 +696,17 @@ int can_change_mtu(struct net_device *dev, int
>> new_mtu)
>>   	/* allow change of MTU according to the CANFD ability of the device
>> */
>>   	switch (new_mtu) {
>>   	case CAN_MTU:
>> +		/* 'CANFD-only' controllers can not switch to CAN_MTU */
>> +		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
>> +			return -EINVAL;
>> +
>>   		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
>>   		break;
>>
>>   	case CANFD_MTU:
>> -		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
>> +		/* check for potential CANFD ability */
>> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
>> +		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
>>   			return -EINVAL;
>>
>>   		priv->ctrlmode |= CAN_CTRLMODE_FD;
>> @@ -782,6 +788,35 @@ static const struct nla_policy
>> can_policy[IFLA_CAN_MAX + 1] = {
>>   				= { .len = sizeof(struct can_bittiming_const) },
>> };
>>
>> +static int can_validate(struct nlattr *tb[], struct nlattr *data[]) {
>> +	u32 is_can_fd = 0;
>> +
>> +	/* Make sure that valid CAN FD configurations always consist of
>> +	 * - nominal/arbitration bittiming
>> +	 * - data bittiming
>> +	 * - control mode with CAN_CTRLMODE_FD set
>> +	 */
>> +
>> +	if (data[IFLA_CAN_CTRLMODE]) {
>> +		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>> +
>> +		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
>> +	}
>> +
>> +	if (is_can_fd) {
>> +		if (!data[IFLA_CAN_BITTIMING] ||
>> !data[IFLA_CAN_DATA_BITTIMING])
>> +			return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (data[IFLA_CAN_DATA_BITTIMING]) {
>> +		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
>> +			return -EOPNOTSUPP;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int can_changelink(struct net_device *dev,
>>   			  struct nlattr *tb[], struct nlattr *data[])  { @@ -
>> 813,19 +848,31 @@ static int can_changelink(struct net_device *dev,
>>
>>   	if (data[IFLA_CAN_CTRLMODE]) {
>>   		struct can_ctrlmode *cm;
>> +		u32 ctrlstatic;
>> +		u32 maskedflags;
>>
>>   		/* Do not allow changing controller mode while running */
>>   		if (dev->flags & IFF_UP)
>>   			return -EBUSY;
>>   		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
>> +		ctrlstatic = priv->ctrlmode_static;
>> +		maskedflags = cm->flags & cm->mask;
>> +
>> +		/* check whether provided bits are allowed to be passed */
>> +		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
>> +			return -EOPNOTSUPP;
>> +
>> +		/* do not check for static fd-non-iso if 'fd' is disabled */
>> +		if (!(maskedflags & CAN_CTRLMODE_FD))
>> +			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
>>
>> -		/* check whether changed bits are allowed to be modified */
>> -		if (cm->mask & ~priv->ctrlmode_supported)
>> +		/* make sure static options are provided by configuration */
>> +		if ((maskedflags & ctrlstatic) != ctrlstatic)
>>   			return -EOPNOTSUPP;
>>
>>   		/* clear bits to be modified and copy the flag values */
>>   		priv->ctrlmode &= ~cm->mask;
>> -		priv->ctrlmode |= (cm->flags & cm->mask);
>> +		priv->ctrlmode |= maskedflags;
>>
>>   		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
>>   		if (priv->ctrlmode & CAN_CTRLMODE_FD) @@ -966,6 +1013,7 @@
>> static struct rtnl_link_ops can_link_ops __read_mostly = {
>>   	.maxtype	= IFLA_CAN_MAX,
>>   	.policy		= can_policy,
>>   	.setup		= can_setup,
>> +	.validate	= can_validate,
>>   	.newlink	= can_newlink,
>>   	.changelink	= can_changelink,
>>   	.get_size	= can_get_size,
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> index 39cf911..195f15e 100644
>> --- a/drivers/net/can/m_can/m_can.c
>> +++ b/drivers/net/can/m_can/m_can.c
>> @@ -955,7 +955,7 @@ static struct net_device *alloc_m_can_dev(void)
>>   	priv->can.do_get_berr_counter = m_can_get_berr_counter;
>>
>>   	/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.1 */
>> -	priv->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
>> +	can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
>>
>>   	/* CAN_CTRLMODE_FD_NON_ISO can not be changed with M_CAN IP v3.0.1
>> */
>>   	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK | diff --git
>> a/include/linux/can/dev.h b/include/linux/can/dev.h index 735f9f8..098243b
>> 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -40,8 +40,11 @@ struct can_priv {
>>   	struct can_clock clock;
>>
>>   	enum can_state state;
>> -	u32 ctrlmode;
>> -	u32 ctrlmode_supported;
>> +
>> +	/* CAN controller features - see include/uapi/linux/can/netlink.h */
>> +	u32 ctrlmode;		/* current options setting */
>> +	u32 ctrlmode_supported;	/* options that can be modified by netlink
>> */
>> +	u32 ctrlmode_static;	/* static enabled options for
>> driver/hardware */
>>
>>   	int restart_ms;
>>   	struct timer_list restart_timer;
>> @@ -108,6 +111,21 @@ static inline bool can_is_canfd_skb(const struct
>> sk_buff *skb)
>>   	return skb->len == CANFD_MTU;
>>   }
>>
>> +/* helper to define static CAN controller features at device creation
>> +time */ static inline void can_set_static_ctrlmode(struct net_device
>> *dev,
>> +					   const u32 static_mode)
>> +{
>> +	struct can_priv *priv = netdev_priv(dev);
>> +
>> +	/* alloc_candev() succeeded => netdev_priv() is valid at this point
>> */
>> +	priv->ctrlmode = static_mode;
>> +	priv->ctrlmode_static = static_mode;
>> +
>> +	/* override MTU which was set by default in can_setup()? */
>> +	if (static_mode & CAN_CTRLMODE_FD)
>> +		dev->mtu = CANFD_MTU;
>> +}
>> +
>>   /* get data length from can_dlc with sanitized can_dlc */
>>   u8 can_dlc2len(u8 can_dlc);
>>
>> --
>> 2.7.0
>

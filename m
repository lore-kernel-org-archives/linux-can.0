From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add CAN interface termination API
Date: Thu, 12 Jan 2017 09:28:33 +0100
Message-ID: <5a6466b5-9015-4e62-cabe-9cce491c950b@hartkopp.net>
References: <20170111152758.3578-1-mkl@pengutronix.de>
 <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:36954 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdALI2l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2017 03:28:41 -0500
In-Reply-To: <HK2PR06MB05459122CBD7F49D3491BC67C3790@HK2PR06MB0545.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 01/12/2017 09:03 AM, Ramesh Shanmugasundaram wrote:
> HI Oliver, Marc,
>
>> Subject: [PATCH] can: add CAN interface termination API
>>
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> This patch adds a netlink interface to configure the CAN bus termination
>> of CAN interfaces.
>>
>> Inside the driver an array of supported termination values is defined:
>>
>> const u16 drvname_termination[] = { 60, 120, CAN_TERMINATION_DISABLED };
>>
>> struct drvname_priv *priv;
>> priv = netdev_priv(dev);
>>
>> priv->termination_const = &drvname_termination; termination_const_cnt =
>> priv->ARRAY_SIZE(drvname_termination);
>> priv->termination = CAN_TERMINATION_DISABLED;
>>
>> And the funtion to set the value has to be defined:
>>
>> priv->do_set_termination = drvname_set_termination;
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> picking up Oliver's work.
>>
>> Changes since v3:
>> - can_changelink: use "const".
>> - register_candev: add consistency check for termination_const and
>> termination_const_cnt
>> - can_get_size & can_fill_info: remove check for termination_const_cnt
>> - can_get_size: reorder to match IFLA_CAN_ enum.
>> - can_get_size & can_fill_info: convert sizeof(u16) to use appropriate
>> member of struct can_priv.
>> - can_fill_info: use || to chain multiple nla_put.
>
> These are nice additions.
> One minor comment further down. Otherwise
>
> Reviewed-by: Ramesh Shanmugasundaram <Ramesh.shanmugasundaram@bp.renesas.com>
>
>>
>>  drivers/net/can/dev.c            | 48
>> +++++++++++++++++++++++++++++++++++++++-
>>  include/linux/can/dev.h          |  4 ++++
>>  include/uapi/linux/can/netlink.h |  5 +++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>> c240cd9f823b..254183e5baf9 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -978,6 +978,30 @@ static int can_changelink(struct net_device *dev,
>>  		}
>>  	}
>>
>> +	if (data[IFLA_CAN_TERMINATION]) {
>> +		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>> +		const int num_term = priv->termination_const_cnt;
>> +		int i;
>
> The above two definitions can be unsigned int.

Yes.

>
>> +
>> +		if (!priv->do_set_termination)
>> +			return -EOPNOTSUPP;
>> +
>
> Do we need a check for IFF_UP flag here or is it up to the do_set_termination call?

IMO we do not need to check of IFF_UP.
Ist does not really affect the tricky CAN controller configuration.

Regards,
Oliver


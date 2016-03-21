From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [RFC] [PATCH v4] can: fix handling of unmodifiable configuration
 options
Date: Mon, 21 Mar 2016 08:37:07 +0000
Message-ID: <SG2PR06MB10388D08005F04DAD837A02DC38F0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1458374870-5380-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:34813 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751371AbcCUIhO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 04:37:14 -0400
In-Reply-To: <1458374870-5380-1-git-send-email-socketcan@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thanks for the patch.

> -----Original Message-----
> From: Oliver Hartkopp [mailto:socketcan@hartkopp.net]
> Sent: 19 March 2016 08:08
> To: linux-can@vger.kernel.org
> Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>;
> Oliver Hartkopp <socketcan@hartkopp.net>
> Subject: [RFC] [PATCH v4] can: fix handling of unmodifiable configuration
> options
> 
> As described in 'can: m_can: tag current CAN FD controllers as non-ISO'
> (6cfda7fbebe) it is possible to define fixed configuration options by
> setting the according bit in 'ctrlmode' and clear it in
> 'ctrlmode_supported'.
> This leads to the incovenience that the fixed configuration bits can not
> be passed by netlink even when they have the correct values (e.g. non-ISO,
> FD).
> 
> This patch fixes that issue and not only allows fixed set bit values to be
> set again but now requires(!) to provide these fixed values at
> configuration time.
> A valid CAN FD configuration consists of a nominal/arbitration bittiming,
> a data bittiming and a control mode with CAN_CTRLMODE_FD set - which is
> now enforced by a new can_validate() function. This fix additionally
> removed the inconsistency that was prohibiting the support of 'CANFD-only'
> controller drivers, like the RCar CAN FD.
> 
> For this reason a new helper can_set_static_ctrlmode() has been introduced
> to provide a proper interface to handle static enabled CAN controller
> options.
> 
> Reported-by: Ramesh Shanmugasundaram
> <ramesh.shanmugasundaram@bp.renesas.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  drivers/net/can/dev.c         | 49
> ++++++++++++++++++++++++++++++++++++++++---
>  drivers/net/can/m_can/m_can.c |  2 +-
>  include/linux/can/dev.h       | 22 +++++++++++++++++--
>  3 files changed, 67 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
> 141c2a4..854ace78 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -696,11 +696,17 @@ int can_change_mtu(struct net_device *dev, int
> new_mtu)
>  	/* allow change of MTU according to the CANFD ability of the device
> */
>  	switch (new_mtu) {
>  	case CAN_MTU:
> +		/* 'CANFD-only' controllers can not switch to CAN_MTU */
> +		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
> +			return -EINVAL;
> +
>  		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
>  		break;
> 
>  	case CANFD_MTU:
> -		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD))
> +		/* check for potential CANFD ability */
> +		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
> +		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
>  			return -EINVAL;
> 
>  		priv->ctrlmode |= CAN_CTRLMODE_FD;
> @@ -782,6 +788,36 @@ static const struct nla_policy
> can_policy[IFLA_CAN_MAX + 1] = {
>  				= { .len = sizeof(struct can_bittiming_const) },
> };
> 
> +static int can_validate(struct nlattr *tb[], struct nlattr *data[]) {
> +	u32 is_can_fd = 0;
> +
> +	/*
> +	 * Make sure that valid CAN FD configurations always consist of
> +	 * - nominal/arbitration bittiming
> +	 * - data bittiming
> +	 * - control mode with CAN_CTRLMODE_FD set
> +	 */

This comment style prompts WARNING in latest checkpatch.pl in case you plan to submit in linux-can-next. Otherwise

Reviewed-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks,
Ramesh

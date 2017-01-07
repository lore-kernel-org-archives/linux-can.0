From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Sat, 7 Jan 2017 14:22:36 +0100
Message-ID: <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
References: <20170106125344.15267-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:25358 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdAGNWr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 7 Jan 2017 08:22:47 -0500
In-Reply-To: <20170106125344.15267-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi Marc,

On 01/06/2017 01:53 PM, Marc Kleine-Budde wrote:

> @@ -872,10 +868,22 @@ static int can_changelink(struct net_device *dev,
>  		/* Do not allow changing bittiming while running */
>  		if (dev->flags & IFF_UP)
>  			return -EBUSY;
> +
> +		/* Calculate bittiming parameters based on
> +		 * bittiming_const if set, otherwise pass bitrate
> +		 * directly via do_set_bitrate(). Bail out if neither
> +		 * is given.
> +		 */
> +		if (!priv->bittiming_const && !priv->do_set_bittiming)
> +			return -EOPNOTSUPP;
> +

I would suggest to remove this check and the comment here and better add 
an else path with

	return -EOPNOTSUPP;
at
	if (priv->do_set_bittiming) { } else ...


>  		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
> -		err = can_get_bittiming(dev, &bt, priv->bittiming_const);
> -		if (err)
> -			return err;
> +		if (priv->bittiming_const) {
> +			err = can_get_bittiming(dev, &bt,
> +						priv->bittiming_const);
> +			if (err)
> +				return err;
> +		}
>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
>
>  		if (priv->do_set_bittiming) {
> @@ -943,11 +951,23 @@ static int can_changelink(struct net_device *dev,
>  		/* Do not allow changing bittiming while running */
>  		if (dev->flags & IFF_UP)
>  			return -EBUSY;
> +
> +		/* Calculate bittiming parameters based on
> +		 * data_bittiming_const if set, otherwise pass bitrate
> +		 * directly via do_set_bitrate(). Bail out if neither
> +		 * is given.
> +		 */
> +		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
> +			return -EOPNOTSUPP;
> +
>  		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
>  		       sizeof(dbt));
> -		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
> -		if (err)
> -			return err;
> +		if (priv->data_bittiming_const) {
> +			err = can_get_bittiming(dev, &dbt,
> +						priv->data_bittiming_const);
> +			if (err)
> +				return err;
> +		}
>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>
>  		if (priv->do_set_data_bittiming) {
>

dito here.

Maybe this leads to two patches then:

1. Introduce the -EOPNOTSUPP for missing do_set[_data]_bittiming
2. Allow to set bitrates without providing bittiming_const

Regards,
Oliver

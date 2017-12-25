From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] flex_can: Fix checking can_dlc
Date: Mon, 25 Dec 2017 12:38:11 +0100
Message-ID: <486344fc-f4cf-6311-ab83-ecf9958d16e9@hartkopp.net>
References: <1513672833-28402-1-git-send-email-phu.luuan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1513672833-28402-1-git-send-email-phu.luuan@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Luu An Phu <phu.luuan@nxp.com>, wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, stefan-gabriel.mirea@nxp.com
List-Id: linux-can.vger.kernel.org

This patch looks wrong to me.

On 12/19/2017 09:40 AM, Luu An Phu wrote:
> From: "phu.luuan" <phu.luuan@nxp.com>
> 
> flexcan_start_xmit should write data to register when can_dlc > 4.
> Because can_dlc is data length and it has value from 1 to 8.

No. can_dlc can contain values from 0 to 8. Even 0 is a valid DLC.

> But CAN data
> index has value from 0 to 7. So in case we have data in cf->data[4],
> the can_dlc has value is more than 4.
> 
> Signed-off-by: Luu An Phu <phu.luuan@nxp.com>
> ---
>   drivers/net/can/flexcan.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0626dcf..0e3ff13 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2009 Sascha Hauer, Pengutronix
>    * Copyright (c) 2010-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
>    * Copyright (c) 2014 David Jander, Protonic Holland
> + * Copyright 2017 NXP
>    *
>    * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
>    *
> @@ -526,7 +527,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   		data = be32_to_cpup((__be32 *)&cf->data[0]);
>   		flexcan_write(data, &priv->tx_mb->data[0]);
>   	}
> -	if (cf->can_dlc > 3) {

This is correct as data[0 .. 3] are filled from the code above. And if 
can_dlc is greater than 3 (== 4 .. 8) the following 4 bytes are copied 
into the registers.

So everything is correct with the current code.

> +	if (cf->can_dlc > 4) {
>   		data = be32_to_cpup((__be32 *)&cf->data[4]);
>   		flexcan_write(data, &priv->tx_mb->data[1]);
>   	}
> 

Regards,
Oliver

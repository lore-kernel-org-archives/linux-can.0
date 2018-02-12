From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: [PATCH v2 1/3] can: cc770: Remove redundant IRQ ack
Date: Mon, 12 Feb 2018 20:41:48 +0100
Message-ID: <2795059.IeN8S1rsHy@blindfold>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lilium.sigma-star.at ([109.75.188.150]:59988 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBLTkf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Feb 2018 14:40:35 -0500
In-Reply-To: <20180130165649.22732-1-andri.yngvason@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

Andri,

Am Dienstag, 30. Januar 2018, 17:56:47 CET schrieb Andri Yngvason:
> This has been reported to cause stalls on rt-linux.
> 
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/cc770/cc770.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index 1e37313..9fed163 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -447,15 +447,6 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff
> *skb, struct net_device *dev)
> 
>  	stats->tx_bytes += dlc;
> 
> -
> -	/*
> -	 * HM: We had some cases of repeated IRQs so make sure the
> -	 * INT is acknowledged I know it's already further up, but
> -	 * doing again fixed the issue
> -	 */
> -	cc770_write_reg(priv, msgobj[mo].ctrl0,
> -			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
> -
>  	return NETDEV_TX_OK;
>  }
> 
> @@ -684,12 +675,6 @@ static void cc770_tx_interrupt(struct net_device *dev,
> unsigned int o) /* Nothing more to send, switch off interrupts */
>  	cc770_write_reg(priv, msgobj[mo].ctrl0,
>  			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
> -	/*
> -	 * We had some cases of repeated IRQ so make sure the
> -	 * INT is acknowledged
> -	 */
> -	cc770_write_reg(priv, msgobj[mo].ctrl0,
> -			MSGVAL_UNC | TXIE_UNC | RXIE_UNC | INTPND_RES);
> 
>  	stats->tx_packets++;
>  	can_get_echo_skb(dev, 0);

I saw that stalls too.
But instead of just removing these writes I suggest adding a quirk for the can 
card where they cause trouble.
Maybe Wolfgang can give more details why they are here.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

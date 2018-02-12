From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: [PATCH v2 2/3] can: cc770: Stop queue on NETDEV_TX_BUSY
Date: Mon, 12 Feb 2018 20:40:41 +0100
Message-ID: <2260026.6LYqVhIflL@blindfold>
References: <20180130165649.22732-1-andri.yngvason@marel.com> <20180130165649.22732-2-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lilium.sigma-star.at ([109.75.188.150]:59946 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeBLTjf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Feb 2018 14:39:35 -0500
In-Reply-To: <20180130165649.22732-2-andri.yngvason@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com

Andri,

Am Dienstag, 30. Januar 2018, 17:56:48 CET schrieb Andri Yngvason:
> If the queue is not stopped, the start_xmit function will continue to be
> called until the driver or the system is reset.
> 
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
> ---
>  drivers/net/can/cc770/cc770.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index 9fed163..12d3b89 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -405,6 +405,7 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb,
> struct net_device *dev)
> 
>  	if ((cc770_read_reg(priv,
>  			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
> +		netif_stop_queue(dev);
>  		netdev_err(dev, "TX register is still occupied!\n");
>  		return NETDEV_TX_BUSY;
>  	}

I see that some can drivers stop the queue, others not.
What exactly is the problem in this case?

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

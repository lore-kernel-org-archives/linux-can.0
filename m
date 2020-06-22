From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp25xxfd: add listen-only mode
Date: Mon, 22 Jun 2020 15:38:03 +0200
Message-ID: <24a81519-9628-6626-77e6-22dbd5253954@pengutronix.de>
References: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbgFVNiH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 09:38:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF82C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 06:38:07 -0700 (PDT)
In-Reply-To: <20200622122047.9494-1-dev.kurt@vandijck-laurijssen.be>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can@vger.kernel.org

On 6/22/20 2:20 PM, Kurt Van Dijck wrote:
> This commit enables listen-only mode, which works internally like CANFD mode.

Does the controller distinguish between CAN-2.0 listen only and CAN-FD listen
only mode?

If listen only means CAN-FD...should we add a check to open() if CAN_CTRLMODE_FD
and CAN_CTRLMODE_LISTENONLY is both set (or unset).

Please compile with #define DEBUG and look in dmesg the size of the objects in
the mailbox. Maybe it's worth not allocating any TEF and TX mailbox and using
more RX instead.

We have to convert the driver from using a bit mask to modulo to get from the
tail and head to the actual index inside the RAM.

> Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> ---
>  drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> index c744a0bf2faa..f3bc7d0f1f94 100644
> --- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> +++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
> @@ -392,7 +392,8 @@ static int mcp25xxfd_ring_alloc(struct mcp25xxfd_priv *priv)
>  	int ram_free, i;
>  
>  	tef_obj_size = sizeof(struct mcp25xxfd_hw_tef_obj);
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> +	/* listen-only mode works like FD mode */
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY)) {
>  		tx_obj_num = MCP25XXFD_TX_OBJ_NUM_CANFD;
>  		tx_obj_size = sizeof(struct mcp25xxfd_hw_tx_obj_canfd);
>  		rx_obj_size = sizeof(struct mcp25xxfd_hw_rx_obj_canfd);
> @@ -807,7 +808,7 @@ mcp25xxfd_chip_rx_fifo_init_one(const struct mcp25xxfd_priv *priv,
>  		MCP25XXFD_REG_FIFOCON_RXOVIE |
>  		MCP25XXFD_REG_FIFOCON_TFNRFNIE;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
>  		fifo_con |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
>  				       MCP25XXFD_REG_FIFOCON_PLSIZE_64);
>  	else
> @@ -857,7 +858,7 @@ static int mcp25xxfd_chip_fifo_init(const struct mcp25xxfd_priv *priv)
>  		MCP25XXFD_REG_FIFOCON_TXEN |
>  		MCP25XXFD_REG_FIFOCON_TXATIE;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_LISTENONLY))
>  		val |= FIELD_PREP(MCP25XXFD_REG_FIFOCON_PLSIZE_MASK,
>  				  MCP25XXFD_REG_FIFOCON_PLSIZE_64);
>  	else
> @@ -930,7 +931,9 @@ static u8 mcp25xxfd_get_normal_mode(const struct mcp25xxfd_priv *priv)
>  {
>  	u8 mode;
>  
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		mode = MCP25XXFD_REG_CON_MODE_LISTENONLY;
> +	else if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
>  		mode = MCP25XXFD_REG_CON_MODE_MIXED;
>  	else
>  		mode = MCP25XXFD_REG_CON_MODE_CAN2_0;
> @@ -2778,6 +2781,7 @@ static int mcp25xxfd_probe(struct spi_device *spi)
>  	priv->can.bittiming_const = &mcp25xxfd_bittiming_const;
>  	priv->can.data_bittiming_const = &mcp25xxfd_data_bittiming_const;
>  	priv->can.ctrlmode_supported = CAN_CTRLMODE_FD |
> +		CAN_CTRLMODE_LISTENONLY |
>  		CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD_NON_ISO;

please sort this list following (I know it currently isn't):

https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/can/netlink.h#L95

>  	priv->ndev = ndev;
>  	priv->spi = spi;
> 

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

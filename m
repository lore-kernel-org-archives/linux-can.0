From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Wed, 02 Apr 2014 19:21:12 +0200
Message-ID: <533C4708.8030600@hartkopp.net>
References: <1396423121-28949-1-git-send-email-sbabic@denx.de> <1396423121-28949-3-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:16150 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932305AbaDBRVR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 13:21:17 -0400
In-Reply-To: <1396423121-28949-3-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hello Stefano,

On 02.04.2014 09:18, Stefano Babic wrote:

> +
> +/* CFG message */
> +struct msg_cfg_data {
> +	u8	channel;
> +	u8	enabled;
> +	struct can_bittiming bt;
> +} __packed;


> +static int spi_can_probe(struct spi_device *spi)
> +{

(..)

> +
> +		/* Set CAN specific parameters */
> +		priv->can.clock.freq = SLAVE_CLK_FREQ;
> +		priv->can.bittiming_const = NULL;
> +		priv->can.do_set_mode = spi_can_set_mode;
> +		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +			CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES;

This looks wrong to me.

In the one case (ctrlmode_supported) you aim to know about the SPI CAN
controllers e.g. if they support LISTENONLY.

In the other case (bittiming_const) you don't know anything about the
controller??

How do you set the bitrate without defining bittiming_const??
And how does

	ip -det link show can0

look like for your device then?

Setting the bitrate with the ip tools requires bittiming_const to be set:

http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/tree/drivers/net/can/dev.c#n252

IMO both ctrlmode_supported and bittiming_const need to be retrieved from
each remote SPI attached CAN controller at startup initialization time.
So that the configuration can be done with the standard tools.

Regards,
Oliver


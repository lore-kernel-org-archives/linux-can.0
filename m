From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 2/2] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Wed, 29 Oct 2014 21:57:34 +0100
Message-ID: <545154BE.8000603@hartkopp.net>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de> <1406565510-10783-3-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:56030 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaJ2U5h (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Oct 2014 16:57:37 -0400
In-Reply-To: <1406565510-10783-3-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 28.07.2014 18:38, Stefano Babic wrote:

> --- a/drivers/net/can/spi/Makefile
> +++ b/drivers/net/can/spi/Makefile
> @@ -4,5 +4,6 @@
>
>
>   obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
> +obj-$(CONFIG_CAN_SPI)		+= spi_can.o
>
>   ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG

This ccflags stuff already has been remove - so it needs a tiny rebase here.
Sorry.

> diff --git a/drivers/net/can/spi/spi_can.c b/drivers/net/can/spi/spi_can.c
> new file mode 100644
> index 0000000..087e6b7
> --- /dev/null
> +++ b/drivers/net/can/spi/spi_can.c


> +struct msg_cfg_get_data {
> +	u8	channel;
> +	u8	tseg1_min;
> +	u8	tseg1_max;
> +	u8	tseg2_min;
> +	u8	tseg2_max;
> +	u8	sjw_max;
> +	u32	brp_min;
> +	u32	brp_max;
> +	u32	brp_inc;
> +	u8	ctrlmode;

u32 ?


> +static int spi_can_hwtstamp_ioctl(struct net_device *netdev,
> +			struct ifreq *ifr, int cmd)
> +{
> +	struct hwtstamp_config config;
> +
> +	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> +		return -EFAULT;
> +
> +	if (config.flags)
> +		return -EINVAL;
> +
> +	switch (config.tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config.rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		break;
> +	default:
> +		config.rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	}
> +
> +	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
> +		-EFAULT : 0;
> +}
> +
> +static int spi_can_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	if (!netif_running(dev))
> +		return -EINVAL;
> +
> +	if (cmd == SIOCSHWTSTAMP)
> +		return spi_can_hwtstamp_ioctl(dev, rq, cmd);
> +
> +	return -EINVAL;
> +}

What is this ioctl() intended for?

Can this be handled by the standard Linux configuration interface for hardware 
timestamping?


Finally I would like to ask you about IFF_ECHO support (again).
I know that you had some concerns about the SPI performance when putting the 
sent CAN frame into the SPI receive path.

But I would at least suggest to make the SPI message interface capable to 
support IFF_ECHO on the slave CPU. E.g. by sending some index (!=0) from an 
echo skb store to/from the slave to detect originated frames in the receive path.

The SPI slave should announce if it supports IFF_ECHO. And some 8 bit value 
which goes down to the slave and is received together with a CAN frame would 
help to detect local frames.

Probably we can also use the high nibble from the dlc for that.

Regards,
Oliver


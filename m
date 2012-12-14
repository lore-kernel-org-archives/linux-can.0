From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v7] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 14 Dec 2012 13:53:51 +0100
Message-ID: <50CB215F.9080903@grandegger.com>
References: <1355424053-608-1-git-send-email-krumboeck@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49201 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab2LNMxz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 07:53:55 -0500
In-Reply-To: <1355424053-608-1-git-send-email-krumboeck@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <b.krumboeck@gmail.com>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

On 12/13/2012 07:40 PM, Bernd Krumboeck wrote:
> Add device driver for USB2CAN interface from "8 devices" (http://www.8devices.com).
> 
> changes since v6:
> * changed some variable types to big endian equivalent
> * small cleanups
> 
> changes since v5:
> * unlock mutex on error
> 
> changes since v4:
> * removed FSF address
> * renamed struct usb_8dev
> * removed unused variable free_slots
> * replaced some _to_cpu functions with pointer equivalent
> * fix return value for usb_8dev_set_mode
> * handle can errors with separate function
> * fix overrun error handling
> * rewrite error handling for usb_8dev_start_xmit
> * fix urb submit in usb_8dev_start
> * various small fixes
> 
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
> ---
>  drivers/net/can/usb/Kconfig    |    6 +
>  drivers/net/can/usb/Makefile   |    1 +
>  drivers/net/can/usb/usb_8dev.c | 1094 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1101 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb_8dev.c
> 
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2162233 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>  	  This driver supports the PCAN-USB and PCAN-USB Pro adapters
>  	  from PEAK-System Technik (http://www.peak-system.com).
>  
> +config CAN_8DEV_USB
> +	tristate "8 devices USB2CAN interface"
> +	---help---
> +	  This driver supports the USB2CAN interface
> +	  from 8 devices (http://www.8devices.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index 80a2ee4..becef46 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
>  obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
> +obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
>  
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
> new file mode 100644
> index 0000000..d9c681b
> --- /dev/null
> +++ b/drivers/net/can/usb/usb_8dev.c
...
> +/* Read error/status frames */
> +static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
> +				struct usb_8dev_rx_msg *msg)
> +{
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	struct net_device_stats *stats = &priv->netdev->stats;
> +
> +	/*
> +	 * Error message:
> +	 * byte 0: Status
> +	 * byte 1: bit   7: Receive Passive
> +	 * byte 1: bit 0-6: Receive Error Counter
> +	 * byte 2: Transmit Error Counter
> +	 * byte 3: Always 0 (maybe reserved for future use)
> +	 */
> +
> +	u8 state = msg->data[0];
> +	u8 rxerr = msg->data[1] & USB_8DEV_RP_MASK;
> +	u8 txerr = msg->data[2];
> +	int rx_errors = 0;
> +	int tx_errors = 0;
> +
> +	skb = alloc_can_err_skb(priv->netdev, &cf);
> +	if (!skb)
> +		return;
> +
> +	switch (state) {
> +	case USB_8DEV_STATUSMSG_OK:
> +		priv->can.state = CAN_STATE_ERROR_ACTIVE;
> +		cf->can_id |= CAN_ERR_PROT;
> +		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> +		break;
> +	case USB_8DEV_STATUSMSG_BUSOFF:
> +		priv->can.state = CAN_STATE_BUS_OFF;
> +		cf->can_id |= CAN_ERR_BUSOFF;
> +		can_bus_off(priv->netdev);
> +		break;
> +	case USB_8DEV_STATUSMSG_OVERRUN:
> +	case USB_8DEV_STATUSMSG_BUSLIGHT:
> +	case USB_8DEV_STATUSMSG_BUSHEAVY:
> +		cf->can_id |= CAN_ERR_CRTL;
> +		break;
> +	default:
> +		priv->can.state = CAN_STATE_ERROR_WARNING;
> +		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +		priv->can.can_stats.bus_error++;
> +		break;
> +	}
> +
> +	switch (state) {
> +	case USB_8DEV_STATUSMSG_ACK:
> +		cf->can_id |= CAN_ERR_ACK;
> +		tx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_CRC:
> +		cf->data[2] |= CAN_ERR_PROT_BIT;

For the time being please use here:

		cf->data[2] |= CAN_ERR_PROT_UNSPEC;
		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
                               CAN_ERR_PROT_LOC_CRC_DEL;


That's a weak point. A "CAN_ERR_PROT_CRC" is missing. Unfortunately, all
bits in data[3] are already used. Anyway, I'm going to look for a
consistent solution ASAP.

> +		rx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_BIT0:
> +		cf->data[2] |= CAN_ERR_PROT_BIT0;
> +		tx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_BIT1:
> +		cf->data[2] |= CAN_ERR_PROT_BIT1;
> +		tx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_FORM:
> +		cf->data[2] |= CAN_ERR_PROT_FORM;
> +		rx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_STUFF:
> +		cf->data[2] |= CAN_ERR_PROT_STUFF;
> +		rx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_OVERRUN:
> +		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> +		stats->rx_over_errors++;
> +		rx_errors = 1;
> +		break;
> +	case USB_8DEV_STATUSMSG_BUSLIGHT:
> +		priv->can.state = CAN_STATE_ERROR_WARNING;
> +		cf->data[1] = (txerr > rxerr) ?
> +			CAN_ERR_CRTL_TX_WARNING :
> +			CAN_ERR_CRTL_RX_WARNING;
> +		priv->can.can_stats.error_warning++;
> +		break;
> +	case USB_8DEV_STATUSMSG_BUSHEAVY:
> +		priv->can.state = CAN_STATE_ERROR_WARNING;

s/WARNING/PASSIVE/ ?

You can add my "Acked-by: Wolfgang Grandegger <wg@grandegger.com>" after
fixing these issues.

Thanks,

Wolfgang.


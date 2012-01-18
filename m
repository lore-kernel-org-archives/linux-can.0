From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 3/3 v2] can/usb: PEAK-System Technik PCAN-USB Pro specific
 part
Date: Wed, 18 Jan 2012 14:41:16 +0100
Message-ID: <4F16CBFC.1060207@grandegger.com>
References: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com> <1326468404-19330-4-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60030 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab2ARNlT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2012 08:41:19 -0500
In-Reply-To: <1326468404-19330-4-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 01/13/2012 04:26 PM, Stephane Grosjean wrote:
> This patch adds the specific part which handles the PCAN-USB Pro adapter
> from PEAK-System Technik (http://www.peak-system.com). The PCAN-USB Pro
> adapter is a dual-channel USB 2.0 adapter compliant with CAN specifications
>  2.0A (11-bit ID) and 2.0B (29-bit ID).
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Tested-by: Stephane Grosjean <s.grosjean@peak-system.com>

Please remove "Tested-by" here as well.

> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c |  948 +++++++++++++++++++++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h |  178 +++++
>  2 files changed, 1126 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.c
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> new file mode 100644
> index 0000000..cfbf24a
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c

...

> +static int pcan_usb_pro_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
> +{
> +	int len, i;
> +	u8 *pc;
> +	va_list ap;
> +
> +	va_start(ap, id);
> +
> +	pc = pm->rec_ptr + 1;
> +
> +	i = 0;
> +	switch (id) {
> +	case PCAN_USBPRO_TXMSG8:
> +		i += 4;
> +	case PCAN_USBPRO_TXMSG4:
> +		i += 4;
> +	case PCAN_USBPRO_TXMSG0:
> +		*pc++ = va_arg(ap, int);
> +		*pc++ = va_arg(ap, int);
> +		*pc++ = va_arg(ap, int);
> +		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32));
> +		pc += 4;
> +		memcpy(pc, va_arg(ap, int *), i);
> +		pc += i;
> +		break;
> +
> +	case PCAN_USBPRO_SETBTR:
> +	case PCAN_USBPRO_GETDEVID:
> +		*pc++ = va_arg(ap, int);
> +		pc += 2;
> +		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32));
> +		pc += 4;
> +		break;
> +
> +	case PCAN_USBPRO_SETFILTR:
> +	case PCAN_USBPRO_SETBUSACT:
> +	case PCAN_USBPRO_SETSILENT:
> +		*pc++ = va_arg(ap, int);
> +		*(u16 *)pc = cpu_to_le16(va_arg(ap, int));
> +		pc += 2;
> +		break;
> +
> +	case PCAN_USBPRO_SETLED:
> +		*pc++ = va_arg(ap, int);
> +		*(u16 *)pc = cpu_to_le16(va_arg(ap, int));
> +		pc += 2;
> +		*(u32 *)pc = cpu_to_le32(va_arg(ap, u32));
> +		pc += 4;
> +		break;
> +
> +	case PCAN_USBPRO_SETTS:
> +		pc++;
> +		*(u16 *)pc = cpu_to_le16(va_arg(ap, int));
> +		pc += 2;
> +		break;
> +
> +	default:
> +		pr_err("%s: %s(): unknown data type %02Xh (%d)\n",
> +			PCAN_USB_DRIVER_NAME, __func__, id, id);
> +		pc--;
> +		break;
> +	}
> +
> +	len = pc - pm->rec_ptr;
> +	if (len > 0) {
> +		*pm->u.rec_cnt = cpu_to_le32(*pm->u.rec_cnt+1);
> +		*(pm->rec_ptr) = id;

"()" not needed.

...

> +static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
> +				     struct pcan_usb_pro_rxstatus *er)
> +{
> +	const u32 raw_status = le32_to_cpu(er->status);
> +	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
> +	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
> +	struct net_device *netdev = dev->netdev;
> +	struct can_frame *can_frame;
> +	struct sk_buff *skb;
> +	struct timeval tv;
> +
> +	skb = alloc_can_err_skb(netdev, &can_frame);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (raw_status & PCAN_USBPRO_STATUS_BUS) {
> +		can_frame->can_id |= CAN_ERR_BUSOFF;
> +		can_bus_off(netdev);
> +
> +	} else if (raw_status & PCAN_USBPRO_STATUS_ERROR) {
> +		u32 rx_err_cnt = (le32_to_cpu(er->err_frm) & 0x00ff0000) >> 16;
> +		u32 tx_err_cnt = (le32_to_cpu(er->err_frm) & 0xff000000) >> 24;
> +
> +		if (rx_err_cnt > 127) {
> +			can_frame->can_id |= CAN_ERR_CRTL;
> +			can_frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
> +			dev->can.can_stats.error_passive++;
> +
> +		} else if (rx_err_cnt > 96) {
> +			can_frame->can_id |= CAN_ERR_CRTL;
> +			can_frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
> +			dev->can.can_stats.error_warning++;
> +		}
> +
> +		if (tx_err_cnt > 127) {
> +			can_frame->can_id |= CAN_ERR_CRTL;
> +			can_frame->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
> +			dev->can.can_stats.error_passive++;
> +
> +		} else if (tx_err_cnt > 96) {
> +			can_frame->can_id |= CAN_ERR_CRTL;
> +			can_frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
> +			dev->can.can_stats.error_warning++;
> +		}
> +	}
> +
> +	if (raw_status & PCAN_USBPRO_STATUS_OVERRUN) {
> +		can_frame->can_id |= CAN_ERR_PROT;
> +		can_frame->data[2] |= CAN_ERR_PROT_OVERLOAD;
> +	}
> +
> +	if (raw_status & PCAN_USBPRO_STATUS_QOVERRUN) {
> +		can_frame->can_id |= CAN_ERR_CRTL;
> +		can_frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
> +	}
> +
> +	if (can_frame->can_id != CAN_ERR_FLAG) {
> +		peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(er->ts32),
> +				   &tv);
> +		skb->tstamp = timeval_to_ktime(tv);
> +		netif_rx(skb);
> +		netdev->stats.rx_packets++;
> +		netdev->stats.rx_bytes += can_frame->can_dlc;
> +	} else {
> +		dev_kfree_skb(skb);

(can_frame->can_id != CAN_ERR_FLAG) is always true!

...

> +/*
> + * probe function for new PCAN-USB Pro usb interface
> + */
> +static int pcan_usb_pro_probe(struct usb_interface *intf)
> +{
> +	struct usb_host_interface *if_desc;
> +	int i;
> +
> +	if_desc = intf->altsetting;
> +
> +	/* check interface endpoint addresses */
> +	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> +
> +		/*
> +		 * below is the list of valid ep addreses. All other ep address
> +		 * is considered as not-CAN interface address => no dev created
> +		 */
> +		switch (ep->bEndpointAddress) {
> +		case PCAN_USBPRO_EP_CMDOUT:
> +		case PCAN_USBPRO_EP_CMDIN:
> +		case PCAN_USBPRO_EP_MSGOUT_0:
> +		case PCAN_USBPRO_EP_MSGOUT_1:
> +		case PCAN_USBPRO_EP_MSGIN:
> +			/* CAN usb interface unused ep */
> +		case 0x83:

Macro definition!?

...

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> new file mode 100644
> index 0000000..bc56579
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> @@ -0,0 +1,178 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB Pro adapter
> + * Derived from the PCAN project file driver/src/pcan_usbpro_fw.h
> + *
> + * Copyright (C) 2003-2011 PEAK System-Technik GmbH
> + * Copyright (C) 2011-2012 Stephane Grosjean <s.grosjean@peak-system.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#ifndef __pcan_usb_pro_h__
> +#define __pcan_usb_pro_h__

Please use uppercase here and in pcan_usb_core.h as well.

Wolfgang.

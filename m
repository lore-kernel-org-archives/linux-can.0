From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Tue, 04 Dec 2012 21:44:29 +0100
Message-ID: <50BE60AD.10307@grandegger.com>
References: <50BE6092.9050602@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:57423 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2LDUop (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Dec 2012 15:44:45 -0500
In-Reply-To: <50BE6092.9050602@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 12/04/2012 09:44 PM, krumboeck@universalnet.at wrote:
> Add device driver for USB2CAN interface from "8 devices"
> (http://www.8devices.com).
> 
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
> ---
>  drivers/net/can/usb/Kconfig    |    6 +
>  drivers/net/can/usb/Makefile   |    1 +
>  drivers/net/can/usb/usb_8dev.c | 1093
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1100 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb_8dev.c
> 
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2162233 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>        This driver supports the PCAN-USB and PCAN-USB Pro adapters
>        from PEAK-System Technik (http://www.peak-system.com).
>  +config CAN_8DEV_USB
> +    tristate "8 devices USB2CAN interface"
> +    ---help---
> +      This driver supports the USB2CAN interface
> +      from 8 devices (http://www.8devices.com).
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
>   ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG

The patch looks white-space mangled.

> diff --git a/drivers/net/can/usb/usb_8dev.c
> b/drivers/net/can/usb/usb_8dev.c
> new file mode 100644
> index 0000000..9202a12
> --- /dev/null
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -0,0 +1,1093 @@
> +/*
> + * CAN driver for "8 devices" USB2CAN converter
> + *
> + * Copyright (C) 2012 Bernd Krumboeck (krumboeck@universalnet.at)
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * This driver is inspired by the 3.2.0 version of
> drivers/net/can/usb/ems_usb.c
> + * and drivers/net/can/usb/esd_usb2.c
> + *
> + * Many thanks to Gerhard Bertelsmann (info@gerhard-bertelsmann.de)
> + * for testing and fixing this driver. Also many thanks to "8 devices",
> + * who were very cooperative and answered my questions.
> + */
> +
...
> +
> +/* Read data and status frames */
> +static void usb_8dev_rx_can_msg(struct usb_8dev *dev,
> +                struct usb_8dev_rx_msg *msg)
> +{
> +    struct can_frame *cf;
> +    struct sk_buff *skb;
> +    struct net_device_stats *stats = &dev->netdev->stats;
> +
> +    if (msg->type == USB_8DEV_TYPE_CAN_FRAME) {
> +        skb = alloc_can_skb(dev->netdev, &cf);
> +        if (!skb)
> +            return;
> +
> +        cf->can_id = be32_to_cpu(msg->id);
> +        cf->can_dlc = get_can_dlc(msg->dlc & 0xF);
> +
> +        if (msg->flags & USB_8DEV_EXTID)
> +            cf->can_id |= CAN_EFF_FLAG;
> +
> +        if (msg->flags & USB_8DEV_RTR)
> +            cf->can_id |= CAN_RTR_FLAG;
> +        else
> +            memcpy(cf->data, msg->data, cf->can_dlc);
> +    } else if (msg->type == USB_8DEV_TYPE_ERROR_FRAME &&
> +           msg->flags == USB_8DEV_ERR_FLAG) {
> +
> +        /*
> +         * Error message:
> +         * byte 0: Status
> +         * byte 1: bit   7: Receive Passive
> +         * byte 1: bit 0-6: Receive Error Counter
> +         * byte 2: Transmit Error Counter
> +         * byte 3: Always 0 (maybe reserved for future use)
> +         */
> +
> +        u8 state = msg->data[0];
> +        u8 rxerr = msg->data[1] & USB_8DEV_RP_MASK;
> +        u8 txerr = msg->data[2];
> +        int rx_errors = 0;
> +        int tx_errors = 0;
> +
> +        skb = alloc_can_err_skb(dev->netdev, &cf);
> +        if (!skb)
> +            return;
> +
> +        dev->can.can_stats.bus_error++;

As we have seen, the device does either report bus-errors or state
changes. ALso obvious because a switch is used. Please don't increment
"bus_error" for state change messages.

> +
> +        switch (state) {
> +        case USB_8DEV_STATUSMSG_OK:
> +            dev->can.state = CAN_STATE_ERROR_ACTIVE;
> +            cf->can_id |= CAN_ERR_PROT;
> +            cf->data[2] = CAN_ERR_PROT_ACTIVE;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSOFF:
> +            dev->can.state = CAN_STATE_BUS_OFF;
> +            cf->can_id |= CAN_ERR_BUSOFF;
> +            can_bus_off(dev->netdev);
> +            break;
> +        case USB_8DEV_STATUSMSG_OVERRUN:
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            dev->can.state = CAN_STATE_ERROR_WARNING;
> +            cf->can_id |= CAN_ERR_CRTL;
> +            break;
> +        default:
> +            dev->can.state = CAN_STATE_ERROR_WARNING;
> +            cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +            break;
> +        }
> +
> +        switch (state) {
> +        case USB_8DEV_STATUSMSG_ACK:
> +            cf->can_id |= CAN_ERR_ACK;
> +            tx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_CRC:
> +            cf->data[2] |= CAN_ERR_PROT_BIT;
> +            rx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_BIT0:
> +            cf->data[2] |= CAN_ERR_PROT_BIT0;
> +            tx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_BIT1:
> +            cf->data[2] |= CAN_ERR_PROT_BIT1;
> +            tx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_FORM:
> +            cf->data[2] |= CAN_ERR_PROT_FORM;
> +            rx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_STUFF:
> +            cf->data[2] |= CAN_ERR_PROT_STUFF;
> +            rx_errors = 1;
> +            break;
> +        case USB_8DEV_STATUSMSG_OVERRUN:
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_OVERFLOW :
> +                CAN_ERR_CRTL_RX_OVERFLOW;
> +            cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
> +            stats->rx_over_errors++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_WARNING :
> +                CAN_ERR_CRTL_RX_WARNING;
> +            dev->can.can_stats.error_warning++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_PASSIVE :
> +                CAN_ERR_CRTL_RX_PASSIVE;
> +            dev->can.can_stats.error_passive++;
> +            break;
> +        default:
> +            cf->data[2] |= CAN_ERR_PROT_UNSPEC;

Did you see this happen?

> +            break;
> +        }
> +
> +        if (tx_errors) {
> +            cf->data[2] |= CAN_ERR_PROT_TX;
> +            stats->tx_errors++;
> +        }
> +
> +        if (rx_errors)
> +            stats->rx_errors++;
> +
> +        cf->data[6] = txerr;
> +        cf->data[7] = rxerr;
> +
> +        dev->bec.txerr = txerr;
> +        dev->bec.rxerr = rxerr;
> +
> +    } else {
> +        netdev_warn(dev->netdev, "frame type %d unknown",
> +             msg->type);
> +        return;
> +    }
> +
> +    netif_rx(skb);
> +
> +    stats->rx_packets++;
> +    stats->rx_bytes += cf->can_dlc;
> +}

Wolfgang.


From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Mon, 03 Dec 2012 09:11:55 +0100
Message-ID: <50BC5ECB.9070206@grandegger.com>
References: <50BBF73F.9080208@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36976 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab2LCIMM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Dec 2012 03:12:12 -0500
In-Reply-To: <50BBF73F.9080208@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, gediminas@8devices.com, info@gerhard-bertelsmann.de

Hi, at a closer look I see a few more issues:

Please use s/dev_warn(netdev->dev.parent,/netdev_warn(/ for dev_warn and
friends.

You can drop the do_set_bittiming callback if it's not needed. There is
no need for a dummy function, IIRC.

And please also drop the remaining sysfs files for firmware and
hardware. I thinks it's enough that the versions are printed when the
device is probed.

On 12/03/2012 01:50 AM, krumboeck@universalnet.at wrote:
> Add device driver for USB2CAN interface from "8 devices"
> (http://www.8devices.com).
> 
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
> ---
>  drivers/net/can/usb/Kconfig    |    6 +
>  drivers/net/can/usb/Makefile   |    1 +
>  drivers/net/can/usb/usb_8dev.c | 1098
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1105 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb_8dev.c
> 
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2162233 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>        This driver supports the PCAN-USB and PCAN-USB Pro adapters
>        from PEAK-System Technik (http://www.peak-system.com).
> 
> +config CAN_8DEV_USB
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
> 
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> diff --git a/drivers/net/can/usb/usb_8dev.c
> b/drivers/net/can/usb/usb_8dev.c
> new file mode 100644
> index 0000000..345ce6e
> --- /dev/null
> +++ b/drivers/net/can/usb/usb_8dev.c
> @@ -0,0 +1,1098 @@
> +/*
> + * CAN driver for UAB "8 devices" USB2CAN converter

UAB means?


> +/* Get firmware version */
> +static ssize_t show_firmware(struct device *d, struct device_attribute
> *attr,
> +                 char *buf)
> +{
> +    struct usb_8dev_cmd_msg    outmsg;
> +    struct usb_8dev_cmd_msg    inmsg;

Just one space.

> +    int err = 0;
> +    u16 result;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb_8dev *dev = usb_get_intfdata(intf);
> +
> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));
> +    outmsg.command = USB_8DEV_GET_SOFTW_VER;
> +
> +    err = usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    result = be16_to_cpu(*(u16 *)inmsg.data);
> +
> +    return sprintf(buf, "%d.%d\n", (u8)(result>>8), (u8)result);
> +}
> +
> +/* Get hardware version */
> +static ssize_t show_hardware(struct device *d, struct device_attribute
> *attr,
> +                 char *buf)
> +{
> +    struct usb_8dev_cmd_msg    outmsg;
> +    struct usb_8dev_cmd_msg    inmsg;

Ditto.

> +static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
> +static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
> +
> +/*
> + * Set network device mode
> + *
> + * Maybe we should leave this function empty, because the device
> + * set mode variable with open command.
> + */
> +static int usb_8dev_set_mode(struct net_device *netdev, enum can_mode
> mode)
> +{
> +    struct usb_8dev *dev = netdev_priv(netdev);
> +    int err = 0;
> +
> +    switch (mode) {
> +    case CAN_MODE_START:
> +        err = usb_8dev_cmd_open(dev);
> +        if (err)
> +            dev_warn(netdev->dev.parent, "couldn't start device");
> +
> +        if (netif_queue_stopped(netdev))
> +            netif_wake_queue(netdev);
> +        break;
> +
> +    default:
> +        return -EOPNOTSUPP;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Empty function: We set bittiming when we start the interface.
> + * This is a firmware limitation.
> + */
> +static int usb_8dev_set_bittiming(struct net_device *netdev)
> +{
> +    return 0;
> +}
> +
> +/* Read data and status frames */
> +static void usb_8dev_rx_can_msg(struct usb_8dev *dev,
> +                struct usb_8dev_rx_msg *msg)
> +{
> +    struct can_frame *cf;
> +    struct sk_buff *skb;
> +    int i;
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
> +            for (i = 0; i < cf->can_dlc; i++)
> +                cf->data[i] = msg->data[i];
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

As we have seen, please check first if a bus error has been reported.
And the same for setting "CAN_ERR_PROT | CAN_ERR_BUSERROR" below.
Obviously, the device reports either a bus-error or a state-change.

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
> +        default:
> +            dev->can.state = CAN_STATE_ERROR_WARNING;
> +            cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +            break;
> +        }

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
> +            cf->can_id |= CAN_ERR_CRTL;
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_OVERFLOW :
> +                CAN_ERR_CRTL_RX_OVERFLOW;
> +            cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
> +            stats->rx_over_errors++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +            cf->can_id |= CAN_ERR_CRTL;
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_WARNING :
> +                CAN_ERR_CRTL_RX_WARNING;
> +            dev->can.can_stats.error_warning++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            cf->can_id |= CAN_ERR_CRTL;
> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_PASSIVE :
> +                CAN_ERR_CRTL_RX_PASSIVE;
> +            dev->can.can_stats.error_passive++;
> +            break;
> +        default:
> +            cf->data[2] |= CAN_ERR_PROT_UNSPEC;
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

If tx_errors or rx_errors is set, it's a bus-error. Then also set
CAN_ERR_PROT | CAN_ERR_BUSERROR and increment bus_error.

> +        cf->data[6] = txerr;
> +        cf->data[7] = rxerr;
> +
> +        dev->bec.txerr = txerr;
> +        dev->bec.rxerr = rxerr;
> +
> +    } else {
> +        dev_warn(dev->udev->dev.parent, "frame type %d unknown",
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


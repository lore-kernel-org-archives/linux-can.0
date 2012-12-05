From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 11:13:44 +0100
Message-ID: <50BF1E58.4090603@grandegger.com>
References: <50BE7C7E.8080406@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50BE7C7E.8080406-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bernd Krumboeck <krumboeck-Hi41barv6paIERSsAYjmKA@public.gmane.org>
Cc: "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org, gediminas-LljXPT5IorFWk0Htik3J/w@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hi Bernd,

still a few issues with error handling.

> +/* Send open command to device */
> +static int usb_8dev_cmd_open(struct usb_8dev *dev)
> +{
> +    struct can_bittiming *bt = &dev->can.bittiming;
> +    struct usb_8dev_cmd_msg outmsg;
> +    struct usb_8dev_cmd_msg inmsg;
> +    u32 flags = 0;
> +    u32 beflags;
> +    u16 bebrp;
> +    u32 ctrlmode = dev->can.ctrlmode;
> +
> +    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +        flags |= USB_8DEV_LOOPBACK;
> +    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +        flags |= USB_8DEV_SILENT;
> +    if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +        flags |= USB_8DEV_DISABLE_AUTO_RESTRANS;
> +
> +    flags |= USB_8DEV_STATUS_FRAME;
> +
> +    memset(&outmsg, 0, sizeof(struct usb_8dev_cmd_msg));

sizeof(outmsg) is better, here and maybe in other places.

> +    outmsg.command = USB_8DEV_OPEN;
> +    outmsg.opt1 = USB_8DEV_BAUD_MANUAL;
> +    outmsg.data[0] = (bt->prop_seg + bt->phase_seg1);

Minor issue. Brackets not needed.

> +    outmsg.data[1] = bt->phase_seg2;
> +    outmsg.data[2] = bt->sjw;
> +
> +    /* BRP */
> +    bebrp = cpu_to_be16((u16) bt->brp);
> +    memcpy(&outmsg.data[3], &bebrp, sizeof(bebrp));
> +
> +    /* flags */
> +    beflags = cpu_to_be32(flags);
> +    memcpy(&outmsg.data[5], &beflags, sizeof(beflags));
> +
> +    return usb_8dev_send_cmd(dev, &outmsg, &inmsg);
> +}
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

Overrun is not a bus-erroror state change. It should be treated
separately. More below...

> +        case USB_8DEV_STATUSMSG_BUSLIGHT:
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:
> +            dev->can.state = CAN_STATE_ERROR_WARNING;

Please set the state below when you re-treat BUSLIGHT and BUSHEAVY.

> +            cf->can_id |= CAN_ERR_CRTL;
> +            break;
> +        default:
> +            dev->can.state = CAN_STATE_ERROR_WARNING;

Bus-errors do not necessarily change the state. Please remove.

> +            cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +            dev->can.can_stats.bus_error++;
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

The overrun normally means the a message could not be received because
the hardware was busy (FIFO full). It does not depend on the tx/rxerrs
and we only set CAN_ERR_CRTL_RX_OVERFLOW. As good example please check:

http://lxr.linux.no/#linux+v3.6.9/drivers/net/can/usb/ems_usb.c#L335

> +            break;
> +        case USB_8DEV_STATUSMSG_BUSLIGHT:

               dev->can.state = CAN_STATE_ERROR_WARNING;

> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_WARNING :
> +                CAN_ERR_CRTL_RX_WARNING;
> +            dev->can.can_stats.error_warning++;
> +            break;
> +        case USB_8DEV_STATUSMSG_BUSHEAVY:

               dev->can.state = CAN_STATE_ERROR_PASSIVE;

> +            cf->data[1] = (txerr > rxerr) ?
> +                CAN_ERR_CRTL_TX_PASSIVE :
> +                CAN_ERR_CRTL_RX_PASSIVE;
> +            dev->can.can_stats.error_passive++;
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

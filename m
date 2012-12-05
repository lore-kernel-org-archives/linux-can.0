From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 18:36:02 +0100
Message-ID: <50BF8602.1070909@universalnet.at>
References: <50BE6092.9050602@universalnet.at> <50BE6F0E.80308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:42129 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599Ab2LERhj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Dec 2012 12:37:39 -0500
In-Reply-To: <50BE6F0E.80308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi Marc!


>> +    default:
>> +        netdev_info(netdev, "Rx URB aborted (%d)\n",
>> +             urb->status);
>> +        goto resubmit_urb;
>> +    }
>> +
>> +    while (pos < urb->actual_length) {
>> +        struct usb_8dev_rx_msg *msg;
>> +
>> +        if (pos + sizeof(struct usb_8dev_rx_msg) > urb->actual_length) {
>> +            netdev_err(dev->netdev, "format error\n");
>> +            break;
>
> is resubmitting the urb the correct way to handle this problem?

Suggestions? (maybe CAN_ERR_CRTL_UNSPEC ??)

>> +
>> +            stats->tx_dropped++;
>> +        }
>> +    } else {
>> +        /* Slow down tx path */
>> +        if (atomic_read(&dev->active_tx_urbs) >= MAX_TX_URBS ||
>> +            dev->free_slots < 5) {
>
> where's the 5 coming from?
>

 From ems_usb driver.

>> +            netif_stop_queue(netdev);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * Release our reference to this URB, the USB core will eventually
>> free
>> +     * it entirely.
>> +     */
>> +    usb_free_urb(urb);
>> +
>> +    return NETDEV_TX_OK;
>> +
>> +nomem:
>> +    dev_kfree_skb(skb);
>> +    stats->tx_dropped++;
>> +
>> +    return NETDEV_TX_OK;
>> +}
>> +
>> +static int usb_8dev_get_berr_counter(const struct net_device *netdev,
>> +                     struct can_berr_counter *bec)
>> +{
>> +    struct usb_8dev *dev = netdev_priv(netdev);
>> +
>> +    bec->txerr = dev->bec.txerr;
>> +    bec->rxerr = dev->bec.rxerr;
>> +
>> +    return 0;
>> +}
>> +
>> +/* Start USB device */
>> +static int usb_8dev_start(struct usb_8dev *dev)
>> +{
>> +    struct net_device *netdev = dev->netdev;
>> +    int err, i;
>> +
>> +    dev->free_slots = 15; /* initial size */
>
> there does the 15 come from?

ditto

>> + * Check device and firmware.
>> + * Set supported modes and bittiming constants.
>> + * Allocate some memory.
>> + */
>> +static int usb_8dev_probe(struct usb_interface *intf,
>> +             const struct usb_device_id *id)
>> +{
>> +    struct net_device *netdev;
>> +    struct usb_8dev *dev;
>> +    int i, err = -ENOMEM;
>> +    u32 version;
>> +    char buf[18];
>
> where does this 18 come from?

String "USB2CAN converter" + trailing 0.

>
>> +    struct usb_device *usbdev = interface_to_usbdev(intf);
>> +
>> +    /* product id looks strange, better we also check iProdukt string */
>
> iProduct?

Check if usbdev->descriptor.iProduct == "USB2CAN converter".

>> +    if (usb_string(usbdev, usbdev->descriptor.iProduct, buf,
>> +               sizeof(buf)) > 0 && strcmp(buf, "USB2CAN converter")) {
>> +        dev_info(&usbdev->dev, "ignoring: not an USB2CAN converter\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    netdev = alloc_candev(sizeof(struct usb_8dev), MAX_TX_URBS);
>> +    if (!netdev) {
>> +        dev_err(&intf->dev, "Couldn't alloc candev\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    dev = netdev_priv(netdev);
>> +
>> +    dev->udev = usbdev;
>> +    dev->netdev = netdev;
>> +
>> +    dev->can.state = CAN_STATE_STOPPED;
>> +    dev->can.clock.freq = USB_8DEV_ABP_CLOCK;
>> +    dev->can.bittiming_const = &usb_8dev_bittiming_const;
>> +    dev->can.do_set_mode = usb_8dev_set_mode;
>> +    dev->can.do_get_berr_counter = usb_8dev_get_berr_counter;
>> +    dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>> +                      CAN_CTRLMODE_LISTENONLY |
>> +                      CAN_CTRLMODE_ONE_SHOT;
>
> Have you actually tested one shot? What happens if a can frame cannot be
> transmitted?
>

Not really. Can someone explain what one-shot exactly means and what is the correct behavior.
I've only tested without any other device connected. I got the same errors like in normal mode.


regards,
Bernd

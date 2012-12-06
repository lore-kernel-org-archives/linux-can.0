From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: [PATCH v3] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Thu, 06 Dec 2012 05:47:52 +0100
Message-ID: <50C02378.90001@universalnet.at>
References: <50BE6092.9050602@universalnet.at> <50BE6F0E.80308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:36827 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753406Ab2LFEt1 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Dec 2012 23:49:27 -0500
In-Reply-To: <50BE6F0E.80308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi Marc!


Am 2012-12-04 22:45, schrieb Marc Kleine-Budde:
>> +
>> +        /* create a URB, and a buffer for it */
>> +        urb = usb_alloc_urb(0, GFP_KERNEL);
>> +        if (!urb) {
>> +            netdev_err(netdev, "No memory left for URBs\n");
>> +            return -ENOMEM;
>
> who will free the already allocated urbs if i != 0 ?

This function tries to submit 10 urbs (MAX_RX_URBS) for receiving. When we could not
submit all, we still proceed as long as we could submit at least 1.

We must not free, because we should break the loop not return from the function.
I'll correct.


>
>> +        }
>> +
>> +        buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
>> +                     &urb->transfer_dma);
>> +        if (!buf) {
>> +            netdev_err(netdev, "No memory left for USB buffer\n");
>> +            usb_free_urb(urb);
>
> same problem here for coherent

dito.

>
>> +            return -ENOMEM;
>> +        }
>> +
>> +        usb_fill_bulk_urb(urb, dev->udev,
>> +                  usb_rcvbulkpipe(dev->udev,
>> +                          USB_8DEV_ENDP_DATA_RX),
>> +                  buf, RX_BUFFER_SIZE,
>> +                  usb_8dev_read_bulk_callback, dev);
>> +        urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>> +        usb_anchor_urb(urb, &dev->rx_submitted);
>> +
>> +        err = usb_submit_urb(urb, GFP_KERNEL);
>> +        if (err) {
>> +            if (err == -ENODEV)
>> +                netif_device_detach(dev->netdev);
>> +
>> +            usb_unanchor_urb(urb);
>> +            usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
>> +                      urb->transfer_dma);
> same here
>
> add a loop that runs backwards at the end of the function

dito.

>
>> +            break;
>> +        }
>> +
>> +        /* Drop reference, USB core will take care of freeing it */
>> +        usb_free_urb(urb);
>> +    }
>> +
>> +    /* Did we submit any URBs */
>> +    if (i == 0) {
>> +        netdev_warn(netdev, "couldn't setup read URBs\n");
>> +        return err;
>> +    }
>> +
>
> Marc
>

regards,
Bernd

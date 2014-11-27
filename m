From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/3] can/peak_usb: CAN-FD: driver's core modifications
Date: Thu, 27 Nov 2014 12:43:51 +0100
Message-ID: <54770E77.8080108@hartkopp.net>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com> <1417084329-8997-4-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:60700 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbaK0LoA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 06:44:00 -0500
In-Reply-To: <1417084329-8997-4-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

Hello Stephane,

I have two more questions:

On 27.11.2014 11:32, Stephane Grosjean wrote:

> @@ -322,7 +341,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
>   	}
>
>   	context->echo_index = i;
> -	context->dlc = cf->can_dlc;
> +
> +	/* Note: this works with CANFD frames too */
> +	context->data_len = cf->can_dlc;
>
>   	usb_anchor_urb(urb, &dev->tx_submitted);
>

Even with this comment the assignment looks fishy.

What about defining

	struct canfd_frame *cfd = (struct can_frame *)skb->data;

instead of

	struct can_frame *cf = (struct can_frame *)skb->data;

at the top of the function and assign

	context->data_len = cfd->len;

??


> @@ -679,19 +700,43 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
>   }
>
>   /*
> - * candev callback used to set device bitrate.
> + * candev callback used to set device nominal bitrate.

Is this the nominal bitrate or the arbitration bitrate ?

What about stating both:
candev callback used to set device nominal/arbitration bitrate.


> @@ -735,7 +780,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
>   	dev->cmd_buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
>   	if (!dev->cmd_buf) {
>   		err = -ENOMEM;
> -		goto lbl_set_intf_data;
> +		goto lbl_free_candev;

These label changes

>   	}
>
>   	dev->udev = usb_dev;
> @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
>   	dev->can.clock = peak_usb_adapter->clock;
>   	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
>   	dev->can.do_set_bittiming = peak_usb_set_bittiming;
> +	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
> +	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
>   	dev->can.do_set_mode = peak_usb_set_mode;
> -	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
> -				      CAN_CTRLMODE_LISTENONLY;
> +	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
>
>   	netdev->netdev_ops = &peak_usb_netdev_ops;
>
> @@ -770,12 +816,11 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
>   	usb_set_intfdata(intf, dev);
>
>   	SET_NETDEV_DEV(netdev, &intf->dev);
> -	netdev->dev_id = ctrl_idx;
>
>   	err = register_candev(netdev);
>   	if (err) {
>   		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
> -		goto lbl_free_cmd_buf;
> +		goto lbl_set_intf_data;

here

>   	}
>
>   	if (dev->prev_siblings)
> @@ -788,14 +833,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
>   	if (dev->adapter->dev_init) {
>   		err = dev->adapter->dev_init(dev);
>   		if (err)
> -			goto lbl_free_cmd_buf;
> +			goto lbl_unregister;

here

>   	}
>
>   	/* set bus off */
>   	if (dev->adapter->dev_set_bus) {
>   		err = dev->adapter->dev_set_bus(dev, 0);
>   		if (err)
> -			goto lbl_free_cmd_buf;
> +			goto lbl_unregister;

here

>   	}
>
>   	/* get device number early */
> @@ -807,11 +852,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
>
>   	return 0;
>
> -lbl_free_cmd_buf:
> -	kfree(dev->cmd_buf);
> +lbl_unregister:
> +	unregister_netdev(netdev);
>
>   lbl_set_intf_data:
>   	usb_set_intfdata(intf, dev->prev_siblings);
> +	kfree(dev->cmd_buf);
> +
> +lbl_free_candev:
>   	free_candev(netdev);

and here ...

Are these changes necessary for the current PCAN USB driver too?
Should they go into the stable tree with a separate patch?

If so this separate patch should be the first in the series to be picked.

There's something like this in patch 1/3 too - will send it after this mail.

Regards,
Oliver

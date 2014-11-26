From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/2] can/peak_usb: preparing existing files for CAN-FD
Date: Wed, 26 Nov 2014 18:37:52 +0100
Message-ID: <54760FF0.8040309@hartkopp.net>
References: <1416997291-23092-1-git-send-email-s.grosjean@peak-system.com> <1416997291-23092-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:9445 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbaKZRiB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 12:38:01 -0500
In-Reply-To: <1416997291-23092-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

Hello Stephane,

nice to see this driver update getting into mainline.

Btw. you provide two patches which

1. modify the existing files
2. add some new files (for CAN FD)

But if you want to split it up in the way you named the patches:

   can/peak_usb: preparing existing files for CAN-FD
   can/peak_usb: add support for new PEAK CAN-FD adapters

there must not be any CAN FD (pro) specific definitions inside the first patch.

E.g. here:

On 26.11.2014 11:21, Stephane Grosjean wrote:

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 644e6ab..2f034c1 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -37,6 +37,8 @@ MODULE_LICENSE("GPL v2");
>   static struct usb_device_id peak_usb_table[] = {
>   	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID)},
>   	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
> +	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID)},
> +	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID)},
>   	{} /* Terminating entry */
>   };
>
> @@ -46,6 +48,8 @@ MODULE_DEVICE_TABLE(usb, peak_usb_table);
>   static struct peak_usb_adapter *peak_usb_adapters_list[] = {
>   	&pcan_usb,
>   	&pcan_usb_pro,
> +	&pcan_usb_pro_fd,
> +	&pcan_usb_fd,
>   	NULL,
>   };
>



> @@ -679,19 +700,43 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
>   }

(..)

and here:

> +/*
> + * candev callback used to set device data bitrate.
> + */
> +static int peak_usb_set_data_bittiming(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +	struct peak_usb_adapter *pa = dev->adapter;
> +
> +	if (pa->dev_set_data_bittiming) {
> +		struct can_bittiming *bt = &dev->can.data_bittiming;
> +		int err = pa->dev_set_data_bittiming(dev, bt);
> +
> +		if (err)
> +			netdev_info(netdev,
> +				    "couldn't set data bitrate (err %d)\n",
> +				    err);
> +
>   		return err;
>   	}
>

and here:

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


and here:

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> index 073b47f..13d44a5 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -25,6 +25,8 @@
>   /* supported device ids. */
>   #define PCAN_USB_PRODUCT_ID		0x000c
>   #define PCAN_USBPRO_PRODUCT_ID		0x000d
> +#define PCAN_USBPROFD_PRODUCT_ID	0x0011
> +#define PCAN_USBFD_PRODUCT_ID		0x0012
>
>   #define PCAN_USB_DRIVER_NAME		"peak_usb"
>
> @@ -44,8 +46,10 @@ struct peak_usb_device;
>   struct peak_usb_adapter {
>   	char *name;
>   	u32 device_id;
> +	u32 ctrlmode_supported;
>   	struct can_clock clock;
>   	const struct can_bittiming_const bittiming_const;
> +	const struct can_bittiming_const data_bittiming_const;
>   	unsigned int ctrl_count;
>
>   	int (*intf_probe)(struct usb_interface *intf);
> @@ -57,6 +61,8 @@ struct peak_usb_adapter {
>   	int (*dev_close)(struct peak_usb_device *dev);
>   	int (*dev_set_bittiming)(struct peak_usb_device *dev,
>   					struct can_bittiming *bt);
> +	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
> +				      struct can_bittiming *bt);
>   	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
>   	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
>   	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
> @@ -80,6 +86,8 @@ struct peak_usb_adapter {
>
>   extern struct peak_usb_adapter pcan_usb;
>   extern struct peak_usb_adapter pcan_usb_pro;
> +extern struct peak_usb_adapter pcan_usb_pro_fd;
> +extern struct peak_usb_adapter pcan_usb_fd;
>
>   struct peak_time_ref {
>   	struct timeval tv_host_0, tv_host;

These CAN FD specific changes should go into the second patch.

Best regards,
Oliver

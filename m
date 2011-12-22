From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: [PATCH] Add PEAK System USB adapters core driver
Date: Thu, 22 Dec 2011 22:41:34 +0100
Message-ID: <4EF3A40E.4080206@sebastianhaas.info>
References: <871799.098418222-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:45525 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab1LVVlj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2011 16:41:39 -0500
In-Reply-To: <871799.098418222-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

Hi again,

some nitpicking this time. ;-)

You are mixing pr_*, dev_* and netdev_* please check if it is possible 
to harmonize the usage.

Cheers,
  Sebastian

Am 22.12.2011 14:11, schrieb Stephane Grosjean:
> +static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +
> +	if (!dev->open_time)
> +		return -EINVAL;
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		if (dev->adapter->dev_set_bus) {
> +			int err = dev->adapter->dev_set_bus(dev, 1);
> +			if (err)
> +				netdev_warn(netdev,
> +					"couldn't start device (err %d)", err);
Missing \n and I wonder if you should return \err\ or another error code 
if dev_set_bus failed.

> +		}
> +		if (netif_queue_stopped(netdev))
> +			netif_wake_queue(netdev);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int peak_usb_set_bittiming(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +	struct can_bittiming *bt =&dev->can.bittiming;
                                  ^^^ remove whitespace
> +
> +	netdev_info(netdev, "setting bitrate to %u Kbps\n", bt->bitrate);
> +	netdev_dbg(netdev, "sam=%u phase_seg2=%u phase_seg1=%u\n",
> +		bt->sample_point, bt->phase_seg2, bt->phase_seg1);
> +	netdev_dbg(netdev, "prop_seg=%u sjw=%d brp=%u\n",
> +		bt->prop_seg, bt->sjw, bt->brp);
> +
> +	if (dev->adapter->dev_set_bittiming) {
> +		int err = dev->adapter->dev_set_bittiming(dev, bt);
> +		if (err)
> +			netdev_info(netdev, "couldn't set bitrate (err %d)",
> +				err);
Missing \n.
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * called to create one device, atached to USB adapter's CAN controller
> + * number 'ctrl_idx'
> + */
> +static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
> +	struct usb_interface *intf, int ctrl_idx)
> +{
> +	struct usb_device *usb_dev = interface_to_usbdev(intf);
> +	int sizeof_candev = peak_usb_adapter->sizeof_dev_private;
> +	struct peak_usb_device *dev;
> +	struct net_device *netdev;
> +	int i, err;
> +	u16 tmp16;
> +
> +	if (sizeof_candev<  sizeof(struct peak_usb_device))
                         ^^^^^^ cleanup
> +		sizeof_candev = sizeof(struct peak_usb_device);
> +
> +	netdev = alloc_candev(sizeof_candev, PCAN_USB_MAX_TX_URBS);
> +	if (!netdev) {
> +		dev_err(&intf->dev, "%s: Couldn't alloc candev\n",
> +			PCAN_USB_DRIVER_NAME);
> +		return -ENOMEM;
> +	}
> +
> +	dev = netdev_priv(netdev);
> +
> +	dev->udev = usb_dev;
> +	dev->netdev = netdev;
> +	dev->adapter = peak_usb_adapter;
> +	dev->ctrl_idx = ctrl_idx;
> +	dev->state = PCAN_USB_STATE_CONNECTED;
> +
> +	dev->ep_msg_in = peak_usb_adapter->ep_msg_in;
> +	dev->ep_msg_out = peak_usb_adapter->ep_msg_out[ctrl_idx];
> +
> +	dev->can.clock = peak_usb_adapter->clock;
> +	dev->can.bittiming_const =&peak_usb_adapter->bittiming_const;
> +	dev->can.do_set_bittiming = peak_usb_set_bittiming;
> +	dev->can.do_set_mode = peak_usb_set_mode;
> +	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES \
> +		| CAN_CTRLMODE_LISTENONLY;
> +
> +	netdev->netdev_ops =&peak_usb_netdev_ops;
                            ^^^^ whitespace
> +
> +	netdev->flags |= IFF_ECHO; /* we support local echo */
> +
> +	init_usb_anchor(&dev->rx_submitted);
> +
> +	init_usb_anchor(&dev->tx_submitted);
> +	atomic_set(&dev->active_tx_urbs, 0);
> +
> +	for (i = 0; i<  PCAN_USB_MAX_TX_URBS; i++)
> +		dev->tx_contexts[i].echo_index = PCAN_USB_MAX_TX_URBS;
> +
> +	dev->prev_siblings = usb_get_intfdata(intf);
> +	usb_set_intfdata(intf, dev);
> +
> +	SET_NETDEV_DEV(netdev,&intf->dev);
                              ^^^
> +
> +	err = register_candev(netdev);
> +	if (err) {
> +		dev_err(&intf->dev,
> +			"couldn't register CAN device: %d\n", err);
> +		goto lbl_set_intf_data;
> +	}
> +
> +	if (dev->prev_siblings)
> +		(dev->prev_siblings)->next_siblings = dev;
> +
> +	/* read some info from PCAN-USB device */
> +	tmp16 = le16_to_cpu(usb_dev->descriptor.bcdDevice);
> +	dev->device_num = (u8)(tmp16&  0xff);
> +	dev->device_rev = (u8)(tmp16>>  8);
> +
> +	if (dev->adapter->dev_init) {
> +		err = dev->adapter->dev_init(dev);
> +		if (err)
> +			goto lbl_set_intf_data;
> +	}
> +
> +	/* set bus off */
> +	if (dev->adapter->dev_set_bus) {
> +		err = dev->adapter->dev_set_bus(dev, 0);
> +		if (err)
> +			goto lbl_set_intf_data;
> +	}
> +
> +	/* get device number early */
> +	if (dev->adapter->dev_get_device_id)
> +		dev->adapter->dev_get_device_id(dev,&dev->device_number);
> +
> +	dev_info(&intf->dev,
> +		"%s attached to %s can controller %u (device %u)\n",
> +		netdev->name, peak_usb_adapter->name, ctrl_idx,
> +		dev->device_number);
> +
> +	return 0;
> +
> +lbl_set_intf_data:
> +	usb_set_intfdata(intf, dev->prev_siblings);
> +	free_candev(netdev);
> +
> +	return err;
> +}
> +
> +/*
> + * called by the usb core when the device is removed from the system
> + */
> +static void peak_usb_disconnect(struct usb_interface *intf)
> +{
> +	struct peak_usb_device *dev;
> +
> +	/* unregister as netdev devices as siblings */
> +	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings) {
> +		struct net_device *netdev = dev->netdev;
> +		char name[IFNAMSIZ];
> +
> +		dev->state&= ~PCAN_USB_STATE_CONNECTED;
                          ^^^^
> +		strcpy(name, netdev->name);
Use strncpy with IFNAMSIZ.
> +
> +		unregister_netdev(netdev);
> +		free_candev(netdev);
> +
> +		peak_usb_unlink_all_urbs(dev);
> +
> +		dev->next_siblings = NULL;
> +		if (dev->adapter->dev_free)
> +			dev->adapter->dev_free(dev);
> +
> +		dev_info(&intf->dev, "%s removed\n", name);
> +	}
> +
> +	usb_set_intfdata(intf, NULL);
> +}
> +
> +/*
> + * probe function for new PEAK-System devices
> + */
> +static int peak_usb_probe(struct usb_interface *intf,
> +	const struct usb_device_id *id)
> +{
> +	struct usb_device *usb_dev = interface_to_usbdev(intf);
> +	struct peak_usb_adapter *peak_usb_adapter, **pp;
> +	int i, err = -ENOMEM;
> +
> +	usb_dev = interface_to_usbdev(intf);
> +
> +	/* get corresponding PCAN-USB adapter */
> +	for (pp = peak_usb_adapters_list; *pp; pp++)
> +		if ((*pp)->device_id == usb_dev->descriptor.idProduct)
> +			break;
> +
> +	peak_usb_adapter = *pp;
> +	if (!peak_usb_adapter) {
> +		/* should never come except device_id bad usage in this file */
> +		pr_info("%s: didn't find device id. 0x%x in devices list\n",
> +			PCAN_USB_DRIVER_NAME, usb_dev->descriptor.idProduct);
> +		return -ENODEV;
> +	}
> +
> +	/* got corresponding adapter: check if it handles current interface */
> +	if (peak_usb_adapter->intf_probe) {
> +		err = peak_usb_adapter->intf_probe(intf);
> +		if (err)
> +			return err;
> +	}
> +
> +	dev_info(&intf->dev,
> +		"new PEAK-System usb adapter with %u CAN detected:\n",
> +		peak_usb_adapter->ctrl_count);
> +
> +	dev_info(&intf->dev, "%s %s\n",
> +		(usb_dev->manufacturer) ? usb_dev->manufacturer : "PEAK-System",
> +		peak_usb_adapter->name);
> +
> +	if (usb_dev->product) {
> +		/* remove some non-printable chars from the product string */
> +		char *pc;
> +		for (pc = usb_dev->product; *pc != 0; pc++)
> +			if (*pc<  32 || *pc>  127)
                               ^^^^         ^^
> +				*pc = '.';
> +		dev_info(&intf->dev, "%s\n", usb_dev->product);
> +	}
> +
> +	if (usb_dev->serial)
> +		dev_info(&intf->dev, "Serial: %s\n", usb_dev->serial);
> +
> +	for (i = 0; i<  peak_usb_adapter->ctrl_count; i++) {
                     ^^^^
> +		err = peak_usb_create_dev(peak_usb_adapter, intf, i);
> +		if (err) {
> +			/* deregister already created devices */
> +			peak_usb_disconnect(intf);
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
...
> +static int peak_usb_do_device_exit(struct device *d, void *arg)
> +{
> +	struct usb_interface *intf = to_usb_interface(d);
> +	struct peak_usb_device *dev;
> +
> +	/* stop as netdev devices as siblings */
> +	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings) {
> +		struct net_device *netdev = dev->netdev;
> +
> +		if (netif_device_present(netdev))
> +			if (dev->adapter->dev_exit)
> +				dev->adapter->dev_exit(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit peak_usb_exit(void)
> +{
> +	int err;
> +
> +	/* Last chance do send some synchronous commands here */
> +	err = driver_for_each_device(&peak_usb_driver.drvwrap.driver, NULL,
> +		NULL, peak_usb_do_device_exit);
> +	if (err)
> +		err = 0;
\err\ is neither checked nor printed, why not removing it?
> +
> +	/* deregister this driver with the USB subsystem */
> +	usb_deregister(&peak_usb_driver);
> +
> +	pr_info("%s: PCAN-USB kernel driver unloaded\n", PCAN_USB_DRIVER_NAME);
> +}

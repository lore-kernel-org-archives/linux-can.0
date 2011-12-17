From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Sat, 17 Dec 2011 14:17:40 +0100
Message-ID: <4EEC9674.2010307@sebastianhaas.info>
References: <301939.630738588-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:47384 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab1LQNRv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Dec 2011 08:17:51 -0500
In-Reply-To: <301939.630738588-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>
Cc: "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

some annotations also from me. ;-) Since Marc already did the coding 
style nitpicking I've tried to focus on logical stuff. I hope it is helpful.

Cheers,
  Sebastian

Am 16.12.2011 11:19, schrieb s.grosjean@peak-system.com:
> +static int pcan_usb_wait_response(struct peak_usb_device *dev, u8 f, u8 n, u8 *p)
> +{
> +	int actual_length;
> +	struct pcan_usb_parameter cmd;
> +	int err;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> +
> +	/* first, send command */
> +	err = pcan_usb_send_command(dev, f, n, NULL);
> +	if (err) {
> +		return err;
> +	}
> +
> +	cmd.function = f;
> +	cmd.number = n;
> +	memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);
> +
> +	/* then, wait for the response */
> +	mdelay(5);
A delay to wait for a response? What happens if the device takes a 
little bit longer. This looks to be not really robust.
> +	err = usb_bulk_msg(dev->udev,
> +	                   usb_rcvbulkpipe(dev->udev, PCAN_USB_EP_CMDIN),
> +	&cmd, sizeof(struct pcan_usb_parameter),
> +	&actual_length, PCAN_USB_COMMAND_TIMEOUT);
> +	if (err)
> +		netdev_err(dev->netdev,
> +		           "waiting response function=0x%x number=0x%x failure: %d\n",
> +		           f, n, err);
> +	else if (p) memcpy(p,&cmd.parameters[0], PCAN_USB_PARAMETER_LEN);
> +
> +	return err;
> +}
> +
> +
> +/*
> + * Start interface
> + */
> +static int peak_usb_start(struct peak_usb_device *dev)
> +{
> +	struct net_device *netdev = dev->netdev;
> +	int err, i;
> +
> +	for (i = 0; i<  PCAN_USB_MAX_RX_URBS; i++) {
> +		struct urb *urb = NULL;
> +		u8 *buf = NULL;
> +
> +		/* create a URB, and a buffer for it, to receive usb messages */
> +		urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!urb) {
> +			netdev_err(netdev, "No memory left for URBs\n");
> +			return -ENOMEM;
> +		}
> +
> +		buf = usb_alloc_coherent(dev->udev, dev->adapter->rx_buffer_size,
> +		                         GFP_KERNEL,&urb->transfer_dma);
> +		if (!buf) {
> +			netdev_err(netdev, "No memory left for USB buffer\n");
> +			usb_free_urb(urb);
> +			return -ENOMEM;
> +		}
> +
> +		usb_fill_bulk_urb(urb, dev->udev,
> +		                  usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
> +		                  buf, dev->adapter->rx_buffer_size,
> +		                  peak_usb_read_bulk_callback, dev);
> +		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +		usb_anchor_urb(urb,&dev->rx_submitted);
> +
> +		err = usb_submit_urb(urb, GFP_KERNEL);
> +		if (err) {
> +			if (err == -ENODEV)
> +				netif_device_detach(dev->netdev);
> +
> +			usb_unanchor_urb(urb);
> +			usb_free_coherent(dev->udev, dev->adapter->rx_buffer_size, buf,
> +					  urb->transfer_dma);
How about the URB?
> +			break;
> +		}
> +
> +		/* Drop reference, USB core will take care of freeing it */
> +		usb_free_urb(urb);
> +	}
> +
> +	/* Did we submit any URBs */
> +	if (i == 0) {
> +		netdev_warn(netdev, "couldn't setup read URBs\n");
> +		return err;
> +	}
> +
> +	/* Warn if we've couldn't transmit all the URBs */
> +	if (i<  PCAN_USB_MAX_RX_URBS)
> +		netdev_warn(netdev, "rx performance may be slow\n");
> +
> +	/* Pre-alloc tx buffers and corresponding urbs */
> +	for (i = 0; i<  PCAN_USB_MAX_TX_URBS; i++) {
> +		 struct peak_tx_urb_context *context;
> +		struct urb *urb = NULL;
> +		u8 *buf = NULL;
> +
> +		/* create a URB, and a buffer for it, to trsmit usb messages */
> +		urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!urb) {
> +			netdev_err(netdev, "No memory left for URBs\n");
> +			return -ENOMEM;
What happens with the URBs and buffers allocated before?
> +		}
> +
> +		buf = usb_alloc_coherent(dev->udev, dev->adapter->tx_buffer_size,
> +		                         GFP_KERNEL,&urb->transfer_dma);
> +		if (!buf) {
> +			netdev_err(netdev, "No memory left for USB buffer\n");
> +			usb_free_urb(urb);
> +			return -ENOMEM;
Dito.
> +		}
> +
> +		context =&dev->tx_contexts[i];
> +		context->dev = dev;
> +		context->urb = urb;
> +
> +		usb_fill_bulk_urb(urb, dev->udev,
> +		                  usb_sndbulkpipe(dev->udev, dev->ep_msg_out),
> +		                  buf, dev->adapter->tx_buffer_size,
> +		                  peak_usb_write_bulk_callback, context);
> +		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +	}
> +
> +	/* Warn if we've couldn't transmit all the URBs */
> +	if (i<  PCAN_USB_MAX_TX_URBS)
This will never happen since the loop above will always return from this 
function in error case (return -ENOMEM).

> +		netdev_warn(netdev, "tx performance may be slow\n");
> +
> +	if (dev->adapter->device_start) {
> +		err = dev->adapter->device_start(dev);
> +		if (err)
> +			goto failed;
> +	}
> +
> +	/* can set bus on now */
> +	if (dev->adapter->device_set_bus) {
> +		err = dev->adapter->device_set_bus(dev, 1);
> +		if (err)
> +			goto failed;
> +	}
> +
> +	dev->can.state = CAN_STATE_ERROR_ACTIVE;
> +
> +	return 0;
> +
> +failed:
> +	if (err == -ENODEV)
> +		netif_device_detach(dev->netdev);
> +
> +	netdev_warn(netdev, "couldn't submit control: %d\n", err);
> +
> +	return err;
> +}
> +
> +
> +static int peak_usb_ndo_open(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +	int err;
> +
> +	/* common open */
> +	err = open_candev(netdev);
> +	if (err)
> +		return err;
> +
> +	/* finally start device */
> +	err = peak_usb_start(dev);
> +	if (err) {
> +		if (err == -ENODEV)
> +			netif_device_detach(dev->netdev);
This is already done in peak_usb_start() on -ENODEV.
> +
> +		netdev_warn(netdev, "couldn't start device: %d\n", err);
> +
> +		close_candev(netdev);
> +
> +		return err;
> +	}
> +
> +	dev->open_time = jiffies;
> +
> +	netif_start_queue(netdev);
> +
> +	return 0;
> +}
> +
> +static int peak_usb_set_bittiming(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev = netdev_priv(netdev);
> +	struct can_bittiming *bt =&dev->can.bittiming;
> +	int err;
> +
> +	netdev_info(netdev, "set bitrate %u Kbps [sam=%d, phase_seg2=%d phase_seg1=%d prop_seg=%d sjw=%d brp=%d] ",
> +	            bt->bitrate, bt->sample_point, bt->phase_seg2, bt->phase_seg1, bt->prop_seg, bt->sjw, bt->brp);
> +
> +	if (dev->adapter->device_set_bittiming)
> +		err = dev->adapter->device_set_bittiming(dev, bt);
> +
> +	else {
> +		printk("not supported");
Use e.g. dev_warn or whatever.
> +		err = 0;
> +	}
> +
> +	if (err)
> +		printk(" failure (err %d)", err);
> +	printk("\n");
> +
> +	return err;
I would generally recommend to fix up the whole function. Dedicated err 
variable looks a bit too much cause it is only used to print error value 
for dev_set_bittiming.
> +}
> +
> +static int pcan_usb_pro_wait_response(struct peak_usb_device *dev,
> +                                      struct pcan_usb_pro_msg_t *pum)
> +{
> +	u8 req_data_type, req_channel;
> +	int actual_length;
> +	int i, err = 0;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> +
> +	/* first, keep in memory the request type and the eventual channel */
> +	/* to filter received message */
> +	req_data_type = pum->u.rec_buffer[4];
> +	req_channel = pum->u.rec_buffer[5];
> +
> +	/* then, clear number of records to be sure to receive a real response */
> +	/* from the device */
> +	*pum->u.rec_counter = 0;
> +	mdelay(5);
I wonder if this delay is really necessary as usb_bulk_msg is waits a 
finite time to finish.

> +	for (i = 0; !err&&  i<  PCAN_USBPRO_RSP_SUBMIT_MAX; i++) {
> +		struct pcan_usb_pro_msg_t rsp;
> +		u32 r, rec_counter;
> +		u8 *pc;
> +
> +		err = usb_bulk_msg(dev->udev,
> +		                   usb_rcvbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDIN),
> +		&pum->u.rec_buffer[0], pum->rec_buffer_len,
> +		&actual_length, PCAN_USBPRO_COMMAND_TIMEOUT);
> +		if (err) {
> +			netdev_err(dev->netdev, "waiting response failure: %d\n", err);
> +			break;
> +		}
> +
> +		if (actual_length == 0) {
> +			continue;
> +		}
> +
> +		if (actual_length<  PCAN_USB_PRO_MSG_HEADER_LEN) {
> +			netdev_err(dev->netdev, "got abnormal too small response (len=%d)\n",
> +			           actual_length);
> +			err = -EBADMSG;
> +			break;
> +		}
> +	
> +		pc = pcan_usb_pro_msg_init(&rsp,&pum->u.rec_buffer[0], actual_length);
> +
> +		rec_counter = le32_to_cpu(*rsp.u.rec_counter);
> +
> +		for (r = 0; r<  rec_counter; r++) {
> +			union pcan_usb_pro_rec_t *pr = (union pcan_usb_pro_rec_t *)pc;
> +			int rec_size = pcan_usb_pro_sizeof_rec(pr->data_type);
> +			if (rec_size<= 0) {
> +				netdev_err(dev->netdev, "got unprocessed record in msg\n");
> +				dump_mem("received response msg",
> +				&pum->u.rec_buffer[0], actual_length);
> +				err = -EBADMSG;
> +				break;
> +			}
> +
> +			/* check if the response corresponds to the request */
> +			if (pr->data_type != req_data_type) {
Empty statement.
> +			}
> +
> +			/* check if the channel in the response corresponds to the request */
> +			else if ((req_channel != 0xff)&&  (pr->bus_activity.channel != req_channel)) {
Dito.
> +			}
> +
> +			/* got the response */
> +			else return 0;
Optimize the if/else if/else statement to also ge rid of the empty 
statements.
> +
> +			/* otherwise, go on with next record in message */
> +			pc += rec_size;	
> +		}
> +
> +		if (r>= rec_counter) {
Empty statement. Remove it.
> +		}
> +	}
> +
> +	return (i>= PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
> +}
> +
> +static int pcan_usb_pro_request(struct peak_usb_device *dev, int req_id, int req_value, void *req_addr, int req_size)
> +{
> +	int err;
> +	u8 req_type;
> +	unsigned int p;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state&  PCAN_USB_STATE_CONNECTED)) return 0;
> +
> +	memset(req_addr, '\0', req_size);
> +
> +	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
> +	switch (req_id) {
> +	case USB_VENDOR_REQUEST_FKT:
> +		/* Host to device */
> +		p = usb_sndctrlpipe(dev->udev, 0);
> +		break;
> +
> +	case USB_VENDOR_REQUEST_INFO:
> +	default:
> +		/* Device to host */
> +		p = usb_rcvctrlpipe(dev->udev, 0);
> +		req_type |= USB_DIR_IN;
Missing break.
> +	}
> +
> +	err = usb_control_msg(dev->udev,
> +	                      p,
> +	                      req_id,
> +	                      req_type,
> +	                      req_value,
> +	                      0, req_addr, req_size,
> +	                      2*USB_CTRL_GET_TIMEOUT);
> +	if (err<  0)
> +		netdev_info(dev->netdev,
> +		            "unable to request usb[type=%d value=%d] err=%d\n",
> +		            req_id, req_value, err);
> +	else {
> +		//dump_mem("request content", req_addr, req_size);
> +		err = 0;
> +	}
> +
> +	return err;
> +}
> +
> +
> +/*
> + * called when driver module is being unloaded:
> + *
> + * rmmod when plugged  =>  module_exit =>  device_exit, then
> + *                                       usb_deregister(), then
> + *                                       device_stop, then
> + *                        module_disconnect =>  device_free
> + * rmmod but unplugged =>  module_exit
> + * unplug              =>  module_disconnect =>  device_free
> + *
> + * (last change to send something on usb)
> + */
> +static void pcan_usb_pro_exit(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_pro_device *pdev = (struct pcan_usb_pro_device *)dev;
> +
> +	/* when rmmod called before unplug and ifconfig down, MUST reset things */
> +	/* before leaving */
> +	if (dev->can.state != CAN_STATE_STOPPED) {
> +
> +		/* set bus off on the corresponding channel */
> +		pcan_usb_pro_set_bus(dev, 0);
> +	}
> +
> +	/* if channel #0 (only) =>  tell PCAN-USB-PRO the can driver is being */
> +	/* unloaded */
> +	if (dev->ctrl_index == 0) {
> +
> +		/* turn off calibration message if any device were opened */
> +		if (pdev->usb_if->dev_opened_count>  0)
> +			pcan_usb_pro_set_calibration_msgs(dev, 0);
> +
> +		/* tell the PCAN-USB-PRO device that drive is being unloaded */
> +		pcan_usb_pro_driver_loaded(dev, 0, 0);
> +
> +		/* this device needs also to be resetted when driver is unloaded */
> +		/* TODO hangs when rmmod */
Then fix it. ;-)
> +		//if (dev->udev)
> +		//	usb_reset_device(dev->udev);
> +	}
> +}
> +

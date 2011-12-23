From: Sebastian Haas <dev@sebastianhaas.info>
Subject: Re: [PATCH] Add support for PEAK System PCAN-USB Pro adapter
Date: Fri, 23 Dec 2011 20:57:59 +0100
Message-ID: <4EF4DD47.3040900@sebastianhaas.info>
References: <604716.570905538-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:59012 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab1LWT6F (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Dec 2011 14:58:05 -0500
In-Reply-To: <604716.570905538-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Linux CAN mailing list <linux-can@vger.kernel.org>

Hi St=E9phane,

just some minor annotations.

Cheers and Merry Christmas,
  Sebastian

Am 22.12.2011 14:14, schrieb Stephane Grosjean:
> +static int pcan_usb_pro_sizeof_rec(u8 data_type)
> +{
> +	switch (data_type) {
> +	case PCAN_USBPRO_RXMSG8:
> +		return sizeof(struct pcan_usb_pro_rxmsg);
> +	case PCAN_USBPRO_RXMSG4:
> +		return sizeof(struct pcan_usb_pro_rxmsg) - 4;
> +	case PCAN_USBPRO_RXMSG0:
> +	case PCAN_USBPRO_RXRTR:
> +		return sizeof(struct pcan_usb_pro_rxmsg) - 8;
> +	case PCAN_USBPRO_RXSTATUS:
> +		return sizeof(struct pcan_usb_pro_rxstatus);
=2E..
I wonder if it is possible to use some kind of a table here to improve=20
readability and reduce code.
=2E..
> +	case PCAN_USBPRO_SETLED:
> +		return sizeof(struct pcan_usb_pro_setled);
> +	default:
> +		pr_info("%s: %s(%d): unsupported data type\n",
> +			PCAN_USB_DRIVER_NAME, __func__, data_type);
> +		break;
> +	}
> +
> +	return -1;
> +}
> +static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
> +	struct can_bittiming *bt)
> +{
> +	struct pcan_usb_pro_msg um;
> +	u8 tmp[32];
> +	u32 ccbt;
> +
> +	ccbt =3D (dev->can.ctrlmode&  CAN_CTRLMODE_3_SAMPLES) ? 0x00800000 =
: 0;
> +	ccbt |=3D (bt->sjw - 1)<<  24;
> +	ccbt |=3D (bt->phase_seg2 - 1)<<  20;
> +	ccbt |=3D (bt->prop_seg + bt->phase_seg1 - 1)<<  16; /* =3D tseg1 *=
/
> +	ccbt |=3D bt->brp - 1;
Does the PCAN-USB uses a NXP LPC21xx controller?
> +
> +	netdev_dbg(dev->netdev, "ccbt=3D0x%08x\n", ccbt);
> +
> +	pcan_usb_pro_msg_init_empty(&um, tmp, sizeof(tmp));
> +	pcan_usb_pro_add_rec(&um, PCAN_USBPRO_SETBTR, dev->ctrl_idx, ccbt);
> +
> +	return pcan_usb_pro_send_cmd(dev,&um);
> +}
> +/*
> + * callback for bulk IN urb
> + */
> +static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, stru=
ct urb *urb)
> +{
> +	struct pcan_usb_pro_interface *usb_if =3D pcan_usb_pro_dev_if(dev);
> +	struct net_device *netdev =3D dev->netdev;
> +	struct pcan_usb_pro_msg usb_msg;
> +	u8 *rec_ptr, *msg_end;
> +	u16 rec_cnt;
> +	int err =3D 0;
> +
> +	rec_ptr =3D pcan_usb_pro_msg_init(&usb_msg, urb->transfer_buffer,
> +		urb->actual_length);
> +	if (!rec_ptr) {
> +		netdev_err(netdev, "bad msg hdr len %d\n", urb->actual_length);
> +		return -EINVAL;
> +	}
> +
> +	/* loop reading all the records from the incoming message */
> +	msg_end =3D urb->transfer_buffer + urb->actual_length;
> +	rec_cnt =3D le16_to_cpu(*usb_msg.u.rec_cnt_rd);
> +	for (; rec_cnt>  0; rec_cnt--) {
> +		union pcan_usb_pro_rec *pr =3D (union pcan_usb_pro_rec *)rec_ptr;
> +		int sizeof_rec =3D pcan_usb_pro_sizeof_rec(pr->data_type);
> +
> +		if (sizeof_rec<=3D 0) {
> +			netdev_err(netdev,
> +				"got unsupported rec in usb msg:\n");
> +			err =3D -ENOTSUPP;
> +			break;
> +		}
> +
> +		/* check if the record goes out of current packet */
> +		if (rec_ptr + sizeof_rec>  msg_end) {
> +			netdev_err(netdev,
> +				"got frag rec: should inc usb rx buf size\n");
> +			err =3D -EBADMSG;
> +			break;
> +		}
> +
> +		switch (pr->data_type) {
> +		case PCAN_USBPRO_RXMSG8:
> +		case PCAN_USBPRO_RXMSG4:
> +		case PCAN_USBPRO_RXMSG0:
> +		case PCAN_USBPRO_RXRTR:
> +			err =3D pcan_usb_pro_handle_canmsg(usb_if,&pr->rx_msg);
> +			if (err<  0)
> +				goto fail;
> +			break;
> +
> +		case PCAN_USBPRO_RXSTATUS:
> +			err =3D pcan_usb_pro_handle_error(usb_if,&pr->rx_status);
> +			if (err<  0)
> +				goto fail;
> +			break;
> +
> +		case PCAN_USBPRO_RXTS:
> +			err =3D pcan_usb_pro_handle_ts(usb_if,&pr->rx_ts);
No handling in error case, is that right?
> +			break;
> +
> +		default:
> +			netdev_err(netdev,
> +				"unhandled rec type 0x%02x (%d): ignored\n",
> +				pr->data_type, pr->data_type);
> +			break;
> +		}
> +
> +		rec_ptr +=3D sizeof_rec;
> +	}
> +
> +fail:
> +	if (err)
> +		dump_mem("received msg",
> +			urb->transfer_buffer, urb->actual_length);
> +
> +	return err;
> +}
> +
> +static int pcan_usb_pro_encode_msg(struct peak_usb_device *dev,
> +	struct sk_buff *skb, u8 *obuf, size_t *size)
> +{
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u8 data_type, len, flags;
> +	struct pcan_usb_pro_msg usb_msg;
> +	int err =3D 0;
> +
> +	pcan_usb_pro_msg_init_empty(&usb_msg, obuf, *size);
> +
> +	if ((cf->can_id&  CAN_RTR_FLAG) || (cf->can_dlc =3D=3D 0))
> +		data_type =3D PCAN_USBPRO_TXMSG0;
> +
Remove empty line.
> +	else if (cf->can_dlc<=3D 4)
> +		data_type =3D PCAN_USBPRO_TXMSG4;
> +	else
> +		data_type =3D PCAN_USBPRO_TXMSG8;
> +
> +	len =3D (dev->ctrl_idx<<  4) | (cf->can_dlc&  0x0f);
> +
> +	flags =3D 0;
> +	if (cf->can_id&  CAN_EFF_FLAG)
> +		flags |=3D 0x02;
> +	if (cf->can_id&  CAN_RTR_FLAG)
> +		flags |=3D 0x01;
> +
> +	err =3D pcan_usb_pro_add_rec(&usb_msg, data_type, 0, flags, len,
> +		cf->can_id, cf->data);
\err\ is not checked.
> +
> +	*size =3D usb_msg.rec_buffer_len;
> +
> +	return 0;
> +}
> +
> +/*
> + * called when probing to initialize a device object.
> + */
> +static int pcan_usb_pro_init(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_pro_interface *usb_if;
> +	struct pcan_usb_pro_device *pdev =3D (struct pcan_usb_pro_device *)=
dev;
> +
> +	/* do this for 1st channel only */
> +	if (!dev->prev_siblings) {
> +		struct pcan_usb_pro_fwinfo fi;
> +		struct pcan_usb_pro_blinfo bi;
> +
> +		/* tell the device the can driver is running */
> +		pcan_usb_pro_drv_loaded(dev, 1);
> +
> +		if (pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
> +			PCAN_USBPRO_INFO_FIRMWARE,&fi, sizeof(fi))>=3D 0)
> +			netdev_info(dev->netdev,
> +				"%s fw v%d.%d.%d (%02d/%02d/%02d) fw 0x%08x\n",
> +				pcan_usb_pro.name,
> +				fi.version[0], fi.version[1], fi.version[2],
> +				fi.day, fi.month, fi.year, fi.fw_type);
> +
> +		if (pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
> +			PCAN_USBPRO_INFO_BOOTLOADER,&bi, sizeof(bi))>=3D 0) {
> +			netdev_info(dev->netdev,
> +				"bootloader v%d.%d.%d (%02d/%02d/%02d)\n",
> +				bi.version[0], bi.version[1], bi.version[2],
> +				bi.day, bi.month, bi.year);
> +
> +			netdev_info(dev->netdev,
> +				"serial %08X.%08X hw 0x%08x rev 0x%08x\n",
> +				bi.serial_num_hi, bi.serial_num_lo,
> +				bi.hw_type, bi.hw_rev);
> +
> +			dev->device_rev =3D (u8)bi.hw_rev;
> +		}
> +
> +		usb_if =3D kzalloc(sizeof(struct pcan_usb_pro_interface),
> +			GFP_KERNEL);
> +		if (!usb_if)
> +			return -ENOMEM;
Is it necessary to call pcan_usb_pro_drv_loaded(dev, 0) here?
> +
> +		/* number of ts msgs to ignore before taking one into account */
> +		usb_if->cm_ignore_count =3D 5;
> +
Remove empty line.
> +	} else {
> +		usb_if =3D pcan_usb_pro_dev_if(dev->prev_siblings);
> +	}
> +
> +	pdev->usb_if =3D usb_if;
> +	usb_if->dev[dev->ctrl_idx] =3D dev;
> +
> +	/* set LED in default state (end of init phase) */
> +	pcan_usb_pro_set_led(dev, 0, 1);
> +
> +	return 0;
> +}
> +
> +static void pcan_usb_pro_exit(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_pro_device *pdev =3D (struct pcan_usb_pro_device *)=
dev;
> +
> +	/*
> +	 * when rmmod called before unplug and if down, should reset things
> +	 * before leaving
> +	 */
> +	if (dev->can.state !=3D CAN_STATE_STOPPED)
> +
Remove empty line. Brackets may increase readability here.
> +		/* set bus off on the corresponding channel */
> +		pcan_usb_pro_set_bus(dev, 0);
> +
> +	/* if channel #0 (only) */
> +	if (dev->ctrl_idx =3D=3D 0) {
> +		/* turn off calibration message if any device were opened */
> +		if (pdev->usb_if->dev_opened_count>  0)
> +			pcan_usb_pro_set_ts(dev, 0);
> +
> +		/* tell the PCAN-USB Pro device driver is being unloaded */
> +		pcan_usb_pro_drv_loaded(dev, 0);
> +	}
> +}

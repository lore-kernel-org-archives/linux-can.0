From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Wed, 07 Jan 2015 18:03:01 +0100
Message-ID: <54AD66C5.10908@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CkIgEcLwRggGOsWghd49inw3SB9cRmw49"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41273 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbbAGRDJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 12:03:09 -0500
In-Reply-To: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CkIgEcLwRggGOsWghd49inw3SB9cRmw49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
> Add support for the following new PEAK-System technik CANFD USB adapter=
s:
>=20
> PCAN-USB FD             single CANFD channel USB adapter
> PCAN-USB Pro FD         dual CANFD channels USB adapter

Can you please work out the correct ISO/non-ISO for CAN-fd with Oliver.
If you need CAN_CTRLMODE_FD_NON_ISO make your patch based on

    https://gitorious.org/linux-can/linux-can.git testing

>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
> v4: pcan_usb_fd.c: fix missing code for setting standard filtering crit=
eria on
>     received CANID, in function pcan_usb_fd_set_filter_std().
>     Note: driver behavior is to accept all CANID.
>=20
>  drivers/net/can/usb/Kconfig                  |   14 +-
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +-
>  drivers/net/can/usb/peak_usb/pcan_ucan.h     |  192 +++++
>  drivers/net/can/usb/peak_usb/pcan_usb.c      |    1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |   66 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |   14 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 1070 ++++++++++++++++++=
++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |   17 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   14 +
>  9 files changed, 1362 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a77db919..6dbbc85 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -53,10 +53,18 @@ config CAN_KVASER_USB
>  	  module will be called kvaser_usb.
> =20
>  config CAN_PEAK_USB
> -	tristate "PEAK PCAN-USB/USB Pro interfaces"
> +	tristate "PEAK PCAN-USB/USB Pro interfaces for CAN 2.0b/CAN-FD"
>  	---help---
> -	  This driver supports the PCAN-USB and PCAN-USB Pro adapters
> -	  from PEAK-System Technik (http://www.peak-system.com).
> +	  This driver supports the PEAK-System Technik USB adapters that enab=
le
> +	  access to the CAN bus, with repect to the CAN 2.0b and/or CAN-FD
> +	  standards, that is:
> +
> +	  PCAN-USB             single CAN 2.0b channel USB adapter
> +	  PCAN-USB Pro         dual CAN 2.0b channels USB adapter
> +	  PCAN-USB FD          single CAN-FD channel USB adapter
> +	  PCAN-USB Pro FD      dual CAN-FD channels USB adapter
> +
> +	  (see also http://www.peak-system.com).
> =20
>  config CAN_8DEV_USB
>  	tristate "8 devices USB2CAN interface"
> diff --git a/drivers/net/can/usb/peak_usb/Makefile b/drivers/net/can/us=
b/peak_usb/Makefile
> index 1aefbc8..1839e9c 100644
> --- a/drivers/net/can/usb/peak_usb/Makefile
> +++ b/drivers/net/can/usb/peak_usb/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
> -peak_usb-y =3D pcan_usb_core.o pcan_usb.o pcan_usb_pro.o
> +peak_usb-y =3D pcan_usb_core.o pcan_usb.o pcan_usb_pro.o pcan_usb_fd.o=

> diff --git a/drivers/net/can/usb/peak_usb/pcan_ucan.h b/drivers/net/can=
/usb/peak_usb/pcan_ucan.h
> new file mode 100644
> index 0000000..02c0424
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_ucan.h
> @@ -0,0 +1,192 @@
> +/*
> + * CAN driver for PEAK System micro-CAN based adapters
> + *
> + * Copyright (C) 2003-2011 PEAK System-Technik GmbH
> + * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.c=
om>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#ifndef PUCAN_H
> +#define PUCAN_H
> +
> +/* uCAN commands opcodes list (low-order 10 bits) */
> +#define PUCAN_CMD_NOP			0x000
> +#define PUCAN_CMD_RESET_MODE		0x001
> +#define PUCAN_CMD_NORMAL_MODE		0x002
> +#define PUCAN_CMD_LISTEN_ONLY_MODE	0x003
> +#define PUCAN_CMD_TIMING_SLOW		0x004
> +#define PUCAN_CMD_TIMING_FAST		0x005
> +#define PUCAN_CMD_FILTER_STD		0x008
> +#define PUCAN_CMD_TX_ABORT		0x009
> +#define PUCAN_CMD_WR_ERR_CNT		0x00a
> +#define PUCAN_CMD_RX_FRAME_ENABLE	0x00b
> +#define PUCAN_CMD_RX_FRAME_DISABLE	0x00c
> +#define PUCAN_CMD_END_OF_COLLECTION	0x3ff
> +
> +/* uCAN received messages list */
> +#define PUCAN_MSG_CAN_RX		0x0001
> +#define PUCAN_MSG_ERROR			0x0002
> +#define PUCAN_MSG_STATUS		0x0003
> +#define PUCAN_MSG_BUSLOAD		0x0004
> +#define PUCAN_MSG_CAN_TX		0x1000
> +
> +/* uCAN command common header */
> +#define PUCAN_CMD_OPCODE_CHANNEL(c, o)	(((c) << 12) | ((o) & 0x3ff))
> +
> +struct __packed pucan_command {
> +	__le16	opcode_channel;
> +	u16	args[3];
> +};
> +
> +/* uCAN TIMING_SLOW command fields */
> +#define PUCAN_TSLOW_SJW_T(s, t)		(((s) & 0xf) | ((!!(t)) << 7))
> +#define PUCAN_TSLOW_TSEG2(t)		((t) & 0xf)
> +#define PUCAN_TSLOW_TSEG1(t)		((t) & 0x3f)
> +#define PUCAN_TSLOW_BRP(b)		((b) & 0x3ff)
> +
> +struct __packed pucan_timing_slow {
> +	__le16	opcode_channel;
> +
> +	u8	ewl;		/* Error Warning limit */
> +	u8	sjw_t;		/* Sync Jump Width + Triple sampling */
> +	u8	tseg2;		/* Timing SEGment 2 */
> +	u8	tseg1;		/* Timing SEGment 1 */
> +
> +	__le16	brp;		/* BaudRate Prescaler */
> +};
> +
> +/* uCAN TIMING_FAST command fields */
> +#define PUCAN_TFAST_SJW(s)		((s) & 0x3)
> +#define PUCAN_TFAST_TSEG2(t)		((t) & 0x7)
> +#define PUCAN_TFAST_TSEG1(t)		((t) & 0xf)
> +#define PUCAN_TFAST_BRP(b)		((b) & 0x3ff)
> +
> +struct __packed pucan_timing_fast {
> +	__le16	opcode_channel;
> +
> +	u8	unused;
> +	u8	sjw;		/* Sync Jump Width */
> +	u8	tseg2;		/* Timing SEGment 2 */
> +	u8	tseg1;		/* Timing SEGment 1 */
> +
> +	__le16	brp;		/* BaudRate Prescaler */
> +};
> +
> +/* uCAN FILTER_STD command fields */
> +#define PUCAN_FLTSTD_ROW_IDX_BITS	6
> +
> +struct __packed pucan_filter_std {
> +	__le16	opcode_channel;
> +
> +	__le16	idx;
> +	__le32	mask;		/* CAN-ID bitmask in idx range */
> +};
> +
> +/* uCAN RX_FRAME_ENABLE command fields */
> +#define PUCAN_FLTEXT_ERROR		0x0001
> +#define PUCAN_FLTEXT_BUSLOAD		0x0002
> +
> +struct __packed pucan_filter_ext {
> +	__le16	opcode_channel;
> +
> +	__le16	ext_mask;
> +	u32	unused;
> +};
> +
> +/* uCAN received messages global format */
> +struct __packed pucan_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +};
> +
> +/* uCAN flags for CAN/CANFD messages */
> +#define PUCAN_MSG_SELF_RECEIVE		0x80
> +#define PUCAN_MSG_ERROR_STATE_IND	0x40	/* error state indicator */
> +#define PUCAN_MSG_BITRATE_SWITCH	0x20	/* bitrate switch */
> +#define PUCAN_MSG_EXT_DATA_LEN		0x10	/* extended data length */
> +#define PUCAN_MSG_SINGLE_SHOT		0x08
> +#define PUCAN_MSG_LOOPED_BACK		0x04
> +#define PUCAN_MSG_EXT_ID		0x02
> +#define PUCAN_MSG_RTR			0x01
> +
> +#define PUCAN_MSG_CHANNEL(m)		((m)->channel_dlc & 0xf)
> +#define PUCAN_MSG_DLC(m)		((m)->channel_dlc >> 4)

Do not dereference a pointer in a define. Either create a static inline
function for this, or create proper defines for the constants and open
code it.

> +
> +struct __packed pucan_rx_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	__le32	tag_low;
> +	__le32	tag_high;
> +	u8	channel_dlc;
> +	u8	client;
> +	__le16	flags;
> +	__le32	can_id;
> +	u8	d[0];
> +};
> +
> +/* uCAN error types */
> +#define PUCAN_ERMSG_BIT_ERROR		0
> +#define PUCAN_ERMSG_FORM_ERROR		1
> +#define PUCAN_ERMSG_STUFF_ERROR		2
> +#define PUCAN_ERMSG_OTHER_ERROR		3
> +#define PUCAN_ERMSG_ERR_CNT_DEC		4
> +
> +#define PUCAN_ERMSG_CHANNEL(e)		((e)->channel_type_d & 0x0f)
> +#define PUCAN_ERMSG_ERRTYPE(e)		(((e)->channel_type_d >> 4) & 0x07)
> +#define PUCAN_ERMSG_D(e)		((e)->channel_type_d & 0x80)
> +
> +#define PUCAN_ERMSG_ERRCODE(e)		((e)->code_g & 0x7f)
> +#define PUCAN_ERMSG_G(e)		((e)->code_g & 0x80)

same here

> +
> +struct __packed pucan_error_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	u8	channel_type_d;
> +	u8	code_g;
> +	u8	tx_err_cnt;
> +	u8	rx_err_cnt;
> +};
> +
> +#define PUCAN_STMSG_CHANNEL(e)		((e)->channel_p_w_b & 0x0f)
> +#define PUCAN_STMSG_PASSIVE(e)		((e)->channel_p_w_b & 0x20)
> +#define PUCAN_STMSG_WARNING(e)		((e)->channel_p_w_b & 0x40)
> +#define PUCAN_STMSG_BUSOFF(e)		((e)->channel_p_w_b & 0x80)

same here

> +
> +struct __packed pucan_status_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	u8	channel_p_w_b;
> +	u8	unused[3];
> +};
> +
> +/* uCAN transmitted message format */
> +#define PUCAN_MSG_CHANNEL_DLC(c, d)	(((c) & 0xf) | ((d) << 4))
> +
> +struct __packed pucan_tx_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	tag_low;
> +	__le32	tag_high;
> +	u8	channel_dlc;
> +	u8	client;
> +	__le16	flags;
> +	__le32	can_id;
> +	u8	d[0];
> +};
> +
> +#endif
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index 4e1659d..5972c7a 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb =3D {
>  	.name =3D "PCAN-USB",
>  	.device_id =3D PCAN_USB_PRODUCT_ID,
>  	.ctrl_count =3D 1,
> +	.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,

Can you move all ctrlmode_supported related code into a seperate patch.

>  	.clock =3D {
>  		.freq =3D PCAN_USB_CRYSTAL_HZ / 2 ,
>  	},
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.c
> index c62f48a..7e8ebc4 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -37,6 +37,8 @@ MODULE_LICENSE("GPL v2");
>  static struct usb_device_id peak_usb_table[] =3D {
>  	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID)},
>  	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
> +	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID)},
> +	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID)},
>  	{} /* Terminating entry */
>  };
> =20
> @@ -46,6 +48,8 @@ MODULE_DEVICE_TABLE(usb, peak_usb_table);
>  static struct peak_usb_adapter *peak_usb_adapters_list[] =3D {
>  	&pcan_usb,
>  	&pcan_usb_pro,
> +	&pcan_usb_fd,
> +	&pcan_usb_pro_fd,
>  	NULL,
>  };
> =20
> @@ -165,6 +169,21 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time=
_ref, u32 ts,
>  }
> =20
>  /*
> + * post received skb after having set any hw timestamp
> + */
> +int peak_usb_netif_rx(struct sk_buff *skb,
> +		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
> +{
> +	struct skb_shared_hwtstamps *hwts =3D skb_hwtstamps(skb);
> +	struct timeval tv;
> +
> +	peak_usb_get_ts_tv(time_ref, ts_low, &tv);
> +	hwts->hwtstamp =3D timeval_to_ktime(tv);
> +
> +	return netif_rx(skb);
> +}
> +
> +/*
>   * callback for bulk Rx urb
>   */
>  static void peak_usb_read_bulk_callback(struct urb *urb)
> @@ -253,7 +272,7 @@ static void peak_usb_write_bulk_callback(struct urb=
 *urb)
>  	case 0:
>  		/* transmission complete */
>  		netdev->stats.tx_packets++;
> -		netdev->stats.tx_bytes +=3D context->dlc;
> +		netdev->stats.tx_bytes +=3D context->data_len;
> =20
>  		/* prevent tx timeout */
>  		netdev->trans_start =3D jiffies;
> @@ -289,7 +308,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct s=
k_buff *skb,
>  	struct peak_usb_device *dev =3D netdev_priv(netdev);
>  	struct peak_tx_urb_context *context =3D NULL;
>  	struct net_device_stats *stats =3D &netdev->stats;
> -	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
>  	struct urb *urb;
>  	u8 *obuf;
>  	int i, err;
> @@ -322,7 +341,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct s=
k_buff *skb,
>  	}
> =20
>  	context->echo_index =3D i;
> -	context->dlc =3D cf->can_dlc;
> +
> +	/* Note: this works with CANFD frames too */
> +	context->data_len =3D cfd->len;
> =20
>  	usb_anchor_urb(urb, &dev->tx_submitted);
> =20
> @@ -679,19 +700,43 @@ static int peak_usb_set_mode(struct net_device *n=
etdev, enum can_mode mode)
>  }
> =20
>  /*
> - * candev callback used to set device bitrate.
> + * candev callback used to set device nominal/arbitration bitrate.
>   */
>  static int peak_usb_set_bittiming(struct net_device *netdev)
>  {
>  	struct peak_usb_device *dev =3D netdev_priv(netdev);
> -	struct can_bittiming *bt =3D &dev->can.bittiming;
> +	struct peak_usb_adapter *pa =3D dev->adapter;
> =20
> -	if (dev->adapter->dev_set_bittiming) {
> -		int err =3D dev->adapter->dev_set_bittiming(dev, bt);
> +	if (pa->dev_set_bittiming) {
> +		struct can_bittiming *bt =3D &dev->can.bittiming;
> +		int err =3D pa->dev_set_bittiming(dev, bt);
> =20
>  		if (err)
>  			netdev_info(netdev, "couldn't set bitrate (err %d)\n",
> -				err);
> +				    err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * candev callback used to set device data bitrate.
> + */
> +static int peak_usb_set_data_bittiming(struct net_device *netdev)
> +{
> +	struct peak_usb_device *dev =3D netdev_priv(netdev);
> +	struct peak_usb_adapter *pa =3D dev->adapter;
> +
> +	if (pa->dev_set_data_bittiming) {
> +		struct can_bittiming *bt =3D &dev->can.data_bittiming;
> +		int err =3D pa->dev_set_data_bittiming(dev, bt);
> +
> +		if (err)
> +			netdev_info(netdev,
> +				    "couldn't set data bitrate (err %d)\n",
> +				    err);
> +
>  		return err;
>  	}
> =20
> @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct peak_usb_ada=
pter *peak_usb_adapter,
>  	dev->can.clock =3D peak_usb_adapter->clock;
>  	dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const;
>  	dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
> +	dev->can.data_bittiming_const =3D &peak_usb_adapter->data_bittiming_c=
onst;
> +	dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>  	dev->can.do_set_mode =3D peak_usb_set_mode;
> -	dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
> -				      CAN_CTRLMODE_LISTENONLY;
> +	dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_supported;=


All ctrlmode_supported can go into a seperate patch.

> =20
>  	netdev->netdev_ops =3D &peak_usb_netdev_ops;
> =20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net=
/can/usb/peak_usb/pcan_usb_core.h
> index 073b47f..13d44a5 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
> @@ -25,6 +25,8 @@
>  /* supported device ids. */
>  #define PCAN_USB_PRODUCT_ID		0x000c
>  #define PCAN_USBPRO_PRODUCT_ID		0x000d
> +#define PCAN_USBPROFD_PRODUCT_ID	0x0011
> +#define PCAN_USBFD_PRODUCT_ID		0x0012
> =20
>  #define PCAN_USB_DRIVER_NAME		"peak_usb"
> =20
> @@ -44,8 +46,10 @@ struct peak_usb_device;
>  struct peak_usb_adapter {
>  	char *name;
>  	u32 device_id;
> +	u32 ctrlmode_supported;

seperate patch

>  	struct can_clock clock;
>  	const struct can_bittiming_const bittiming_const;
> +	const struct can_bittiming_const data_bittiming_const;
>  	unsigned int ctrl_count;
> =20
>  	int (*intf_probe)(struct usb_interface *intf);
> @@ -57,6 +61,8 @@ struct peak_usb_adapter {
>  	int (*dev_close)(struct peak_usb_device *dev);
>  	int (*dev_set_bittiming)(struct peak_usb_device *dev,
>  					struct can_bittiming *bt);
> +	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
> +				      struct can_bittiming *bt);
>  	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
>  	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id)=
;
>  	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
> @@ -80,6 +86,8 @@ struct peak_usb_adapter {
> =20
>  extern struct peak_usb_adapter pcan_usb;
>  extern struct peak_usb_adapter pcan_usb_pro;
> +extern struct peak_usb_adapter pcan_usb_pro_fd;
> +extern struct peak_usb_adapter pcan_usb_fd;
> =20
>  struct peak_time_ref {
>  	struct timeval tv_host_0, tv_host;
> @@ -92,7 +100,7 @@ struct peak_time_ref {
>  struct peak_tx_urb_context {
>  	struct peak_usb_device *dev;
>  	u32 echo_index;
> -	u8 dlc;
> +	u8 data_len;
>  	struct urb *urb;
>  };
> =20
> @@ -139,7 +147,9 @@ void peak_usb_update_ts_now(struct peak_time_ref *t=
ime_ref, u32 ts_now);
>  void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
>  void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
>  			struct timeval *tv);
> -
> +int peak_usb_netif_rx(struct sk_buff *skb,
> +		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high);
>  void peak_usb_async_complete(struct urb *urb);
>  void peak_usb_restart_complete(struct peak_usb_device *dev);
> +
>  #endif
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> new file mode 100644
> index 0000000..57d73b5
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -0,0 +1,1070 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB FD / PCAN-USB Pro FD adapter
> + *
> + * Copyright (C) 2013-2014 Stephane Grosjean <s.grosjean@peak-system.c=
om>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +#include <linux/module.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +#include "pcan_usb_core.h"
> +#include "pcan_usb_pro.h"
> +#include "pcan_ucan.h"
> +
> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
> +
> +#define PCAN_USBPROFD_CHANNEL_COUNT	2
> +#define PCAN_USBFD_CHANNEL_COUNT	1
> +
> +/* PCAN-USB Pro FD adapter internal clock (MHz) */
> +#define PCAN_UFD_CRYSTAL_HZ		80000000

HZ or MHz?

> +
> +#define PCAN_UFD_CMD_BUFFER_SIZE	512
> +#define PCAN_UFD_LOSPD_PKT_SIZE		64
> +
> +/* PCAN-USB Pro FD command timeout (ms.) */
> +#define PCAN_UFD_CMD_TIMEOUT_MS		1000
> +
> +/* PCAN-USB Pro FD rx/tx buffers size */
> +#define PCAN_UFD_RX_BUFFER_SIZE		2048
> +#define PCAN_UFD_TX_BUFFER_SIZE		512
> +
> +/* read some versions info from the hw devcie */
> +struct __packed pcan_ufd_fw_info {
> +	__le16	size_of;	/* sizeof this */
> +	__le16	type;		/* type of this structure */
> +	u8	hw_type;	/* Type of hardware (HW_TYPE_xxx) */
> +	u8	bl_version[3];	/* Bootloader version */
> +	u8	hw_version;	/* Hardware version (PCB) */
> +	u8	fw_version[3];	/* Firmware version */
> +	__le32	dev_id[2];	/* "device id" per CAN */
> +	__le32	ser_no;		/* S/N */
> +	__le32	flags;		/* special functions */
> +};
> +
> +/* handle device specific info used by the netdevices */
> +struct pcan_usb_fd_if {
> +	struct peak_usb_device *dev[PCAN_USB_MAX_CHANNEL];
> +	struct pcan_ufd_fw_info	fw_info;
> +	struct peak_time_ref	time_ref;
> +	int			cm_ignore_count;
> +	int			dev_opened_count;
> +};
> +
> +/* device information */
> +struct pcan_usb_fd_device {
> +	struct peak_usb_device	dev;
> +	struct pcan_usb_fd_if *	usb_if;
	struct pcan_usb_fd_if *usb_if
> +
> +	u8 *	cmd_buffer_addr;
	u8 *cmd_buffer_addr
> +
> +	uint	tx_error_counter;
> +	uint	rx_error_counter;
	unsigned int

Please don't use a tab after the struct foo, u8, unsinged int, etc...,
as it doesn't align.

> +};
> +
> +/* Extended USB commands (non uCAN commands) */
> +
> +/* Clock Modes command */
> +#define PCAN_UFD_CMD_CLK_SET		0x80
> +
> +#define PCAN_UFD_CLK_80MHZ		0x0
> +#define PCAN_UFD_CLK_60MHZ		0x1
> +#define PCAN_UFD_CLK_40MHZ		0x2
> +#define PCAN_UFD_CLK_30MHZ		0x3
> +#define PCAN_UFD_CLK_24MHZ		0x4
> +#define PCAN_UFD_CLK_20MHZ		0x5
> +#define PCAN_UFD_CLK_DEF		PCAN_UFD_CLK_80MHZ
> +
> +struct __packed pcan_ufd_clock {
> +	__le16	opcode_channel;
> +
> +	u8	mode;
> +	u8	unused[5];
> +};
> +
> +/* LED control command */
> +#define PCAN_UFD_CMD_LED_SET		0x86
> +
> +#define PCAN_UFD_LED_DEV		0x00
> +#define PCAN_UFD_LED_FAST		0x01
> +#define PCAN_UFD_LED_SLOW		0x02
> +#define PCAN_UFD_LED_ON			0x03
> +#define PCAN_UFD_LED_OFF		0x04
> +#define PCAN_UFD_LED_DEF		PCAN_UFD_LED_DEV
> +
> +struct __packed pcan_ufd_led {
> +	__le16	opcode_channel;
> +
> +	u8	mode;
> +	u8	unused[5];
> +};
> +
> +/* Extended usage of uCAN commands CMD_RX_FRAME_xxxABLE for PCAN-USB P=
ro FD */
> +#define PCAN_UFD_FLTEXT_CALIBRATION	0x8000
> +
> +struct __packed pcan_ufd_filter_ext {
> +	__le16	opcode_channel;
> +
> +	__le16	ext_mask;
> +	u16	unused;
> +	__le16	usb_mask;
> +};
> +
> +/* Extended usage of uCAN messages for PCAN-USB Pro FD */
> +#define PCAN_UFD_MSG_CALIBRATION	0x100
> +
> +struct __packed pcan_ufd_ts_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	__le16	usb_frame_index;
> +	u16	unused;
> +};
> +
> +#define PCAN_UFD_MSG_OVERRUN		0x101
> +
> +#define PCAN_UFD_OVMSG_CHANNEL(o)	((o)->channel & 0xf)

no deref please

> +
> +struct __packed pcan_ufd_ovr_msg {
> +	__le16	size;
> +	__le16	type;
> +	__le32	ts_low;
> +	__le32	ts_high;
> +	u8	channel;
> +	u8	unused[3];
> +};
> +
> +/* Clock mode frequency values */
> +static const u32 pcan_usb_fd_clk_freq[6] =3D {
> +	[PCAN_UFD_CLK_80MHZ] =3D 80000000,
> +	[PCAN_UFD_CLK_60MHZ] =3D 60000000,
> +	[PCAN_UFD_CLK_40MHZ] =3D 40000000,
> +	[PCAN_UFD_CLK_30MHZ] =3D 30000000,
> +	[PCAN_UFD_CLK_24MHZ] =3D 24000000,
> +	[PCAN_UFD_CLK_20MHZ] =3D 20000000
> +};
> +
> +/* build the opcode_channel field with respect to the correct endianes=
s */
> +static inline __le16 pucan_cmd_opcode_channel(int opcode, int channel)=

> +{
> +	return cpu_to_le16(PUCAN_CMD_OPCODE_CHANNEL(opcode, channel));

Just get rid of the PUCAN_CMD_OPCODE_CHANNEL here.

> +}
> +
> +/* return a device USB interface */
> +static inline
> +struct pcan_usb_fd_if *pcan_usb_fd_dev_if(struct peak_usb_device *dev)=

> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	return pdev->usb_if;
> +}
> +
> +/* return a device USB commands buffer */
> +static inline void *pcan_usb_fd_cmd_buffer(struct peak_usb_device *dev=
)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	return pdev->cmd_buffer_addr;
> +}
> +
> +/* send PCAN-USB Pro FD commands synchronously */
> +static int pcan_usb_fd_send_cmd(struct peak_usb_device *dev, void *cmd=
_tail)
> +{
> +	void *cmd_head =3D pcan_usb_fd_cmd_buffer(dev);
> +	int err;
> +	u8 *packet_ptr;
> +	int i, n =3D 1, packet_len;
> +	ptrdiff_t cmd_len;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
> +		return 0;
> +
> +	/*
> +	 * if a packet is not filled completely by commands, the command list=

> +	 * is terminated with an "end of collection" record.
> +	 */
> +	cmd_len =3D cmd_tail - cmd_head;
> +	if (cmd_len <=3D (PCAN_UFD_CMD_BUFFER_SIZE - sizeof(u64))) {
> +		memset(cmd_tail, 0xff, sizeof(u64));
> +		cmd_len +=3D sizeof(u64);
> +	}
> +
> +	packet_ptr =3D cmd_head;
> +
> +	/* firmware is not able to re-assemble 512 bytes buffer in full-speed=
 */
> +	if ((dev->udev->speed !=3D USB_SPEED_HIGH) &&
> +	    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
> +		packet_len =3D PCAN_UFD_LOSPD_PKT_SIZE;
> +		n +=3D cmd_len / packet_len;
> +	} else {
> +		packet_len =3D cmd_len;
> +	}
> +
> +	for (i =3D 0; i < n; i++) {
> +		err =3D usb_bulk_msg(dev->udev,
> +				   usb_sndbulkpipe(dev->udev,
> +						   PCAN_USBPRO_EP_CMDOUT),
> +				   packet_ptr, packet_len,
> +				   NULL, PCAN_UFD_CMD_TIMEOUT_MS);
> +		if (err) {
> +			netdev_err(dev->netdev,
> +				   "sending command failure: %d\n", err);
> +			break;
> +		}
> +
> +		packet_ptr +=3D packet_len;
> +	}
> +
> +	return err;
> +}
> +
> +static int pcan_usb_fd_set_bus(struct peak_usb_device *dev, u8 onoff)
> +{
> +	struct pucan_command *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +	u16 opcode;
> +
> +	if (onoff) {
> +		opcode =3D (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
> +				PUCAN_CMD_LISTEN_ONLY_MODE :
> +				PUCAN_CMD_NORMAL_MODE;
> +	} else {
> +		opcode =3D PUCAN_CMD_RESET_MODE;
> +	}
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx, opcod=
e);
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/*
> + * set filtering masks:
> + *
> + *	idx  in range [0..63] selects a row #idx, all rows otherwise
> + *	mask in range [0..0xffffffff] defines up to 32 CANIDs in the row(s)=

> + *
> + *	Each bit of this 64 x 32 bits array defines a CANID value:
> + *
> + *	bit[i,j] =3D 1 implies that CANID=3D(i x 32)+j will be received, wh=
ile
> + *	bit[i,j] =3D 0 implies that CANID=3D(i x 32)+j will be discarded.
> + */
> +static int pcan_usb_fd_set_filter_std(struct peak_usb_device *dev, int=
 idx,
> +				      u32 mask)
> +{
> +	struct pucan_filter_std *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +	int i, n;
> +
> +	/* select all rows when idx is out of range [0..63] */
> +	if ((idx < 0) || (idx >=3D (1 << PUCAN_FLTSTD_ROW_IDX_BITS))) {
> +		n =3D 1 << PUCAN_FLTSTD_ROW_IDX_BITS;
> +		idx =3D 0;
> +
> +	/* select the row (and only the row) otherwise */
> +	} else {
> +		n =3D idx + 1;
> +	}
> +
> +	for (i =3D idx; i < n; i++, cmd++) {
> +		cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +							PUCAN_CMD_FILTER_STD);
> +		cmd->idx =3D cpu_to_le16(i);
> +		cmd->mask =3D cpu_to_le32(mask);
> +	}
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, cmd);
> +}
> +
> +/*
> + * set/unset notifications filter:
> + *
> + *	onoff	sets(1)/unset(0) notifications
> + *	mask	each bit defines a kind of notification to set/unset
> + */
> +static int pcan_usb_fd_set_filter_ext(struct peak_usb_device *dev,
> +				      int onoff, u16 ext_mask, u16 usb_mask)
bool onoff
> +{
> +	struct pcan_ufd_filter_ext *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +					(onoff) ? PUCAN_CMD_RX_FRAME_ENABLE :
> +						  PUCAN_CMD_RX_FRAME_DISABLE);
> +
> +	cmd->ext_mask =3D cpu_to_le16(ext_mask);
> +	cmd->usb_mask =3D cpu_to_le16(usb_mask);
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/* setup LED control */
> +static int pcan_usb_fd_set_can_led(struct peak_usb_device *dev, u8 led=
_mode)
> +{
> +	struct pcan_ufd_led *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +						       PCAN_UFD_CMD_LED_SET);
> +	cmd->mode =3D led_mode;
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/* set CAN clock domain */
> +static int pcan_usb_fd_set_clock_domain(struct peak_usb_device *dev,
> +					u8 clk_mode)
> +{
> +	struct pcan_ufd_clock *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +						       PCAN_UFD_CMD_CLK_SET);
> +	cmd->mode =3D clk_mode;
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/* set bittiming for CAN and CAN-FD header */
> +static int pcan_usb_fd_set_bittiming_slow(struct peak_usb_device *dev,=

> +					  struct can_bittiming *bt)
> +{
> +	struct pucan_timing_slow *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +						       PUCAN_CMD_TIMING_SLOW);
> +	cmd->sjw_t =3D PUCAN_TSLOW_SJW_T(bt->sjw - 1,
> +				dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
> +
> +	cmd->tseg2 =3D PUCAN_TSLOW_TSEG2(bt->phase_seg2 - 1);
> +	cmd->tseg1 =3D PUCAN_TSLOW_TSEG1(bt->prop_seg + bt->phase_seg1 - 1);
> +	cmd->brp =3D cpu_to_le16(PUCAN_TSLOW_BRP(bt->brp - 1));
> +
> +	cmd->ewl =3D 96;	/* default */
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/* set CAN-FD bittiming for data */
> +static int pcan_usb_fd_set_bittiming_fast(struct peak_usb_device *dev,=

> +					  struct can_bittiming *bt)
> +{
> +	struct pucan_timing_fast *cmd =3D pcan_usb_fd_cmd_buffer(dev);
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +						       PUCAN_CMD_TIMING_FAST);
> +	cmd->sjw =3D PUCAN_TFAST_SJW(bt->sjw - 1);
> +	cmd->tseg2 =3D PUCAN_TFAST_TSEG2(bt->phase_seg2 - 1);
> +	cmd->tseg1 =3D PUCAN_TFAST_TSEG1(bt->prop_seg + bt->phase_seg1 - 1);
> +	cmd->brp =3D cpu_to_le16(PUCAN_TFAST_BRP(bt->brp - 1));
> +
> +	/* send the command */
> +	return pcan_usb_fd_send_cmd(dev, ++cmd);
> +}
> +
> +/*
> + * handle restart but in asynchronously way
> + * (uses PCAN-USB Pro code to complete)
> + */
> +static int pcan_usb_fd_restart_async(struct peak_usb_device *dev,
> +				     struct urb *urb, u8 *buf)
> +{
> +	struct pucan_command *cmd =3D (struct pucan_command *)buf;
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(dev->ctrl_idx,
> +				(dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) ?
> +						PUCAN_CMD_LISTEN_ONLY_MODE :
> +						PUCAN_CMD_NORMAL_MODE);
> +	/* EOC */
> +	memset(cmd+1, 0xff, sizeof(struct pucan_command));
	cmd + 1
> +
> +	usb_fill_bulk_urb(urb, dev->udev,
> +			  usb_sndbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDOUT),
> +			  buf, 2 * sizeof(struct pucan_command),
> +			  pcan_usb_pro_restart_complete, dev);
> +
> +	return usb_submit_urb(urb, GFP_ATOMIC);
> +}
> +
> +static int pcan_usb_fd_drv_loaded(struct peak_usb_device *dev, int loa=
ded)
bool loaded
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +
> +	pdev->cmd_buffer_addr[0] =3D 0;
> +	pdev->cmd_buffer_addr[1] =3D !!loaded;
> +
> +	return pcan_usb_pro_send_req(dev,
> +				PCAN_USBPRO_REQ_FCT,
> +				PCAN_USBPRO_FCT_DRVLD,
> +				pdev->cmd_buffer_addr,
> +				PCAN_USBPRO_FCT_DRVLD_REQ_LEN);
> +}
> +
> +static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
> +				     struct pucan_msg *rx_msg)
> +{
> +	struct pucan_rx_msg *rm =3D (struct pucan_rx_msg *)rx_msg;
> +	struct peak_usb_device *dev =3D usb_if->dev[PUCAN_MSG_CHANNEL(rm)];
> +	struct net_device *netdev =3D dev->netdev;
> +	struct canfd_frame *cfd;
> +	struct sk_buff *skb;
> +	const u16 rx_msg_flags =3D le16_to_cpu(rm->flags);
> +
> +	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
> +		/* CANFD frame case */
> +		skb =3D alloc_canfd_skb(netdev, &cfd);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		if (rx_msg_flags & PUCAN_MSG_BITRATE_SWITCH)
> +			cfd->flags |=3D CANFD_BRS;
> +
> +		if (rx_msg_flags & PUCAN_MSG_ERROR_STATE_IND)
> +			cfd->flags |=3D CANFD_ESI;
> +
> +		cfd->len =3D can_dlc2len(PUCAN_MSG_DLC(rm));

please use get_canfd_dlc() first:

	cfd->len =3D can_dlc2len(get_canfd_dlc(PUCAN_MSG_DLC(rm)));

Although AFAICS it makes no difference here.

> +	} else {
> +		/* CANFD frame case */
> +		skb =3D alloc_can_skb(netdev, (struct can_frame **)&cfd);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		cfd->len =3D get_can_dlc(PUCAN_MSG_DLC(rm));
> +	}
> +
> +	cfd->can_id =3D le32_to_cpu(rm->can_id);
> +
> +	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
> +		cfd->can_id |=3D CAN_EFF_FLAG;
> +
> +	if (rx_msg_flags & PUCAN_MSG_RTR)
> +		cfd->can_id |=3D CAN_RTR_FLAG;
> +	else
> +		memcpy(cfd->data, rm->d, cfd->len);
> +
> +	peak_usb_netif_rx(skb, &usb_if->time_ref,
> +			  le32_to_cpu(rm->ts_low), le32_to_cpu(rm->ts_high));
> +
> +	netdev->stats.rx_packets++;
> +	netdev->stats.rx_bytes +=3D cfd->len;
> +
> +	return 0;
> +}
> +
> +/* handle uCAN status message */
> +static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
> +				     struct pucan_msg *rx_msg)
> +{
> +	struct pucan_status_msg *st =3D (struct pucan_status_msg *)rx_msg;
> +	struct peak_usb_device *dev =3D usb_if->dev[PUCAN_STMSG_CHANNEL(st)];=

> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> +	struct net_device *netdev =3D dev->netdev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;

Please talk to Wolfgang and Andri Yngvason about the state handling.

> +
> +	/* nothing should be sent while in BUS_OFF state */
> +	if (dev->can.state =3D=3D CAN_STATE_BUS_OFF)
> +		return 0;
> +
> +	if (PUCAN_STMSG_BUSOFF(st)) {
> +		new_state =3D CAN_STATE_BUS_OFF;
> +	} else if (PUCAN_STMSG_PASSIVE(st)) {
> +		new_state =3D CAN_STATE_ERROR_PASSIVE;
> +	} else if (PUCAN_STMSG_WARNING(st)) {
> +		new_state =3D CAN_STATE_ERROR_WARNING;
> +	} else {
> +		/* no error bit (so, no error skb, back to active state) */
> +		dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +		pdev->tx_error_counter =3D 0;
> +		pdev->rx_error_counter =3D 0;
> +		return 0;
> +	}
> +
> +	/* donot post any error if current state didn't change */
do not
> +	if (dev->can.state =3D=3D new_state)
> +		return 0;
> +
> +	/* allocate an skb to store the error frame */
> +	skb =3D alloc_can_err_skb(netdev, &cf);
> +	if (!skb)
> +		return -ENOMEM;

In case of an OOM, the some vital state change code is missed, please
rearange your code to deal with OOM.

> +
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		cf->can_id |=3D CAN_ERR_BUSOFF;
> +		can_bus_off(netdev);
> +		break;
> +
> +	case CAN_STATE_ERROR_PASSIVE:
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		if (pdev->rx_error_counter > 127)
> +			cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
> +		if (pdev->tx_error_counter > 127)
> +			cf->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
> +
> +		dev->can.can_stats.error_passive++;
> +		break;
> +
> +	case CAN_STATE_ERROR_WARNING:
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		if (pdev->rx_error_counter > 96)
> +			cf->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
> +		if (pdev->tx_error_counter > 96)
> +			cf->data[1] |=3D CAN_ERR_CRTL_TX_WARNING;
> +
> +		dev->can.can_stats.error_warning++;
> +		break;
> +
> +	default:
> +		/* default case never happens, only for warnings */
> +		new_state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	case CAN_STATE_ERROR_ACTIVE:	/* fallthrough */
> +		pdev->tx_error_counter =3D 0;
> +		pdev->rx_error_counter =3D 0;
> +		break;
> +	}
> +
> +	dev->can.state =3D new_state;
> +
> +	peak_usb_netif_rx(skb, &usb_if->time_ref,
> +			  le32_to_cpu(st->ts_low), le32_to_cpu(st->ts_high));
> +
> +	netdev->stats.rx_packets++;
> +	netdev->stats.rx_bytes +=3D cf->can_dlc;
> +
> +	return 0;
> +}
> +
> +/* handle uCAN error message */
> +static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
> +				    struct pucan_msg *rx_msg)
> +{
> +	struct pucan_error_msg *er =3D (struct pucan_error_msg *)rx_msg;
> +	struct peak_usb_device *dev =3D usb_if->dev[PUCAN_ERMSG_CHANNEL(er)];=

> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +
> +	/* keep a trace of tx and rx error counters for later use */
> +	pdev->tx_error_counter =3D er->tx_err_cnt;
> +	pdev->rx_error_counter =3D er->rx_err_cnt;

Does is make sense to implement priv->can.do_get_berr_counter, too? You
might fill a "struct can_berr_counter" here instead of using
{r,t}x_error_counter.

> +
> +	return 0;
> +}
> +
> +/* handle uCAN overrun message */
> +static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
> +				      struct pucan_msg *rx_msg)
> +{
> +	struct pcan_ufd_ovr_msg *ov =3D (struct pcan_ufd_ovr_msg *)rx_msg;
> +	struct peak_usb_device *dev =3D usb_if->dev[PCAN_UFD_OVMSG_CHANNEL(ov=
)];
> +	struct net_device *netdev =3D dev->netdev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	/* allocate an skb to store the error frame */
> +	skb =3D alloc_can_err_skb(netdev, &cf);
> +	if (!skb)
> +		return -ENOMEM;

Please to the stats, even in case of OOM.

> +
> +	cf->can_id |=3D CAN_ERR_CRTL;
> +	cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +	peak_usb_netif_rx(skb, &usb_if->time_ref,
> +			  le32_to_cpu(ov->ts_low), le32_to_cpu(ov->ts_high));
> +
> +	netdev->stats.rx_over_errors++;
> +	netdev->stats.rx_errors++;
> +
> +	return 0;
> +}
> +
> +/* handle USB calibration message */
> +static void pcan_usb_fd_decode_ts(struct pcan_usb_fd_if *usb_if,
> +				  struct pucan_msg *rx_msg)
> +{
> +	struct pcan_ufd_ts_msg *ts =3D (struct pcan_ufd_ts_msg *)rx_msg;
> +
> +	/* should wait until clock is stabilized */
> +	if (usb_if->cm_ignore_count > 0)
> +		usb_if->cm_ignore_count--;
> +	else
> +		peak_usb_set_ts_now(&usb_if->time_ref, le32_to_cpu(ts->ts_low));
> +}
> +
> +/* callback for bulk IN urb */
> +static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct =
urb *urb)
> +{
> +	struct pcan_usb_fd_if *usb_if =3D pcan_usb_fd_dev_if(dev);
> +	struct net_device *netdev =3D dev->netdev;
> +	struct pucan_msg *rx_msg;
> +	u8 *msg_ptr, *msg_end;
> +	int err =3D 0;
> +
> +	/* loop reading all the records from the incoming message */
> +	msg_ptr =3D urb->transfer_buffer;
> +	msg_end =3D urb->transfer_buffer + urb->actual_length;
> +	for (; msg_ptr < msg_end;) {
> +		u16 rx_msg_type, rx_msg_size;
> +
> +		rx_msg =3D (struct pucan_msg *)msg_ptr;
> +		if (!rx_msg->size) {

You might access transfer_buffer out of bounds here. Please adjust the
check in the for() loop.

> +			/* null packet found: end of list */
> +			break;
> +		}
> +
> +		rx_msg_size =3D le16_to_cpu(rx_msg->size);
> +		rx_msg_type =3D le16_to_cpu(rx_msg->type);
> +
> +		/* check if the record goes out of current packet */

rx_msg_size is not to be trusted, as it comes from the outside. You have
to check if size is big enough for the advertised rx_msg_type.

> +		if (msg_ptr + rx_msg_size > msg_end) {
> +			netdev_err(netdev,
> +				   "got frag rec: should inc usb rx buf sze\n");
> +			err =3D -EBADMSG;
> +			break;
> +		}
> +

Why don't you case the rx_msg into the correct type here?

> +		switch (rx_msg_type) {
> +		case PUCAN_MSG_CAN_RX:
> +			err =3D pcan_usb_fd_decode_canmsg(usb_if, rx_msg);
> +			if (err < 0)
> +				goto fail;
> +			break;
> +
> +		case PCAN_UFD_MSG_CALIBRATION:
> +			pcan_usb_fd_decode_ts(usb_if, rx_msg);
> +			break;
> +
> +		case PUCAN_MSG_ERROR:
> +			err =3D pcan_usb_fd_decode_error(usb_if, rx_msg);
> +			if (err < 0)
> +				goto fail;
> +			break;
> +
> +		case PUCAN_MSG_STATUS:
> +			err =3D pcan_usb_fd_decode_status(usb_if, rx_msg);
> +			if (err < 0)
> +				goto fail;
> +			break;
> +
> +		case PCAN_UFD_MSG_OVERRUN:
> +			err =3D pcan_usb_fd_decode_overrun(usb_if, rx_msg);
> +			if (err < 0)
> +				goto fail;
> +			break;
> +
> +		default:
> +			netdev_err(netdev,
> +				   "unhandled msg type 0x%02x (%d): ignored\n",
> +				   rx_msg_type, rx_msg_type);
> +			break;
> +		}
> +
> +		msg_ptr +=3D rx_msg_size;
> +	}
> +
> +fail:
> +	if (err)
> +		pcan_dump_mem("received msg",
> +			      urb->transfer_buffer, urb->actual_length);
> +	return err;
> +}
> +
> +/* CAN/CANFD frames encoding callback */
> +static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
> +				  struct sk_buff *skb, u8 *obuf, size_t *size)
> +{
> +	struct pucan_tx_msg *tx_msg =3D (struct pucan_tx_msg *)obuf;
> +	struct canfd_frame *cfd =3D (struct canfd_frame *)skb->data;
> +	u16 tx_msg_size, tx_msg_flags;
> +	u8 can_dlc;
> +
> +	tx_msg_size =3D ALIGN(sizeof(struct pucan_tx_msg) + cfd->len, 4);
> +	tx_msg->size =3D cpu_to_le16(tx_msg_size);
> +	tx_msg->type =3D cpu_to_le16(PUCAN_MSG_CAN_TX);
> +
> +	tx_msg_flags =3D 0;
> +	if (cfd->can_id & CAN_EFF_FLAG) {
> +		tx_msg_flags |=3D PUCAN_MSG_EXT_ID;
> +		tx_msg->can_id =3D cpu_to_le32(cfd->can_id & CAN_EFF_MASK);
> +	} else {
> +		tx_msg->can_id =3D cpu_to_le32(cfd->can_id & CAN_SFF_MASK);
> +	}
> +
> +	if (skb->len =3D=3D CANFD_MTU) {
can_is_canfd_skb()
> +		/* considering a CANFD frame */
> +		can_dlc =3D can_len2dlc(cfd->len);
> +
> +		tx_msg_flags |=3D PUCAN_MSG_EXT_DATA_LEN;
> +
> +		if (cfd->flags & CANFD_BRS)
> +			tx_msg_flags |=3D PUCAN_MSG_BITRATE_SWITCH;
> +
> +		if (cfd->flags & CANFD_ESI)
> +			tx_msg_flags |=3D PUCAN_MSG_ERROR_STATE_IND;
> +	} else {
> +		/* CAND 2.0 frames */
> +		can_dlc =3D cfd->len;
> +
> +		if (cfd->can_id & CAN_RTR_FLAG)
> +			tx_msg_flags |=3D PUCAN_MSG_RTR;
> +	}
> +
> +	tx_msg->flags =3D cpu_to_le16(tx_msg_flags);
> +	tx_msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, can_dlc)=
;
> +	memcpy(tx_msg->d, cfd->data, cfd->len);
> +
> +	/* add null size message to tag the end (messages are 32-bits aligned=
)*/

add space before the */, make a multiline comment if needed.

> +	tx_msg =3D (struct pucan_tx_msg *)(obuf + tx_msg_size);
> +
> +	tx_msg->size =3D 0;
> +
> +	/* set the whole size of the USB packet to send */
> +	*size =3D tx_msg_size + sizeof(u32);
> +
> +	return 0;
> +}
> +
> +/* start the interface (last chance before set bus on) */
> +static int pcan_usb_fd_start(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	int err;
> +
> +	/* set filter mode: all acceptance */
> +	err =3D pcan_usb_fd_set_filter_std(dev, -1, 0xffffffff);
> +	if (err)
> +		return err;
> +
> +	/* opening first device: */
> +	if (pdev->usb_if->dev_opened_count =3D=3D 0) {
> +		/* reset time_ref */
> +		peak_usb_init_time_ref(&pdev->usb_if->time_ref,
> +				       &pcan_usb_pro_fd);
> +
> +		/* enable USB calibration messages */
> +		err =3D pcan_usb_fd_set_filter_ext(dev, 1,
> +						 PUCAN_FLTEXT_ERROR,
> +						 PCAN_UFD_FLTEXT_CALIBRATION);
> +	}
> +
> +	pdev->usb_if->dev_opened_count++;
> +
> +	/* reset cached error counters */
> +	pdev->tx_error_counter =3D 0;
> +	pdev->rx_error_counter =3D 0;
> +
> +	return err;
> +}
> +
> +/* stop interface (last chance before set bus off) */
> +static int pcan_usb_fd_stop(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +
> +	/* turn off special msgs for that interface if no other dev opened */=

> +	if (pdev->usb_if->dev_opened_count =3D=3D 1)
> +		pcan_usb_fd_set_filter_ext(dev, 0,
> +					   PUCAN_FLTEXT_ERROR,
> +					   PCAN_UFD_FLTEXT_CALIBRATION);
> +	pdev->usb_if->dev_opened_count--;
> +
> +	return 0;
> +}
> +
> +/* called when probing, to initialize a device object */
> +static int pcan_usb_fd_init(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +	int i, err =3D -ENOMEM;
> +
> +	/* do this for 1st channel only */
> +	if (!dev->prev_siblings) {
> +		/* allocate netdevices common structure attached to first one */
> +		pdev->usb_if =3D kzalloc(sizeof(*pdev->usb_if), GFP_KERNEL);
> +		if (!pdev->usb_if)
> +			goto err_out;
> +
> +		/* allocate command buffer once for all for the interface */
> +		pdev->cmd_buffer_addr =3D kmalloc(PCAN_UFD_CMD_BUFFER_SIZE,
> +						GFP_KERNEL);
> +		if (!pdev->cmd_buffer_addr)
> +			goto err_out_1;
> +
> +		/* number of ts msgs to ignore before taking one into account */
> +		pdev->usb_if->cm_ignore_count =3D 5;
> +
> +		err =3D pcan_usb_pro_send_req(dev, PCAN_USBPRO_REQ_INFO,
> +					    PCAN_USBPRO_INFO_FW,
> +					    &pdev->usb_if->fw_info,
> +					    sizeof(pdev->usb_if->fw_info));
> +		if (err) {
> +			dev_err(dev->netdev->dev.parent,
> +				"unable to read %s firmware info (err %d)\n",
> +				dev->adapter->name, err);
> +			goto err_out_2;
> +		}
> +
> +		/*
> +		 * explicit use of dev_xxx() instead of netdev_xxx() here:
> +		 * information displayed are related to the device itself, not
> +		 * to the canx (channel) device.
> +		 */
> +		dev_info(dev->netdev->dev.parent,
> +			 "PEAK-System %s v%u fw v%u.%u.%u (%u channels)\n",
> +			 dev->adapter->name, pdev->usb_if->fw_info.hw_version,
> +			 pdev->usb_if->fw_info.fw_version[0],
> +			 pdev->usb_if->fw_info.fw_version[1],
> +			 pdev->usb_if->fw_info.fw_version[2],
> +			 dev->adapter->ctrl_count);
> +
> +		/* tell the hardware the can driver is running */
> +		err =3D pcan_usb_fd_drv_loaded(dev, 1);
> +		if (err) {
> +			dev_err(dev->netdev->dev.parent,
> +				"unable to tell %s driver is loaded (err %d)\n",
> +				dev->adapter->name, err);
> +			goto err_out_2;
> +		}
> +
> +	} else {
> +		/* otherwise, simply copy previous sibling's values */
> +		struct pcan_usb_fd_device *ppdev =3D
> +			container_of(dev->prev_siblings,
> +				     struct pcan_usb_fd_device, dev);
> +
> +		pdev->usb_if =3D ppdev->usb_if;
> +		pdev->cmd_buffer_addr =3D ppdev->cmd_buffer_addr;
> +	}
> +
> +	pdev->usb_if->dev[dev->ctrl_idx] =3D dev;
> +	dev->device_number =3D
> +		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
> +
> +	/* set clock domain */
> +	for (i =3D 0; i < ARRAY_SIZE(pcan_usb_fd_clk_freq); i++)
> +		if (dev->adapter->clock.freq =3D=3D pcan_usb_fd_clk_freq[i])
> +			break;
> +
> +	if (i >=3D ARRAY_SIZE(pcan_usb_fd_clk_freq)) {
> +		dev_warn(dev->netdev->dev.parent,
> +			 "incompatible clock frequencies\n");
> +		err =3D -EINVAL;
> +		goto err_out_2;
> +	}
> +
> +	pcan_usb_fd_set_clock_domain(dev, i);
> +
> +	/* set LED in default state (end of init phase) */
> +	pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF);
> +
> +	return 0;
> +
> +err_out_2:
> +	kfree(pdev->cmd_buffer_addr);
> +err_out_1:
> +	kfree(pdev->usb_if);
> +err_out:
> +	return err;
> +}
> +
> +/* called when driver module is being unloaded */
> +static void pcan_usb_fd_exit(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +
> +	/*
> +	 * when rmmod called before unplug and if down, should reset things
> +	 * before leaving
> +	 */

multiline comments in net are like this:

/* foo
 * bar
 */
> +	if (dev->can.state !=3D CAN_STATE_STOPPED) {
> +		/* set bus off on the corresponding channel */
> +		pcan_usb_fd_set_bus(dev, 0);
> +	}
> +
> +	/* switch off corresponding CAN LEDs */
> +	pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_OFF);
> +
> +	/* if channel #0 (only) */
> +	if (dev->ctrl_idx =3D=3D 0) {
> +		/* turn off calibration message if any device were opened */
> +		if (pdev->usb_if->dev_opened_count > 0)
> +			pcan_usb_fd_set_filter_ext(dev, 0,
> +						   PUCAN_FLTEXT_ERROR,
> +						   PCAN_UFD_FLTEXT_CALIBRATION);
> +
> +		/* tell USB adapter that the driver is being unloaded */
> +		pcan_usb_fd_drv_loaded(dev, 0);
> +	}
> +}
> +
> +/* called when the USB adapter is unplugged */
> +static void pcan_usb_fd_free(struct peak_usb_device *dev)
> +{
> +	/* last device: can free shared objects now */
> +	if (!dev->prev_siblings && !dev->next_siblings) {
> +		struct pcan_usb_fd_device *pdev =3D
> +			container_of(dev, struct pcan_usb_fd_device, dev);
> +
> +		/* free commands buffer */
> +		kfree(pdev->cmd_buffer_addr);
> +
> +		/* free usb interface object */
> +		kfree(pdev->usb_if);
> +	}
> +}
> +
> +/* describes the PCAN-USB FD adapter */
> +struct peak_usb_adapter pcan_usb_fd =3D {
> +	.name =3D "PCAN-USB FD",
> +	.device_id =3D PCAN_USBFD_PRODUCT_ID,
> +	.ctrl_count =3D PCAN_USBFD_CHANNEL_COUNT,
> +	.ctrlmode_supported =3D CAN_CTRLMODE_FD |
> +			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
> +	.clock =3D {
> +		.freq =3D PCAN_UFD_CRYSTAL_HZ,
> +	},
> +	.bittiming_const =3D {
> +		.name =3D "pcan_usb_fd",
> +		.tseg1_min =3D 1,
> +		.tseg1_max =3D 64,
> +		.tseg2_min =3D 1,
> +		.tseg2_max =3D 16,
> +		.sjw_max =3D 16,
> +		.brp_min =3D 1,
> +		.brp_max =3D 1024,
> +		.brp_inc =3D 1,
> +	},
> +	.data_bittiming_const =3D {
> +		.name =3D "pcan_usb_fd",
> +		.tseg1_min =3D 1,
> +		.tseg1_max =3D 16,
> +		.tseg2_min =3D 1,
> +		.tseg2_max =3D 8,
> +		.sjw_max =3D 4,
> +		.brp_min =3D 1,
> +		.brp_max =3D 1024,
> +		.brp_inc =3D 1,
> +	},
> +
> +	/* size of device private data */
> +	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> +
> +	/* timestamps usage */
> +	.ts_used_bits =3D 32,
> +	.ts_period =3D 1000000, /* calibration period in ts. */
> +	.us_per_ts_scale =3D 1, /* us =3D (ts * scale) >> shift */
> +	.us_per_ts_shift =3D 0,
> +
> +	/* give here messages in/out endpoints */
> +	.ep_msg_in =3D PCAN_USBPRO_EP_MSGIN,
> +	.ep_msg_out =3D {PCAN_USBPRO_EP_MSGOUT_0},
> +
> +	/* size of rx/tx usb buffers */
> +	.rx_buffer_size =3D PCAN_UFD_RX_BUFFER_SIZE,
> +	.tx_buffer_size =3D PCAN_UFD_TX_BUFFER_SIZE,
> +
> +	/* device callbacks */
> +	.intf_probe =3D pcan_usb_pro_probe,	/* same as PCAN-USB Pro */
> +	.dev_init =3D pcan_usb_fd_init,
> +
> +	.dev_exit =3D pcan_usb_fd_exit,
> +	.dev_free =3D pcan_usb_fd_free,
> +	.dev_set_bus =3D pcan_usb_fd_set_bus,
> +	.dev_set_bittiming =3D pcan_usb_fd_set_bittiming_slow,
> +	.dev_set_data_bittiming =3D pcan_usb_fd_set_bittiming_fast,
> +	.dev_decode_buf =3D pcan_usb_fd_decode_buf,
> +	.dev_start =3D pcan_usb_fd_start,
> +	.dev_stop =3D pcan_usb_fd_stop,
> +	.dev_restart_async =3D pcan_usb_fd_restart_async,
> +	.dev_encode_msg =3D pcan_usb_fd_encode_msg,
> +};
> +
> +/* describes the PCAN-USB Pro FD adapter */
> +struct peak_usb_adapter pcan_usb_pro_fd =3D {
> +	.name =3D "PCAN-USB Pro FD",
> +	.device_id =3D PCAN_USBPROFD_PRODUCT_ID,
> +	.ctrl_count =3D PCAN_USBPROFD_CHANNEL_COUNT,
> +	.ctrlmode_supported =3D CAN_CTRLMODE_FD |
> +			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
> +	.clock =3D {
> +		.freq =3D PCAN_UFD_CRYSTAL_HZ,
> +	},
> +	.bittiming_const =3D {
> +		.name =3D "pcan_usb_pro_fd",
> +		.tseg1_min =3D 1,
> +		.tseg1_max =3D 64,
> +		.tseg2_min =3D 1,
> +		.tseg2_max =3D 16,
> +		.sjw_max =3D 16,
> +		.brp_min =3D 1,
> +		.brp_max =3D 1024,
> +		.brp_inc =3D 1,
> +	},
> +	.data_bittiming_const =3D {
> +		.name =3D "pcan_usb_pro_fd",
> +		.tseg1_min =3D 1,
> +		.tseg1_max =3D 16,
> +		.tseg2_min =3D 1,
> +		.tseg2_max =3D 8,
> +		.sjw_max =3D 4,
> +		.brp_min =3D 1,
> +		.brp_max =3D 1024,
> +		.brp_inc =3D 1,
> +	},
> +
> +	/* size of device private data */
> +	.sizeof_dev_private =3D sizeof(struct pcan_usb_fd_device),
> +
> +	/* timestamps usage */
> +	.ts_used_bits =3D 32,
> +	.ts_period =3D 1000000, /* calibration period in ts. */
> +	.us_per_ts_scale =3D 1, /* us =3D (ts * scale) >> shift */
> +	.us_per_ts_shift =3D 0,
> +
> +	/* give here messages in/out endpoints */
> +	.ep_msg_in =3D PCAN_USBPRO_EP_MSGIN,
> +	.ep_msg_out =3D {PCAN_USBPRO_EP_MSGOUT_0, PCAN_USBPRO_EP_MSGOUT_1},
> +
> +	/* size of rx/tx usb buffers */
> +	.rx_buffer_size =3D PCAN_UFD_RX_BUFFER_SIZE,
> +	.tx_buffer_size =3D PCAN_UFD_TX_BUFFER_SIZE,
> +
> +	/* device callbacks */
> +	.intf_probe =3D pcan_usb_pro_probe,	/* same as PCAN-USB Pro */
> +	.dev_init =3D pcan_usb_fd_init,
> +
> +	.dev_exit =3D pcan_usb_fd_exit,
> +	.dev_free =3D pcan_usb_fd_free,
> +	.dev_set_bus =3D pcan_usb_fd_set_bus,
> +	.dev_set_bittiming =3D pcan_usb_fd_set_bittiming_slow,
> +	.dev_set_data_bittiming =3D pcan_usb_fd_set_bittiming_fast,
> +	.dev_decode_buf =3D pcan_usb_fd_decode_buf,
> +	.dev_start =3D pcan_usb_fd_start,
> +	.dev_stop =3D pcan_usb_fd_stop,
> +	.dev_restart_async =3D pcan_usb_fd_restart_async,
> +	.dev_encode_msg =3D pcan_usb_fd_encode_msg,
> +};

What about the following hunks (but not the .ctrlmode_supported) ? They
can go into a seperate patch which comes first?

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index 4cfa3b8..a764045 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -27,14 +27,6 @@
> =20
>  MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
> =20
> -/* PCAN-USB Pro Endpoints */
> -#define PCAN_USBPRO_EP_CMDOUT		1
> -#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
> -#define PCAN_USBPRO_EP_MSGOUT_0		2
> -#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
> -#define PCAN_USBPRO_EP_MSGOUT_1		3
> -#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
> -
>  #define PCAN_USBPRO_CHANNEL_COUNT	2
> =20
>  /* PCAN-USB Pro adapter internal clock (MHz) */
> @@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_de=
vice *dev,
>  	return (i >=3D PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
>  }
> =20
> -static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_=
id,
> -				 int req_value, void *req_addr, int req_size)
> +int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
> +			  int req_value, void *req_addr, int req_size)
>  {
>  	int err;
>  	u8 req_type;
> @@ -475,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct peak_u=
sb_device *dev,
>  	return pcan_usb_pro_set_bitrate(dev, ccbt);
>  }
> =20
> -static void pcan_usb_pro_restart_complete(struct urb *urb)
> +void pcan_usb_pro_restart_complete(struct urb *urb)
>  {
>  	/* can delete usb resources */
>  	peak_usb_async_complete(urb);
> @@ -977,7 +969,7 @@ static void pcan_usb_pro_free(struct peak_usb_devic=
e *dev)
>  /*
>   * probe function for new PCAN-USB Pro usb interface
>   */
> -static int pcan_usb_pro_probe(struct usb_interface *intf)
> +int pcan_usb_pro_probe(struct usb_interface *intf)
>  {
>  	struct usb_host_interface *if_desc;
>  	int i;
> @@ -1015,6 +1007,7 @@ struct peak_usb_adapter pcan_usb_pro =3D {
>  	.name =3D "PCAN-USB Pro",
>  	.device_id =3D PCAN_USBPRO_PRODUCT_ID,
>  	.ctrl_count =3D PCAN_USBPRO_CHANNEL_COUNT,
> +	.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,
>  	.clock =3D {
>  		.freq =3D PCAN_USBPRO_CRYSTAL_HZ,
>  	},
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.h
> index 837cee2..31cef84 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
> @@ -27,6 +27,14 @@
>  #define PCAN_USBPRO_INFO_BL		0
>  #define PCAN_USBPRO_INFO_FW		1
> =20
> +/* PCAN-USB Pro (FD) Endpoints */
> +#define PCAN_USBPRO_EP_CMDOUT		1
> +#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
> +#define PCAN_USBPRO_EP_MSGOUT_0		2
> +#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
> +#define PCAN_USBPRO_EP_MSGOUT_1		3
> +#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
> +
>  /* Vendor Request value for XXX_FCT */
>  #define PCAN_USBPRO_FCT_DRVLD		5 /* tell device driver is loaded */
>  #define PCAN_USBPRO_FCT_DRVLD_REQ_LEN	16
> @@ -176,4 +184,10 @@ union pcan_usb_pro_rec {
>  	struct pcan_usb_pro_txmsg	tx_msg;
>  };
> =20
> +extern int pcan_usb_pro_probe(struct usb_interface *intf);
> +extern int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_=
id,
> +		                                 int req_value, void *req_addr,
> +						 int req_size);
> +extern void pcan_usb_pro_restart_complete(struct urb *urb);

IIRC we're killing the "extern" in function definitions in the kernel.

> +
>  #endif
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--CkIgEcLwRggGOsWghd49inw3SB9cRmw49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrWbFAAoJECte4hHFiupUQ50P/AviujzNRw+GL9iK37lY7wff
+rzBxJrTfV6oL8kwoV+hXMGX6mqGZ0TK4DvUAQCZH5KndIntcHwvSTI0sJu8prGq
Hb2HsDSe+yeAQC/zeoNBcvzRn3EEjlMcBKcGull2B7ZfIuNRxWYhq4sN4RXRVsUs
pjINHXwp+GxVEdRC4+2lVXSUDDdymcP+CP+I7aAcq+0BPnRE0tQBxN1ZkHc86Nzn
nW03rpP6jwrahJDoOhbXYDEwtL9k9qYbtebl7bYGJG3bFGN1/Xmp7VwcbEK9APwQ
X0oWMmB2NC2F4ZhNnhxmvtpDF5MN47kvGq+uQRko4Wc7xYv3/PLycIVVQo1aQSK9
SK7TuVxZ/lEU+ZSudFl1Tho0aV+IKKaQztGpboHy9aZud54Z69eOPJcBQ+ZBmEas
8cT8KVJLWhoqIOd7V660g4yJgbB5uo6M8ubeZEMmFc6mkm+UzDq9jPvkWBzZR1LF
tkNgDUO5bHDsyGea9micw4Olm5oRiqtYNq1LpXp6VAPKMFPleIakGh4u3Zkw9Ri1
cZccrKFr5dCfP9fHXpIediG+7mvum+jS22mvVQ7vDLnk2YYsX/Zj+9PPEep8b8TX
J78TbE1yAvrkFd1W1PmB2O0MvBfeTwFWJ2gtuZAHweYx1A/zx2k01HidUvJdq3Fr
Or3BOHoKOpScD33urvmj
=Oye6
-----END PGP SIGNATURE-----

--CkIgEcLwRggGOsWghd49inw3SB9cRmw49--

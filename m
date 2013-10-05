From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: GS_USB
Date: Sat, 05 Oct 2013 22:36:02 +0200
Message-ID: <52507832.8000709@grandegger.com>
References: <1380889887.22484.2.camel@blackbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40909 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab3JEUgI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Oct 2013 16:36:08 -0400
In-Reply-To: <1380889887.22484.2.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>

On 10/04/2013 02:31 PM, Max S. wrote:
> I forgot to set a subject for this email last time i sent it :/
> It probably never made it out of anyone=92s spam filters.
> Here it is again
>=20
> Hello All,
>=20
> Whats the protocol for getting a driver into the mainline kernel?

Simply post it here "inline" on the mailing list after you have done th=
e
usual checkpatch.pl validation.

> I've reached a working and fairly stable state with the CAN adapter I=
'm
> working on, and would like to get its driver mainlined.
>=20
> Attached is a patch.

I inlined it here for review:

>>From 2e4c4df9aae119279eb0913db0b7bc1d1025879a Mon Sep 17 00:00:00 200=
1
> From: Maximilian Schneider <max@schneidersoft.net>
> Date: Wed, 2 Oct 2013 18:48:26 +0000
> Subject: [PATCH] GS_USB CAN Driver.

A few more words here about the device and this driver are welcome.

>=20
> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
> ---
>  drivers/net/can/usb/Kconfig  |    8 +
>  drivers/net/can/usb/Makefile |    1 +
>  drivers/net/can/usb/gs_usb.c | 1121 ++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 1130 insertions(+)
>  create mode 100644 drivers/net/can/usb/gs_usb.c
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfi=
g
> index fc96a3d..f5e3e8c 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -54,4 +54,12 @@ config CAN_8DEV_USB
>  	  This driver supports the USB2CAN interface
>  	  from 8 devices (http://www.8devices.com).
> =20
> +config CAN_GS_USB
> +	tristate "Geschwister Schneider UG interfaces"
> +	---help---
> +	  This driver supports the Geschwister Schneider USB/CAN devices.
> +	  If unsure choose N,
> +	  choose Y for built in support,
> +	  M to compile as module (module will be named: gs_usb).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makef=
ile
> index becef46..c21a521 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -7,5 +7,6 @@ obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
>  obj-$(CONFIG_CAN_KVASER_USB) +=3D kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb/
>  obj-$(CONFIG_CAN_8DEV_USB) +=3D usb_8dev.o
> +obj-$(CONFIG_CAN_GS_USB) +=3D gs_usb.o
> =20
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_us=
b.c
> new file mode 100644
> index 0000000..558fc23
> --- /dev/null
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -0,0 +1,1121 @@
> +/* CAN driver for Geschwister Schneider USB/CAN devices.
> + *
> + * Copyright (C) 2013 Geschwister Schneider Technologie-,
> + * Entwicklungs- und Vertriebs UG (Haftungsbeschr=E4nkt).
> + *
> + * Many thanks to all socketcan devs!
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/signal.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +/* Device specific constants */
> +#define USB_GSUSB_1_VENDOR_ID      0x1d50
> +#define USB_GSUSB_1_PRODUCT_ID     0x606f
> +
> +#define GSUSB_ENDPOINT_IN          1
> +#define GSUSB_ENDPOINT_OUT         2
> +
> +/* Device specific constants */
> +enum gs_usb_breq {
> +	GS_USB_BREQ_HOST_FORMAT =3D 0,
> +	GS_USB_BREQ_BITTIMING,
> +	GS_USB_BREQ_MODE,
> +	GS_USB_BREQ_BERR,
> +	GS_USB_BREQ_BT_CONST,
> +	GS_USB_BREQ_DEVICE_CONFIG
> +};
> +
> +enum gs_can_mode {
> +	GS_CAN_MODE_RESET =3D 0,
> +	GS_CAN_MODE_START
> +};
> +
> +enum gs_can_state {
> +	GS_CAN_STATE_ERROR_ACTIVE =3D 0,
> +	GS_CAN_STATE_ERROR_WARNING,
> +	GS_CAN_STATE_ERROR_PASSIVE,
> +	GS_CAN_STATE_BUS_OFF,
> +	GS_CAN_STATE_STOPPED,
> +	GS_CAN_STATE_SLEEPING
> +};
> +
> +/* data types passed between host and device */
> +struct __packed gs_host_config {
> +	u32 byte_order;
> +};
> +
> +struct __packed gs_device_config {
> +	u8 reserved1;
> +	u8 reserved2;
> +	u8 reserved3;
> +	u8 icount;
> +	u32 sw_version;
> +	u32 hw_version;
> +};
> +
> +#define GS_CAN_MODE_NORMAL               0
> +#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
> +#define GS_CAN_MODE_LOOP_BACK            (1<<1)
> +#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
> +#define GS_CAN_MODE_ONE_SHOT             (1<<3)
> +
> +struct __packed gs_device_mode {
> +	u32 mode;
> +	u32 flags;
> +};
> +
> +struct __packed gs_device_state {
> +	u32 state;
> +	u32 rxerr;
> +	u32 txerr;
> +};
> +
> +struct __packed gs_device_bittiming {
> +	u32 prop_seg;
> +	u32 phase_seg1;
> +	u32 phase_seg2;
> +	u32 sjw;
> +	u32 brp;
> +};
> +
> +#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
> +#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
> +#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
> +#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
> +
> +struct __packed gs_device_bt_const {
> +	u32 feature;
> +	u32 fclk_can;
> +	u32 tseg1_min;
> +	u32 tseg1_max;
> +	u32 tseg2_min;
> +	u32 tseg2_max;
> +	u32 sjw_max;
> +	u32 brp_min;
> +	u32 brp_max;
> +	u32 brp_inc;
> +};
> +
> +#define GS_CAN_FLAG_OVERFLOW 1
> +
> +struct __packed gs_host_frame {
> +	u32 echo_id;
> +	u32 can_id;
> +
> +	u8 can_dlc;
> +	u8 channel;
> +	u8 flags;
> +	u8 reserved;
> +
> +	u8 data[8];
> +};
> +
> +#define GS_RX_BUFFER_SIZE sizeof(struct __packed gs_host_frame)
> +
> +/* Special address description flags for the CAN_ID */
> +#define GS_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
> +#define GS_RTR_FLAG 0x40000000U /* remote transmission request */
> +#define GS_ERR_FLAG 0x20000000U /* error frame */
> +
> +/* Valid bits in CAN ID for frame formats */
> +#define GS_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
> +#define GS_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
> +#define GS_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */
> +
> +/* FIXME: this macro is only a placeholder for a better function */
> +#define CONVERT_FLAGS(x) x

Please fix (=3D=3D remove?).

> +/* Only send a max of MAX_TX_URBS frames per channel to the device a=
t a time. */
> +#define MAX_TX_URBS 10
> +/* Only launch a max of MAX_RX_URBS usb requests at a time. */
> +#define MAX_RX_URBS 30
> +/* Maximum number of interfaces the driver supports per device.
> + * Current hardware only supports 2 interfaces. The future may vary.
> + */
> +#define MAX_INTF 2
> +
> +struct gs_tx_context {
> +	struct gs_can *dev;
> +	unsigned int echo_id;
> +};
> +
> +struct gs_can {
> +	struct can_priv can; /* must be the first member */
> +
> +	struct gs_usb *parent;
> +
> +	struct net_device *netdev;
> +	struct usb_device *udev;
> +	struct usb_interface *iface;
> +
> +	struct can_bittiming_const bt_const;
> +	unsigned int channel;	/* channel number */
> +
> +	spinlock_t tx_ctx_lock;

Please briefly describe what the lock is used for.

> +	struct gs_tx_context tx_context[MAX_TX_URBS];
> +
> +	struct usb_anchor tx_submitted;
> +	atomic_t active_tx_urbs;
> +};
> +
> +/* usb interface struct */
> +struct gs_usb {
> +	struct gs_can *canch[MAX_INTF];
> +
> +	struct usb_anchor rx_submitted;
> +
> +	atomic_t active_channels;
> +};
> +
> +/* 'allocate' a tx context.
> + * returns a valid tx context or NULL if there is no space.
> + */
> +static struct gs_tx_context *gs_alloc_tx_context(struct gs_can *dev)
> +{
> +	int i =3D 0;
> +	unsigned long flags;
> +	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
> +
> +	for (; i < MAX_TX_URBS; i++) {
> +		if (dev->tx_context[i].echo_id =3D=3D MAX_TX_URBS) {
> +			dev->tx_context[i].echo_id =3D i;
> +			spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
> +			return &dev->tx_context[i];
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
> +	return NULL;
> +}
> +
> +/* releases a tx context
> + */
> +static void gs_free_tx_context(struct gs_tx_context *txc)
> +{
> +	unsigned long flags;

Empty line please.

> +	spin_lock_irqsave(&txc->dev->tx_ctx_lock, flags);
> +	txc->echo_id =3D MAX_TX_URBS;
> +	spin_unlock_irqrestore(&txc->dev->tx_ctx_lock, flags);
> +}
> +
> +/* Get a tx context by id.
> + */
> +static struct gs_tx_context *gs_get_tx_context(
> +	struct gs_can *dev,
> +	unsigned int id)
> +{
> +	unsigned long flags;

Ditto

> +	spin_lock_irqsave(&dev->tx_ctx_lock, flags);
> +	if (id < MAX_TX_URBS) {
> +		if (dev->tx_context[id].echo_id =3D=3D id) {
> +			spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
> +			return &dev->tx_context[id];
> +		}
> +	}
> +	spin_unlock_irqrestore(&dev->tx_ctx_lock, flags);
> +	return NULL;
> +}
> +
> +/* Get a tx contexts id.
> + */
> +static unsigned int gs_tx_context_id(struct gs_tx_context *txc)
> +{
> +	unsigned int id;
> +	unsigned long flags;

Ditto.

> +	spin_lock_irqsave(&txc->dev->tx_ctx_lock, flags);
> +	id =3D txc->echo_id;
> +	spin_unlock_irqrestore(&txc->dev->tx_ctx_lock, flags);
> +	return id;
> +}
> +
> +#define BUFFER_SIZE sizeof(struct gs_host_frame)

I think sizeof is clear enough.

> +
> +static int gs_cmd_reset(struct gs_usb *gsusb, struct gs_can *gsdev)
> +{
> +	struct gs_device_mode *dm;
> +	struct usb_interface *intf =3D gsdev->iface;
> +	int rc;
> +
> +	dm =3D kzalloc(sizeof(*dm), GFP_KERNEL);
> +	if (!dm)
> +		return -ENOMEM;
> +
> +	dm->mode =3D GS_CAN_MODE_RESET;
> +
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_MODE,
> +			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			gsdev->channel,
> +			0,
> +			dm,
> +			sizeof(*dm),
> +			1000);
> +
> +	return rc;
> +}
> +
> +/**************************** USB CALLBACKS ************************=
**/
> +static void gs_usb_recieve_bulk_callback(struct urb *urb)
> +{
> +	struct gs_usb *usbcan =3D urb->context;
> +	struct gs_can *dev;
> +	struct net_device *netdev;
> +	int rc;
> +	struct net_device_stats *stats;
> +	struct gs_host_frame *hf =3D urb->transfer_buffer;
> +	struct gs_tx_context *txc;
> +
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	BUG_ON(!usbcan);
> +
> +	switch (urb->status) {
> +	case 0: /* success */
> +		break;
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		return;
> +	default:
> +		/* printk(KERN_INFO "Rx URB aborted (%d)\n", urb->status); */

Please remove. You have too much debug lines and printouts.

> +		/* do not resubmit aborted urbs. eg: when device goes down */
> +		return;
> +	}
> +
> +	/* device reports out of range channel id */
> +	if (hf->channel >=3D MAX_INTF)
> +		/* printk(KERN_INFO "%d] strange channel #\n", hf->channel); */

Ditto.

> +		goto resubmit_urb;
> +
> +	/* device reports bad channel id */
> +	dev =3D usbcan->canch[hf->channel];
> +	BUG_ON(!dev);
> +
> +	netdev =3D dev->netdev;
> +	BUG_ON(!netdev);
> +
> +	if (!netif_device_present(netdev))
> +		return;
> +
> +	stats =3D &dev->netdev->stats;
> +
> +	if (hf->echo_id =3D=3D -1) { /* normal rx */
> +		skb =3D alloc_can_skb(dev->netdev, &cf);
> +		if (skb =3D=3D NULL)
> +			return;
> +
> +		cf->can_id =3D CONVERT_FLAGS(hf->can_id);
> +		/* is it necessary to use get_can_dlc? */
> +		cf->can_dlc =3D get_can_dlc(hf->can_dlc);
> +		memcpy(cf->data, hf->data, 8);
> +
> +		netif_rx(skb);
> +
> +		netdev->stats.rx_packets++;
> +		netdev->stats.rx_bytes +=3D hf->can_dlc;
> +	} else { /* echo_id =3D hf->echo_id */

s/=3D/=3D=3D/

> +		if (hf->echo_id >=3D MAX_TX_URBS) {
> +			netdev_info(netdev, "BAD echo %d\n", hf->echo_id);
> +			goto resubmit_urb;
> +		}
> +
> +		netdev->stats.tx_packets++;
> +		netdev->stats.tx_bytes +=3D hf->can_dlc;
> +
> +		txc =3D gs_get_tx_context(dev, hf->echo_id);
> +
> +		/* bad devices send bad echo_ids. */
> +		if (!txc) {
> +			netdev_info(netdev, "bad echo %d\n", hf->echo_id);

Isn't this an error or a warning, at least?

> +			goto resubmit_urb;
> +		}
> +
> +		can_get_echo_skb(netdev, gs_tx_context_id(txc));
> +
> +		gs_free_tx_context(txc);
> +
> +		netif_wake_queue(netdev);
> +	}
> +
> +	if (hf->flags & GS_CAN_FLAG_OVERFLOW)
> +		netdev_info(netdev, "overflow\n");

Is this a CAN message overflow? If yes please generate an error message
like for the SJA1000:

http://lxr.free-electrons.com/source/drivers/net/can/sja1000/sja1000.c#=
L391

> +
> +
> +resubmit_urb:
> +	/* note: no urb refill... works for me */
> +
> +	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
> +
> +	/* USB failure take down all interfaces */
> +	if (rc =3D=3D -ENODEV) {
> +		for (rc =3D 0; rc < MAX_INTF; rc++) {
> +			if (usbcan->canch[rc])
> +				netif_device_detach(usbcan->canch[rc]->netdev);
> +		}
> +	}
> +}
> +
> +static int gs_usb_set_bittiming(struct net_device *netdev)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct can_bittiming *bt =3D &dev->can.bittiming;
> +	struct usb_interface *intf =3D dev->iface;
> +	int rc;
> +	struct gs_device_bittiming *dbt;
> +
> +	dbt =3D kmalloc(sizeof(*dbt), GFP_KERNEL);
> +	if (!dbt)
> +		return -ENOMEM;
> +
> +	dbt->prop_seg =3D bt->prop_seg;
> +	dbt->phase_seg1 =3D bt->phase_seg1;
> +	dbt->phase_seg2 =3D bt->phase_seg2;
> +	dbt->sjw =3D bt->sjw;
> +	dbt->brp =3D bt->brp;
> +
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_BITTIMING,
> +			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			dev->channel,
> +			0,
> +			dbt,
> +			sizeof(*dbt),
> +			1000);
> +	if (rc < 0)
> +		dev_warn(netdev->dev.parent, "Couldn't set bittimings %d", rc);

netdev_err?

> +	kfree(dbt);
> +
> +	return rc;
> +}
> +
> +static int gs_usb_set_mode(struct net_device *netdev, enum can_mode =
mode)
> +{
> +	if (mode =3D=3D CAN_MODE_START) {
> +		netif_wake_queue(netdev);
> +		return 0;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int gs_usb_get_state(const struct net_device *netdev,
> +enum can_state *state)

Please use some indention here and in other similar places.

> +{
> +
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct usb_interface *intf =3D dev->iface;
> +	int rc;
> +	struct gs_device_state *dstate;
> +
> +	dev_warn(netdev->dev.parent, "CAN state");
> +
> +	dstate =3D kmalloc(sizeof(*dstate), GFP_KERNEL);
> +	if (!dstate)
> +		return -ENOMEM;
> +
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_BERR,
> +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			dev->channel,
> +			0,
> +			dstate,
> +			sizeof(*dstate),
> +			1000);
> +
> +	if (rc < 0) {
> +		dev_warn(netdev->dev.parent, "Couldn't get state %d", rc);
> +		kfree(dstate);
> +		return rc;
> +	}
> +
> +	switch (dstate->state) {
> +	/* RX/TX error count < 96 */
> +	case GS_CAN_STATE_ERROR_ACTIVE:
> +		*state =3D CAN_STATE_ERROR_ACTIVE;
> +		break;
> +	/* RX/TX error count < 128 */
> +	case GS_CAN_STATE_ERROR_WARNING:
> +		*state =3D CAN_STATE_ERROR_WARNING;
> +		break;
> +	/* RX/TX error count < 256 */
> +	case GS_CAN_STATE_ERROR_PASSIVE:
> +		*state =3D CAN_STATE_ERROR_PASSIVE;
> +		break;
> +	/* RX/TX error count >=3D 256 */
> +	case GS_CAN_STATE_BUS_OFF:
> +		*state =3D CAN_STATE_BUS_OFF;
> +		break;
> +	/* Device is stopped */
> +	case GS_CAN_STATE_STOPPED:
> +		*state =3D CAN_STATE_STOPPED;
> +		break;
> +	/* Device is sleeping */
> +	case GS_CAN_STATE_SLEEPING:
> +		*state =3D CAN_STATE_SLEEPING;
> +		break;
> +	default:
> +		kfree(dstate);
> +		return -ENOTSUPP;
> +	}
> +
> +	kfree(dstate);
> +	return 0;
> +}

This callback is normally only needed if the state is not updated by th=
e
driver via asynchronous events (interrupts).

> +static int gs_usb_get_berr_counter(const struct net_device *netdev,
> +struct can_berr_counter *bec)

Indention.

> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct usb_interface *intf =3D dev->iface;
> +	int rc;
> +	struct gs_device_state *dstate;
> +
> +	dstate =3D kmalloc(sizeof(*dstate), GFP_KERNEL);
> +	if (!dstate)
> +		return -ENOMEM;
> +
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_BERR,
> +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			dev->channel,
> +			0,
> +			dstate,
> +			sizeof(*dstate),
> +			1000);
> +	if (rc < 0) {
> +		dev_warn(netdev->dev.parent, "Couldn't get error counters %d",
> +			rc);

dev_err or better netdev_err? Please use the netdev_* function whenever
possible, not only here.

> +		kfree(dstate);
> +		return rc;
> +	}
> +
> +	bec->txerr =3D dstate->txerr;
> +	bec->rxerr =3D dstate->rxerr;
> +
> +	kfree(dstate);
> +	return 0;
> +}
> +
> +static void gs_usb_xmit_callback(struct urb *urb)
> +{
> +	struct gs_tx_context *txc =3D urb->context;
> +	struct gs_can *dev;
> +	struct net_device *netdev;
> +
> +	BUG_ON(!txc);
> +
> +	dev =3D txc->dev;
> +	BUG_ON(!dev);
> +
> +	netdev =3D dev->netdev;
> +	BUG_ON(!netdev);

Too much sanity checks! Please reduce the number of BUG_ONs here and in
other places.

> +	if (urb->status) {
> +		dev_info(netdev->dev.parent, "%d] xmit err %d\n",
> +			dev->channel, txc->echo_id);

netdev_err?

> +	}
> +
> +	usb_free_coherent(urb->dev,
> +		urb->transfer_buffer_length,
> +		urb->transfer_buffer,
> +		urb->transfer_dma);
> +
> +	atomic_dec(&dev->active_tx_urbs);
> +
> +	if (!netif_device_present(netdev))
> +		return;
> +
> +	if (netif_queue_stopped(netdev))
> +		netif_wake_queue(netdev);
> +}
> +
> +static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
> +struct net_device *netdev)

Indention!

> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct net_device_stats *stats =3D &dev->netdev->stats;
> +	struct urb *urb;
> +	struct gs_host_frame *hf;
> +	struct can_frame *cf;
> +	int rc;
> +	unsigned int idx;
> +	struct gs_tx_context *txc;
> +
> +	if (dev->can.ctrlmode&CAN_CTRLMODE_LISTENONLY)
> +		return NETDEV_TX_BUSY;

Hm, it's better not to start the TX queue in that case. But that's a
problem other driver do have as well.

> +
> +	if (can_dropped_invalid_skb(netdev, skb))
> +		return NETDEV_TX_OK;
> +
> +	/* find an empty context to keep track of transmission */
> +	txc =3D gs_alloc_tx_context(dev);
> +	if (!txc)
> +		return NETDEV_TX_BUSY;
> +
> +	/* create a URB, and a buffer for it */
> +	urb =3D usb_alloc_urb(0, GFP_ATOMIC);
> +	if (!urb) {
> +		gs_free_tx_context(txc);
> +		dev_err(netdev->dev.parent, "No memory left for URBs\n");
> +		goto nomem;
> +	}
> +
> +	hf =3D usb_alloc_coherent(dev->udev, sizeof(*hf), GFP_ATOMIC,
> +		&urb->transfer_dma);
> +	if (!hf) {
> +		gs_free_tx_context(txc);
> +		dev_err(netdev->dev.parent, "No memory left for USB buffer\n");
> +		usb_free_urb(urb);
> +		goto nomem;

It usual to use labels for cleanup to avoid code duplication, e.g. "got=
o
free_urb;".

> +	}
> +
> +	cf =3D (struct can_frame *)skb->data;
> +
> +	idx =3D gs_tx_context_id(txc);
> +
> +	if (idx >=3D MAX_TX_URBS) {

Can that happen?

> +		dev_err(netdev->dev.parent, "Invalid tx context %d\n", idx);
> +		usb_free_urb(urb);
> +		usb_free_coherent(dev->udev,
> +					sizeof(*hf),
> +					hf,
> +					urb->transfer_dma);

Label?

> +		goto nomem;
> +	}
> +
> +	hf->echo_id =3D idx;
> +	hf->channel =3D dev->channel;
> +
> +	hf->can_id =3D CONVERT_FLAGS(cf->can_id);
> +	hf->can_dlc =3D cf->can_dlc;
> +	memcpy(hf->data, cf->data, 8);
> +
> +	usb_fill_bulk_urb(urb, dev->udev,
> +			usb_sndbulkpipe(dev->udev, GSUSB_ENDPOINT_OUT),
> +			hf,
> +			sizeof(*hf),
> +			gs_usb_xmit_callback,
> +			txc);
> +
> +	urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +	usb_anchor_urb(urb, &dev->tx_submitted);
> +
> +	can_put_echo_skb(skb, netdev, idx);
> +
> +	atomic_inc(&dev->active_tx_urbs);
> +
> +	rc =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	if (unlikely(rc)) {			/* usb send failed */
> +		dev_err(netdev->dev.parent, "usb_submit failed %d\n", rc);

netdev_err!

> +		can_free_echo_skb(netdev, gs_tx_context_id(txc));
> +		gs_free_tx_context(txc);
> +
> +		usb_unanchor_urb(urb);
> +		usb_free_coherent(dev->udev,
> +			sizeof(*hf),
> +			hf,
> +			urb->transfer_dma);
> +
> +		atomic_dec(&dev->active_tx_urbs);
> +
> +		if (rc =3D=3D -ENODEV) {
> +			netif_device_detach(netdev);
> +		} else {
> +			dev_warn(netdev->dev.parent, "Failed tx_urb %d\n", rc);

dev_err? Does it happen?

> +			stats->tx_dropped++;
> +		}
> +	} else {
> +		netdev->trans_start =3D jiffies;
> +
> +		/* Slow down tx path */
> +		if (atomic_read(&dev->active_tx_urbs) >=3D MAX_TX_URBS)
> +			netif_stop_queue(netdev);
> +	}
> +
> +	/* let usb core take care of this urb */
> +	usb_free_urb(urb);
> +
> +	return NETDEV_TX_OK;
> +
> +nomem:
> +	dev_kfree_skb(skb);
> +	stats->tx_dropped++;
> +	return NETDEV_TX_OK;
> +}
> +
> +static int gs_can_open(struct net_device *netdev)
> +{
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct gs_usb *parent =3D dev->parent;
> +	int rc, i;
> +	struct gs_device_mode *dm;
> +	u32 ctrlmode;
> +
> +	/* common open */
> +	rc =3D open_candev(netdev);
> +	if (rc)
> +		return rc;
> +
> +	if (atomic_add_return(1, &parent->active_channels) =3D=3D 1) {
> +		dev_info(netdev->dev.parent, "Allocating rx URBs\n");

You are using to much debug messages, which are not really useful for
the user.

> +		for (i =3D 0; i < MAX_RX_URBS; i++) {
> +			struct urb *urb =3D NULL;
> +			u8 *buf =3D NULL;
> +
> +			/* alloc rx urb */
> +			urb =3D usb_alloc_urb(0, GFP_KERNEL);
> +			if (!urb) {
> +				dev_err(netdev->dev.parent,
> +					"No memory left for URBs\n");

close_candev() is missing. Please use labels for cleanup.

> +				return -ENOMEM;
> +			}
> +
> +			/* alloc rx buffer */
> +			buf =3D usb_alloc_coherent(dev->udev,
> +				BUFFER_SIZE,
> +				GFP_KERNEL,
> +				&urb->transfer_dma);
> +			if (!buf) {
> +				dev_err(netdev->dev.parent,
> +					"No memory left for USB buffer\n");
> +				usb_free_urb(urb);
> +				return -ENOMEM;
> +			}
> +
> +
> +			/* fill, anchor, and submit rx urb */
> +			usb_fill_bulk_urb(urb,
> +					dev->udev,
> +					usb_rcvbulkpipe(dev->udev,
> +						GSUSB_ENDPOINT_IN),
> +					buf,
> +					BUFFER_SIZE,
> +					gs_usb_recieve_bulk_callback,
> +					parent
> +					);
> +			urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> +
> +			usb_anchor_urb(urb, &parent->rx_submitted);
> +
> +			rc =3D usb_submit_urb(urb, GFP_KERNEL);
> +			if (rc) {
> +				if (rc =3D=3D -ENODEV)
> +					netif_device_detach(dev->netdev);
> +
> +				usb_unanchor_urb(urb);
> +				break;
> +			}
> +
> +			/* Drop reference,
> +			 * USB core will take care of freeing it
> +			 */
> +			usb_free_urb(urb);
> +		}
> +	}
> +
> +	dm =3D kmalloc(sizeof(*dm), GFP_KERNEL);
> +	if (!dm)
> +		return -ENOMEM;

Cleanup?

> +
> +	/* flags */
> +	ctrlmode =3D dev->can.ctrlmode;
> +	dm->flags =3D 0;
> +
> +	if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		dm->flags |=3D GS_CAN_MODE_LOOP_BACK;
> +
> +	else if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		dm->flags |=3D GS_CAN_MODE_LISTEN_ONLY;
> +
> +
> +	/* Controller is not allowed to retry TX
> +	 * this mode is unavailable on atmels uc3c hardware
> +	 */
> +	if (ctrlmode & CAN_CTRLMODE_ONE_SHOT) {
> +		dm->flags |=3D GS_CAN_MODE_ONE_SHOT;
> +		dev_warn(netdev->dev.parent, "GS_USB_ONE_SHOT\n");

Why a warning? I think you can remove this message.

> +	}
> +
> +	if (ctrlmode & CAN_CTRLMODE_3_SAMPLES) {
> +		dm->flags |=3D GS_CAN_MODE_TRIPLE_SAMPLE;
> +		dev_warn(netdev->dev.parent, "GS_USB_TRIPLE_SAMPLE\n");

Ditto.

> +	}
> +
> +
> +	/* finally start device */
> +	dm->mode =3D GS_CAN_MODE_START;
> +	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
> +			usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
> +			GS_USB_BREQ_MODE,
> +			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			dev->channel,
> +			0,
> +			dm,
> +			sizeof(*dm),
> +			1000);
> +
> +	kfree(dm);
> +
> +	if (rc < 0) {
> +		dev_warn(netdev->dev.parent, "Couldn't start device %d\n", rc);

netdev_err?

> +		return rc;
> +	}
> +
> +	/* check mode... */
> +	dm =3D kmalloc(sizeof(*dm), GFP_KERNEL);
> +	if (!dm)
> +		return -ENOMEM;

No need to re-allocate "dm".

> +	rc =3D usb_control_msg(interface_to_usbdev(dev->iface),
> +			usb_rcvctrlpipe(interface_to_usbdev(dev->iface), 0),
> +			GS_USB_BREQ_MODE,
> +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			dev->channel,
> +			0,
> +			dm,
> +			sizeof(*dm),
> +			1000);
> +
> +	if (rc < 0) {
> +		dev_warn(netdev->dev.parent, "Couldn't get device mode %d\n",
> +			rc);

netdev_err?

> +		kfree(dm);
> +		return rc;
> +	}
> +
> +	kfree(dm);

Again, please use labels to simplify your cleanup code.

> +
> +	dev->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	netif_start_queue(netdev);
> +
> +	netdev_info(netdev, "CAN open\n");

You are too verbose. Please remove.

> +	return 0;
> +}
> +
> +/* think: ip link set canx down */

What do you mean?

> +static int gs_can_close(struct net_device *netdev)
> +{
> +	int rc;
> +	struct gs_can *dev =3D netdev_priv(netdev);
> +	struct gs_usb *parent =3D dev->parent;
> +
> +	netif_stop_queue(netdev);
> +
> +	/* Stop polling */
> +	if (atomic_dec_and_test(&parent->active_channels)) {
> +		dev_info(netdev->dev.parent,
> +			"Freeing rx usb memory\n");

You are too verbose. Please remove.

> +		usb_kill_anchored_urbs(&parent->rx_submitted);
> +	}
> +
> +	rc =3D gs_cmd_reset(parent, dev);
> +	if (rc < 0)
> +		dev_warn(netdev->dev.parent, "Couldn't shutdown device %d", rc);

netdev_err?

> +	close_candev(netdev);
> +
> +	netdev_info(netdev, "CAN close\n");

You are too verbose. Please remove.

> +	return 0;
> +}
> +
> +/******************************** USB ******************************=
**/
> +
> +static const struct net_device_ops gs_usb_netdev_ops =3D {
> +	.ndo_open =3D gs_can_open,
> +	.ndo_stop =3D gs_can_close,
> +	.ndo_start_xmit =3D gs_can_start_xmit,
> +};
> +
> +static int gs_make_candev(struct gs_can **out, unsigned int channel,
> +struct usb_interface *intf)

Indention!

> +{
> +	struct gs_can *dev;
> +	struct net_device *netdev;
> +	int rc;
> +	struct gs_device_bt_const *bt_const;
> +
> +	bt_const =3D kmalloc(sizeof(*bt_const), GFP_KERNEL);
> +	if (!bt_const)
> +		return -ENOMEM;
> +
> +	/* fetch bit timing constants */
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_BT_CONST,
> +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			channel,
> +			0,
> +			bt_const,
> +			sizeof(*bt_const),
> +			1000);
> +
> +	if (rc < 0) {
> +		dev_err(&intf->dev,
> +			"Couldn't get bit timing const for channel %d\n",
> +			rc);
> +		kfree(bt_const);

labels for cleanup!

> +		return rc;
> +	}
> +
> +	dev_info(&intf->dev, "fclock: %d\n", bt_const->fclk_can);

Please remove. The use can query the information with "ip -d link show"=
=2E

> +
> +	/* create netdev */
> +	netdev =3D alloc_candev(sizeof(struct gs_can), MAX_TX_URBS);
> +	if (!netdev) {
> +		dev_err(&intf->dev, "Couldn't alloc candev\n");
> +		kfree(bt_const);
> +		return -ENOMEM;
> +	}
> +
> +	dev =3D netdev_priv(netdev);
> +
> +	netdev->netdev_ops =3D &gs_usb_netdev_ops;
> +
> +	netdev->flags |=3D IFF_ECHO; /* we support full roundtrip echo */
> +
> +	/* dev settup */
> +	strcpy(dev->bt_const.name, "gs_usb");
> +	dev->bt_const.tseg1_min =3D bt_const->tseg1_min;
> +	dev->bt_const.tseg1_max =3D bt_const->tseg1_max;
> +	dev->bt_const.tseg2_min =3D bt_const->tseg2_min;
> +	dev->bt_const.tseg2_max =3D bt_const->tseg2_max;
> +	dev->bt_const.sjw_max =3D bt_const->sjw_max;
> +	dev->bt_const.brp_min =3D bt_const->brp_min;
> +	dev->bt_const.brp_max =3D bt_const->brp_max;
> +	dev->bt_const.brp_inc =3D bt_const->brp_inc;

memcpy() or "dev->bt_const =3D bt_const->sjw_max;"?

> +
> +	dev->udev =3D interface_to_usbdev(intf);
> +	dev->iface =3D intf;
> +	dev->netdev =3D netdev;
> +	dev->channel =3D channel;
> +
> +	init_usb_anchor(&dev->tx_submitted);
> +	atomic_set(&dev->active_tx_urbs, 0);
> +	spin_lock_init(&dev->tx_ctx_lock);
> +	for (rc =3D 0; rc < MAX_TX_URBS; rc++) {
> +		dev->tx_context[rc].dev =3D dev;
> +		dev->tx_context[rc].echo_id =3D MAX_TX_URBS;
> +	}
> +
> +	/* can settup */
> +	dev->can.state =3D CAN_STATE_STOPPED;
> +	dev->can.clock.freq =3D bt_const->fclk_can;
> +	dev->can.bittiming_const =3D &dev->bt_const;
> +	dev->can.do_set_bittiming =3D gs_usb_set_bittiming;
> +	dev->can.do_set_mode =3D gs_usb_set_mode;
> +	dev->can.do_get_state =3D gs_usb_get_state;
> +	dev->can.do_get_berr_counter =3D gs_usb_get_berr_counter;
> +
> +	dev->can.ctrlmode_supported =3D 0;
> +
> +	if (bt_const->feature & GS_CAN_FEATURE_LISTEN_ONLY)
> +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LISTENONLY;
> +
> +	if (bt_const->feature & GS_CAN_FEATURE_LOOP_BACK)
> +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_LOOPBACK;
> +
> +	if (bt_const->feature & GS_CAN_FEATURE_TRIPLE_SAMPLE)
> +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
> +
> +	if (bt_const->feature & GS_CAN_FEATURE_ONE_SHOT)
> +		dev->can.ctrlmode_supported |=3D CAN_CTRLMODE_ONE_SHOT;
> +
> +	kfree(bt_const);
> +
> +	SET_NETDEV_DEV(netdev, &intf->dev);
> +
> +	rc =3D register_candev(dev->netdev);
> +	if (rc) {
> +		free_candev(dev->netdev);
> +		dev_err(&intf->dev, "Couldn't register candev\n");
> +		return rc;
> +	}
> +
> +	*out =3D dev;
> +	return 0;
> +}
> +
> +static void gs_destroy_candev(struct gs_can *dev)
> +{
> +	unregister_candev(dev->netdev);
> +	free_candev(dev->netdev);
> +	usb_kill_anchored_urbs(&dev->tx_submitted);
> +}
> +
> +static int gs_usb_probe(struct usb_interface *intf,
> +const struct usb_device_id *id)

Indention!

> +{
> +	struct gs_usb *dev;
> +	int rc =3D -ENOMEM;
> +	unsigned int icount, i;
> +	struct gs_host_config *hconf;
> +	struct gs_device_config *dconf;
> +
> +	hconf =3D kmalloc(sizeof(*hconf), GFP_KERNEL);
> +	if (!hconf)
> +		return -ENOMEM;
> +
> +	hconf->byte_order =3D 0x0000beef;
> +
> +
> +	/* send host config */
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_sndctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_HOST_FORMAT,
> +			USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			1,
> +			intf->altsetting[0].desc.bInterfaceNumber,
> +			hconf,
> +			sizeof(*hconf),
> +			1000);
> +
> +	kfree(hconf);
> +
> +	if (rc < 0) {
> +		dev_err(&intf->dev, "Couldn't send data format: %d\n",
> +			rc);
> +		return rc;
> +	}
> +
> +
> +	dconf =3D kmalloc(sizeof(*dconf), GFP_KERNEL);
> +	if (!dconf)
> +		return -ENOMEM;
> +
> +	/* read device config */
> +	rc =3D usb_control_msg(interface_to_usbdev(intf),
> +			usb_rcvctrlpipe(interface_to_usbdev(intf), 0),
> +			GS_USB_BREQ_DEVICE_CONFIG,
> +			USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
> +			1,
> +			intf->altsetting[0].desc.bInterfaceNumber,
> +			dconf,
> +			sizeof(*dconf),
> +			1000);
> +	if (rc < 0) {
> +		dev_err(&intf->dev, "Couldn't recieve device config: %d\n",
> +			rc);

kfree(dconf); ?

> +		return rc;
> +	}
> +
> +	icount =3D dconf->icount+1;
> +	kfree(dconf);
> +
> +	dev_info(&intf->dev, "Configuring for %d interfaces\n", icount);
> +
> +	if (icount > MAX_INTF) {
> +		dev_err(&intf->dev,
> +			"Driver cannot handle more that %d Can interfaces\n",
> +			MAX_INTF);
> +		return -EINVAL;
> +	}
> +
> +	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> +	init_usb_anchor(&dev->rx_submitted);
> +
> +	atomic_set(&dev->active_channels, 0);
> +
> +	usb_set_intfdata(intf, dev);
> +
> +	for (i =3D 0; i < icount; i++) {
> +		rc =3D gs_make_candev(&dev->canch[i], i, intf);
> +		if (rc) {
> +			/* on failure destroy previously created candevs */
> +			icount =3D i;
> +			for (i =3D 0; i < icount; i++) {
> +				gs_destroy_candev(dev->canch[i]);
> +				dev->canch[icount] =3D NULL;
> +			}
> +			return rc;
> +		}
> +		dev->canch[i]->parent =3D dev;
> +	}
> +
> +	dev_info(&intf->dev, "Probe\n");

One dev_info per probe is fine but it should provide more information.

> +	return 0;
> +}
> +
> +static void gs_usb_disconnect(struct usb_interface *intf)
> +{
> +	unsigned i;
> +	struct gs_usb *dev =3D usb_get_intfdata(intf);
> +	usb_set_intfdata(intf, NULL);
> +
> +	if (!dev) {
> +		dev_info(&intf->dev, "Disconnect (nodata)\n");

dev_err?

> +		return;
> +	}
> +
> +	for (i =3D 0; i < MAX_INTF; i++) {
> +		struct gs_can *can =3D dev->canch[i];
> +
> +		if (!can)
> +			continue;
> +
> +		gs_destroy_candev(can);
> +	}
> +
> +	usb_kill_anchored_urbs(&dev->rx_submitted);
> +
> +	dev_info(&intf->dev, "Disconnect\n");
> +}
> +
> +MODULE_DEVICE_TABLE(usb, gs_usb_table);
> +
> +static struct usb_device_id gs_usb_table[] =3D {
> +	{USB_DEVICE(USB_GSUSB_1_VENDOR_ID, USB_GSUSB_1_PRODUCT_ID)},
> +	{} /* Terminating entry */
> +};
> +
> +static struct usb_driver gs_usb_driver =3D {
> +	.name       =3D "gs_usb",
> +	.probe      =3D gs_usb_probe,
> +	.disconnect =3D gs_usb_disconnect,
> +	.id_table   =3D gs_usb_table
> +};
> +
> +static int __init gs_usb_init(void)
> +{
> +	return usb_register(&gs_usb_driver);
> +}
> +
> +static void __exit gs_usb_exit(void)
> +{
> +	usb_deregister(&gs_usb_driver);
> +}
> +
> +module_init(gs_usb_init);
> +module_exit(gs_usb_exit);
> +
> +MODULE_AUTHOR("Maximilian Schneider <mws@schneidersoft.net>");
> +MODULE_DESCRIPTION(
> +"Socket CAN device driver for Geschwister Schneider Technologie-, "
> +"Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces.");
> +MODULE_LICENSE("GPL v2");
> +
> --=20
> 1.7.10.4

Wolfgang.

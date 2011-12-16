From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Fri, 16 Dec 2011 13:41:10 +0100
Message-ID: <4EEB3C66.1020303@pengutronix.de>
References: <301939.630738588-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig737B3AEAA45C838ACD85A7B0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41669 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1LPMlO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Dec 2011 07:41:14 -0500
In-Reply-To: <301939.630738588-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>
Cc: "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig737B3AEAA45C838ACD85A7B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/16/2011 11:19 AM, s.grosjean@peak-system.com wrote:
> From 1cee3be3875f27a2ee3942b00d611450f4369325 Mon Sep 17 00:00:00 2001
> From: Stephane Grosjean <s.grosjean@peak-system.com>
> Date: Fri, 16 Dec 2011 11:11:37 +0100
> Subject: [PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)=


The driver has some unusal coding style, please use checkpatch and do
sparse checking (compile the drivers with C=3D2). Make use of C99
initialisers. Use foo->bar not &foo->bar[0] to get the pointer for the
first array element

more comments inline.

Marc

>=20
> v2 includes:
>  change dev_xxx() into netdev_xxx() macros
>  add missing include linux/module.h
>  pre-allocate urbs and buffers for tx path at _open() and free them at =
_close()
>   rather than into _start_xmit()
>  remove some unused code and (boring) #ifdef/#endif
>  use "menuconfig" in Kconfig rather than "config" entry
> ---
>  drivers/net/can/usb/Kconfig         |   20 +
>  drivers/net/can/usb/Makefile        |   12 +
>  drivers/net/can/usb/pcan_usb.c      |  654 +++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_core.c |  895 ++++++++++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_pro.c  | 1207 +++++++++++++++++++++++++++=
++++++++
>  drivers/net/can/usb/pcan_usb_pro.h  |  468 ++++++++++++++
>  drivers/net/can/usb/peak_usb.h      |  148 +++++
>  7 files changed, 3404 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/pcan_usb.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_core.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_pro.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_pro.h
>  create mode 100644 drivers/net/can/usb/peak_usb.h
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 0452549..cb5f91c 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -13,4 +13,24 @@ config CAN_ESD_USB2
>            This driver supports the CAN-USB/2 interface
>            from esd electronic system design gmbh (http://www.esd.eu).
> =20
> +menuconfig CAN_PEAK_USB
> +	tristate "PEAK-System USB adapters"
> +	---help---
> +	  This driver is for PCAN USB interfaces from PEAK-System=20
> +	  (http://www.peak-system.com).
> +
> +config CAN_PCAN_USB
> +	tristate "PEAK PCAN-USB adapter"
> +	depends on CAN_PEAK_USB
> +	---help---
> +	  This driver is for the one channel PCAN-USB interface
> +	  from PEAK-System (http://www.peak-system.com).
> +
> +config CAN_PCAN_USB_PRO
> +	tristate "PEAK PCAN-USB Pro adapter"
> +	depends on CAN_PEAK_USB
> +	---help---
> +	  This driver is for the two channels PCAN-USB Pro interface
> +	  from PEAK-System (http://www.peak-system.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefil=
e
> index fce3cf1..a6f1cf6 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -5,4 +5,16 @@
>  obj-$(CONFIG_CAN_EMS_USB) +=3D ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) +=3D esd_usb2.o
> =20
> +obj-$(CONFIG_CAN_PEAK_USB) +=3D peak_usb.o
> +peak_usb-y =3D pcan_usb_core.o
> +
> +ifneq ($(CONFIG_CAN_PCAN_USB),)
> +peak_usb-y +=3D pcan_usb.o
> +endif
> +
> +ifneq ($(CONFIG_CAN_PCAN_USB_PRO),)
> +peak_usb-y +=3D pcan_usb_pro.o
> +endif
> +
> +ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG

^^^^^^^^^^

one ccflag should be enough :)

> diff --git a/drivers/net/can/usb/pcan_usb.c b/drivers/net/can/usb/pcan_=
usb.c
> new file mode 100644
> index 0000000..ec46da6
> --- /dev/null
> +++ b/drivers/net/can/usb/pcan_usb.c
> @@ -0,0 +1,654 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB adapter
> + *
> + * Copyright (C) 2011-2012 PEAK-System GmbH
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
> + *
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, write to the Free Software Foundation, I=
nc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

please remove the address

> + */
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +#include <linux/module.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +#include "peak_usb.h"
> +
> +MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB adapter");
> +
> +/* PCAN-USB Endpoints */
> +#define PCAN_USB_EP_CMDOUT   1
> +#define PCAN_USB_EP_CMDIN    (PCAN_USB_EP_CMDOUT|USB_DIR_IN)
> +#define PCAN_USB_EP_MSGOUT   2
> +#define PCAN_USB_EP_MSGIN    (PCAN_USB_EP_MSGOUT|USB_DIR_IN)
                                                  ^^^
please add spaces around the |

> +
> +/* PCAN-USB parameter command */
> +#define PCAN_USB_PARAMETER_LEN   14
> +struct __packed pcan_usb_parameter {
> +	u8 function;
> +	u8	number;
         ^^^
please use one space
> +	u8 parameters[PCAN_USB_PARAMETER_LEN];
> +};
> +
> +/* PCAN-USB command timeout (ms.) */
> +#define PCAN_USB_COMMAND_TIMEOUT 1000
> +
> +/* PCAN-USB rx/tx buffers size */
> +#define PCAN_USB_RX_BUFFER_SIZE  64
> +#define PCAN_USB_TX_BUFFER_SIZE  64
> +
> +#define PCAN_USB_MSG_HEADER_LEN  2 /* Packet type information (1xbyte)=
=20
> +                                    + count of messages (1xbyte) */
> +
> +/* PCAN-USB adapter internal clock (MHz) */
> +#define PCAN_USB_CRYSTAL_HZ      16000000
> +
> +/* PCAN-USB USB message record status/len field */
> +#define PCAN_USB_STATUSLEN_TIMESTAMP (1 << 7)
> +#define PCAN_USB_STATUSLEN_INTERNAL  (1 << 6)
> +#define PCAN_USB_STATUSLEN_EXT_ID    (1 << 5)
> +#define PCAN_USB_STATUSLEN_RTR       (1 << 4)
> +#define PCAN_USB_STATUSLEN_DLC       (0xf)
> +
> +/* PCAN-USB error flags */
> +#define PCAN_USB_ERROR_TXFULL    0x01
> +#define PCAN_USB_ERROR_RXQOVR    0x02
> +#define PCAN_USB_ERROR_BUS_LIGHT 0x04
> +#define PCAN_USB_ERROR_BUS_HEAVY 0x08
> +#define PCAN_USB_ERROR_BUS_OFF   0x10
> +#define PCAN_USB_ERROR_RXQEMPTY  0x20
> +#define PCAN_USB_ERROR_QOVR      0x40
> +#define PCAN_USB_ERROR_TXQFULL   0x80
> +
> +/* SJA1000 modes */
> +#define SJA1000_MODE_NORMAL 0x00
> +#define SJA1000_MODE_INIT   0x01
> +
> +/* tick duration =3D 42.666 us =3D>=20
> + * (tick_number * 44739243) >> 20 ~ (tick_number * 42666) / 1000
> + *  accuracy =3D 10^-7
> + */
> +#define PCAN_USB_TS_DIV_SHIFTER        20
> +#define PCAN_USB_TS_US_PER_TICK        44739243

If you want to align the #defines please use tab between symbol and value=


> +
> +struct pcan_usb {
> +	struct peak_usb_device pcandev; /* must be the first member */
> +	struct peak_time_ref time_ref;
> +};
> +
> +/*
> + * Send the given PCAN-USB command synchronously
> + */
> +static int pcan_usb_send_command(struct peak_usb_device *dev, u8 f, u8=
 n, u8 *p)
> +{
> +	int actual_length;
> +	struct pcan_usb_parameter cmd;
> +	int err;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;
> +
> +	cmd.function =3D f;
> +	cmd.number =3D n;

you can use C99 initialisers instead:

	struct pcan_usb_parameter cmd =3D {
		.function =3D f,
		.number =3D n,
	};

then parameters in automatically set with 0x0....
> +
> +	if (p !=3D NULL)

if (p)

> +		memcpy(&cmd.parameters[0], p, PCAN_USB_PARAMETER_LEN);

I'd write memcpy(cmd.parameters, p, ARRAY_SIZE(cmd.parameters))

> +	else
> +		memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);

=2E..and you can remove the memset here.

> +
> +	err =3D usb_bulk_msg(dev->udev,=20
> +	                   usb_sndbulkpipe(dev->udev, PCAN_USB_EP_CMDOUT),
> +	                   &cmd, sizeof(struct pcan_usb_parameter),
> +	                   &actual_length, PCAN_USB_COMMAND_TIMEOUT);
> +	if (err)=20
> +		netdev_err(dev->netdev,=20
> +		           "sending command function=3D0x%x number=3D0x%x failure: %=
d\n",
> +		           f, n, err);
> +
> +	return err;
> +}
> +
> +static int pcan_usb_wait_response(struct peak_usb_device *dev, u8 f, u=
8 n, u8 *p)
> +{
> +	int actual_length;
> +	struct pcan_usb_parameter cmd;
> +	int err;
> +
> +	/* usb device unregistered? */
> +	if (!(dev->state & PCAN_USB_STATE_CONNECTED)) return 0;

please put the return in a seperate line.

> +
> +	/* first, send command */
> +	err =3D pcan_usb_send_command(dev, f, n, NULL);
> +	if (err) {
> +		return err;
> +	}

please remove the { }

> +
> +	cmd.function =3D f;
> +	cmd.number =3D n;
> +	memset(&cmd.parameters[0], '\0', PCAN_USB_PARAMETER_LEN);

please use C99 initialisers

> +
> +	/* then, wait for the response */
> +	mdelay(5);
> +	err =3D usb_bulk_msg(dev->udev,=20
> +	                   usb_rcvbulkpipe(dev->udev, PCAN_USB_EP_CMDIN),
> +	                   &cmd, sizeof(struct pcan_usb_parameter),
> +	                   &actual_length, PCAN_USB_COMMAND_TIMEOUT);
> +	if (err)
> +		netdev_err(dev->netdev,=20
> +		           "waiting response function=3D0x%x number=3D0x%x failure: =
%d\n",
> +		           f, n, err);
> +	else if (p) memcpy(p, &cmd.parameters[0], PCAN_USB_PARAMETER_LEN);

please put the memcpy in a seperate line. I'd use cmd.parameters instead
of &cmd.parameters[0], please use ARRAY_SIZE.

> +
> +	return err;
> +}
> +
> +static int pcan_usb_set_sja1000(struct peak_usb_device *dev, u8 mode)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +
> +	args[0] =3D 0;
> +	args[1] =3D mode;

the array can be initializes in C99 style, too:

	u8 args[PCAN_USB_PARAMETER_LEN] =3D {
		[0] =3D 0,
		[1] =3D mode,
	};

The [0] can be skipped, by you might want to include it for
documentation purpose.

Please add a newline in before return

> +	return pcan_usb_send_command(dev, 9, 2, args);
> +}
> +
> +static int pcan_usb_set_bus(struct peak_usb_device *dev, u8 onoff)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +
> +	args[0] =3D onoff ? 1 : 0;
> +	return pcan_usb_send_command(dev, 3, 2, args);

please use/add C99 initialisers + newline, too

> +}
> +
> +static int pcan_usb_set_silent(struct peak_usb_device *dev, u8 onoff)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +
> +	args[0] =3D onoff ? 1 : 0;
> +	return pcan_usb_send_command(dev, 3, 3, args);

dito

> +}
> +
> +static int pcan_usb_set_ext_vcc(struct peak_usb_device *dev, u8 onoff)=

> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +
> +	args[0] =3D onoff ? 1 : 0;
> +	return pcan_usb_send_command(dev, 10, 2, args);

dito

I see some magic numbers for the command here, does it make sense to
define an enum for them?

> +}
> +
> +/*
> + * This routine was stolen from drivers/net/can/sja1000/sja1000.c
> + */

Nice for crediting this, but IMHO no need to write it into the code.

> +static int pcan_usb_set_bittiming(struct peak_usb_device *dev, struct =
can_bittiming *bt)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +	u8 btr0, btr1;
> +
> +	btr0 =3D ((bt->brp - 1) & 0x3f) | (((bt->sjw - 1) & 0x3) << 6);
> +	btr1 =3D ((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) \
> +	     | (((bt->phase_seg2 - 1) & 0x7) << 4);
> +	if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +		btr1 |=3D 0x80;
> +
> +	args[0] =3D btr1;
> +	args[1] =3D btr0;
> +
> +	printk("btr0=3D0x%02x btr1=3D0x%02x", btr0, btr1);

Please use netdev_LEVEL() instead of printk
> +
> +	return pcan_usb_send_command(dev, 1, 2, args);
> +}
> +
> +static int pcan_usb_write_mode(struct peak_usb_device *dev, u8 onoff)
> +{
> +	int err;
> +
> +	err =3D pcan_usb_set_bus(dev, onoff);
> +	if (err)=20
> +		return err;
> +
> +	if (!onoff) {
> +		err =3D pcan_usb_set_sja1000(dev, SJA1000_MODE_INIT);
> +	}

please remove the { }
> +
> +	return err;
> +}
> +
> +static int pcan_usb_get_serial_number(struct peak_usb_device *dev, u32=
 *serial_number)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +	int err;
> +
> +	err =3D pcan_usb_wait_response(dev, 6, 1, args);
> +	if (err)=20
> +		netdev_err(dev->netdev, "getting serial number failure: %d\n", err);=

> +	else {
> +		if (serial_number) memcpy(serial_number, &args[0], 4);
> +	}

please remove the { }, no command after the if, please.

Hmmm that serial number to u32 memcpy looks fishy, I smell endianess
problem. Can you test your driver on an big endian machine, like powerpc?=


> +
> +	return err;
> +}
> +
> +static int pcan_usb_get_device_number(struct peak_usb_device *dev, u32=
 *device_number)
> +{
> +	u8 args[PCAN_USB_PARAMETER_LEN];
> +	int err;
> +
> +	err =3D pcan_usb_wait_response(dev, 4, 1, args);
> +	if (err)=20
> +		netdev_err(dev->netdev, "getting device number failure: %d\n", err);=

> +	else {
> +		if (device_number) *device_number =3D args[0];

please remove the { }, no command in the same line as the "if"

> +	}
> +
> +	return err;
> +}
> +
> +static void pcan_usb_update_time_word(struct pcan_usb *pdev, u16 ts16,=
 u8 s)
> +{
> +
> +	if (s =3D=3D 0)
> +		peak_usb_set_timestamp_now(&pdev->time_ref, ts16);
> +	else=20
> +		peak_usb_update_timestamp_now(&pdev->time_ref, ts16);
> +}
> +
> +/*
> + * callback for bulk IN urb
> + */
> +static int pcan_usb_decode_msg(struct peak_usb_device *dev, struct urb=
 *urb)
> +{
> +	struct pcan_usb *pdev =3D (struct pcan_usb *)dev;
> +	struct net_device *netdev =3D dev->netdev;
> +	int err =3D 0;
> +
> +	if (urb->actual_length > PCAN_USB_MSG_HEADER_LEN) {
> +		struct net_device_stats *stats =3D &netdev->stats;
> +
> +		u8 *ibuf =3D urb->transfer_buffer;
> +		const u8 msg_count =3D ibuf[1];
> +		int frm_count =3D 0;
> +		u8 i;
> +
> +		ibuf +=3D PCAN_USB_MSG_HEADER_LEN;
> +
> +		for (i =3D 0; i < msg_count && !err; i++) {
> +

please remove that extra blame line

> +			struct sk_buff *skb;
> +			struct can_frame *cf;
> +			struct timeval tv;
> +			u16 tmp16, ts16=3D0, dts=3D0, prev_ts8=3D0;

please add spaces around =3D

> +			u8 sl =3D *ibuf++;
> +			u8 rec_len =3D (sl & PCAN_USB_STATUSLEN_DLC);
> +
> +			/* handle error frames here */

I suggest to put the error handling in a sub function. If you have

> +			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> +				u8 f =3D *ibuf++;
> +				u8 n =3D *ibuf++;
> +
> +				if (sl & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +					/* only the first packet supplies a word timestamp */
> +					if (i =3D=3D 0) {
> +						memcpy(&tmp16, ibuf, 2);
> +						ibuf +=3D 2;
> +						ts16 =3D le16_to_cpu(tmp16);
> +						dts =3D 0;
> +					}
> +					else {
> +						u8 ts8 =3D *ibuf++;
> +
> +						if (dts) {
> +							dts &=3D 0xff00;
> +							if (ts8 < prev_ts8)
> +								dts +=3D 0x100;
> +						}
> +
> +						dts |=3D ts8;
> +						prev_ts8 =3D ts8;
> +
> +					}
> +				}
> +
> +				switch (f) {
> +
> +				case 1:
> +
please reove these two empty lines. I think you should define an enum
for the functions.

> +					/* allocate an skb to store the error frame */
> +					skb =3D alloc_can_err_skb(netdev, &cf);
> +					if (skb =3D=3D NULL) {
!skb

please talk to Wolfgang for the error handling, he is the expert now :)

> +						err =3D -ENOMEM;
> +						break;
> +					}
> +
> +					if (n & (PCAN_USB_ERROR_RXQOVR|PCAN_USB_ERROR_QOVR)) {
> +						cf->can_id |=3D CAN_ERR_CRTL;
> +						cf->data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> +						stats->rx_over_errors++;
> +						stats->rx_errors++;
> +					}
> +					if (n & PCAN_USB_ERROR_BUS_OFF) {
> +						cf->can_id |=3D CAN_ERR_BUSOFF;
> +						can_bus_off(netdev);
> +					}
> +					if (n & PCAN_USB_ERROR_BUS_HEAVY) {
> +						cf->can_id |=3D CAN_ERR_CRTL;
> +						cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
> +						dev->can.can_stats.error_passive++;
> +					}
> +					if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> +						cf->can_id |=3D CAN_ERR_CRTL;
> +						cf->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
> +						dev->can.can_stats.error_warning++;
> +					}
> +
> +					if (cf->can_id !=3D CAN_ERR_FLAG) {
> +						if (sl & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +							peak_usb_get_timestamp_tv(&pdev->time_ref, ts16+dts, &tv);
> +							skb->tstamp =3D timeval_to_ktime(tv);
> +						}
> +						netif_rx(skb);
> +						stats->rx_packets++;
> +					}
> +
> +					/* v3: sometimes the telegram carries 3 additional data */
> +					/* without note in ucStatusLen. */
> +					ibuf +=3D rec_len;
> +					break;
> +
> +				case 2:
> +					/* analog values (ignored) */
> +					ibuf +=3D 2;
> +					break;
> +
> +				case 3:
> +					/* bus load (ignored) */
> +					ibuf++;
> +					break;
> +
> +				case 4:
> +					/* only timestamp */
> +					memcpy(&tmp16, ibuf, 2);
> +					ibuf +=3D 2;
> +					ts16 =3D le16_to_cpu(tmp16);
> +					pcan_usb_update_time_word(pdev, ts16, i);
> +					break;
> +
> +				case 5:
> +					/* error frame/bus event */
> +					if (n & PCAN_USB_ERROR_TXQFULL) {
> +						netdev_info(netdev, "device Tx queue full)\n");
> +					}

remove { }
> +					ibuf +=3D rec_len;
> +					break;
> +
> +				case 10:
> +					/* future... */
> +					break;
> +
> +				default:
> +					netdev_err(netdev, "unexpected function %u\n", f);
> +					break;
> +				}
> +			}
> +
> +			/* handle normal can frames here */

please use an extra fucntion for normal frames

> +			else {
> +
> +				u8 d =3D 0;
> +
> +				skb =3D alloc_can_skb(netdev, &cf);
> +				if (skb =3D=3D NULL) {
> +					err =3D -ENOMEM;
> +					break;
> +				}
> +
> +				if (sl & PCAN_USB_STATUSLEN_EXT_ID) {
> +					u32 tmp32;
> +					memcpy(&tmp32, ibuf, 4);
> +					ibuf +=3D 4;
> +					cf->can_id =3D le32_to_cpu(tmp32 >> 3) | CAN_EFF_FLAG;
> +				}
> +				else {
> +					memcpy(&tmp16, ibuf, 2);
> +					ibuf +=3D 2;
> +					cf->can_id =3D le16_to_cpu(tmp16 >> 5);
> +				}
> +
> +				cf->can_dlc =3D get_can_dlc(rec_len);
> +
> +				/* first data packet timestamp is a word */
> +				if (!frm_count++) {
> +					memcpy(&tmp16, ibuf, 2);
> +					ibuf +=3D 2;
> +					ts16 =3D le16_to_cpu(tmp16);
> +					dts =3D 0;
> +				}
> +				else {

the preferred coding style is
} else {
> +					u8 ts8 =3D *ibuf++;
> +
> +					if (dts) {
> +						dts &=3D 0xff00;
> +						if (ts8 < prev_ts8)
> +							dts +=3D 0x100;
> +					}
> +
> +					dts |=3D ts8;
> +					prev_ts8 =3D ts8;

I think I've seen this code before, please add a function for it.

> +
> +				}
> +
> +				/* read data */
> +				if (sl & PCAN_USB_STATUSLEN_RTR) {
> +					cf->can_id |=3D CAN_RTR_FLAG;
> +				}
> +				else {

} else { - or better get remove the { }

> +					for (; d < rec_len; d++)
> +						cf->data[d] =3D *ibuf++;
> +				}
> +
> +				for (; d < 8; d++) {
> +					cf->data[d] =3D 0;
> +				}
memset?

> +
> +				peak_usb_get_timestamp_tv(&pdev->time_ref, ts16+dts, &tv);
> +				skb->tstamp =3D timeval_to_ktime(tv);
> +				netif_rx(skb);
> +
> +				stats->rx_packets++;
> +				stats->rx_bytes +=3D cf->can_dlc;
> +			}
> +
> +			if ((ibuf - (u8 *)urb->transfer_buffer) > urb->transfer_buffer_leng=
th) {

What does this check do? You should do bounds checking of ibuf before
accessing it.

> +				netdev_err(netdev, "usb message format error\n");
> +				err =3D -EINVAL;
> +				break;
> +			}
> +		}
> +	}
> +	else if (urb->actual_length > 0) {
> +		netdev_err(netdev, "usb message length error (%u)\n", urb->actual_le=
ngth);
> +		err =3D -EINVAL;
> +	}

I'd move the error checking to the beginning of the function. Return
early if you detect an error, so that you can get rid of (at least) one
indention level.

> +
> +	return err;
> +}
> +
> +static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_=
buff *skb, u8 *obuf, size_t *size)
> +{
> +	struct net_device *netdev =3D dev->netdev;
> +	struct net_device_stats *stats =3D &netdev->stats;
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u8 *pc;
> +
> +	obuf[0] =3D 2;
> +	obuf[1] =3D 1;
> +
> +	pc =3D &obuf[PCAN_USB_MSG_HEADER_LEN];
> +
> +	/* status/len byte */
> +	*pc =3D cf->can_dlc;
> +	if (cf->can_id & CAN_RTR_FLAG)=20
> +		*pc |=3D PCAN_USB_STATUSLEN_RTR;
> +=09
> +	/* can id */
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		u32 tmp32 =3D cpu_to_le32(cf->can_id & CAN_ERR_MASK);
                ^^^ should be __le32 then
> +		tmp32 <<=3D 3;
> +		*pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
> +		memcpy(++pc, &tmp32, 4);
> +		pc +=3D 4;
> +	}
> +	else {
} else {
> +		u16 tmp16 =3D (u16 )cpu_to_le32(cf->can_id & CAN_ERR_MASK);
                            ^^^^^^^^^^^^^^^^^
why convert to le32 and then cast to u16?

> +		tmp16 <<=3D 5;
> +		memcpy(++pc, &tmp16, 2);
> +		pc +=3D 2;
> +	}
> +
> +	/* can data */
> +	if ((cf->can_id & CAN_RTR_FLAG) =3D=3D 0) {

if (cf->can_id & CAN_RTR_FLAG)

> +		memcpy(pc, &cf->data[0], cf->can_dlc);

		memcpy(pc, cf->data, cf->can_dlc);

> +		pc +=3D cf->can_dlc;
> +	}
> +
> +	/* Hmm... pcan driver sets the count of messages sent in the last byt=
e... */
> +	obuf[(*size)-1] =3D (u8 )(stats->tx_packets & 0xff);
> +
> +	return 0;
> +}
> +
> +/*
> + * Start interface
> + */
> +static int pcan_usb_start(struct peak_usb_device *dev)
> +{
> +	struct pcan_usb *pdev =3D (struct pcan_usb *)dev;=20
> +	int err;
> +
> +	/* number of bits used in timestamps read from adapter struct */
> +	peak_usb_init_time_ref(&pdev->time_ref, &pcan_usb);
> +
> +	/* If revision greater than 3, can put silent mode on/off*/
> +	if (dev->device_rev > 3) {
> +=09
> +		err =3D pcan_usb_set_silent(dev,=20
> +		                          (dev->can.ctrlmode & CAN_CTRLMODE_LISTENON=
LY));
> +		if (err)
> +			goto failed;
> +	}
> +
> +	err =3D pcan_usb_set_ext_vcc(dev, 0);
> +	if (err)
> +		goto failed;
> +
> +	return 0;
> +
> +failed:
> +
> +	return err;
> +}
> +
> +static int pcan_usb_init(struct peak_usb_device *dev)
> +{
> +	u32 serial_number;
> +	int err;
> +
> +	err =3D pcan_usb_get_serial_number(dev, &serial_number);
> +	if (!err)
> +		netdev_info(dev->netdev, "serial %08X\n", serial_number);
> +
> +	return err;
> +}
> +
> +/*
> + * probe function for new PCAN-USB usb interface
> + */
> +static int pcan_usb_probe(struct usb_interface *intf)
> +{
> +	struct usb_host_interface *iface_desc;
> +	int i;
> +
> +	/* check endpoint addresses (numbers) and associated max data length =
*/
> +	/* (only from setting 0) */
> +	iface_desc =3D &intf->altsetting[0];
> +
> +	/* check interface endpoint addresses */
> +	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *endpoint =3D &iface_desc->endpoint[i=
].desc;
> +
> +		/* Below is the list of valid ep addreses. All other ep address */
> +		/* is considered as not-CAN interface address =3D> no dev created */=

> +		switch (endpoint->bEndpointAddress) {
> +		case PCAN_USB_EP_CMDOUT:
> +		case PCAN_USB_EP_CMDIN:
> +		case PCAN_USB_EP_MSGOUT:
> +		case PCAN_USB_EP_MSGIN:
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
> +	}
> +=20
> +	return 0;
> +}
> +
> +/*=20
> + * Describe the PCAN-USB adapter=20
> + */
> +struct peak_usb_adapter pcan_usb =3D {
> +	.name =3D "PCAN-USB",
> +	.device_id =3D PCAN_USB_PRODUCT_ID,
> +	.ctrl_count =3D 1,
> +	.clock =3D {
> +		.freq =3D PCAN_USB_CRYSTAL_HZ/2,
> +	},
> +	.bittiming_const =3D {
> +		.name =3D "pcan_usb",
> +		.tseg1_min =3D 1,
> +		.tseg1_max =3D 16,
> +		.tseg2_min =3D 1,
> +		.tseg2_max =3D 8,
> +		.sjw_max =3D 4,
> +		.brp_min =3D 1,
> +		.brp_max =3D 64,
> +		.brp_inc =3D 1,
> +	},
> +
> +	/* size of device private data */
> +	.sizeof_dev_private =3D sizeof(struct pcan_usb),
> +=09
> +	/* timestamps usage */
> +	.ts_used_bits =3D 16,
> +	.ts_period =3D 24575, /* calibration period in ts. */
> +	.us_per_ts_scale =3D PCAN_USB_TS_US_PER_TICK, /* us =3D (ts * scale) =
>> shift */
> +	.us_per_ts_shift =3D PCAN_USB_TS_DIV_SHIFTER,
> +
> +	/* give here commands/messages in/out endpoints */
> +	.ep_msg_in =3D PCAN_USB_EP_MSGIN,
> +	.ep_msg_out =3D {PCAN_USB_EP_MSGOUT},
> +
> +	/* size of rx/tx usb buffers */
> +	.rx_buffer_size =3D PCAN_USB_RX_BUFFER_SIZE,
> +	.tx_buffer_size =3D PCAN_USB_TX_BUFFER_SIZE,
> +
> +	/* device callbacks */
> +	.intf_probe =3D pcan_usb_probe,
> +	.device_init =3D pcan_usb_init,
> +	.device_set_bus =3D pcan_usb_write_mode,
> +	.device_set_bittiming =3D pcan_usb_set_bittiming,
> +	.device_get_device_number =3D pcan_usb_get_device_number,
> +	.device_decode_msg =3D pcan_usb_decode_msg,
> +	.device_encode_msg =3D pcan_usb_encode_msg,
> +	.device_start =3D pcan_usb_start,
> +};
> +

that's it for now

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig737B3AEAA45C838ACD85A7B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7rPGgACgkQjTAFq1RaXHNfXwCfW50QufX73BgoscjEb2t8b29K
sdMAnRZGCExUQBeJxZwXDuujowcHxDC5
=bjoJ
-----END PGP SIGNATURE-----

--------------enig737B3AEAA45C838ACD85A7B0--

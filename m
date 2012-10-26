From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: usb: esd_usb2: Add support for CAN-USB/Micro and
 listen-only mode
Date: Fri, 26 Oct 2012 13:34:51 +0200
Message-ID: <508A755B.8050408@pengutronix.de>
References: <508A7170.2060104@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig365A1BCC73196331690734C0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54834 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758513Ab2JZLe5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Oct 2012 07:34:57 -0400
In-Reply-To: <508A7170.2060104@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig365A1BCC73196331690734C0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/26/2012 01:18 PM, Matthias Fuchs wrote:
> This patch extends the esd_usb2 driver to support the
> tiny CAN-USB/Micro CAN/USB interface.
>=20
> Listen-only mode for both supported devices is added also.

Please make it two separate patches, see comments inline.

>=20
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
> ---
>  drivers/net/can/usb/Kconfig    |    4 ++--
>  drivers/net/can/usb/esd_usb2.c |   39 +++++++++++++++++++++++++++++++-=
-------
>  2 files changed, 33 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index 0a68768..ef96520 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -8,9 +8,9 @@ config CAN_EMS_USB
>  	  from EMS Dr. Thomas Wuensche (http://www.ems-wuensche.de).
> =20
>  config CAN_ESD_USB2
> -        tristate "ESD USB/2 CAN/USB interface"
> +        tristate "ESD USB/2 and USB/Micro CAN/USB interfaces"
>          ---help---
> -          This driver supports the CAN-USB/2 interface
> +          This driver supports the CAN-USB/2 and CAN-USB/Micro interfa=
ces
>            from esd electronic system design gmbh (http://www.esd.eu).
> =20
>  config CAN_PEAK_USB
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
> index bd36e55..a9fe8a2 100644
> --- a/drivers/net/can/usb/esd_usb2.c
> +++ b/drivers/net/can/usb/esd_usb2.c
> @@ -1,7 +1,7 @@
>  /*
> - * CAN driver for esd CAN-USB/2
> + * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
>   *
> - * Copyright (C) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh=

> + * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd=
 gmbh
>   *
>   * This program is free software; you can redistribute it and/or modif=
y it
>   * under the terms of the GNU General Public License as published
> @@ -28,14 +28,16 @@
>  #include <linux/can/error.h>
> =20
>  MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
> -MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 interfaces");
> +MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro int=
erfaces");
>  MODULE_LICENSE("GPL v2");
> =20
>  /* Define these values to match your devices */
>  #define USB_ESDGMBH_VENDOR_ID	0x0ab4
>  #define USB_CANUSB2_PRODUCT_ID	0x0010
> +#define USB_CANUSBM_PRODUCT_ID	0x0011
> =20
>  #define ESD_USB2_CAN_CLOCK	60000000
> +#define ESD_USBM_CAN_CLOCK	36000000
>  #define ESD_USB2_MAX_NETS	2
> =20
>  /* USB2 commands */
> @@ -69,6 +71,7 @@ MODULE_LICENSE("GPL v2");
>  #define ESD_USB2_TSEG2_SHIFT	20
>  #define ESD_USB2_SJW_MAX	4
>  #define ESD_USB2_SJW_SHIFT	14
> +#define ESD_USBM_SJW_SHIFT	24
>  #define ESD_USB2_BRP_MIN	1
>  #define ESD_USB2_BRP_MAX	1024
>  #define ESD_USB2_BRP_INC	1
> @@ -183,6 +186,7 @@ struct __attribute__ ((packed)) esd_usb2_msg {
> =20
>  static struct usb_device_id esd_usb2_table[] =3D {
>  	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID)},
> +	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSBM_PRODUCT_ID)},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(usb, esd_usb2_table);
> @@ -889,18 +893,29 @@ static int esd_usb2_set_bittiming(struct net_devi=
ce *netdev)
>  	struct can_bittiming *bt =3D &priv->can.bittiming;
>  	struct esd_usb2_msg msg;
>  	u32 canbtr;
> +	int sjw_shift;
> =20
>  	canbtr =3D ESD_USB2_UBR;
>  	canbtr |=3D (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
> +
> +	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) =3D=3D
> +	    USB_CANUSBM_PRODUCT_ID)
> +		sjw_shift =3D ESD_USBM_SJW_SHIFT;
> +	else {
> +		sjw_shift =3D ESD_USB2_SJW_SHIFT;
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +			canbtr |=3D ESD_USB2_3_SAMPLES;

No need to move the CAN_CTRLMODE_3_SAMPLES setting here. The framework
takes care, that only supported ctrl modes are accepted.

> +	}
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		canbtr |=3D ESD_USB2_LOM;
> +
>  	canbtr |=3D ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
> -		<< ESD_USB2_SJW_SHIFT;
> +		<< sjw_shift;
>  	canbtr |=3D ((bt->prop_seg + bt->phase_seg1 - 1)
>  		   & (ESD_USB2_TSEG1_MAX - 1))
>  		<< ESD_USB2_TSEG1_SHIFT;
>  	canbtr |=3D ((bt->phase_seg2 - 1) & (ESD_USB2_TSEG2_MAX - 1))
>  		<< ESD_USB2_TSEG2_SHIFT;
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> -		canbtr |=3D ESD_USB2_3_SAMPLES;
> =20
>  	msg.msg.hdr.len =3D 2;
>  	msg.msg.hdr.cmd =3D CMD_SETBAUD;
> @@ -971,12 +986,20 @@ static int esd_usb2_probe_one_net(struct usb_inte=
rface *intf, int index)
>  	priv->index =3D index;
> =20
>  	priv->can.state =3D CAN_STATE_STOPPED;
> -	priv->can.clock.freq =3D ESD_USB2_CAN_CLOCK;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY;
> +
> +	if (le16_to_cpu(dev->udev->descriptor.idProduct) =3D=3D
> +	    USB_CANUSBM_PRODUCT_ID)
> +		priv->can.clock.freq =3D ESD_USBM_CAN_CLOCK;
> +	else {
> +		priv->can.clock.freq =3D ESD_USB2_CAN_CLOCK;
> +		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
> +	}
> +
>  	priv->can.bittiming_const =3D &esd_usb2_bittiming_const;
>  	priv->can.do_set_bittiming =3D esd_usb2_set_bittiming;
>  	priv->can.do_set_mode =3D esd_usb2_set_mode;
>  	priv->can.do_get_berr_counter =3D esd_usb2_get_berr_counter;
> -	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES;
> =20
>  	netdev->flags |=3D IFF_ECHO; /* we support local echo */
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig365A1BCC73196331690734C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCKdV8ACgkQjTAFq1RaXHO98ACghUZIFa5Juob4wEBxDQAhudmS
/kAAnRuIndllSuNAMy1xJstURpLMv2sW
=iVJB
-----END PGP SIGNATURE-----

--------------enig365A1BCC73196331690734C0--

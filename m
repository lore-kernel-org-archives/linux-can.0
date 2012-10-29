From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: usb: esd_usb2: Add support for CAN-USB/Micro
Date: Mon, 29 Oct 2012 11:26:41 +0100
Message-ID: <508E59E1.4010901@pengutronix.de>
References: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu> <1351504488-7060-3-git-send-email-matthias.fuchs@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig68F32BABF911143001143503"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758492Ab2J2K0r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 06:26:47 -0400
In-Reply-To: <1351504488-7060-3-git-send-email-matthias.fuchs@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: matthias.fuchs@esd.eu
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68F32BABF911143001143503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/29/2012 10:54 AM, matthias.fuchs@esd.eu wrote:
> From: Matthias Fuchs <matthias.fuchs@esd.eu>
>=20
> This patch extends the esd_usb2 driver to support the
> tiny CAN-USB/Micro CAN/USB interface.
>=20
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
> ---
>  drivers/net/can/usb/esd_usb2.c |   31 +++++++++++++++++++++++++------
>  1 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
> index f4317c0..124e0dd 100644
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

I just noticed that you can add a driver_info pointer to the struct
usb_device_id [1].

You can define a struct describing your hardware:

struct esd_driver_info {
	int sjw_shift;
	int clock_freq;=09
};

struct esd_driver_info esd_usb2 =3D {
	.sjw_shift =3D 23,
	.clock_freq =3D 42,
};

static struct usb_device_id esd_usb2_table[] =3D {
  	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID),
		.driver_info =3D (kernel_ulong_t)&esd_usb2, },
};

And then access the driver_info pointer in the probe function (via
id->driver_info)....

Bit I think your solution is easier. If you add more device a conversion
might become handy.

>  };
>  MODULE_DEVICE_TABLE(usb, esd_usb2_table);
> @@ -889,14 +893,22 @@ static int esd_usb2_set_bittiming(struct net_devi=
ce *netdev)
>  	struct can_bittiming *bt =3D &priv->can.bittiming;
>  	struct esd_usb2_msg msg;
>  	u32 canbtr;
> +	int sjw_shift;
> =20
>  	canbtr =3D ESD_USB2_UBR;
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>  		canbtr |=3D ESD_USB2_LOM;
> =20
>  	canbtr |=3D (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
> +
> +	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) =3D=3D
> +	    USB_CANUSBM_PRODUCT_ID)
> +		sjw_shift =3D ESD_USBM_SJW_SHIFT;
> +	else
> +		sjw_shift =3D ESD_USB2_SJW_SHIFT;
> +
>  	canbtr |=3D ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
> -		<< ESD_USB2_SJW_SHIFT;
> +		<< sjw_shift;
>  	canbtr |=3D ((bt->prop_seg + bt->phase_seg1 - 1)
>  		   & (ESD_USB2_TSEG1_MAX - 1))
>  		<< ESD_USB2_TSEG1_SHIFT;
> @@ -975,12 +987,19 @@ static int esd_usb2_probe_one_net(struct usb_inte=
rface *intf, int index)
> =20
>  	priv->can.state =3D CAN_STATE_STOPPED;
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY;
> -	priv->can.clock.freq =3D ESD_USB2_CAN_CLOCK;
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

[1]
http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L101=


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig68F32BABF911143001143503
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCOWeUACgkQjTAFq1RaXHMaZwCZAULszB4AtslzTZD2VlThLF9l
VUAAnj6HTL/EAIaYJv9ruHJQ1bOD2p7t
=Y7tU
-----END PGP SIGNATURE-----

--------------enig68F32BABF911143001143503--

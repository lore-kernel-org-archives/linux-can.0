From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can/peak_usb: CAN-FD: existing source files modifications
Date: Thu, 27 Nov 2014 22:27:17 +0100
Message-ID: <54779735.8030809@pengutronix.de>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com> <1417084329-8997-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Gg05VO2Bnq23fSTSorneE3J4LOJTiNTQs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51877 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaK0V12 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 16:27:28 -0500
In-Reply-To: <1417084329-8997-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gg05VO2Bnq23fSTSorneE3J4LOJTiNTQs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/27/2014 11:32 AM, Stephane Grosjean wrote:
> This patch does some modifications to the existing files that support t=
he
> PEAK-System Technik CAN 2.0b USB adapters, for preparing the support of=
 CAN-FD.
>=20
> In particular, this patch changes some static identifiers into global o=
nes, to
> share common functionalities with the further incoming CAN-FD specific =
source
> files.

The subject of this patch should describe what it does and the
description why. You should not split your patches by source files it
touches but thematically. Only handle one problem per patch.

>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c     |  1 +
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 22 +++++++--------------=
-
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h |  8 ++++++++
>  3 files changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/=
usb/peak_usb/pcan_usb.c
> index 925ab8e..10a4ceb 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb =3D {
>  	.name =3D "PCAN-USB",
>  	.device_id =3D PCAN_USB_PRODUCT_ID,
>  	.ctrl_count =3D 1,
> +	.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,

This change seems unrelated to the make functions non static.

and FTBFS:

> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: error: unknown fie=
ld =E2=80=98ctrlmode_supported=E2=80=99 specified in initializer
>   .ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENO=
NLY,
>   ^
> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning: initializ=
ation makes pointer from integer without a cast
> linux/drivers/net/can/usb/peak_usb/pcan_usb.c:861:2: warning: (near ini=
tialization for =E2=80=98pcan_usb.intf_probe=E2=80=99)

>  	.clock =3D {
>  		.freq =3D PCAN_USB_CRYSTAL_HZ / 2 ,
>  	},
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index 263dd92..10887b0 100644
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
> @@ -333,8 +325,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_de=
vice *dev, int req_id,
>  	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
>  		return 0;
> =20
> -	memset(req_addr, '\0', req_size);
> -
>  	req_type =3D USB_TYPE_VENDOR | USB_RECIP_OTHER;
> =20
>  	switch (req_id) {
> @@ -345,6 +335,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_de=
vice *dev, int req_id,
>  	default:
>  		p =3D usb_rcvctrlpipe(dev->udev, 0);
>  		req_type |=3D USB_DIR_IN;
> +		memset(req_addr, '\0', req_size);

Why is this memset moved?

>  		break;
>  	}
> =20
> @@ -476,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct peak_u=
sb_device *dev,
>  	return pcan_usb_pro_set_bitrate(dev, ccbt);
>  }
> =20
> -static void pcan_usb_pro_restart_complete(struct urb *urb)
> +void pcan_usb_pro_restart_complete(struct urb *urb)
>  {
>  	/* can delete usb resources */
>  	peak_usb_async_complete(urb);
> @@ -932,7 +923,7 @@ static int pcan_usb_pro_init(struct peak_usb_device=
 *dev)
> =20
>  	return 0;
> =20
> - err_out:
> +err_out:

Please don't change this.

>  	kfree(bi);
>  	kfree(fi);
>  	kfree(usb_if);
> @@ -978,7 +969,7 @@ static void pcan_usb_pro_free(struct peak_usb_devic=
e *dev)
>  /*
>   * probe function for new PCAN-USB Pro usb interface
>   */
> -static int pcan_usb_pro_probe(struct usb_interface *intf)
> +int pcan_usb_pro_probe(struct usb_interface *intf)
>  {
>  	struct usb_host_interface *if_desc;
>  	int i;
> @@ -1016,6 +1007,7 @@ struct peak_usb_adapter pcan_usb_pro =3D {
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
> index 32275af..1101c9c 100644
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
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Gg05VO2Bnq23fSTSorneE3J4LOJTiNTQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUd5c1AAoJECte4hHFiupUK7gP/0pb+ld2Xp4gqIwAV+rx1zz6
/UGwHSpQSPLjMDhD0BlWQyZ0Nhn4w2hM7St2Y39lHCqY5kogyt8Qcw9r/wk9SxPR
USmANe37e1ZQudzqxqoGdBhOvsXG90Nu1QyA8CzdDcB+Ws45FX84OnKwRLmPxUl1
ttS7Eci96MSrQjnaXYIGXHasSYQixUNnDgk/mF4pM8zjYaXW+hyfuRmQIYJiNfe8
C1qh+In5foX1diPlcpmDRJVLDdD00JTv2kUzxVJ24qFOGQtlGAbb4Zf54gir2MzU
v3Xcth7L8cvXpH3WMRWOBGN4nNsIls5fPgPZMlI/mV/XrDN8CuphEy3dvrqGjAXl
nbKysAWrNkN2rjlliz3cvSxxkGKx5rNI3iUJMnpvMTiIapEgA+DNGMHAaSkCInua
qoX15U4d5IhjYYpw7wtX+0QHNMJ7Jtj6yhN7+s4DVWB7sj/WGAYE7DR3FaKVCOZm
equOl7Pt3NDuwXoq7AfwSW7tX9GWixDGOAYTMP6w23PICoPWPFz4uYI5oykGTpSU
jtFr7enc89+JHVgflxuF/BrDcYDnqaMj8D8DrlML0nN8d+Dl+fXZew9fmAUOzlsE
XIiEG/kDUoPtDBElcLXNtK2sxi9HwGAAGBleaN1S8XxWvacXM/CinuXbbafVPVBh
76dz8PL3OfXkTJD36dC7
=r6Vk
-----END PGP SIGNATURE-----

--Gg05VO2Bnq23fSTSorneE3J4LOJTiNTQs--

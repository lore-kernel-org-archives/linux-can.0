From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Tue, 20 Jan 2015 15:21:11 +0100
Message-ID: <54BE6457.1020003@pengutronix.de>
References: <1421757005-17271-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TPL0jaSangfAwGF97AOIPoJ6BXFwVEX6j"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37621 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbATOVO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:21:14 -0500
In-Reply-To: <1421757005-17271-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TPL0jaSangfAwGF97AOIPoJ6BXFwVEX6j
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2015 01:30 PM, Stephane Grosjean wrote:
> Add support for the following new PEAK-System technik CANFD USB adapter=
s:
>=20
> PCAN-USB FD             single CANFD channel USB adapter
> PCAN-USB Pro FD         dual CANFD channels USB adapter
>=20
> Communication protocol has been developped using some mechanisms that
> did exist in the PCAN-USB Pro, thus, this patch also changes some
> previously static functions and data into global ones.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/Kconfig                  |   14 +-
>  drivers/net/can/usb/peak_usb/Makefile        |    2 +-
>  drivers/net/can/usb/peak_usb/pcan_ucan.h     |  222 ++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |    4 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |    4 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 1091 ++++++++++++++++++=
++++++++
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c  |   16 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |   13 +
>  8 files changed, 1350 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[...]

> +};
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.c
> index a2fc94a..a764045 100644
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
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/=
can/usb/peak_usb/pcan_usb_pro.h
> index 837cee2..a62f7ab 100644
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
> @@ -176,4 +184,9 @@ union pcan_usb_pro_rec {
>  	struct pcan_usb_pro_txmsg	tx_msg;
>  };
> =20
> +int pcan_usb_pro_probe(struct usb_interface *intf);
> +int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
> +			  int req_value, void *req_addr, int req_size);
> +void pcan_usb_pro_restart_complete(struct urb *urb);
> +
>  #endif
>=20

I've moved the above hunks into a separate patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TPL0jaSangfAwGF97AOIPoJ6BXFwVEX6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUvmRXAAoJECte4hHFiupUtfkP/1j6pGA2dX+wgUUM45LxVWq4
KTZAhcJUn8YD5wEMGa+oWWqkLmj3ZNN4FHQl7q6vCZlpj192zmHVmUMGCGSDkRwh
40+SOowQJjpK9SGTqkV1qYr26SgxrZ4FFEXoMT7W3T/xWUVocXGKEVTteh5i5zeg
8rfkzh7p6TlfsWK62Bk1549aymiQAM4HfIoVbWIY1TzTitMGtZfOj7FfnpJNWYWf
kmjNSUlBZ7rBM7VveMu4aQ/mPOVISDtO8lzWS0EglRlfsJF7gvTctUPEsL6V+ZSt
jsjJCRE5VlkSvO9jb+jN5TeagTpYIPm4Uh1/5flYTI9qOnp8+ip1wPgG1sTgkb8s
zyQ/rRUXC30VrmzJorKIuHo0mjLlzEjonvb3OQzvePFrcqJFod77laxWZATxTxMZ
aDXPdfvuifdksbBf7/HBD5Z16qMFuUkVkeelzwp3RL2sll5RpWDnRhNoa3nmhc5I
KUssVvIMVwEhru9qfSCqLetqjiPbk6oXjC0WttRX4mNcW/ZhqKWCDkfUSNSnK6qz
XoMc2LOWAAAqoWrrajqtV07KBRjx6wpqbcyfAnX7XIIi/XPYU88x5Fcu24l5FOI5
GWyK5l989oM3CPgYXBEfBUKOvQWK1YvbRol13OrnKqZAM9Ci7DsgEsFU09bHcHPo
vpgbe/oF1dBMB01eqx8A
=8vpE
-----END PGP SIGNATURE-----

--TPL0jaSangfAwGF97AOIPoJ6BXFwVEX6j--

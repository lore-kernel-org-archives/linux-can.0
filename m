From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
Date: Mon, 15 Jan 2018 13:53:27 +0100
Message-ID: <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kxkaU7ItJhkivBJq7SQeEeAhSkFfBtHiq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50491 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966285AbeAOMxu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 07:53:50 -0500
In-Reply-To: <20180115104141.4352-1-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kxkaU7ItJhkivBJq7SQeEeAhSkFfBtHiq
Content-Type: multipart/mixed; boundary="9HztJf9JeIFUJVhYBpNLcQA8F02D6vqmU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <51f04cfe-cb9f-b6f8-25a3-8d6df20dfbad@pengutronix.de>
Subject: Re: [PATCH] can: peak/usb: fix potential bug in packet fragmentation
References: <20180115104141.4352-1-s.grosjean@peak-system.com>
In-Reply-To: <20180115104141.4352-1-s.grosjean@peak-system.com>

--9HztJf9JeIFUJVhYBpNLcQA8F02D6vqmU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 11:41 AM, Stephane Grosjean wrote:
> In some rare conditions when running one PCAN USB FD interface other
> a non high-speed USB controller, one useless USB fragment might be sent=
=2E
> This patch fixes the way an USB command is fragmented when its length
> if greater than 64 bytes and when the underlying USB controller is not =
a
> high-speed one.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_fd.c
> index 7ccdc3e30c98..2b03ef0e655d 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -184,7 +184,7 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_dev=
ice *dev, void *cmd_tail)
>  	void *cmd_head =3D pcan_usb_fd_cmd_buffer(dev);
>  	int err =3D 0;
>  	u8 *packet_ptr;
> -	int i, n =3D 1, packet_len;
> +	int packet_len;
>  	ptrdiff_t cmd_len;
> =20
>  	/* usb device unregistered? */
> @@ -201,17 +201,14 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_d=
evice *dev, void *cmd_tail)
>  	}
> =20
>  	packet_ptr =3D cmd_head;
> +	packet_len =3D cmd_len;
> =20
>  	/* firmware is not able to re-assemble 512 bytes buffer in full-speed=
 */
> -	if ((dev->udev->speed !=3D USB_SPEED_HIGH) &&
> -	    (cmd_len > PCAN_UFD_LOSPD_PKT_SIZE)) {
> +	if (unlikely(dev->udev->speed !=3D USB_SPEED_HIGH &&
> +		     packet_len > PCAN_UFD_LOSPD_PKT_SIZE))
>  		packet_len =3D PCAN_UFD_LOSPD_PKT_SIZE;
> -		n +=3D cmd_len / packet_len;
> -	} else {
> -		packet_len =3D cmd_len;
> -	}

What about using min() instead of open coding it?

+       if (unlikely(dev->udev->speed !=3D USB_SPEED_HIGH))
+               packet_len =3D min(packet_len, PCAN_UFD_LOSPD_PKT_SIZE);

> =20
> -	for (i =3D 0; i < n; i++) {
> +	do {
>  		err =3D usb_bulk_msg(dev->udev,
>  				   usb_sndbulkpipe(dev->udev,
>  						   PCAN_USBPRO_EP_CMDOUT),
> @@ -224,7 +221,12 @@ static int pcan_usb_fd_send_cmd(struct peak_usb_de=
vice *dev, void *cmd_tail)
>  		}
> =20
>  		packet_ptr +=3D packet_len;
> -	}
> +		cmd_len -=3D packet_len;
> +
> +		if (cmd_len < PCAN_UFD_LOSPD_PKT_SIZE)
> +			packet_len =3D cmd_len;
> +
> +	} while (packet_len > 0);
> =20
>  	return err;
>  }
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9HztJf9JeIFUJVhYBpNLcQA8F02D6vqmU--

--kxkaU7ItJhkivBJq7SQeEeAhSkFfBtHiq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcpEcACgkQHv7KIOw4
HPYfdQf+Lx7IjeBa/Hoq36Js4bw99rjSupCr+hfkOLwlMQOUe3OW10w43Shf6Zid
OhCYQAPxUDY4GLU/i+zEo8Xuqvlx+k8K+9RbXuajKn6Cy/Ucjg/ZjFlSUF7jLKma
ixkwqQL9Is0VzpvVE73yk0I277ziHNg9G0FuTxrxTc/uLL43F8BEhtDPmJMIEsjv
AOgrXDzd0JM1SSX2tikblB4RPpaSnboTCxzm46/tSCmomNtrUC8AXlOosFyjQZnf
jsJbq6vniDxl35nljL9Blxp61s2Rs2qAR9gPFb7M8IXqLPPLSl1KBWIvW6FpXXDX
OaI4o0vSUP8eNZjLdueXQxFPU9x/Dg==
=nC4I
-----END PGP SIGNATURE-----

--kxkaU7ItJhkivBJq7SQeEeAhSkFfBtHiq--

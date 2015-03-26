From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH -stable 1/3] can: kvaser_usb: Avoid double free on
 URB submission failures
Date: Thu, 26 Mar 2015 08:46:18 +0100
Message-ID: <5513B94A.1060808@pengutronix.de>
References: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com> <1426903404-22925-2-git-send-email-ahmed.darwish@valeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="odufRLrvTptG8fBMx4wuH7sE4nt8MK9EX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53303 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbCZHqW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2015 03:46:22 -0400
In-Reply-To: <1426903404-22925-2-git-send-email-ahmed.darwish@valeo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--odufRLrvTptG8fBMx4wuH7sE4nt8MK9EX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2015 03:03 AM, Ahmed S. Darwish wrote:
> From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>
>=20
> Upon a URB submission failure, the driver calls usb_free_urb()
> but then manually frees the URB buffer by itself.  Meanwhile
> usb_free_urb() has alredy freed out that transfer buffer since
> we're the only code path holding a reference to this URB.
>=20
> Remove two of such invalid manual free().
>=20
> This is a backport of upstream commit: deb2701cf704a2
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> ---
>  drivers/net/can/usb/kvaser_usb.c |   20 ++++++++------------
>  1 files changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kva=
ser_usb.c
> index 7af379c..db43c5a 100644
> --- a/drivers/net/can/usb/kvaser_usb.c
> +++ b/drivers/net/can/usb/kvaser_usb.c
> @@ -595,7 +595,6 @@ static int kvaser_usb_simple_msg_async(struct kvase=
r_usb_net_priv *priv,
>  		netdev_err(netdev, "Error transmitting URB\n");
>  		usb_unanchor_urb(urb);
>  		usb_free_urb(urb);
> -		kfree(buf);
>  		return err;
>  	}
> =20
> @@ -1278,8 +1277,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct s=
k_buff *skb,
>  	struct urb *urb;
>  	void *buf;
>  	struct kvaser_msg *msg;
> -	int i, err;
> -	int ret =3D NETDEV_TX_OK;
> +	int i, err, ret =3D NETDEV_TX_OK;

Nitpick: you can remove that hunk.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--odufRLrvTptG8fBMx4wuH7sE4nt8MK9EX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVE7lKAAoJECte4hHFiupUeAMP/3hZYSHKRcUsEjbf1ieYYcVT
6osULzi6l4BNLlqoSZdghY0lTtefi8uLhUPHp+2yt9v07QJn3fj6TjYAEFKF6sPy
TNxz5h7IfFFmh0BLADVg/x3vGrc/UAOwEMJOnKYJsNrffMqVVif5Ob2svnpZvncy
fSpnfzGtHfy6+zw903WsYs7FDf6vqbIVvoYyjhAGvD9GsmQtE4afiEQhL3j5Ji3s
mRO/K7Uq26OZZiKUmDgTT3MhEK1KjkEcpL5UHac5NAyUKHM1zv9/n2YMI4NXmSV1
BWZ9ZzST+KkmIpWYYVyB9Pa0Z+36eDrKNqfxP4u4qpoUPeieGqscRmwDOamoFCOQ
h0c1qSDlDgi8yVeNFSey3cyb8j6MJB0VGUdS/fQo6ROP+6SofOxBwgEqWQFoTj+8
qhdY5j8pXeXkHQFFhSI3ySO41DJjli3P7lZ8FFqI8ONPiQDzKazIPSAtQyNUjYGF
yhyfB2LKAXGuX6ZMKsEMEdJWZREdu8dR3aocomB5iih0OP9kE06r3jywALVyyuHA
FY8umGWMqtt0ZgoNKTcAnKRYCl08f3KwXuDM6aW1ZcoL/ackpfSkV2Ifjt9mj4vW
NRUkWvsEb9x0RQZFNdxUtSKefxRvZ6dV09ZUucr7WxsoOSixcyglmfzw+suAbyJ/
a2jq90P8XT5Ygx79iiLY
=nD5J
-----END PGP SIGNATURE-----

--odufRLrvTptG8fBMx4wuH7sE4nt8MK9EX--

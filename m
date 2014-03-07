From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: Unify MTU settings for CAN interfaces
Date: Fri, 07 Mar 2014 12:40:35 +0100
Message-ID: <5319B033.10705@pengutronix.de>
References: <5319820D.6060104@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LRcI6gU5ne334f0w86JULCnAbWg1dF9pI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54669 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbaCGLkl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Mar 2014 06:40:41 -0500
In-Reply-To: <5319820D.6060104@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LRcI6gU5ne334f0w86JULCnAbWg1dF9pI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/07/2014 09:23 AM, Oliver Hartkopp wrote:
> CAN interfaces only support MTU values of 16 (CAN 2.0) and 72 (CAN FD).=

> Setting the MTU to other values is pointless but it does not really hur=
t.
> With the introduction of the CAN FD support in drivers/net/can a new
> function to switch the MTU for CAN FD has been introduced.
>=20
> This patch makes use of this can_change_mtu() function to check for cor=
rect
> MTU settings also in legacy CAN (2.0) devices.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index 3fcdae2..f5b16e0 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -411,10 +411,16 @@ static void slc_free_netdev(struct net_device *de=
v)
>  	slcan_devs[i] =3D NULL;
>  }
> =20
> +static int slcan_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	return -EINVAL;
> +}
> +

Why is the slcan special?

>  static const struct net_device_ops slc_netdev_ops =3D {
>  	.ndo_open               =3D slc_open,
>  	.ndo_stop               =3D slc_close,
>  	.ndo_start_xmit         =3D slc_xmit,
> +	.ndo_change_mtu         =3D slcan_change_mtu,
>  };
> =20
>  static void slc_setup(struct net_device *dev)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LRcI6gU5ne334f0w86JULCnAbWg1dF9pI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMZsDMACgkQjTAFq1RaXHOo2ACfaaxK4z/QKesbvyEyBz1VEuSB
lV0Ani+9qsSzwX8Twvv2B3eQ30cuRNqB
=8HhP
-----END PGP SIGNATURE-----

--LRcI6gU5ne334f0w86JULCnAbWg1dF9pI--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN driver for USB2CAN converter (8 devices)
Date: Mon, 19 Nov 2012 19:24:59 +0100
Message-ID: <50AA797B.7020004@pengutronix.de>
References: <afad22f184c5b1bc8e833f5dc02d3b84.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig085DC854475C76B0DB3EF5A6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53086 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab2KSSZF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Nov 2012 13:25:05 -0500
In-Reply-To: <afad22f184c5b1bc8e833f5dc02d3b84.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig085DC854475C76B0DB3EF5A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/17/2012 08:33 AM, "Bernd Krumb=F6ck" wrote:
> Hi!
>=20
> I'm developing a driver for the USB2CAN converter from "8 devices"
> (http://www.8devices.com/product/2/usb2can).

I asked the guys at 8devices some month ago for hardware and
documentation but they didn't want to give me access to it.

> At the moment the community seems to be very small, so I'm the only tes=
ter
> and I have only this USB2CAN converter. Hope this situation will change=
 in
> future.
>=20
> What must be done that this driver will become part of the kernel?
>=20
> Source: https://github.com/krumboeck/usb2can

Just post the driver here on the mailinglist. It doesn't look that bad,
but I'd like to give some comments before you invest more work on it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig085DC854475C76B0DB3EF5A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCqeX4ACgkQjTAFq1RaXHP9ZACfVnA6OhrWIl5XsCv29QsP6qGA
rUkAnjNQoQ56f2gn553qyu8i9STHEdmj
=4mGQ
-----END PGP SIGNATURE-----

--------------enig085DC854475C76B0DB3EF5A6--

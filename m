From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/5] net: can: flexcan: handle state passive -> warning
 transition
Date: Sat, 26 Jul 2014 00:21:03 +0200
Message-ID: <53D2D84F.2070903@pengutronix.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de> <1406312202-2542-3-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B2nuOOqoTJF06vOGvhAAwgdAHHUFGfMrQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33785 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaGYWVH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 18:21:07 -0400
In-Reply-To: <1406312202-2542-3-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B2nuOOqoTJF06vOGvhAAwgdAHHUFGfMrQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2014 08:16 PM, Matthias Klein wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Once the CAN-bus is open and a packet is sent, the controller switches
> into the PASSIVE state. Once the BUS is closed again it goes the back
> err-warning. The TX error counter goes 0 -> 0x80 -> 0x7f.
> This patch makes sure that the user learns about this state chang
> (CAN_STATE_ERROR_WARNING =3D> CAN_STATE_ERROR_PASSIVE)
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>

Looks good.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--B2nuOOqoTJF06vOGvhAAwgdAHHUFGfMrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPS2E8ACgkQjTAFq1RaXHPEfwCdE9IYl+iBBKrXs7AHK+GgY/CY
z9oAniG6Mt8yfbLUQVLaZsDbBG5RKieE
=tbQx
-----END PGP SIGNATURE-----

--B2nuOOqoTJF06vOGvhAAwgdAHHUFGfMrQ--

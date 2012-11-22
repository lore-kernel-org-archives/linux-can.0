From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v7] can: kvaser_usb: Add support for Kvaser CAN/USB devices
Date: Thu, 22 Nov 2012 12:05:35 +0100
Message-ID: <50AE06FF.1070403@pengutronix.de>
References: <1353582257-25870-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB8284E9CD2DDA1AFD3440339"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab2KVTUC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:20:02 -0500
In-Reply-To: <1353582257-25870-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>, Daniel Berglund <db@kvaser.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB8284E9CD2DDA1AFD3440339
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/22/2012 12:04 PM, Marc Kleine-Budde wrote:
> From: Olivier Sobrie <olivier@sobrie.be>
>=20
> This driver provides support for several Kvaser CAN/USB devices.
> Such kind of devices supports up to three CAN network interfaces.
>=20
> It has been tested with a Kvaser USB Leaf Light (one network interface)=

> connected to a pch_can interface.
> The firmware version of the Kvaser device was 2.5.205.
>=20
> List of Kvaser devices supported by the driver:
>   - Kvaser Leaf Light
>   - Kvaser Leaf Professional HS
>   - Kvaser Leaf SemiPro HS
>   - Kvaser Leaf Professional LS
>   - Kvaser Leaf Professional SWC
>   - Kvaser Leaf Professional LIN
>   - Kvaser Leaf SemiPro LS
>   - Kvaser Leaf SemiPro SWC
>   - Kvaser Memorator II HS/HS
>   - Kvaser USBcan Professional HS/HS
>   - Kvaser Leaf Light GI
>   - Kvaser Leaf Professional HS (OBD-II connector)
>   - Kvaser Memorator Professional HS/LS
>   - Kvaser Leaf Light "China"
>   - Kvaser BlackBird SemiPro
>   - Kvaser USBcan R
>=20
> Signed-off-by: Daniel Berglund <db@kvaser.com>
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes since v6:
> - added 'const' to kvaser_usb_table and kvaser_usb_bittiming_const

Olivier, I'm applying this patch to linux-can/next, if you don't have
any objections.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB8284E9CD2DDA1AFD3440339
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCuBv8ACgkQjTAFq1RaXHN2LACaA23HA4rwO4Tg4+M+QOkioF3k
01UAmQFawqCJ8iqZjXMEjFfYhzq4Tjvg
=squg
-----END PGP SIGNATURE-----

--------------enigB8284E9CD2DDA1AFD3440339--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Wed, 18 Jul 2012 11:50:22 +0200
Message-ID: <500686DE.1050908@pengutronix.de>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD392151212D1D7EF28DA8A60"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52371 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab2GRJug (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 05:50:36 -0400
In-Reply-To: <1341174085-11781-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD392151212D1D7EF28DA8A60
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 07/01/2012 10:21 PM, Marc Kleine-Budde wrote:
> From: Hui Wang <jason77.wang@gmail.com>
>=20
> At least in the i.MX series, the flexcan contrller divides into ver_3
> and ver_10, current driver is for ver_3 controller.

Has someone access to the freescale hardware people and can figure out
the controller versions used on:

imx28
imx25
imx35
imx53

Because I noticed that the FLEXCAN_CTRL_CLK_SRC bit (bit 13 of the
FLEXCAN control register) is marked as reserved in the mx53 datasheet
(although its meaning is documented) as well as in the imx6q. Is there a
Changelog of this core available?

> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
> Its reset value is 0xffffffff, this means ID Filter Table must be
> checked when receive a packet, but the driver is designed to accept
> everything during the chip start, we need to clear this register to
> follow this design.
>=20
> Use the data entry of the struct of_device_id to point chip specific
> info, we can set hardware version for each platform.

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD392151212D1D7EF28DA8A60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAGhuIACgkQjTAFq1RaXHM3BgCfZBMxulQr1mxtfEKNCxG2pi9L
cFYAnjQySeELVQ1V1FBG/AGKspKmq+Rg
=AvOr
-----END PGP SIGNATURE-----

--------------enigD392151212D1D7EF28DA8A60--

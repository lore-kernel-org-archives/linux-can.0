From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 13:56:49 +0200
Message-ID: <55EECD01.4020304@pengutronix.de>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
 <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk>
 <55EEC2BD.6010302@pengutronix.de> <55EECAAE.1020901@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uUClP6DPNPFgmBFEmiro2X5p8UsObAl4T"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbbIHL47 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:56:59 -0400
In-Reply-To: <55EECAAE.1020901@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUClP6DPNPFgmBFEmiro2X5p8UsObAl4T
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2015 01:46 PM, Wolfgang Grandegger wrote:

>> I mean what kind of CAN adapter...
>=20
> "https://github.com/fabiobaltieri/open-usb-can" seems to use a MCP2515 =

> controller.

ACK. But from the Linux driver side it's a USB device and Daniel is
using the driver from github.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uUClP6DPNPFgmBFEmiro2X5p8UsObAl4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7s0BAAoJEP5prqPJtc/HmXoIALvF2dGJ2cjVvFE76tPHfung
Ti9RO/7Qcc0QoCWFPveBEs2BGNuv8y8prm3u+jDlrzeiuXUxVBImyKmly22zuII5
I1AkA16F8gQL6LIvAD7fOdwrT60YKCVd1yQxQ4dScKyqtuHSkeymzU8ixOXiAVCt
ECye8vuQ7iN/xur3YaCpdwmp7paSXCymSN/L/9p5Kw9aLzUwpsguzU7iPcU2x0LH
l4RZqMjFLxMZ0IecS3DcWha4fOWTZhqmtjJRtvQxGJxkprFGoySnYeY+6IDxIGE2
sL+09BMMjwomti7VUk1yhd+/3JQYVcltfHUZz3w85sp5OYoPdMWa8zq5fwxuAM8=
=+E04
-----END PGP SIGNATURE-----

--uUClP6DPNPFgmBFEmiro2X5p8UsObAl4T--

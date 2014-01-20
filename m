From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: commit 40d4511 "can: Disable flexcan driver build for big endian
 CPU on ARM" breaks Flexcan on ARM
Date: Mon, 20 Jan 2014 12:37:02 +0100
Message-ID: <52DD0A5E.6010303@pengutronix.de>
References: <20140120123257.573205a9@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="O0aN9QxEAoP1c7uNv2ORSqAvbQKGQ6QI0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48519 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbaATLhQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Jan 2014 06:37:16 -0500
In-Reply-To: <20140120123257.573205a9@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O0aN9QxEAoP1c7uNv2ORSqAvbQKGQ6QI0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2014 12:32 PM, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> The commit 40d451181a7fa57e32bca4632ae7b22f80861a73
> |Author: Guenter Roeck <linux@roeck-us.net>
> |Date:   Mon Jan 6 05:21:03 2014 -0800
> |
> |    can: Disable flexcan driver build for big endian CPU on ARM
> |   =20
> |    Building arm:allmodconfig fails with
> |   =20
> |    flexcan.c: In function 'flexcan_read':
> |    flexcan.c:243:2: error: implicit declaration of function 'in_be32'=

> |    flexcan.c: In function 'flexcan_write':
> |    flexcan.c:248:2: error: implicit declaration of function 'out_be32=
'
> |   =20
> |    in_be32 and out_be32 do not (or no longer) exist for ARM targets.
> |    Disable the build for ARM on big endian CPUs.
> |   =20
> |    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> |    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> |
> |diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> |index 9e7d95d..d447b88 100644
> |--- a/drivers/net/can/Kconfig
> |+++ b/drivers/net/can/Kconfig
> |@@ -104,7 +104,7 @@ config CAN_JANZ_ICAN3
> |=20
> | config CAN_FLEXCAN
> |        tristate "Support for Freescale FLEXCAN based chips"
> |-       depends on ARM || PPC
> |+       depends on (ARM && CPU_LITTLE_ENDIAN) || PPC
> |        ---help---
> |          Say Y here if you want to support for Freescale FlexCAN.
>>
> completely disables the flexcan driver for all ARM platforms, since the=

> symbol CPU_LITTLE_ENDIAN does not exist on ARM!

Arnd Bergmann posted a better patch, which I'll include in a pull
request once the net tree is open again.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--O0aN9QxEAoP1c7uNv2ORSqAvbQKGQ6QI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLdCl4ACgkQjTAFq1RaXHNejQCfZFRjFAn4BJGZbNhxP9Yzu0Fm
xPIAn3mcnUhS+/y2l/nCEJd34tMboY1N
=9OlK
-----END PGP SIGNATURE-----

--O0aN9QxEAoP1c7uNv2ORSqAvbQKGQ6QI0--

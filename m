From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: peak: Fix bittiming ranges and add PCAN-USB X6
 support
Date: Thu, 1 Dec 2016 14:14:27 +0100
Message-ID: <81bc2c0a-f607-ab51-f4b6-80a5bc041ce3@pengutronix.de>
References: <1480588872-13555-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5uF7FRdmVJJRkqrkj93JkFdQi1ixAkG6v"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54081 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751423AbcLANOe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2016 08:14:34 -0500
In-Reply-To: <1480588872-13555-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5uF7FRdmVJJRkqrkj93JkFdQi1ixAkG6v
Content-Type: multipart/mixed; boundary="P42Ml4HL5Iv8Xghq2MGlJqXoCHNvAF6jb";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <81bc2c0a-f607-ab51-f4b6-80a5bc041ce3@pengutronix.de>
Subject: Re: [PATCH 0/2] can: peak: Fix bittiming ranges and add PCAN-USB X6
 support
References: <1480588872-13555-1-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1480588872-13555-1-git-send-email-s.grosjean@peak-system.com>

--P42Ml4HL5Iv8Xghq2MGlJqXoCHNvAF6jb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2016 11:41 AM, Stephane Grosjean wrote:
> These patches fix obsolete bittiming ranges definitions for all USB CAN=
-FD
> interfaces family and add support for the new PCAN-USB X6 USB CAN-FD
> interface.
>=20
> Stephane Grosjean (2):
>   can: peak: Fix bittiming fields size in bits
>   can: peak: Add support for PCAN-USB X6 USB interface
>=20
>  drivers/net/can/usb/peak_usb/pcan_ucan.h     |  37 +++++++---
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |   2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |   2 +
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 104 +++++++++++++++++++=
+++-----
>  4 files changed, 121 insertions(+), 24 deletions(-)

Added to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P42Ml4HL5Iv8Xghq2MGlJqXoCHNvAF6jb--

--5uF7FRdmVJJRkqrkj93JkFdQi1ixAkG6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhAIjMACgkQPTuqJayp
JWoXwAf/b3Qqgs5JNFwEfGCotxnH43KmzatI1wGAQiqm9w/QXl4NFLelOcBXtDfM
1pzo/m786BRAgokaAXKtw8OeDggWaSgy42CHs0hqkg+J5drLu9D9i8wlZ/OaRk8/
VM143BiazkP4mvJ8GGTD8avmtNZ0MBjSHXjr6jgrtgOd7RyLaO4jry12TnsInwx/
3wt6EDRxfctqjcfM5tFqJZhU140Lb3hVzRoBp8x6vW235wtWqyl7GSgwm1YGgPeY
tzIk2P9rjRVnPjzYN5TLtL2iuWs0LL7uudSI8oUpTzxXYI+X/cOMlI8W74UUyz7b
PGcb5RlvzSDt98tZnEuwChAU1APxQw==
=XTvN
-----END PGP SIGNATURE-----

--5uF7FRdmVJJRkqrkj93JkFdQi1ixAkG6v--

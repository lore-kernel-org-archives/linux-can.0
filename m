From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Thu, 04 Oct 2012 11:45:08 +0200
Message-ID: <506D5AA4.5080704@pengutronix.de>
References: <1349188730-11434-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig90217E64B8E293AB5BE306B8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab2JDJpZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 05:45:25 -0400
In-Reply-To: <1349188730-11434-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90217E64B8E293AB5BE306B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

On 10/02/2012 04:38 PM, Andreas Larsson wrote:
> This driver supports GRCAN and CRHCAN CAN controllers available in the =
GRLIB
> VHDL IP core library.
>=20
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  drivers/net/can/Kconfig  |    6 +
>  drivers/net/can/Makefile |    1 +
>  drivers/net/can/grcan.c  | 1283 ++++++++++++++++++++++++++++++++++++++=
++++++++
>  drivers/net/can/grcan.h  |  273 ++++++++++
>  4 files changed, 1563 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/grcan.c
>  create mode 100644 drivers/net/can/grcan.h

Some general remarks while scrolling though the driver:
- please provide a device tree binding documentation
  Documentation/devicetree/bindings/net/can/grcan.txt
  and add devicetree-discuss@lists.ozlabs.org on Cc
- please provide a documentation for the sysfs entries:
  Documentation/ABI/testing/sys-XXX-grcan.txt
- please implement a NAPI
- please include the .h file into the C code,
  as the C code is the one and only user of the .h file
- please give every macro a GRCAN_ prefix

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig90217E64B8E293AB5BE306B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBtWqsACgkQjTAFq1RaXHO+MQCgi9hUpiH9UmFmckly5Mmitbs+
ENMAniLhkrrzBxvkYeS+vfjJfxNjrbOz
=ChRD
-----END PGP SIGNATURE-----

--------------enig90217E64B8E293AB5BE306B8--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Thu, 11 Oct 2012 12:04:15 +0200
Message-ID: <5076999F.6070302@pengutronix.de>
References: <1349188730-11434-1-git-send-email-andreas@gaisler.com> <506D5AA4.5080704@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig447FD3DFB03C8982224C2B2F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35382 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249Ab2JKKE1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Oct 2012 06:04:27 -0400
In-Reply-To: <506D5AA4.5080704@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig447FD3DFB03C8982224C2B2F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2012 11:45 AM, Marc Kleine-Budde wrote:
> Hello,
>=20
> On 10/02/2012 04:38 PM, Andreas Larsson wrote:
>> This driver supports GRCAN and CRHCAN CAN controllers available in the=
 GRLIB
>> VHDL IP core library.
>>
>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>> ---
>>  drivers/net/can/Kconfig  |    6 +
>>  drivers/net/can/Makefile |    1 +
>>  drivers/net/can/grcan.c  | 1283 +++++++++++++++++++++++++++++++++++++=
+++++++++
>>  drivers/net/can/grcan.h  |  273 ++++++++++
>>  4 files changed, 1563 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/net/can/grcan.c
>>  create mode 100644 drivers/net/can/grcan.h
>=20
> Some general remarks while scrolling though the driver:
> - please provide a device tree binding documentation
>   Documentation/devicetree/bindings/net/can/grcan.txt
>   and add devicetree-discuss@lists.ozlabs.org on Cc
> - please provide a documentation for the sysfs entries:
>   Documentation/ABI/testing/sys-XXX-grcan.txt
> - please implement a NAPI
> - please include the .h file into the C code,
>   as the C code is the one and only user of the .h file
> - please give every macro a GRCAN_ prefix

Your driver should work on little as well as on big endian systems. You
need probably two implementations of the grcan_{read,write}_reg
functions, you can take the flexcan driver [1] as an example.

Marc

[1] http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c#L222

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig447FD3DFB03C8982224C2B2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB2mZ8ACgkQjTAFq1RaXHP5FQCeKjMceaIfwIBlenoqjxk9Ejo2
xjwAn1FzhXkKrx9D/ljWYCvM+qKo9y1E
=je9K
-----END PGP SIGNATURE-----

--------------enig447FD3DFB03C8982224C2B2F--

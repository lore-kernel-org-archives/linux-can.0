From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 13:50:53 +0200
Message-ID: <4FC6099D.3030906@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5E9F0896EA42F3F73F8B139E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48171 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2E3LvC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 07:51:02 -0400
In-Reply-To: <jq50tg$55u$1@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E9F0896EA42F3F73F8B139E
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On 05/30/2012 01:39 PM, Martin Kozusky wrote:
> Hello,
> I downloaded latest sources of can4linux from svn and I'm trying to
> compile it for 2.6.39 kernel (i.mx25 driver).
> I edit cross-imx25 with proper compiler settings etc then ".
> cross-imx25" and "make"
>=20
> There are some errors like
> core.c:441:12: error: 'CAN1_BASE_ADDR' undeclared
> core.c:452:11: error: 'MXC_INT_CAN1' undeclared
>=20
> I can change CAN1_BASE_ADDR to MX25_CAN1_BASE_ADDR and MXC_INT_CAN1 to
> MX25_INT_CAN1, but there is error
>=20
> imx35.c:18:26: fatal error: mach/mxc_can.h: No such file or directory

It comes from a Karo patch:

http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dopenembedded.git;a=3Dco=
mmitdiff_plain;h=3D58d6c0ace0c9fe2a3ed9fa845bec9a89583e2fd5

> Does anybody have idea where do I get this file? When I comment this
> line, compilation continues and stops at
>=20
> imx35.c:113:18: error: dereferencing pointer to incomplete type
>=20
> Does it have anything to do with Karo tx25 board? (which I'm not using)=

> I already have CAN running using SocketCAN, but I also wanted to try
> can4linux.

Why do you want to use can4linux? Socketcan is the official CAN Stack
for Linux. Be sure you use the latest kernel, because the flexcan driver
has some bugs and problems prior to v3.4.

Regards, Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5E9F0896EA42F3F73F8B139E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GCaAACgkQjTAFq1RaXHPnewCgiHVcWRlJOMhyiLccnEqfKXRa
QpgAnA4tBQLEpF4tQwCudU52/g0siW2t
=FXv0
-----END PGP SIGNATURE-----

--------------enig5E9F0896EA42F3F73F8B139E--

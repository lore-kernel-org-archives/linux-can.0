From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can4linux compilation for i.mx25 under 2.6.39
Date: Wed, 30 May 2012 14:18:15 +0200
Message-ID: <4FC61007.80802@pengutronix.de>
References: <jq50tg$55u$1@dough.gmane.org> <4FC6099D.3030906@pengutronix.de> <jq52en$i2e$1@dough.gmane.org> <jq52jo$i2e$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D74EB874E03FBA9F846A823"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38506 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab2E3MSR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 May 2012 08:18:17 -0400
In-Reply-To: <jq52jo$i2e$2@dough.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Kozusky <mkozusky@kkmicro.cz>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D74EB874E03FBA9F846A823
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On 05/30/2012 02:08 PM, Martin Kozusky wrote:
>>> Why do you want to use can4linux? Socketcan is the official CAN Stack=

>>> for Linux. Be sure you use the latest kernel, because the flexcan dri=
ver
>>> has some bugs and problems prior to v3.4.
>>>
>>> Regards, Marc
>>>
>=20
> And I can only use 2.6.39 kernel because there is no patch for my board=

> for kernel 3.x yet :(

Ask your supplier to a) backport the fixes to your kernel or b) to
deliver a 3.4 based BSP.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig5D74EB874E03FBA9F846A823
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/GEAcACgkQjTAFq1RaXHN2dQCfRBzpubraBiXte0n3GHTH6iUK
SW0An1opKxQigCueatA72nb1S0mWlMoY
=kUz2
-----END PGP SIGNATURE-----

--------------enig5D74EB874E03FBA9F846A823--

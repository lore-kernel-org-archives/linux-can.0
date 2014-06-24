From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] cansniffer: increase resolution for timeout values
Date: Tue, 24 Jun 2014 23:19:30 +0200
Message-ID: <53A9EB62.2080800@pengutronix.de>
References: <1403638263-4019-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1EOAVaFSeevixTuhQh0asPNQ712v55edM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37547 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaFXVTf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 17:19:35 -0400
In-Reply-To: <1403638263-4019-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1EOAVaFSeevixTuhQh0asPNQ712v55edM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/24/2014 09:31 PM, Oliver Hartkopp wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> As requested by Felix Seitz the timeout for screen updates should be
> configurable to values smaller than 100ms. Marc Kleine-Budde provided t=
he
> original patch to increase the resolution of the timing relevant variab=
les.
>=20
> The rotating animation was replaced by a rolling screen update counter.=

> Additionally the CAN-ID is now printed in the same ASCII hex representa=
tion
> as the CAN data.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Looks good, please re-add my S-o-b before yours.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1EOAVaFSeevixTuhQh0asPNQ712v55edM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOp62IACgkQjTAFq1RaXHPl3gCcCilbDp2jNT51w327uGj2kVhF
mQ0AnRsuQ9sXrguLK6Zb7bzP1J9EHOIx
=L8bE
-----END PGP SIGNATURE-----

--1EOAVaFSeevixTuhQh0asPNQ712v55edM--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] do not use --symlink for autoreconf
Date: Wed, 02 Jul 2014 14:18:22 +0200
Message-ID: <53B3F88E.2080202@pengutronix.de>
References: <1404303178-24608-1-git-send-email-nautsch2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vIjTEjlHPMbvcwaOOErOV1JxORMAk1LGr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50650 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaGBMXz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 08:23:55 -0400
In-Reply-To: <1404303178-24608-1-git-send-email-nautsch2@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andre Naujoks <nautsch2@gmail.com>, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vIjTEjlHPMbvcwaOOErOV1JxORMAk1LGr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/02/2014 02:12 PM, Andre Naujoks wrote:
> When packaging the can-utils, I understand, that the generation step fo=
r
> autoconf should be done beforehand. However using the --symlink option =
in the
> autoreconf step installs links instead of the actual files, which leads=
 to a
> build failure when trying to build on another host with different autot=
ools
> installed.
>=20
> Signed-off-by: Andre Naujoks <nautsch2@gmail.com>

How do you package the can-utils? The usual steps are:

=2E/autogen.sh
=2E/configure
make dist

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vIjTEjlHPMbvcwaOOErOV1JxORMAk1LGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOz+I4ACgkQjTAFq1RaXHMjEQCeMBZ+maE+qSwK1ZDMEDpwDybB
rAEAniPf8SCzxRY1soGmtGO8nG/z69Kb
=O2LU
-----END PGP SIGNATURE-----

--vIjTEjlHPMbvcwaOOErOV1JxORMAk1LGr--

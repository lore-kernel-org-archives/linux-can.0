From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 18/19] net/can/gw.c:370:13: sparse: restricted
 __wsum degrades to integer
Date: Wed, 23 Jan 2013 10:18:54 +0100
Message-ID: <50FFAAFE.7030405@pengutronix.de>
References: <50ff3c61.yH1i+RBrM59x8gEs%fengguang.wu@intel.com> <50FFA819.8060708@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2EASNCJETIEVUEJXBGVAM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33241 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab3AWJS7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Jan 2013 04:18:59 -0500
In-Reply-To: <50FFA819.8060708@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2EASNCJETIEVUEJXBGVAM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/23/2013 10:06 AM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> it was hard to make sparse to give this warning on my machine ...
>=20
> For the records:
>=20
> 	make C=3D1 CF=3D"-D__CHECK_ENDIAN__"
>=20
> made it :-)
>=20
>=20
> I pushed a new commit to the cangw branch of ollis-can-next:
>=20
> https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commits/cangw
>=20
> The commit is=20
>=20
> https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commit/4068160=
ad6f42436a40edf4b04ec47e86399b544

I've squashed the commit into "can: gw: add a variable limit for CAN
frame routings" and pushed the resulting tree to linux-can-next/for-davem=


tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2EASNCJETIEVUEJXBGVAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/qwEACgkQjTAFq1RaXHOOTACfeJ69xAAvOgB2Qv+iGdjOmaVX
dYQAoJIT4MFQZ74le1h955Y/HAkTNc4J
=keCP
-----END PGP SIGNATURE-----

------enig2EASNCJETIEVUEJXBGVAM--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_pci: fix use after free in netdev teardown
Date: Mon, 19 May 2014 11:20:31 +0200
Message-ID: <5379CCDF.90809@pengutronix.de>
References: <1397072720.22713.19.camel@acrs-z800-1> <5379AE8C.9050406@pengutronix.de> <5379CB87.20106@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jg9S86gCblNx9qa47Sh2fmmjiANJa1fuJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38443 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbaESJVK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 05:21:10 -0400
In-Reply-To: <5379CB87.20106@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jg9S86gCblNx9qa47Sh2fmmjiANJa1fuJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2014 11:14 AM, Stephane Grosjean wrote:
> Hi All,
>=20
> So I finally had a look to the diff file. It clearly does what
> Christopher says, that is, it fixes some memory access order issues whe=
n
> the CAN devices have to be removed from the system, either when probing=

> has failed or when the driver is unloaded from the system.
>=20
> The diff file has to be re-written into a Linux-coding style patch, and=

> yes, maybe all this removing stuff could be put into a (new) single
> function made for that.
>=20
> So, how do we proceed, please ?

Make it so.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jg9S86gCblNx9qa47Sh2fmmjiANJa1fuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5zN8ACgkQjTAFq1RaXHP5GQCglSkciNJWrj4XqDHAytpPEQ+i
5F8Ani8JcRu3+WPoKDLnapYSdO4jTA1I
=SWQC
-----END PGP SIGNATURE-----

--jg9S86gCblNx9qa47Sh2fmmjiANJa1fuJ--

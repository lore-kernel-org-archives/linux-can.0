From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] Add CAN FD driver infrastructure
Date: Wed, 12 Feb 2014 12:15:09 +0100
Message-ID: <52FB57BD.90704@pengutronix.de>
References: <52F291D8.90008@hartkopp.net> <52F374DC.3000105@pengutronix.de> <52F3DC33.6080402@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5J5VuUC9ek2j6paOKOAl5vtO7T5hU3k4x"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42316 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbaBLLPM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 12 Feb 2014 06:15:12 -0500
In-Reply-To: <52F3DC33.6080402@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5J5VuUC9ek2j6paOKOAl5vtO7T5hU3k4x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/06/2014 08:02 PM, Oliver Hartkopp wrote:
> My patch is currently based on Davems net-tree, as this patch
>=20
> http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=3D=
0ae89beb283a0db5980d1d4781c7d7be2f2810d6
>=20
> is currently not in mainline nor in net-next nor in linux-can-next.
>=20
> As the above patch clashes with the changes I did, I'll wait for Daves
> net-next tree to be opened for development again before sending the pat=
ch set.

net-next is open and I've send a pull request to merge can-next/testing
branch. Do you have a series with split patches I can have a look at?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5J5VuUC9ek2j6paOKOAl5vtO7T5hU3k4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL7V70ACgkQjTAFq1RaXHMucwCggDtXJOEgF2+NlBl2vU4i49kx
2eMAoJlJgurBGVAMUfpoe1/qi9aA4oxY
=c6Rj
-----END PGP SIGNATURE-----

--5J5VuUC9ek2j6paOKOAl5vtO7T5hU3k4x--

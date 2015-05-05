From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can.h: make padding given by gcc explicit
Date: Tue, 5 May 2015 21:25:25 +0200
Message-ID: <55491925.1060803@pengutronix.de>
References: <554797BA.6080506@hartkopp.net>
 <1430842036-21509-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="foAa3hfMhkbvCIWSvslEuvIlE3aXrohwr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbbEETZe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 May 2015 15:25:34 -0400
in-reply-to: <1430842036-21509-1-git-send-email-shawn@churchofgit.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--foAa3hfMhkbvCIWSvslEuvIlE3aXrohwr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2015 06:07 PM, Shawn Landden wrote:
> The current definition of struct can_frame has a 16-byte size, with 8-b=
yte
> alignment, but the 3 bytes of padding are not explicit like the similar=
 2 bytes
> of padding of struct canfd_frame. Make it explicit so it is easier to r=
ead.
>=20
> v2: match analogous padding fields in canfd_frame
>     update Documentation

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--foAa3hfMhkbvCIWSvslEuvIlE3aXrohwr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVSRklAAoJECte4hHFiupUrLQP/3GGNsf0b5zf2lgCv0/ZXJU3
ojQDJcBqVROL2jBWF03mrsBMSNTY1iJM/VWrEYaD2TcIn8AJfb+DyyIFbLcNEYB8
5LrlCbl0Ub7JwctZWD4eqwMIlmtO04Ws5/H0Fe7F5yPS220ms3kP3x7SdUtylq4H
/U8bh4O8doiHoMwALf7yl7o4zF1fvjzoKI7P6IAvjpt9VBsIm5tNrSv51Y/YbNrk
kmZM/cDl3idyOmkaLq2D+m2YiwD2lXM2JJS3pkKOrGRVXgWMcfCD+NTsVMLoT5cO
zrev/KppCsRhoUF/PSHb+V8DEpIykq1rSL3EsAC5BBpl7Gn5zorwhTgNIYvnFi8o
c1sMjwlWUkb5Z6p+9lcz9nRv6lucCVC6akqnqZ6sQhyL5bJwzzoWDKxLnSC3ch/u
ozeiWlitjF296GmviDP8Ecd1ozOzciOx3gLNLCyRzcBqZvR5VePnzU+iNq+ICX4F
4nAs4niq7DPgBem+tO8XQlyGTZDbxv8ReXwQivc8JMrtEQV+Sz5pBmfDlyFnqruz
ewHxGNwwOOLtVw990+MMkBK7iT+2dL5NmP5bM1xGeP0qWYMDGrcqtmQkCk4JuTo+
FN4bCAi4mTuo+qS3KmbgsjhMeh9YKPv5MloqbgnOVpEaEA8Y1kzySDc6Vb9TxPSg
KV6fn/kth/3baJClargl
=QbwA
-----END PGP SIGNATURE-----

--foAa3hfMhkbvCIWSvslEuvIlE3aXrohwr--

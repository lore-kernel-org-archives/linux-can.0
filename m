From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can.h: make padding given by gcc explicit
Date: Fri, 1 May 2015 22:23:23 +0200
Message-ID: <5543E0BB.3010902@pengutronix.de>
References: <1430510060-3504-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oLCV79LOtD3GTJqCsrNUNkAI7rRj6KV8X"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54261 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbEAUX3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 May 2015 16:23:29 -0400
in-reply-to: <1430510060-3504-1-git-send-email-shawn@churchofgit.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oLCV79LOtD3GTJqCsrNUNkAI7rRj6KV8X
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/01/2015 09:54 PM, Shawn Landden wrote:
> The current definition of struct can_frame has a 16-byte size, with 8-b=
yte
> alignment, but the 3 bytes of padding are not explicit like the similar=
 2 bytes
> of padding of struct canfd_frame. Make it explicit so it is easier to r=
ead.
>=20
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>

As this is a userspace API header, I'd rather not change it for
readability reasons..... Oliver's on holidays currently, let's wait for
his oppinion.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oLCV79LOtD3GTJqCsrNUNkAI7rRj6KV8X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQ+C7AAoJECte4hHFiupUzE8QAKOBcNqLliGV6iUxIbiygoZD
qDv6bnbabm554PAv+oahf/fROJpQA7HhSEOhU56sDhmDiNt+UXI7Q4t7MM97h5Di
hI9rZj5CBvGYC7qGY/SUkSRftImIk2k2qILiaNXgyQ8seWH8dKFs8A7WF7oGr3hU
iAp5vV2QXj+tacs544tvCV7U14wa4TDX/jyM+mlxYx8lskW8SHmRVSjBi5AZUr0+
X9rwxldYtQyghR4gG3ju29QJFTqIPgpCBihBbR2soWy1fyxCi/pFVpPVrWkZjpN0
Vh5fbUfRnr/FOYFOw0Ja7uK//vNh7I7BrjmLwbmGOK4uHRSTq57cZH9FvKfZkCRG
B5iJYEGxT46YaukF8VNQatveGNKMlkwRLj1aqLt3HFzqiuUQiX/1x1u0b9nQBThG
9PzeyBLSA75j/f3listX3N6UIHUEoedwpnSmZzsbQtKF+n1Iz51OjZ/Ok/1HnsKa
2RvEKt5IoQY1l+Sgi+DLVkkXbNed1sCmqMt6usYwRmPguns+SOE0DnMmeOQRFyQJ
NZnF0rr3BlEA0sSH+jnQb4Wmkb46bibIRl9bcdKCnTq0cRUNqTcKcamI2ugBO53P
Ega0JD0TCpnrlgl4ClGYe6BYbuSzTRMMvXVuQHayK8pDVVvc/dN4OgUHTnH8kyVP
sagGmuGCISO5xYPCRKI1
=8xL6
-----END PGP SIGNATURE-----

--oLCV79LOtD3GTJqCsrNUNkAI7rRj6KV8X--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-utils] Don't overwrite PREFIX and DESTDIR when provided
 via the environment
Date: Sat, 17 Aug 2013 21:32:45 +0200
Message-ID: <520FCFDD.7010308@pengutronix.de>
References: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bEeeTJdsvngX3vlJwSe4BfceNIVUICtfv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42127 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab3HQTcx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Aug 2013 15:32:53 -0400
In-Reply-To: <1376767690-8472-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bEeeTJdsvngX3vlJwSe4BfceNIVUICtfv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2013 09:28 PM, Uwe Kleine-K=C3=B6nig wrote:
> For creating a Debian package providing PREFIX and DESTDIR via the
> environment is the easiest option. So use ?=3D to assign these two
> variables to honor the values in the environment.

I suggest to use autotools.

=2E/configure && make && make install

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bEeeTJdsvngX3vlJwSe4BfceNIVUICtfv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIPz90ACgkQjTAFq1RaXHNVUgCfeyr5+AjbhYvWI5MfqCHmgrCz
/EYAn0rExKhaQqpFzfSg8zKWdwu75Y47
=f298
-----END PGP SIGNATURE-----

--bEeeTJdsvngX3vlJwSe4BfceNIVUICtfv--

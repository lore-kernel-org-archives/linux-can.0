From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull request CAN FD support
Date: Tue, 19 Jun 2012 22:03:48 +0200
Message-ID: <4FE0DB24.6020300@pengutronix.de>
References: <4FE0D0B1.2040103@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98E1DB6E9A6D1048A923BD84"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37986 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab2FSUDu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Jun 2012 16:03:50 -0400
In-Reply-To: <4FE0D0B1.2040103@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98E1DB6E9A6D1048A923BD84
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/19/2012 09:19 PM, Oliver Hartkopp wrote:
> as there were no new remarks (and it has been hanging around on the ML =
for
> quite a long time) i only posted the data structures patch after some
> cosmetics suggested by Wolfgang.

Thanks a lot, hopefully we can get our hands on some "real" hardware soon=
 :)

The series is bisecable and compiles without warnings. Send pull request
to David.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig98E1DB6E9A6D1048A923BD84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/g2yQACgkQjTAFq1RaXHNLyQCcDfh0YYPYLY6ZgCHgtDsuOce4
Vp0AniUaxU7kbhx7BS04v8eu4PH3BF1O
=08bH
-----END PGP SIGNATURE-----

--------------enig98E1DB6E9A6D1048A923BD84--

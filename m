From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can-utils: cleanup headers
Date: Tue, 20 Mar 2012 11:10:10 +0100
Message-ID: <4F685782.8060103@pengutronix.de>
References: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6A69760FF99D9D9AE100E878"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59383 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904Ab2CTKKN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Mar 2012 06:10:13 -0400
In-Reply-To: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A69760FF99D9D9AE100E878
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/20/2012 10:47 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> - add missing sys/socket.h: on some systems (like Android)
> have SOCK_RAW definition directly in sys/socket.h
>=20
> - use sys/wait.h instead if wait.h
>=20
> - include termios.h explicitly (Android)
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

It sill compiles under plain Linux. Thanks, applied to master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6A69760FF99D9D9AE100E878
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9oV4IACgkQjTAFq1RaXHNXJwCfdunBri0UndWtCpvSN0z3fefz
/vkAn3vIxGPxZEvjIVoNDJ5npNjf5d+7
=wk0b
-----END PGP SIGNATURE-----

--------------enig6A69760FF99D9D9AE100E878--

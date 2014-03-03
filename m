From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: remove CAN FD compatibility for CAN 2.0 sockets
Date: Mon, 03 Mar 2014 17:29:09 +0100
Message-ID: <5314ADD5.9040501@pengutronix.de>
References: <5311EF59.6060200@hartkopp.net> <531489E5.203@pengutronix.de> <5314AD74.9090805@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EtCIV3BF2IN5U2xEUFl8wmHe57UgDmxji"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55554 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbaCCQ3Q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 11:29:16 -0500
In-Reply-To: <5314AD74.9090805@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EtCIV3BF2IN5U2xEUFl8wmHe57UgDmxji
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2014 05:27 PM, Oliver Hartkopp wrote:
> On 03.03.2014 14:55, Marc Kleine-Budde wrote:
>=20
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>=20
>>
>> Thx, applied to can and included in my latest pull request.
>=20
> Do you plan to send a can-next pull request with the CAN FD driver exte=
nsions
> (v9) the next days too?

Yes, but that's for net-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EtCIV3BF2IN5U2xEUFl8wmHe57UgDmxji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMUrdUACgkQjTAFq1RaXHNBZQCfRNO/eX1mDZ9Z2n6xJWiCIWGz
jQEAn21DgZIvKcvcJH+i4gtr+LxY3NNK
=Csag
-----END PGP SIGNATURE-----

--EtCIV3BF2IN5U2xEUFl8wmHe57UgDmxji--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 04 Nov 2014 14:26:27 +0100
Message-ID: <5458D403.9040803@pengutronix.de>
References: <1415080039-38327-1-git-send-email-thomas.koerper@esd.eu> <5458D372.3020604@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AtxjhOgSGlKlJHBvbdRtmHhjGnjhBamOC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41517 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaKDN0g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Nov 2014 08:26:36 -0500
In-Reply-To: <5458D372.3020604@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?B?VGhvbWFzIEvDtnJwZQ==?= =?UTF-8?B?cg==?= <thomas.koerper@esd.eu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AtxjhOgSGlKlJHBvbdRtmHhjGnjhBamOC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/04/2014 02:24 PM, Oliver Hartkopp wrote:
> Hello Thomas,
>=20
> looks far better to me now. Thanks.
>=20
> @Marc: The only two questions I would have is this pretty short commit
> message and the module parameter.
> What do you think about it (and the rest)?

Yes, the commit message should be a bit more verbose. And the module
parameter should probably be removed.

I'm currently reviewing Stefano Babic's SPI driver, which has been
waiting for review a bit longer.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AtxjhOgSGlKlJHBvbdRtmHhjGnjhBamOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUWNQDAAoJECte4hHFiupU5D4QAIH5yCp06Hly4zWnPIyp6YAx
pjJMozUbPHQQpbQyLh43YOvsfF1FWxlSOcHrER6ngq0roT0GCEd25fST4URc1Arf
ToYEPxTOcppVVTRypmxpupOHfvjxlFfSGWRZomKZETeIRPcp+7u+NHuCLlLro5MG
k/UFBXCqMZNIsDoXusxgD+bzU2s0eu5OCaMvotIq0P51nY7GPjhTjmD6uKwZyfxi
hBVEeG/3zKhEB7UEotDdkkypIo1dioYi9tb6ieGwTxWYUKmcafZs6cQb3wlr7PuR
emeK5wz4Vvq0iEbGRMnYsoXfDGq9mJEUnct9SGpnk6WqPn3WkwXnzkBRPLO7hN8L
42J9ul19geNdZyAOsDF0cKLc/sq3k5bxWBepLpsPmfN5ljW7zF/Wn0Ekf1/sbjy+
Ady+RcbrxalMgwrZ6+Fo4I2WZnmxnEZfSqpuz8Jzu1wwuMpLfywc/wtVhVvHt6Cd
NvLrFerF8iEHZOZt0c97+NlmbnveCI07u0WDrviSmP4aoBIW37/5j5FTLB2bTP+k
cvgBoP/sQY+RhNPGsJwCveJZkKJt16R+Lyx2d54j8vRzJDcp+3/7tzvYZgXxf/cR
PpDx1GBYLkGjZy7tDwAp6tzWEh01OagU628HXyuImtY6iV0RdpOB8J2hiWQs2q1E
/6VXEfxVRVI1VAMIvRLP
=9MKo
-----END PGP SIGNATURE-----

--AtxjhOgSGlKlJHBvbdRtmHhjGnjhBamOC--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3.19-rc3] c_can: SIE disabled when berr-reporting is off
 to reduce irq flood
Date: Sun, 18 Jan 2015 19:34:23 +0100
Message-ID: <54BBFCAF.2090603@pengutronix.de>
References: <9c72f211-becc-4c0f-94f6-0700dfb1195e@GRBSR0089.marel.net> <alpine.DEB.2.02.1501121751530.28201@login> <1735533.0yOonAfCy1@heinz> <alpine.DEB.2.02.1501121948370.28201@login> <54B472B2.4010300@optusnet.com.au> <alpine.DEB.2.02.1501131523290.12789@login> <20150113153243.26859.47218@shannon> <alpine.DEB.2.02.1501181809150.32136@login>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UroGubUH4bT5a0mBG7pOLJfx1na2I3Dtb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40504 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbbARSe5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Jan 2015 13:34:57 -0500
In-Reply-To: <alpine.DEB.2.02.1501181809150.32136@login>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Viktor Babrian <babrian.viktor@renyi.mta.hu>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UroGubUH4bT5a0mBG7pOLJfx1na2I3Dtb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2015 07:30 PM, Viktor Babrian wrote:
>=20
> Status interrupt is to be disabled if bus error reporting is off in ord=
er=20
> to reduce interrupt flood when e.g. a frame is not acked. Side effect i=
s=20
> that when berr-reporting off, warn->pass and pass-warn state transition=
s=20
> may be reported later (upon a successful rx/tx event) or even go=20
> undetected. With proper implementation, these transitions could always =
be=20
> detected (but still later). It is considered better to have a non-accur=
ate=20
> report of these transitions than having a non-responding system in=20
> possible scenarios.
>=20
> Signed-off-by: Viktor Babrian <babrian.viktor@renyi.mta.hu>

NACK. The transitions are important for some applications. I've an not
yet mainlined series that limits the bus errors. I'm going to port them
to the current kernel tomorrow. Can you test it?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UroGubUH4bT5a0mBG7pOLJfx1na2I3Dtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUu/y1AAoJECte4hHFiupU8tYQAKu6PIa5AnZqIh8J5zBUijYv
Q41f1sBUsxIK2umqlnL9p02jmvyJ5azpYhf/bvg9qo5CXwdR2k6IAtxWmIeyu0SP
2dWQ84pLqhR3IKCOtqOL1DSLc8i/ugdyBmuJBJzgwX1C/qHKjNIdBcEGcRgRWslJ
ECL9EUZGV5phwY7rituFaj0uorJ78fsg+x/inq1OmK/5ObfpI0blHFGYlxE48313
DHus8bMnr3n1IiDNYvVi3WDzAQrWaoKYsCkqGxyFKCwa5XeHSdpHFPSP3LtL06v8
revHzKkMBVESEWznuVuJnfrc06dBLk0s2Sdiwb+E3j5x+Sg9HMmP7vc1iP6gwuMD
Ya8vPEaO31/oWNBVzGXUFMl9KDRKbmVZVUsOIJzSr/mJoacO0Ea+g4W/XAXgKLFR
fFAsGEthjnW7vQhuyIREasPQXhIi52L5B9NKYeGpAd2aMqU6inaeAezrp5wkUjcR
VDnbfrUD5oG7LpE9toeadN+BS8NfMpSnUfYtc8u3zq8fZsBtmp/vsOALFf66F30T
oqPhNPtS4wHb0mKM8tksiXWJ+iI0zTrSnf9fp3pyJxg39S+ZxbXiuSc4cehoz4fM
lzqnhfbhFNfDvq3ei7IinayeVNgfocCz7jCHGXumHrsWDbA3ajRnsLMCw2SrX0x+
C99YoP1zraUV3JWaZX1t
=s3OU
-----END PGP SIGNATURE-----

--UroGubUH4bT5a0mBG7pOLJfx1na2I3Dtb--

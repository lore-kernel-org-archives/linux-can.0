From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Request-for-testing: j1939
Date: Wed, 23 Aug 2017 17:17:54 +0200
Message-ID: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jFb1H5fO55BsGCIwCmWgC2TBEIdMorngA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48897 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754090AbdHWPSI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Aug 2017 11:18:08 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jFb1H5fO55BsGCIwCmWgC2TBEIdMorngA
Content-Type: multipart/mixed; boundary="P67biATWFAUL89VHHb7uMv2HKxTl3kA1R";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 David Jander <david@protonic.nl>
Message-ID: <9071ec9a-2b26-ed36-3b11-5f97f4b252d9@pengutronix.de>
Subject: Request-for-testing: j1939

--P67biATWFAUL89VHHb7uMv2HKxTl3kA1R
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

I've worked my way a bit through the lower layers of the j1939 stack.
While there I cleaned up the livetime handling of the j1939 object and
the bind() and connect() functions. Unplugging a USB network device
while a application is running should now be possible.

The patch stack consists of ~100 patches, ~15 of them are cleanups for
the af_can. I'm not going to post the patches here for review, testing
is much more welcome. Maybe we can put together a testsuite.

The branch is available at my kernel.org linux-can-next repo in the
j1939 branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dj1939

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P67biATWFAUL89VHHb7uMv2HKxTl3kA1R--

--jFb1H5fO55BsGCIwCmWgC2TBEIdMorngA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmdnKUACgkQHv7KIOw4
HPZAGgf9GhDTAwHm6zphhCwwt2kRlwMiZ3CsunFqMDvkfzef/EpXS/GwnU1KoffN
+4sSRH2p4ZUq9gu/FD71KmCPWAjRrimryXj9a6RScRbwFa0qUQbGLyuggd8EVlk+
l2FABFBNbjmdhO9gY9moAiSqCTGgNKITbV/zF2kuhRNVhW2Mb2y/2sgN4D6wT8mf
CW5ihaNYbmqRp/8b0fN2KR7GZLNLYYtm6Esb5mzsiS6OjaqWVAsgzhKfryj/Z8CA
T3PbkEeaVydPgY0OPkGT+GjN8ia9kk6koAUe57HNRVozxlWnyUVbpacLAO+knIuo
NWS8Fxzk+uaZ5eNdJ0z5HhVveWpFAA==
=kAn9
-----END PGP SIGNATURE-----

--jFb1H5fO55BsGCIwCmWgC2TBEIdMorngA--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5] can: kvaser_usb: Avoid double free on URB
 submission failures
Date: Wed, 04 Mar 2015 10:15:45 +0100
Message-ID: <54F6CD41.8050703@pengutronix.de>
References: <20150226152011.GA6075@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0JnsRrmCoa0E1x7bXgoIknreGNmTWWArB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36692 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704AbbCDJP6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Mar 2015 04:15:58 -0500
In-Reply-To: <20150226152011.GA6075@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0JnsRrmCoa0E1x7bXgoIknreGNmTWWArB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2015 04:20 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> Upon a URB submission failure, the driver calls usb_free_urb()
> but then manually frees the URB buffer by itself.  Meanwhile
> usb_free_urb() has alredy freed out that transfer buffer since
> we're the only code path holding a reference to this URB.
>=20
> Remove two of such invalid manual free().
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Applied 1+2 and added stable on Cc. Can you please shuffle the remaining
patches, so that patch 5 comes first, then 4 and 3 as the last patch. As
5 is a bugfix it should go into stable, while 3 isn't.

You can base your series on the can/testing branch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0JnsRrmCoa0E1x7bXgoIknreGNmTWWArB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9s1EAAoJECte4hHFiupUk5cQAIJ2cBy/aeCFLNjSaPFgjlMG
TRhc1OETgSKKjfJMxJeY5WX+hplC8td6kuPXS+hdm8hPRmIR93LYMy43wXzFMTDp
+E6salF8KJOWmfBMOFH6ohr9E18BybICVRqtq5YuWVJqlJySha17GZIWI7x2af1o
f/prrOPScE2e7t4oAxEkUWfiZi2T0X/FAHwi9yikJIDy+u9bbUc1Wly5pFnieUVL
pnikhVwGpvsVTUzxU9ivUiZKVBRac0KKTQv0bW+gmEppVl+Y26jJJX9Vi/NeFupp
rWyIamhhAjgXcPSx0LEwPe2p+rDhPdc5G78ukGg+0Ugn/ddxBrIeeoLPDQcR5a/S
HUv2y9QIKJ7VYdh4NDza7FE9FGPD9HbJGARiGY4aNe9qVxs4kYW8xd6VnsqMZD9i
srTz1DWqVeVUm1i/tt6O2rPcoAaYE8Jk4L3EFic7bHGTWAGScMJjSkZ3AiCHGTJI
FAVDc+EWSFqxMupMPxaLyeKHYq3lWn5EQVnpyYeOdWS7L7okDyZBOmtqNKMtJvzR
dJGMbSi2VEN0beeAk3KWf0LdGAcPE0Ht+bRGv5CezHNRq3wUc4TXHIT/+8SLl/pe
fncxW5ThauSgWFWuj8kInqcXIome1A47XItCk461PSebUPOdoblD0syIMKzWbtxS
okgSV/uJ1cwU3TZXU/r8
=Hk7l
-----END PGP SIGNATURE-----

--0JnsRrmCoa0E1x7bXgoIknreGNmTWWArB--

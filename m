From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH -stable 0/3] Bugfixes for the kvaser_usb module
Date: Thu, 26 Mar 2015 08:46:00 +0100
Message-ID: <5513B938.9010701@pengutronix.de>
References: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9gDS8biu1HfDApcLbxlx2iX0qK5nmveg5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53295 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbbCZHqP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2015 03:46:15 -0400
In-Reply-To: <1426903404-22925-1-git-send-email-ahmed.darwish@valeo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9gDS8biu1HfDApcLbxlx2iX0qK5nmveg5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2015 03:03 AM, Ahmed S. Darwish wrote:
> This is a series of kvaser_usb bugfixes, backported for -stable
> and generated against v3.19. It should apply cleanly on most
> of the -stable kernel trees out there.
>=20
> The patches needed simple backporting since `kvaser_usb' in all
> earlier kernels does not have the can_change_state() changes or
> the extra code for USBCan-II hardware models.
>=20
> Each patch contains a reference in its log to the corresponding
> upstream commit.
>=20
> I've verified that each patch matches exactly, _hunk for hunk_,
> its corresponding upstream commit. Nonetheless, I don't have a
> pure Kvaser Leaf hardware at hand; someone with a Leaf-based
> model should give them a quick smoke test (Olivier Sobrie?)

After Greg has taken many patches into stable in the last days, I think
it's time to send this series to -stable and ask to apply them.

There is one hunk in patch 1 that you might remove, see my reply for
more details.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9gDS8biu1HfDApcLbxlx2iX0qK5nmveg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVE7lCAAoJECte4hHFiupUJpwP/3lDXphW0SV9WLsbj1GdVpZN
NvZJjGgbHLl+OAcbQV7S/AkdakpONZmRZOleP+fFtL7hohlk0jpZa3ioKRmpPxaG
bigjWFXy9qwzDlgCHMGYQoP+DdUncqEhKy3gEUEW5JJJyRULM22Ja5kYvBSKihRy
SfJzz/Dzy5U6LAgYtOu485a/dsIOdr7ibvRHUwBeVquIaCd2D9/bg3SFoJmH7R8O
xH2SZCyk6fZblOz3Jqao8+rbFxayNJcf+jIWeb371N0w2d8rMpLV+KcDbFxp54+B
g/JRDUBpol2CKpmdfA3gRZq1rqi9aUii7JlDfZF/UgEXZ/gCbsyvSe0bmEYoOicu
GZCt9QrgPyz4VFagoamnUJnRgAgP0cyR/2OZ3KdaT7fHFHwjStteqXkp7nCRdwu+
YvWLbTCQCndXpmtMgZc0Xhl3C25bCr6+01pMJh3hcw2ywFRqCnokpXXuvDCrOAlM
oNRoVsqhbCGzyrokv/9SskIRDPrJ9qU1/3Ksc4dAg+QFSNRVNMEYhweVNCBwmklF
YUBsRayDFaHXM/eFmvLmtgRQ2FKx0gO8fDKJvnbDXlz2+j+NAsoV/63JOHkbhVX3
oe/GV8/DnVEJWwIq1aaU4CYP2LCptikxzqdzT69im1NhcnteGo7L+rCuDiTjJm4f
9HJ/xdRMwPe424y1sTOy
=E0xC
-----END PGP SIGNATURE-----

--9gDS8biu1HfDApcLbxlx2iX0qK5nmveg5--

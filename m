From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/4] can: dev: Consolidate and unify state change handling.
Date: Sat, 22 Nov 2014 18:10:37 +0100
Message-ID: <5470C38D.9070209@pengutronix.de>
References: <5425AF94.5000206@marel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c8JDVxLPNISE0T4DrcmbEXbdHvilqAsIC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47900 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaKVRKt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Nov 2014 12:10:49 -0500
In-Reply-To: <5425AF94.5000206@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c8JDVxLPNISE0T4DrcmbEXbdHvilqAsIC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2014 08:25 PM, Andri Yngvason wrote:
> The handling of can error states is different between platforms.
> This is an attempt to correct that problem.
>=20
> I've moved this handling into a generic function for changing the
> error state. This ensures that error state changes are handled
> the same way everywhere (where this function is used).
>=20
> What's changed from the last version of this patch-set is that
> can_change_state() now relies on the individual states of the rx/tx
> counters rather than their individual count values.
>=20
> Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>

What's the status on this series?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--c8JDVxLPNISE0T4DrcmbEXbdHvilqAsIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcMONAAoJECte4hHFiupUnfIQAIjQCGry4sbMRflyKI8G/Niy
yr1Et5zQhg/fISO1W0fbpLMjOMF9Ibdi9xxNSR6URWYYpqovzkIpqJydvP6LOvC/
WojKTZ+UncRdziE9ZbXxp24SU8hfn6+KxVyOm6xXyQKRZHoqPIYREtLrdf9O+kx7
hqQYlKUA1C9jEid3u0SeNC7rIHmVRGlb3eOXQotzUCx5QReHlCzEJupjCXDszpIp
n4I7YXk06eH0MMKv7eD2XCPbDVblFhAAn4O8O1TUTOEICDvFNwgnRm/5Zgqq9gB3
Xjcnkb6fwp8N2CsPg6Ihihkh59Xh15cirvUN+QO/UDLJUtmyEJl8Z555OT4pJNMV
Gqvkk+6U3CXixfFhy9qoym34YXp9YEj404aI07wZKRBstV+k21ckybB/ENu13CC8
PCIcV7VN6U+s3iKPIsFIBM1rF9nED8lotJSWmtQPeIeKtXpGkutyS4Yi5zSkYGzr
w3UeirH3UAyGaBpi91zc7w3m7rHsQCK9sw8b7YEXbrd8t3pm6YRtwyp+TqmNCiSz
rCqSvDeuz+iXq1MNCvEOmOhHH/tqfSA2NJJrFtfAJKbZ2uZGMKNNCC2AbY1MyAQt
BGn9dJBmfoJFW59+pplwKpxk63KOYnGisYC0ifOZ78XFB5YK+1Col1fbhSD8i28Q
6+w1ES8RsUJ9QKL8Axsa
=Lt5d
-----END PGP SIGNATURE-----

--c8JDVxLPNISE0T4DrcmbEXbdHvilqAsIC--

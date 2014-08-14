From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] rcar_can: document device tree bindings
Date: Thu, 14 Aug 2014 12:07:08 +0200
Message-ID: <53EC8A4C.101@pengutronix.de>
References: <201408010124.26505.sergei.shtylyov@cogentembedded.com> <53DAB5CF.8000407@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="huIXsEdOghKHtgik9NehnKIfrhbKKXf1K"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbaHNKHV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 06:07:21 -0400
In-Reply-To: <53DAB5CF.8000407@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org, wg@grandegger.com, linux-can@vger.kernel.org, linux-sh@vger.kernel.org, vksavl@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--huIXsEdOghKHtgik9NehnKIfrhbKKXf1K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2014 11:31 PM, Marc Kleine-Budde wrote:
> On 07/31/2014 11:24 PM, Sergei Shtylyov wrote:
>> Document the R-Car CAN device tree bindings.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> The series looks good from the CAN perpective. I'll apply the patches
> after we've got an Acked-by from the DT folks.

Applied both to linux-can-next.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--huIXsEdOghKHtgik9NehnKIfrhbKKXf1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPsikwACgkQjTAFq1RaXHNh7ACeIWidDw7u9rBMF/UpJbyacQr4
f+YAn2cLEmLeTbEccFH/Oo4Mil1SMK3q
=6r3X
-----END PGP SIGNATURE-----

--huIXsEdOghKHtgik9NehnKIfrhbKKXf1K--

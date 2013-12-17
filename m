From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: mcp251x: Convert to devm-* API
Date: Tue, 17 Dec 2013 12:08:44 +0100
Message-ID: <52B030BC.80002@pengutronix.de>
References: <1387116961-15261-1-git-send-email-shc_work@mail.ru> <52AED339.8050102@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nqAavlCJoCmJPoGtx3FkNqlxLlNum45qH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45779 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab3LQLJH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Dec 2013 06:09:07 -0500
In-Reply-To: <52AED339.8050102@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nqAavlCJoCmJPoGtx3FkNqlxLlNum45qH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/16/2013 11:17 AM, Marc Kleine-Budde wrote:
> On 12/15/2013 03:16 PM, Alexander Shiyan wrote:
>> Replace existing resource handling in the driver with managed
>> device resource, this ensures more consistent error values and
>> simplifies error paths.
>>
>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>=20
> Lookgs good, applied to can-next.

I have included this patch in the current pull request to David Miller's
net-next. Patch 2/2 is postponed, as discussed yesterday.

If you need a tree to base your patch on, feel free to use:

    git://gitorious.org/linux-can/linux-can-next.git for-davem

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nqAavlCJoCmJPoGtx3FkNqlxLlNum45qH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKwMLwACgkQjTAFq1RaXHMe5ACgkJc9/+nukfsTy2grVcrZoGub
pv0An0+DZwzz8zpGAqEYIBHidL1+NbRJ
=22a0
-----END PGP SIGNATURE-----

--nqAavlCJoCmJPoGtx3FkNqlxLlNum45qH--

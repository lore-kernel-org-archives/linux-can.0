From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH wg-linux-can-next devel 1/1] can: cc770: Fix indirect
 access deadlock on ISA cards
Date: Tue, 31 Jan 2012 23:13:08 +0100
Message-ID: <4F286774.8050704@pengutronix.de>
References: <1326630094-3126-1-git-send-email-lkdev@essax.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig01F727CAE946576E56437BC3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43524 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441Ab2AaWNJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 17:13:09 -0500
In-Reply-To: <1326630094-3126-1-git-send-email-lkdev@essax.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Zarre <lkdev@essax.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01F727CAE946576E56437BC3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/15/2012 01:21 PM, Wolfgang Zarre wrote:
> This fix avoids a deadlock if an interrupt occurs
> during consecutive port operations on ISA cards
> utilising indirect access via address and data
> port.
>=20
> Tested on a B&R ISA card.
>=20
> CC: linux-can@vger.kernel.org
> CC: netdev@vger.kernel.org
> Signed-off-by: Wolfgang Zarre <lkdev@essax.com>

Applied to can-next.
tnx Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig01F727CAE946576E56437BC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZ3QACgkQjTAFq1RaXHO5qQCgk6/Hq7mgNSBJMcJ6FBIv4Ptb
Z6AAn2DzXWSyt9NCu/Yz809CpIDOaQJA
=2sM9
-----END PGP SIGNATURE-----

--------------enig01F727CAE946576E56437BC3--

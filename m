From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] janitorial: asc2log: properly close infile
Date: Fri, 06 Mar 2015 10:27:07 +0100
Message-ID: <54F972EB.80904@pengutronix.de>
References: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gGtGXpgsTEnWdqCsngJPleWldufc6E9W4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52153 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbbCFJ1S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 04:27:18 -0500
In-Reply-To: <1425629838-27641-1-git-send-email-r.schwebel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gGtGXpgsTEnWdqCsngJPleWldufc6E9W4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2015 09:17 AM, Robert Schwebel wrote:
> outfile is closed as well, so do this symmetrically for infile.
>=20
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

Thanks, all three applied to master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gGtGXpgsTEnWdqCsngJPleWldufc6E9W4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU+XLxAAoJECte4hHFiupUqtkP/R0awXXBpS14ybI9/C1iaI3P
kRLHYmqlVfDkxf9vRbO8MXphn5QdrDM+kv8fTodUtP598R8xnbfTucB8tRqHB1nv
k58AO3y7BeB9+oljfz6rUkYmoMhfKe0QhZpDHxhaWpT/xolNrcVlxAEFV7dCGpDE
3rqivLJyxEErdjm2j3nStFviYNT7daDGxg1qCtHuTtGdcHDfAppltblDz5Gaf9qj
wnnA7VbyeglN2VW2eeMtqqAptFrIzqdYWWtM40CLbJ17ssgVugyqZx1x3iD/mluP
qNgdSSGyJk1S0YJ22ee/n4WvreFr/+t6IW5gkY4EiAjmol2JIE7K9iUvnsP3Ba9R
CFRfTcUD/llsS2TEDEVO2OgNUyte2wt2HTAz4Hqpyb9+W+/RC4VNGVmmkrelDPoi
24eCckBTOO0APOoks+AMIDRKP9Ab35qWmKcrY7ljBBDtJ2UoPlfGb6nb5rux3Pbc
wQF1GA4Edvvf45fospV8NgQJ/hScklwFCgi3mKSv7p+BbUzk9lsKRz8EgYezBQhh
MNt8zNKf/B5daty69BKbVGi9hAuO/9eFDBm8IiX5H1PaoEyCcbspMYnbDqSTKOSR
LfE3vDRVrufbprZ57FWUlaOdbhO+Q8QZ2dlclrSSfLVwQ/REsueo0fGTB/9Y2T22
d9pr3JGnKjylyonQRZN6
=meQT
-----END PGP SIGNATURE-----

--gGtGXpgsTEnWdqCsngJPleWldufc6E9W4--

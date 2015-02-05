From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V5 1/3] bfin_can: rewrite the blackfin style of read/write
 to common ones
Date: Thu, 05 Feb 2015 12:03:53 +0100
Message-ID: <54D34E19.9070902@pengutronix.de>
References: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lrkXFRiv52nPBiSIXCCNhbE3Ovacn3L5J"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39737 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbbBELED (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 06:04:03 -0500
In-Reply-To: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Aaron Wu <Aaron.wu@analog.com>, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-devel@analog.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrkXFRiv52nPBiSIXCCNhbE3Ovacn3L5J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2015 11:44 AM, Aaron Wu wrote:
> Rewrite the blackfin CAN driver into more common style in three ways:
> part 1/3: rewrite blackfin style of read/write into common readw/writew=

> part 2/3: introduce ioremap to be compitable with MMU enabled arch
> part 3/3: merge the header file from the blackfin arch dependent
> location to driver code directly, note the original copy of more comple=
ted
> bfin_can.h in arch depentdent location is reserved for reg test purpose=
=20
>=20
> V5 changes: merge contents of header file into drivere code in patch 3/=
3
> V4 changes: remove unused variable in patch 2/3
> V3 changes: remove redundant cast in patch 2/3
> V2 changes: split patch into two parts
> V1 changes: rewrite code into common style
>=20
> Signed-off-by: Aaron Wu <Aaron.wu@analog.com>

Please remove the patch history changes from the description, instead
add a description to each patch describing that patch only.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lrkXFRiv52nPBiSIXCCNhbE3Ovacn3L5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU004cAAoJECte4hHFiupUTYUQAJxA2+C1DwE63bHVOqFP4Zk/
YRpJ6r1k5sq/j53oAuI+r2sT7oCFeIu54P/RRbfDqS63rNP89NYg79s+3wvrrTHT
0NGPBoJ617wZLqJNBp1DfjS+wDo7d2u25jWZUB76wnZHeAt2N/ExVXsaZveHglp8
cj9ep3JkkLSsA39yNWXfj6o6axcBdUKWQ7ycHTO98sK4YbZh++ncEYeVk3WZUEIm
otfMxAz2DD3Pa4AtU5fWWuNvNvF9v4CQFc9O8/Oscw1VbUQVndUbMZcpBMmL7tAI
TNLf6SVekfNrtkB4QzF2gqTaYVNnFN/RZi8pk7ZWTmZ96Jn+qPP4TtlI3xj3E8vA
TYkmO+M/HQrF1M+vZux9h3RlnGoh4Q9thpCsgu10DyvWw+j/iM1bhgvzoYQPR9YV
qcIEsLjyOY6bV3vymXaseZwg/fFD+LQzlFnXWq+6LWVFqddNTXnf7ms7Cw817jh5
1l29NLyvUU6z1TugyeFl3xeYTAp7lgLNC1ECHKAqfq02FVrq4VY3MbB5s9LcL1rX
fmhelo5FGqy58kha/jLp0VjFrAVmRap8qXK+xjAgRLfID7ahyfAWPBRkhBjVW1sU
Rg7LFVrY7QPKr/lWM+OOLRxXaJnKwzDtCRTv+rBym5zqIUrkCRhdCY2MiTXDf7J5
/iCwWlCMXl+aK3jzeCCZ
=81sF
-----END PGP SIGNATURE-----

--lrkXFRiv52nPBiSIXCCNhbE3Ovacn3L5J--

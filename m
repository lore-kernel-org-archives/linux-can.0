From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.
Date: Fri, 17 Jun 2016 11:04:03 +0200
Message-ID: <612130a4-30ea-ed73-ac8e-dabe7919ec35@pengutronix.de>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
 <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h3ADrlRrNK9QnoAe1L90Um60T3tQQ6JE2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52047 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754203AbcFQJEW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:04:22 -0400
In-Reply-To: <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tthayer@opensource.altera.com, socketcan@hartkopp.net, wg@grandegger.com, richard.andrysek@gomtec.de
Cc: anilkumar@ti.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tthayer.linux@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3ADrlRrNK9QnoAe1L90Um60T3tQQ6JE2
Content-Type: multipart/mixed; boundary="6oN3eg9fW7jwBHhGAwENwbWfGiQFrQthT"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: tthayer@opensource.altera.com, socketcan@hartkopp.net, wg@grandegger.com,
 richard.andrysek@gomtec.de
Cc: anilkumar@ti.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, tthayer.linux@gmail.com
Message-ID: <612130a4-30ea-ed73-ac8e-dabe7919ec35@pengutronix.de>
Subject: Re: [RFC] can: c_can: Update D_CAN TX and RX functions to 32 bit.
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
 <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>
In-Reply-To: <1466093419-27575-2-git-send-email-tthayer@opensource.altera.com>

--6oN3eg9fW7jwBHhGAwENwbWfGiQFrQthT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/16/2016 06:10 PM, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>=20
> When testing CAN write floods on Altera's CycloneV, the
> first 2 bytes are sometimes 0x00, 0x00 or corrupted
> instead of the values sent. Also observed bytes 4 & 5
> were corrupted in some cases.
>=20
> The D_CAN Data registers are 32 bits and changing from
> 16 bit writes to 32 bit writes fixes the problem.
>=20
> Testing performed on Altera CycloneV (D_CAN).
> Requesting tests on other C_CAN & D_CAN platforms.
>=20
> Reported-by: Richard Andrysek <richard.andrysek@gomtec.de>
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>

Applied to can with stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6oN3eg9fW7jwBHhGAwENwbWfGiQFrQthT--

--h3ADrlRrNK9QnoAe1L90Um60T3tQQ6JE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY70DAAoJED07qiWsqSVqWSIH/1IXDtNW4HqoXxkza23mUzTv
jUmWFxiElCi4qnE915Z0/IYrSKr+tRD85sGqBeyMKaDHO4uKAcKoeFCbqUrfbTqq
BfJuUxpMgzMAeNQoB9V7l40s3nZMmFkM+2VxFHwXunAJaAFi0QXsY0njjrBUmr0l
OdooOG8ucMovuFBNOjXVGiFUAImQFeiDhUA13OAnPqDj7NBV9V0HFSgvBY1DfUds
sZhlLWYld51bI2bLTtcv3WwPWLK9J7jrDf+215X1OKf8/4nqOQX5LMmzuMT6EzjF
/M9f/O1K9L9/jKK6iCG6R9FnFR5hP7HZzzoQseaB+D5xI5qnOn6TYwmoA4qZgN0=
=DI84
-----END PGP SIGNATURE-----

--h3ADrlRrNK9QnoAe1L90Um60T3tQQ6JE2--

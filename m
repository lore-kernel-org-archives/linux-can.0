From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] Fix D_CAN corrupted bytes by using 32 bit register r/w
Date: Fri, 17 Jun 2016 10:48:54 +0200
Message-ID: <dd1178ed-64e7-a117-82e7-4787b59e98c6@pengutronix.de>
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="To7mB4Xu25hPv6FdQlbqB4UXmxp0xM7Qe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37763 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752337AbcFQItI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 04:49:08 -0400
In-Reply-To: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tthayer@opensource.altera.com, socketcan@hartkopp.net, wg@grandegger.com, richard.andrysek@gomtec.de
Cc: anilkumar@ti.com, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tthayer.linux@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--To7mB4Xu25hPv6FdQlbqB4UXmxp0xM7Qe
Content-Type: multipart/mixed; boundary="Trw0B5UDERCOvBwoPuIIKtQhdCnKjw8QN"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: tthayer@opensource.altera.com, socketcan@hartkopp.net, wg@grandegger.com,
 richard.andrysek@gomtec.de
Cc: anilkumar@ti.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, tthayer.linux@gmail.com
Message-ID: <dd1178ed-64e7-a117-82e7-4787b59e98c6@pengutronix.de>
Subject: Re: [RFC] Fix D_CAN corrupted bytes by using 32 bit register r/w
References: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>
In-Reply-To: <1466093419-27575-1-git-send-email-tthayer@opensource.altera.com>

--Trw0B5UDERCOvBwoPuIIKtQhdCnKjw8QN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/16/2016 06:10 PM, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
>=20
> Corrupted bytes in CAN transmission on the Altera CycloneV seem
> to be an issue because the D_CAN registers are 32 bits [1].
> Changing to a 32 bit write fixes the problem and this patch
> includes one method of fixing the problem by selecting 32 bit
> writes for D_CAN or 16 bit writes for C_CAN.
>=20
> Another option would be to remove the D_CAN if test and always use
> the priv->read_reg32() and priv->write_reg32() for both C_CAN and
> D_CAN. The C_CAN read_reg32() function performs two 16 bit writes.
> The code is cleaner without the D_CAN if branch but it adds additional
> overhead for C_CAN (2nd 16 bit write may not be needed in many cases).

Better save the overhead, as an additional register access may seems to
be quite expensive on some platforms.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Trw0B5UDERCOvBwoPuIIKtQhdCnKjw8QN--

--To7mB4Xu25hPv6FdQlbqB4UXmxp0xM7Qe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY7l2AAoJED07qiWsqSVqh6sH/jtt1LwjwGCnk+X6DIakpdzf
+A9g0cLcltjXoP7PS5rjh3/p0pIWq3DvfQQwSRGavELT2aN1zeFyJtinifH9/PDy
9DuOGa48z1Xz16MRJ9Q0xlVeuTAWMouXoRkedLsHCj+Xmn7DjGbOlLisGYEF2rlc
6Il3OqA5/+iMxg3wYIOs73mDD9vYpQNhalZolZSLJvtpo2/HRAtxsU44vZNUxGKT
GJT+J2724Q86r9tnr6jAhlfISNGX+tcWjCvJJG9h+8KDHD5h0EiiDlYUCjxkHyiM
fSr0a49VmB57YwiM+1w23uepQVIvlKdoI+16iBeOsTj1GgfTuZilU/ZONvZ5uTI=
=OjU9
-----END PGP SIGNATURE-----

--To7mB4Xu25hPv6FdQlbqB4UXmxp0xM7Qe--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 5/5] can: flexcan: Add support for non RX-FIFO mode
Date: Thu, 14 May 2015 17:41:56 +0200
Message-ID: <5554C244.80809@pengutronix.de>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="88SNRHfiFFWlTgbQDaRhF68jF6r4RXBAg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38379 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933221AbbENPmG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 May 2015 11:42:06 -0400
in-reply-to: <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bhupesh Sharma <bhupesh.sharma@freescale.com>, arnd@arndb.de, linux-can@vger.kernel.org
Cc: bhupesh.linux@gmail.com, Sakar.Arora@freescale.com, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88SNRHfiFFWlTgbQDaRhF68jF6r4RXBAg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/14/2015 01:33 PM, Bhupesh Sharma wrote:
> This patch adds support for non RX-FIFO (legacy) mode in
> the flexcan driver.
>=20
> On certain SoCs, the RX-FIFO support might be broken, as
> a result we need to fall-back on the legacy (non RX-FIFO)
> mode to receive CAN frames.
>=20
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>

The non FIFO mode doesn't guarantee the order of the incoming frames,
not does not even try to...this is not acceptable. I'm currently working
on a patch by David Jander that brings in non FIFO mode, but tries to
keep the order of the frames.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--88SNRHfiFFWlTgbQDaRhF68jF6r4RXBAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVVMJEAAoJECte4hHFiupUxREP/RspO+rLu9FyImYFGw7N5p65
bRIJdwP6P1I7Bm2HaQLf57KZERQFyAX/fAw9ePEGPbN8Ww2TooqHMn0lQDf6r9uh
j79Flc73r3CPeLnNDlLvVGSt6YJJ2+G8Pdm2HBVA/IOEzAxFtPYpDl6nS7RrnM13
3LHw0vvNn1Oe6V0FLFpVM3PUmb/XsB96NZxJl7w19MeUOUcoxEcKiFV/v69ksGsv
iBNXUWdelDGy1AQ92/ioRtCFkmPOuUuGkSYDj9k6lbWxurS75Anw/7z/4ncYlaPx
/bpLD16DV3nqOhKCfv6nEIG2r1wm4gH0hPcJTrddwlHSpWY8Jvhvi8PwWJT1eU2c
H8DS8eJd9PE/gGH6dhx3uScqv31IX+4sQuvsTsJtLQNtAlb4dK1pcTogOfYdCweH
CppcHKzOeqEeINzeEfpgmn1L/4UvhHn0PoAaHWkuBhRHru40bqLErkL+RAyKpSGp
GcoY+IyOUXhrLKDO15Roag68xpWBEErGZ3P1zVegAQhXRbkKhoiZb6cMTbYML1/v
if3M+AucftOACq2YzTZdlZB9NceZcYdDkLQT8JpHJfIvXJ+vpupZ4jxUlfLYeBOc
DDCHZ8hbU1qN3c3AbHDRaM3P0UPHoadqZh8vCSBMZhj6VnNruGcM1w+8DhYUkvFd
nMpyfe5ZxTsyWw7QAFff
=KAPG
-----END PGP SIGNATURE-----

--88SNRHfiFFWlTgbQDaRhF68jF6r4RXBAg--

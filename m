From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ifi: use correct register to read rx status
Date: Tue, 21 Mar 2017 15:53:01 +0100
Message-ID: <52dc4a65-7d07-5b1f-63de-117a9b459ca6@pengutronix.de>
References: <1489788887-6919-1-git-send-email-markus@marb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TEIIUoRQ34rlXjvukSiWqqgjdn2lJA72g"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46561 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756711AbdCUPcl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2017 11:32:41 -0400
In-Reply-To: <1489788887-6919-1-git-send-email-markus@marb.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus Marb <markus@marb.org>, wg@grandegger.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TEIIUoRQ34rlXjvukSiWqqgjdn2lJA72g
Content-Type: multipart/mixed; boundary="r4VMGK1iAXLKbUVWrhC2U4w7RakmjKi52";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Marb <markus@marb.org>, wg@grandegger.com
Cc: linux-can@vger.kernel.org
Message-ID: <52dc4a65-7d07-5b1f-63de-117a9b459ca6@pengutronix.de>
Subject: Re: [PATCH] can: ifi: use correct register to read rx status
References: <1489788887-6919-1-git-send-email-markus@marb.org>
In-Reply-To: <1489788887-6919-1-git-send-email-markus@marb.org>

--r4VMGK1iAXLKbUVWrhC2U4w7RakmjKi52
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/17/2017 11:14 PM, Markus Marb wrote:
> The incorrect offset was used when trying to read the RXSTCMD register.=

>=20
> Signed-off-by: Markus Marb <markus@marb.org>

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--r4VMGK1iAXLKbUVWrhC2U4w7RakmjKi52--

--TEIIUoRQ34rlXjvukSiWqqgjdn2lJA72g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljRPk0ACgkQHv7KIOw4
HPYceQf/e8Ldw2Vd16/JKm6HzPqSvWfGjvXEAxbMrHCI+19x2zsg9oqL2yalqLRq
yT0tREtIqxKq8/mCN8JOixtSE9ZfGCkFY0Ehwm5gX8AZidL7iFoc9rANcmiq9S71
ciSf+lnqJMWdUvUiC7TjElzDuLpNQ+teqG+dUc6Gb0bZi63ipx2qE26wU/AmD/9r
Fax6+yC8kh0LCtv1JJqhqRt5JJh4m5h9IFllJqNoZPPHOKtuvmtJwXPCXNiSWUZ8
sGSYS5At1i8BGteixPSgysFghvJnKzoLb8fp6FlsjjELOoNxHt+/oo8hb10Au4ai
mTvpJnAGE68fTatTrSzEqLrUZo02dw==
=iQEO
-----END PGP SIGNATURE-----

--TEIIUoRQ34rlXjvukSiWqqgjdn2lJA72g--

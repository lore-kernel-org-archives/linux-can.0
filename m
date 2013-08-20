From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/3] can: mcp251x: Eliminate irq_flags from driver
 platform_data
Date: Tue, 20 Aug 2013 10:58:32 +0200
Message-ID: <52132FB8.5030502@pengutronix.de>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru> <1376912361-22133-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nie5k4E7v8rxCS67Suau8Tn9RS7GSqL6o"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50129 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3HTI6q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Aug 2013 04:58:46 -0400
In-Reply-To: <1376912361-22133-2-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nie5k4E7v8rxCS67Suau8Tn9RS7GSqL6o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/19/2013 01:39 PM, Alexander Shiyan wrote:
> Flags is not used by boards, so remove this field from the driver
> platform_data.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to linux-can-next/testing

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nie5k4E7v8rxCS67Suau8Tn9RS7GSqL6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlITL7gACgkQjTAFq1RaXHNBlgCePOUN/3b5DqRTxpuNT84k1VAk
PGMAnAhqWF74LIukRy0plk+3lKqb1jGC
=ioWN
-----END PGP SIGNATURE-----

--nie5k4E7v8rxCS67Suau8Tn9RS7GSqL6o--

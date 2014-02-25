From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: mcp251x: Remove #ifdef CONFIG_PM_SLEEP
Date: Tue, 25 Feb 2014 21:37:02 +0100
Message-ID: <530CFEEE.6020007@pengutronix.de>
References: <1393048274-7949-1-git-send-email-shc_work@mail.ru> <1393048274-7949-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4hMt9nq83TLmL9nHk0RrA16DMmbwviaSb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43994 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbaBYUhk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2014 15:37:40 -0500
In-Reply-To: <1393048274-7949-2-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Christian Pellegrin <chripell@evolware.org>, Chris Elston <celston@katalix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4hMt9nq83TLmL9nHk0RrA16DMmbwviaSb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2014 06:51 AM, Alexander Shiyan wrote:
> This patch removes #ifdef CONFIG_PM_SLEEP to improve compile
> coverage.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4hMt9nq83TLmL9nHk0RrA16DMmbwviaSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMM/vkACgkQjTAFq1RaXHNBxQCfQPpNp8wzqdllRr2BHFl8s31i
Ay4An18+G/bH2IcE/k7mQpVRUYAMO2Cp
=7JYk
-----END PGP SIGNATURE-----

--4hMt9nq83TLmL9nHk0RrA16DMmbwviaSb--

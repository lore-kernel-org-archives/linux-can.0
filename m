From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: mcp251x: various improvements
Date: Tue, 01 Apr 2014 23:03:27 +0200
Message-ID: <533B299F.4090208@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g4KmSIqfmHQUIAjvMgx8KbRogVwGT0QpT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53486 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaDAVDc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:03:32 -0400
In-Reply-To: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g4KmSIqfmHQUIAjvMgx8KbRogVwGT0QpT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2014 11:02 PM, Marc Kleine-Budde wrote:
> I've picked up Alexander Shiyan's work.
>=20
> Changes since v1:
> - 1/4: mcp251x_can_probe(): do cleanup in case of spi_setup() fails
> - 2/4: mcp251x_hw_reset(): convert ternary-? to if (err) return
> - 3/4: mcp251x_hw_probe(): convert ternary-? to if (err) return

Alexander, can you please test this series?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--g4KmSIqfmHQUIAjvMgx8KbRogVwGT0QpT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7KZ8ACgkQjTAFq1RaXHOvFACcCLC1sIHxd+vtBG5MpeKewhcJ
sxgAn08z7fgQl9fTWbElmt28LIUAdi9o
=FZ3P
-----END PGP SIGNATURE-----

--g4KmSIqfmHQUIAjvMgx8KbRogVwGT0QpT--

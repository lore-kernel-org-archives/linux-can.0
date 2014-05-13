From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 0/3] hwinit support for non-TI devices
Date: Tue, 13 May 2014 16:26:51 +0200
Message-ID: <53722BAB.8050403@pengutronix.de>
References: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M1DlWNacNDdFxo2pqjoUb42Wf4r52e2Aq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50801 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbaEMO05 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 10:26:57 -0400
In-Reply-To: <1399988421-19429-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M1DlWNacNDdFxo2pqjoUb42Wf4r52e2Aq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/13/2014 03:40 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> picking uo Pavel Machek's and Thor Thayer's patches.
>=20
> changes since v3:
> - split make const into seperate patch (1/3)
> - squash make const of 32 bit accessor functions into existing 32-bit a=
ccesses (2/3)
> - the remaining changes are on 3/3

The "const" for the pci driver is missing, I'll post a v5.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--M1DlWNacNDdFxo2pqjoUb42Wf4r52e2Aq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNyK6sACgkQjTAFq1RaXHPpogCfdR7fWVcLv+DYqDUoYlqeupiW
tUoAniMGqKlRZNKi5F5prfCLACx6P1Yn
=dkN6
-----END PGP SIGNATURE-----

--M1DlWNacNDdFxo2pqjoUb42Wf4r52e2Aq--

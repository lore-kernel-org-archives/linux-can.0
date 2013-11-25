From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: c_can: don't call pm_runtime_get_sync() from
 IRQ handler
Date: Mon, 25 Nov 2013 21:42:48 +0100
Message-ID: <5293B648.4040108@pengutronix.de>
References: <2A43324E02E34840B044C9DC92214480090568F0@AMDTCEX12.actuant.pri>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="25GMPLVt7J9xaeh6tfVKBxVS2gx7XC1fU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38864 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3KYUnF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 15:43:05 -0500
In-Reply-To: <2A43324E02E34840B044C9DC92214480090568F0@AMDTCEX12.actuant.pri>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Glen, Andrew" <AGlen@bepmarine.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25GMPLVt7J9xaeh6tfVKBxVS2gx7XC1fU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2013 09:34 PM, Glen, Andrew wrote:
> From: <mkl@pengutronix.de>
>=20
> The c_can driver contains a callpath (c_can_poll -> c_can_state_change =
->
> c_can_get_berr_counter) which may call pm_runtime_get_sync() from the I=
RQ handler, which is not allowed.
>=20
> This problem is fixed by introducing __c_can_get_berr_counter, which wi=
ll not call pm_runtime_get_sync().
>=20
> Reported-by: Andrew Glen <AGlen@bepmarine.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Andrew Glen <AGlen@bepmarine.com>
> Tested-by: Andrew Glen <AGlen@bepmarine.com>

Thanks for fixing and testing.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--25GMPLVt7J9xaeh6tfVKBxVS2gx7XC1fU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKTtkgACgkQjTAFq1RaXHMdOwCeItSc80fk1GJ9bGTDvq77thsG
aa8An02Lh0dEnjFdJPRn4Df/eiD2Ve3b
=z7Hv
-----END PGP SIGNATURE-----

--25GMPLVt7J9xaeh6tfVKBxVS2gx7XC1fU--

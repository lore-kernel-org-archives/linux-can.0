From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can/peak_usb: fix multi-byte values endianess
Date: Sun, 07 Dec 2014 20:59:50 +0100
Message-ID: <5484B1B6.4030702@pengutronix.de>
References: <1417785069-20782-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SNKmKM8MrO5gD0a6ORmPhK4qAWQHq9UBJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35598 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaLGUAD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 7 Dec 2014 15:00:03 -0500
In-Reply-To: <1417785069-20782-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SNKmKM8MrO5gD0a6ORmPhK4qAWQHq9UBJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2014 02:11 PM, Stephane Grosjean wrote:
> This patch fixes the endianess definition as well as the usage
> of the multi-byte fields in the data structures exchanged with
> the PEAK-System USB adapters.
>=20
> By fixing the endianess, this patch also fixes the wrong usage
> of a 32-bits local variable for handling the error status
> 16-bits field, in function pcan_usb_pro_handle_error().
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can/master.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SNKmKM8MrO5gD0a6ORmPhK4qAWQHq9UBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhLG2AAoJECte4hHFiupU/GoP/jVMa4irid7C6rMNPNlrGPye
A4qpWnKdkfiRF+FFYLqfd37BxVbJ/QbqrMmHz9aDhOJaYBHBCHnDnUaDnRm4uRFQ
ZMsi2t1yXiaCkQ0DYOVqgCCyLn+rBI6ZEA9LfEbRrnScBM5G/QBO2d8yg/avd/tf
5wioUKijnbLaiqa2QYRmNO0p1NZqP/Hg4DaY5rKWfcgqxPSF6vfyEswbfgwE/dAy
gR8rv5SOZVGR5Kn8lr/PgKHEMdmVk0E6awvcXKNEXKhNOY63NvbKRGZnbZryRGVw
itR5uexRhmqWJ6l5zaIi92JwO0Z1wDBI1lQQwNVgMQA9AEEzYkgV4buDQPvOKt9c
02I9C2ierT7AxCGhLpc0GWN4VP+hOHobuJovreMcZQBkZPi87Rff88fxSUgyozgi
ILLcnNV/YDonVyQKayS0RIjRIKKBOsQTzYRpWqekfBOSmGKq3e1Jfgl8BBTQzDTR
MOFlIoBA94aRCuq28PnaSacvJsD0Euum48afse2joFAgMXHcN4NN6/zkwb7qDs63
S2UJyyXyL4CWGvS1GzBbSwm0jBC2b/m7E7Ym8kWQtxhp1AkDKswHO6VIW6Zcn8l7
x1vRcAwF95KLFCDfEs5/uUwTHfaPoPewjzjvjn80Z4EyO3qeMVbI791lDGrtbLV7
2dL4NkEWGDdRlNvtypQN
=QG6B
-----END PGP SIGNATURE-----

--SNKmKM8MrO5gD0a6ORmPhK4qAWQHq9UBJ--

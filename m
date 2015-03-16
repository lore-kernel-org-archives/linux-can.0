From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: add combined rx/tx LED trigger support
Date: Mon, 16 Mar 2015 09:49:50 +0100
Message-ID: <5506992E.6080606@pengutronix.de>
References: <1426495093-25272-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SAuvc1hnGm7UHunJr99Okq8bDWR4lhnuk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56853 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbCPIuD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Mar 2015 04:50:03 -0400
In-Reply-To: <1426495093-25272-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, fabio.baltieri@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAuvc1hnGm7UHunJr99Okq8bDWR4lhnuk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 09:38 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Add <ifname>-rxtx trigger, that will be activated both for tx
> as rx events. This trigger mimics "activity" LED for Ethernet
> devices.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks, replaced your v2 by the v3 patch in can-next.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SAuvc1hnGm7UHunJr99Okq8bDWR4lhnuk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBpk0AAoJECte4hHFiupUfUQP/2N7QittYjZenh4zU89iR26B
j+OKzjHKz88qKtUd/d/ABeVs2bPFQjOwtIAyAt6ulcchq8qAFswTPFoXqBAOnWgj
dUKLINTbX4xLpGuzNXWT8Wz3EcT+JpYaH21vPt5M2yauMJOD1pHy2dmnX20wlYTI
U0Pjs023HmWtV8cALYlc1YBpA/7rGUeJq+CGm1UJWWsfVgPVNBLk+b1YbWs+xgXt
pqAI5Ux0h83uT4XUiRJl2pDitNWzPmdHRqPa45NlPrrphrzKFm241N+Aei7LMpaQ
lF9yK/PPRtGUMmDSQJj8SOE4eEbrfwPsIMdXV/L5EyrkhAmh88B3U4XXAdsCE0fC
xzpxFfgTwLNr6ZiR6InRidhntLY++UTGq8uttKX8ib7R7JapWFqCvBTU7WOO4VT6
3H7qj86VowCXoRJSfnQvEowxgpNlSCs2sQjIfWeUfyGPy2Aikk4djEChcDLEHLBW
kgJnRXjm9plMUDLUgGT7coWYeZpYvE9RGYbLJuR5b+jPLqGWpEzgM2MPWrpLGtM3
6rmmSGFXyQ71GTz2btMVKQVKtYjH5hH81cwTZOamsqjIBY4zUgk+yjdsdJdxwlCJ
RsxXGype3a0l96u5LjFAX0xQowbiABcBbRO5zc3J4dP/W/85kyfGOXVMViUUFvVs
PVwpb7gezV5f2zqZMAnn
=BsKo
-----END PGP SIGNATURE-----

--SAuvc1hnGm7UHunJr99Okq8bDWR4lhnuk--

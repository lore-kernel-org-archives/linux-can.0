From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can-next 2019-07-24
Date: Wed, 24 Jul 2019 11:26:08 +0200
Message-ID: <7939ec79-a54b-fc7c-1e75-a9f5c8a5c19b@pengutronix.de>
References: <93540cba-184a-a9c5-f9d2-b1779a69a36f@pengutronix.de>
 <3b3a3c9f-41ac-74a0-4238-ba01799accb6@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Npb9id7f28sWMllPGMaCZxIXBSBjBryx5"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3b3a3c9f-41ac-74a0-4238-ba01799accb6@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Npb9id7f28sWMllPGMaCZxIXBSBjBryx5
Content-Type: multipart/mixed; boundary="ZsQKJ23xh0xztjMTmn40Q325OCSI09xXK";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <7939ec79-a54b-fc7c-1e75-a9f5c8a5c19b@pengutronix.de>
Subject: Re: pull-request: can-next 2019-07-24
References: <93540cba-184a-a9c5-f9d2-b1779a69a36f@pengutronix.de>
 <3b3a3c9f-41ac-74a0-4238-ba01799accb6@hartkopp.net>
In-Reply-To: <3b3a3c9f-41ac-74a0-4238-ba01799accb6@hartkopp.net>

--ZsQKJ23xh0xztjMTmn40Q325OCSI09xXK
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 7/24/19 11:22 AM, Oliver Hartkopp wrote:
> why didn't you include the CAN FD support for the can-gw?

I wanted to have a look at the patches. But the other patches are
already reviewed.

I'll do another pull-request this week.

> [PATCH 1/2] can: gw: use struct canfd_frame as internal data structure
> https://marc.info/?l=3Dlinux-can&m=3D156388681922741&w=3D2
>=20
> [PATCH 2/2] can: gw: add support for CAN FD frames
> https://marc.info/?l=3Dlinux-can&m=3D156388682022742&w=3D2
>=20
> The patches have already been sent in January as RFC and I did extensiv=
e=20
> testing since then.

Good.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ZsQKJ23xh0xztjMTmn40Q325OCSI09xXK--

--Npb9id7f28sWMllPGMaCZxIXBSBjBryx5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl04JDAACgkQWsYho5Hk
nSCw6Qf9FSR8dP6fMn4FSJK4pn5E+ImlfhW4w/xdse4aLJOfPBMRc3B1PKSnEzds
Mx5W4vIgrnQ+SQh9EgxpBovX/TO8CrRk5uUTfT8VCQz2SokFVohTLdO53aTn8+So
iUoySki3lJmtkc4unkX7xP8glyg9JEujqUSihhdlKrkVf5GYeRVJxg4NxGzrxr6c
TMiEvbB95zEzFdhptusuO7KhBzD29ATZI2rT1rVnEA8/Wi0GlU/3mZB+3SrQS1uC
01twAROmJs79cKkamgroIjC42hR0M0R6PbAaYhuBltKJjG6c3zUTft6SB69aLVL6
0qU1g+2mcBX3597GAX9emqdBdTUUhA==
=7uo8
-----END PGP SIGNATURE-----

--Npb9id7f28sWMllPGMaCZxIXBSBjBryx5--

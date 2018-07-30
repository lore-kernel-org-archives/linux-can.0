From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ems_usb: Fix memory leak on ems_usb_disconnect
Date: Mon, 30 Jul 2018 11:09:10 +0200
Message-ID: <cf32d75d-7003-f6d3-fab2-61d7ab268061@pengutronix.de>
References: <20180727155042.24582-1-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RwZHlf65gkhbcyFsC50Grun6KM2e30MUA"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180727155042.24582-1-vasilyev@ispras.ru>
Sender: netdev-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, Martin Kelly <mkelly@xevo.com>, Martin Lederhilger <m.lederhilger@ds-automotion.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RwZHlf65gkhbcyFsC50Grun6KM2e30MUA
Content-Type: multipart/mixed; boundary="A606j0gOoSFVH44laCVam8pZD24dK3y9A";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anton Vasilyev <vasilyev@ispras.ru>,
 Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, Martin Kelly <mkelly@xevo.com>,
 Martin Lederhilger <m.lederhilger@ds-automotion.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Message-ID: <cf32d75d-7003-f6d3-fab2-61d7ab268061@pengutronix.de>
Subject: Re: [PATCH] can: ems_usb: Fix memory leak on ems_usb_disconnect
References: <20180727155042.24582-1-vasilyev@ispras.ru>
In-Reply-To: <20180727155042.24582-1-vasilyev@ispras.ru>

--A606j0gOoSFVH44laCVam8pZD24dK3y9A
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/27/2018 05:50 PM, Anton Vasilyev wrote:
> ems_usb_probe() allocates memory for dev->tx_msg_buffer, but there
> is no its deallocation in ems_usb_disconnect.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--A606j0gOoSFVH44laCVam8pZD24dK3y9A--

--RwZHlf65gkhbcyFsC50Grun6KM2e30MUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlte1bYACgkQk9IU1zQo
ZfGuNwgAg44STehgnuLXuEyBKS02QMmhEd1BZZ1qSL7gmexOZPRjDio2rHRul/dz
ZIXZidGAAe1/Mrf43HqMvMwObeyCXqY0o0/nZlJHKKg9D542qeaJw4+YdRJxOMOX
9cBJHD6JFf+A8Kh/gHuCXQ5fBV2GEKkDLkTr1aqVsfoXvfz2QQz8SVQ26yORmbC5
jvRc21uzsWZJkB9gLaWFab1lbtCnzf1YmusEI+JH2rZ+L1AFbtT8tKMVNf0nX/1B
ILvnG/7VYgfmOwxm2OtUPMGhK2FJheH8+2aGnWs2yiAnGm6B4vFH32k+UA3XewxK
UdokLv2JEr8Sq2iUsFmXq4vpCzauNQ==
=pyP/
-----END PGP SIGNATURE-----

--RwZHlf65gkhbcyFsC50Grun6KM2e30MUA--

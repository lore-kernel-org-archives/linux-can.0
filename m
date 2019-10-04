From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: fix use-after-free on USB disconnect
Date: Fri, 4 Oct 2019 22:45:03 +0200
Message-ID: <ba71cc15-ac3f-66cd-fffe-214080867ea2@pengutronix.de>
References: <20191001102914.4567-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BcwU8lnONr1dgPI4dBqxJeJdOh9qg51hy"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001102914.4567-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcwU8lnONr1dgPI4dBqxJeJdOh9qg51hy
Content-Type: multipart/mixed; boundary="QBkhT7RqXdjN9avIuHHtOSG3z3WkEt6c7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Johan Hovold <johan@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Message-ID: <ba71cc15-ac3f-66cd-fffe-214080867ea2@pengutronix.de>
Subject: Re: [PATCH 0/2] can: fix use-after-free on USB disconnect
References: <20191001102914.4567-1-johan@kernel.org>
In-Reply-To: <20191001102914.4567-1-johan@kernel.org>

--QBkhT7RqXdjN9avIuHHtOSG3z3WkEt6c7
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/1/19 12:29 PM, Johan Hovold wrote:
> Syzbot reported a use-after-free on disconnect in mcba_usb and a quick
> grep revealed a similar issue in usb_8dev.
>=20
> Compile-tested only.

Applied to can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QBkhT7RqXdjN9avIuHHtOSG3z3WkEt6c7--

--BcwU8lnONr1dgPI4dBqxJeJdOh9qg51hy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2Xr08ACgkQWsYho5Hk
nSB91wf8Dgn4I3se1HZozX4bYj71NMqKqekWNgAbm7VKvxLHdRs9YME0522cfOI1
zk0OxfDv9Dnh/4aF0btqP8ia7+QV513E0jecBEfaMAiouu7cT2xxorB5lUdKdRnN
fxlNd/N2SSjXU8bx+5seF1+TmDgyoie6VK2A6mbn7cjSSecMcL/uLjY22dRJ/er/
oG8/8y1rMc0SCW5QSgvaBVx1wpUwdHEIPJgoioxLabK4XkY3DzfF5enPbXvbrCi0
g6KbiyAbOaAjvEzSxmTcXyYjvMNDGFOkGhMH1Qy0y1t4x3apqPeQ4l1hrGQ8otNb
PAvJB97ehE90HD9Ptxu/UEF2vNvgqw==
=GoKp
-----END PGP SIGNATURE-----

--BcwU8lnONr1dgPI4dBqxJeJdOh9qg51hy--

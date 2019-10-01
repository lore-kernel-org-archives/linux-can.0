From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH][next] can: fix resource leak of skb on error return paths
Date: Tue, 1 Oct 2019 22:04:10 +0200
Message-ID: <720cf73f-8df0-6cee-33bd-41aa8b72dd8d@pengutronix.de>
References: <20190918101156.24370-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CTyUqY7dF4NYv8qQMfCoH5TKwo74Fmcw4"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190918101156.24370-1-colin.king@canonical.com>
Sender: netdev-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <linux@rempel-privat.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CTyUqY7dF4NYv8qQMfCoH5TKwo74Fmcw4
Content-Type: multipart/mixed; boundary="iTitcsbzqupLWeTCytjwOQ2RGKHJiXriV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Colin King <colin.king@canonical.com>,
 Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <linux@rempel-privat.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <720cf73f-8df0-6cee-33bd-41aa8b72dd8d@pengutronix.de>
Subject: Re: [PATCH][next] can: fix resource leak of skb on error return paths
References: <20190918101156.24370-1-colin.king@canonical.com>
In-Reply-To: <20190918101156.24370-1-colin.king@canonical.com>

--iTitcsbzqupLWeTCytjwOQ2RGKHJiXriV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/18/19 12:11 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the error return paths do not free skb and this results
> in a memory leak. Fix this by freeing them before the return.
>=20
> Addresses-Coverity: ("Resource leak")
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Added to can.

tnx.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iTitcsbzqupLWeTCytjwOQ2RGKHJiXriV--

--CTyUqY7dF4NYv8qQMfCoH5TKwo74Fmcw4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2TsToACgkQWsYho5Hk
nSDMAQgAmSfPZWyQfnRGyicy3zeAXVdnUuYYS+3L81Gh7rpek12D4bHy9KAepag7
M+FhBQySmrmYNu+dx3j8OzszIcSF0ad+JWU06ZarPaHQAuCX6Q8y/FJ3gPyy6VJv
pa8xV6Nq1SbklDsdeeaXBZmQvMeoXAafDJlfIvZ7Wx9oKn8aoUcL7meAOIZoeGwc
Ttpx2tjnWNYTtz+lG+3p20aV7WqSGKUXWERhjZ/AUSyADFfViA+1a+3ytO0ynWSm
QFAxmu+2kNpiYwoPG8qaZQ0gJv1IRdiURoNz3Lik+MwGJsBWn4Z0nzUtrfxJuNJi
M1B/Uwwfhs10MCWZc8ynWHRLcFO+iQ==
=sDnQ
-----END PGP SIGNATURE-----

--CTyUqY7dF4NYv8qQMfCoH5TKwo74Fmcw4--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: j1939: fix memory leak if filters was set
Date: Thu, 10 Oct 2019 13:55:22 +0200
Message-ID: <55b73887-4626-3b40-e390-a1f10f790167@pengutronix.de>
References: <20191010105031.3507-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="urWE0DKEUTsohPxqPMnFQUAvksq39xTEa"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010105031.3507-1-o.rempel@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--urWE0DKEUTsohPxqPMnFQUAvksq39xTEa
Content-Type: multipart/mixed; boundary="rz9XHY0Jcg8xb8yFCOmWkUjd2OadJ3GVT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 dev.kurt@vandijck-laurijssen.be, wg@grandegger.com
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <55b73887-4626-3b40-e390-a1f10f790167@pengutronix.de>
Subject: Re: [PATCH] can: j1939: fix memory leak if filters was set
References: <20191010105031.3507-1-o.rempel@pengutronix.de>
In-Reply-To: <20191010105031.3507-1-o.rempel@pengutronix.de>

--rz9XHY0Jcg8xb8yFCOmWkUjd2OadJ3GVT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/10/19 12:50 PM, Oleksij Rempel wrote:
> Filters array is coped from user space and linked to the j1939 socket.
> On socket release this memory was not freed.
>=20
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied to linux-can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rz9XHY0Jcg8xb8yFCOmWkUjd2OadJ3GVT--

--urWE0DKEUTsohPxqPMnFQUAvksq39xTEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2fHCoACgkQWsYho5Hk
nSCwKgf+Mi2PcO1MZv8YzRHOyjp7JmZ3v8pehiZ7Njia2EHwawie9flk9MHxhecJ
VAoFml52szEaZg2h2gbRYyr99zS93oBBZgQTOHDL7V2RSVWm9gcZjjDvkui7b9kq
9s3ySH5aN0ifzX080XDy6pU2HZF4ywlETRYdZYSYk0eG8lTh4eBDT3ggwJUSUjSs
3HtaqAldsrw6Tdm1cJg69KFnHnWCtHfQVKWttCettt1J7BtKDj2uzfMsFSIAcKIg
9lQnGqP6gtuNxCGFBqe2UBp2wpt3xmCr37arcIg5v+WbIcRf9If9oGWILTNAgZj4
m6i4k/8AIx619UugHIFAxkHE6xMlSQ==
=SCDC
-----END PGP SIGNATURE-----

--urWE0DKEUTsohPxqPMnFQUAvksq39xTEa--

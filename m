From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2018-01-16
Date: Fri, 19 Jan 2018 10:48:11 +0100
Message-ID: <b75aff2f-96a5-8bce-b4a8-cf1e9b1df8ad@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VjGw25ublRgcCiXkO0D8NYk1EnIkBVkx9"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VjGw25ublRgcCiXkO0D8NYk1EnIkBVkx9
Content-Type: multipart/mixed; boundary="xJ8mw5kQZlv9h0O8AQ7EMFy2khLIwi77d";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <b75aff2f-96a5-8bce-b4a8-cf1e9b1df8ad@pengutronix.de>
Subject: pull-request: can-next 2018-01-16

--xJ8mw5kQZlv9h0O8AQ7EMFy2khLIwi77d
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 1 patch.

This patch by Arnd Bergmann for the m_can driver silences a compiler
warning if CONFIG_PM is not selected.

regards,
Marc

---

The following changes since commit ef58ca38dbda0642e293bcaa2e05edc79677c6=
17:

  net/sched/sch_prio.c: work around gcc-4.4.4 union initializer issues (2=
018-01-18 21:11:31 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.16-20180119

for you to fetch changes up to 58359193193c4261d340b2f7f028e5096d4e4d15:

  can: m_can: mark runtime-PM handlers as __maybe_unused (2018-01-19 10:4=
1:15 +0100)

----------------------------------------------------------------
linux-can-next-for-4.16-20180119

----------------------------------------------------------------
Arnd Bergmann (1):
      can: m_can: mark runtime-PM handlers as __maybe_unused

 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xJ8mw5kQZlv9h0O8AQ7EMFy2khLIwi77d--

--VjGw25ublRgcCiXkO0D8NYk1EnIkBVkx9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlphvtsACgkQHv7KIOw4
HPat8Qf/XRMpc1SeDJeq6aRg6IHqQaNdC4AWZ+sulMJgeNw1JHsa1n5JmjfIEIB5
vj6AqO0SwF6JU/H4vNXjMkl1VfjrsDwcQHf22SNt8U369Je2dq9cDe42uulmrfug
pgz656oZy6caAAn6qr1u5RHLC+UPGKAgHoXB+o69RY84JHnsPGux8zaLjmmLbvG/
9oga4D+MIHwV/Sgc7xK5xqmVQNLwEjWPceR2jiGrDivUAFU/0XQ6qfAiEwpGpm86
cl1wU9iutepGHyDpS2wEuecFt8j4RBRGxSntQroMgEl0b6SI3stkkkffz0tLhK9u
g9oZdy9tV2EnFLqJY//XqvAED/fhpw==
=BMeJ
-----END PGP SIGNATURE-----

--VjGw25ublRgcCiXkO0D8NYk1EnIkBVkx9--

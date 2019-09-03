From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: mcp251x: Make use of device properties
Date: Tue, 3 Sep 2019 14:50:05 +0200
Message-ID: <9ba9d56b-c045-74d3-9693-a9a959ffb675@pengutronix.de>
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7Yt3Q353SybWsFgzEVINh2PvoljzLd32L"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Yt3Q353SybWsFgzEVINh2PvoljzLd32L
Content-Type: multipart/mixed; boundary="voW4yvnxECFVU7r2EVZB7ikWHKSkpr20J";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-ID: <9ba9d56b-c045-74d3-9693-a9a959ffb675@pengutronix.de>
Subject: Re: [PATCH v2 0/4] can: mcp251x: Make use of device properties
References: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190903124259.60920-1-andriy.shevchenko@linux.intel.com>

--voW4yvnxECFVU7r2EVZB7ikWHKSkpr20J
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 9/3/19 2:42 PM, Andy Shevchenko wrote:
> The purpose of this series is to simplify driver by switching to use de=
vice
> properties. In particular it allows to drop legacy platform data.
>=20
> Patch 1 switches driver to use devm_clk_get_optional() API.
>=20
> Patch 2 unifies getting the driver data independently of the table whic=
h
> provides it.
>=20
> Patch 3 drops extra check for regulator presence by switch to use an al=
ready
> present wrapper.
>=20
> And patch 4 gets rid of legacy platform data.
>=20
> Changelog v2:
> - add patch 4 to get rid of legacy platform data

Sorry for not telling, your v1 series has already been applied and it's
included in the latest pull request. Can you please rebase your patches
on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/ta=
g/?h=3Dlinux-can-next-for-5.4-20190903

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--voW4yvnxECFVU7r2EVZB7ikWHKSkpr20J--

--7Yt3Q353SybWsFgzEVINh2PvoljzLd32L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1uYX0ACgkQWsYho5Hk
nSCm0QgAm+Sda/74mBP+bp1ZxemzNMhFzxXTngvEvG6rvix6LibHF0djn+nDkikB
NvsDNpZwPrgsBnN2P9sHmlF1/7tZBRku+zRqrVBT2/jzJqjyTmuiZq/rx9vyI00o
a9yySSPM7AKdZpoBvo4Llq4eEuVHTfrkiAqE4+YQEd7fEY6QCEjW8i4WS80QO3uK
nQGDUavgpbzHR9TCWBzfQsWFUhcasyPJABxncO8uFKqn3eZSzj0IE0kVqsf5OnIL
pRupplOyhohUYFp1zEnNQKEs19G0t0SikWQJdRa7VblZ/vZcfjkk9uOhSNARYrR1
tO6EhFh0QGVd/CHPQ09MVMTZcC619Q==
=eXKT
-----END PGP SIGNATURE-----

--7Yt3Q353SybWsFgzEVINh2PvoljzLd32L--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: m_can: mark runtime-PM handlers as __maybe_unused
Date: Thu, 18 Jan 2018 14:16:37 +0100
Message-ID: <54b08b88-493f-a39e-db00-194ba91dcedf@pengutronix.de>
References: <20180118130513.506569-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QsoqBId3iOzhTL4wJEBBVEJNArre4yqYv"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180118130513.506569-1-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Quentin Schulz <quentin.schulz@free-electrons.com>, Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QsoqBId3iOzhTL4wJEBBVEJNArre4yqYv
Content-Type: multipart/mixed; boundary="7NirtgnNqJA2XJZe6PpVrbzWvFiL1WfUB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: Mario Huettel <mario.huettel@gmx.net>, Faiz Abbas <faiz_abbas@ti.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 Franklin S Cooper Jr <fcooper@ti.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <54b08b88-493f-a39e-db00-194ba91dcedf@pengutronix.de>
Subject: Re: [PATCH] can: m_can: mark runtime-PM handlers as __maybe_unused
References: <20180118130513.506569-1-arnd@arndb.de>
In-Reply-To: <20180118130513.506569-1-arnd@arndb.de>

--7NirtgnNqJA2XJZe6PpVrbzWvFiL1WfUB
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/18/2018 02:04 PM, Arnd Bergmann wrote:
> Building without CONFIG_PM results in a harmless warning:
>=20
> drivers/net/can/m_can/m_can.c:1763:12: error: 'm_can_runtime_resume' de=
fined but not used [-Werror=3Dunused-function]
> drivers/net/can/m_can/m_can.c:1752:12: error: 'm_can_runtime_suspend' d=
efined but not used [-Werror=3Dunused-function]
>=20
> Marking the functions as __maybe_unused lets the compiler
> silently drop them instead.
>=20
> Fixes: cdf8259d6573 ("can: m_can: Add PM Support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tnx - applied.

However all archs using this driver have mandatory PM support and the
driver depends on it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7NirtgnNqJA2XJZe6PpVrbzWvFiL1WfUB--

--QsoqBId3iOzhTL4wJEBBVEJNArre4yqYv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpgnjUACgkQHv7KIOw4
HPZJEgf/cm/hMOFlCr4NTbfn2Wtol4AKxUVBxfIiP2+0KJXgOsNUrS44GWoO1kuO
Fr/BEf+rXsVg/ev74GhE4nPrab09OgZQfzdbRe4LjCG1lwA0en4XlYXYiIrtbH2w
DDmdu+9ZwBYNxmz6iE19lti0l+HAt+BMmJk2bL+mS2NFtjTyg7QOGYkCsGjPnbJH
O1GwPwI9uMbUGDHTglvNWyo6nzcpwBi2OM246Ko7oiabrH+AtsPSmVk6SIVgj4R8
0dunRZY9jH+q1Y0mKAYvKh7Czo0Zpej1jRyqAKNuo7ygW8xIOD1s8UVFjjWS9i1W
7Tw/JstkCwGd/ZyfTguaDMdl347Nhw==
=22xJ
-----END PGP SIGNATURE-----

--QsoqBId3iOzhTL4wJEBBVEJNArre4yqYv--

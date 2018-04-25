From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: fix ican3_xmit()'s return type
Date: Wed, 25 Apr 2018 08:47:04 +0200
Message-ID: <b96f56e5-2ab1-5538-cbe3-e0cef1a74b7b@pengutronix.de>
References: <20180424131609.3258-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BpaZpqa70FJeTQoMtMbeko9Td9Va2AMTr"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424131609.3258-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BpaZpqa70FJeTQoMtMbeko9Td9Va2AMTr
Content-Type: multipart/mixed; boundary="G68VjNvGdsdYkkvBoruNyNmDMUsg6JrI8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org
Message-ID: <b96f56e5-2ab1-5538-cbe3-e0cef1a74b7b@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: fix ican3_xmit()'s return type
References: <20180424131609.3258-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20180424131609.3258-1-luc.vanoostenryck@gmail.com>

--G68VjNvGdsdYkkvBoruNyNmDMUsg6JrI8
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 03:16 PM, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
>=20
> Fix this by returning 'netdev_tx_t' in this driver too.
>=20
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---

Can you send a series fixing the return type in all CAN drivers?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G68VjNvGdsdYkkvBoruNyNmDMUsg6JrI8--

--BpaZpqa70FJeTQoMtMbeko9Td9Va2AMTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrgJGkACgkQk9IU1zQo
ZfHc3AgAzsxjCxNlDUNaumGOG3nVv6cjjL7x/XCnFGabUxuQRz6gBtq+wIXkAGq3
qGoYjmvdGClJUdv2HLi2CqWlfRWCfmyP/f7G+8S6rcHaCojss0+lH9zAj0mkXH/F
7kxYFLRoVYIhdAs6xTJsVsBkLcoJVRNs1qM1p54tZICN0FLv9NtjNRZmQZinF63x
QKsRRmKKAsBek3Co/TV+03IMBHtKmdesgndyc3Tzn3Qnx/5ohF6aWBGLAurw+9IA
ipEEPTi88hjKt5N+9LxvVxqYBEDrYLkIZd00zl/jLsa6fc6INd7x4rt3lOmUvaMx
fia3GZeF7E7joSPhgUJMfM9p7g1IRw==
=6Yb1
-----END PGP SIGNATURE-----

--BpaZpqa70FJeTQoMtMbeko9Td9Va2AMTr--

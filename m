From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
Date: Fri, 27 Apr 2018 09:21:38 +0200
Message-ID: <62fdb875-0940-3396-612c-06ef7533399b@pengutronix.de>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>, "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5
Content-Type: multipart/mixed; boundary="3Szq496S26ecTDO0b8Uki3mtIHn8xYauf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Michal Simek <michal.simek@xilinx.com>,
 "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
Message-ID: <62fdb875-0940-3396-612c-06ef7533399b@pengutronix.de>
Subject: Re: [PATCH 0/3] can: fix ndo_start_xmit()'s return type
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>

--3Szq496S26ecTDO0b8Uki3mtIHn8xYauf
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 11:13 PM, Luc Van Oostenryck wrote:
> ndo_start_xmit() is defined as returing an 'netdev_tx_t'.
> However, several can drivers use 'int' as the return type
> of their start_xmit() method.
> This series contains the fix for all three of them.
>=20
> Luc Van Oostenryck (3):
>   can: janz-ican3: fix ican3_xmit()'s return type
>   can: sun4i: fix sun4ican_start_xmit()'s return type
>   can: xilinx: fix xcan_start_xmit()'s return type
>=20
>  drivers/net/can/janz-ican3.c | 2 +-
>  drivers/net/can/sun4i_can.c  | 2 +-
>  drivers/net/can/xilinx_can.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied all 3 to linux-can-next, added similar patch for the flexcan driv=
er.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3Szq496S26ecTDO0b8Uki3mtIHn8xYauf--

--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlriz4cACgkQk9IU1zQo
ZfH2mQf9HBvlAEf7YT3JUmRjWzO0A02xl+q38B1Vks0QH1nmrJm9bxEaYyREYk9d
6hAM/y3wyH7BR0MoGfstOOfnS065I3ob1Wfra0vrMmqHC90QJ7bVOAL/eB33+vEz
1ogR797IGWp9RuA2bVlrXPOy4NmS4gVDpI9dfQynmmxW/R+FdsK1WwZuzuTZByzo
fsps5wqUnV92lWb4n3Iaaly7rFasq0OKgFA5vjCDJJYZGiKdk6fmrGHb/IXZdjgt
923AtsWHzF6M1pk131oLsJ3bdmbu73F9LIcbZDcvLUnPA/L5by6tsFlac5NPbGaa
g8RVsqbyISBTmQSpfojSncpks6Z6JQ==
=DW9s
-----END PGP SIGNATURE-----

--h1Ujan5qz4X7lsH1QzjmC1LunW5yQrGD5--

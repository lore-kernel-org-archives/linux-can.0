From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
Date: Wed, 20 Mar 2019 14:08:59 +0100
Message-ID: <d1cd73cc-e200-7c06-dd6e-3c5e2e35709c@pengutronix.de>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AtCO4ESIZlZit0M7VDN0gsU3QqTrfNlYZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: netdev-owner@vger.kernel.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AtCO4ESIZlZit0M7VDN0gsU3QqTrfNlYZ
Content-Type: multipart/mixed; boundary="uAr2Tcv5uPxh5vG5HR99EbCyN4MgocTEB";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <d1cd73cc-e200-7c06-dd6e-3c5e2e35709c@pengutronix.de>
Subject: Re: [PATCH 0/6] net: can: xilinx_can: Bug fixes and Enhancements
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>

--uAr2Tcv5uPxh5vG5HR99EbCyN4MgocTEB
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 3/18/19 12:32 PM, Appana Durga Kedareswara rao wrote:
> This patch series does the below
> --> Added support for CANFD FD frames
> --> Fix Checkpatch reported warnings and checks
>=20
> Appana Durga Kedareswara rao (6):
>   net: can: xilinx_can: Fix style issues
>   net: can: xilinx_can: Fix flags field initialization for axi can and
>     canps
>   net: can: xilinx_can: Add cantype parameter in xcan_devtype_data
>     struct
>   net: can: xilinx_can: Add support for CANFD FD frames
>   net: can: xilinx_can: Add SPDX license
>   net: can: xilinx_can: Fix kernel doc warnings
>=20
>  drivers/net/can/xilinx_can.c | 303 +++++++++++++++++++++++++++++++++++=
+-------
>  1 file changed, 257 insertions(+), 46 deletions(-)

Applied to linux-can-next/testing, but in order. First fixes than
enhancements:

> 241826302854 net: can: xilinx_can: Fix style issues
> 70fb26fadc27 net: can: xilinx_can: Fix kernel doc warnings
> 7beb64351ff1 net: can: xilinx_can: Add SPDX license
> dd94910bceae net: can: xilinx_can: Fix flags field initialization for a=
xi can and canps
> 6bd05cece567 net: can: xilinx_can: Add cantype parameter in xcan_devtyp=
e_data struct
> 34e280170736 net: can: xilinx_can: Add support for CANFD FD frames

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uAr2Tcv5uPxh5vG5HR99EbCyN4MgocTEB--

--AtCO4ESIZlZit0M7VDN0gsU3QqTrfNlYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlySO2sACgkQWsYho5Hk
nSAO5wf/TRVP/ca1hbKAMEXeNGULYHXPsAylwWq8dvb/PG9OVMK6WdC60jCkbax2
lRRsxy1gXSjCtV3CGCQAKKDiZSLr5INsAVieVUn07WlNdaBugILb7gD31vK+ql5w
foHe6Tez+njY5BwbMShk0br4k4U23ja9gc/OIONT/3H9OATI/IGP0UTTIzXRlk0U
VZD7Ifv1TGsRcbyTfiX8WpU5iEUUqsMrxfTzSIop6rhpZ0Snfbw678dWYx5+5sgy
telZEt+6WwVYMG980hZVFGPx1uo+YeXS7MirQ0a4ElkonvQTVtmZcCkjs3BNdnlc
V7gTUhZeKQMHVqFwyc6Dm4sg4JT3fg==
=bBPD
-----END PGP SIGNATURE-----

--AtCO4ESIZlZit0M7VDN0gsU3QqTrfNlYZ--

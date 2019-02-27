From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: add PE clock source select support
Date: Wed, 27 Feb 2019 12:00:37 +0100
Message-ID: <d0d2d140-0453-77a5-db6a-88c27f47bbc4@pengutronix.de>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Kcug6F25JDkYZwVmrN2h99Cy94Xjf6sJR"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "robh@kernel.org" <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kcug6F25JDkYZwVmrN2h99Cy94Xjf6sJR
Content-Type: multipart/mixed; boundary="PPyq47czujGXEMXn9BDlDbhDedtpO02Vw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "robh@kernel.org"
 <robh@kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <d0d2d140-0453-77a5-db6a-88c27f47bbc4@pengutronix.de>
Subject: Re: [PATCH 0/2] can: flexcan: add PE clock source select support
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>
In-Reply-To: <47070f2a-4500-4b48-3718-66569a7cc89e@pengutronix.de>

--PPyq47czujGXEMXn9BDlDbhDedtpO02Vw
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 2/27/19 9:46 AM, Marc Kleine-Budde wrote:
> On 12/13/18 8:07 AM, Joakim Zhang wrote:
>> The patch set intends to add support for PE clock source select. The
>> FlexCAN controller can parse "fsl,clk-source" property from device tre=
e
>> to select clock source.
>>
>> Dong Aisheng (2):
>>   Documentation: can: flexcan: add PE clock source property to device
>>     tree
>>   can: flexcan: add support for PE clock source select
>>
>>  .../bindings/net/can/fsl-flexcan.txt           |  8 ++++++++
>>  drivers/net/can/flexcan.c                      | 18 ++++++++++++++---=
-
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>=20
> Added to linux-can-next.

With one change:

> @@ -1369,7 +1371,10 @@ static int register_flexcandev(struct net_device=
 *dev)
>                 goto out_clks_disable;
>=20
>         reg =3D priv->read(&regs->ctrl);
> -       reg |=3D FLEXCAN_CTRL_CLK_SRC;
> +       if (priv->clk_src)
> +               reg |=3D FLEXCAN_CTRL_CLK_SRC;
> +       else
> +               reg &=3D ~FLEXCAN_CTRL_CLK_SRC;

=2E..the FLEXCAN_CTRL_CLK_SRC bit is cleared now.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PPyq47czujGXEMXn9BDlDbhDedtpO02Vw--

--Kcug6F25JDkYZwVmrN2h99Cy94Xjf6sJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2bdUACgkQWsYho5Hk
nSCvnQf+OJMQWmTLRfW26pt70KNd+D/JXgssLgfCeOx2ex0LgXF0bjmlL9ISU+yy
lGJLTprbPInXoOOaFpU2Ni8Z1727g+OhdnRtczrhSwEerEFB9397VcpDLD4u7ie6
VfLavjBqsTKfrg2ORd5CDp8gcmgUBq3b5rACMzYV7d0kXpLxGL8ybQ1jU3yciv7y
o51DTAh5RpGgd/S1ydhP4UtdN1ke8Aj9G9gcfyf0ehylkL8+qkXEAGA/KihtpdWd
WvIvAsvghj8ZYAgBywU5sVbPCOG7j3tUrg9aK0cVyc/vh0+QiRsNT5yPwBMxlpVL
AUmcksgZqgJb5YqBl6xXzLJ0b3kcYQ==
=/aeG
-----END PGP SIGNATURE-----

--Kcug6F25JDkYZwVmrN2h99Cy94Xjf6sJR--

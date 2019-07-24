From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
Date: Wed, 24 Jul 2019 11:48:19 +0200
Message-ID: <080346c5-eace-f0bc-ef3a-0354988b9fb4@pengutronix.de>
References: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
 <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L8Cw1XMGI72qJhJ4eicrbChBaG8O2hc47"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Patrick Zysset <Patrick.Zysset@netmodule.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L8Cw1XMGI72qJhJ4eicrbChBaG8O2hc47
Content-Type: multipart/mixed; boundary="v1QXW5jEeOizdY2Gf64dDD33bLn4mSlJh";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andrejs Cainikovs <Andrejs.Cainikovs@netmodule.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Patrick Zysset <Patrick.Zysset@netmodule.com>
Message-ID: <080346c5-eace-f0bc-ef3a-0354988b9fb4@pengutronix.de>
Subject: Re: [PATCH 1/2] can: c_can: support 64 message objects for D_CAN
References: <20190208131738.27668-1-andrejs.cainikovs@netmodule.com>
 <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>
In-Reply-To: <20190208131738.27668-2-andrejs.cainikovs@netmodule.com>

--v1QXW5jEeOizdY2Gf64dDD33bLn4mSlJh
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 2/8/19 2:17 PM, Andrejs Cainikovs wrote:
> D_CAN supports up to 128 message objects, comparing to 32 on C_CAN.
> However, some CPUs with D_CAN controller have their own limits:
> TI AM335x Sitara CPU, for example, supports max of 64 message objects.
>=20
> This patch extends max D_CAN message objects up to 64.

Please don't make this a kconfig option.

According to you description this is a HW feature, so please add the max
number of messe objects to "struct c_can_driver_data" and adjust the
drvdata accordingly.

> static const struct of_device_id c_can_of_table[] =3D {
> 	{ .compatible =3D "bosch,c_can", .data =3D &c_can_drvdata },
> 	{ .compatible =3D "bosch,d_can", .data =3D &d_can_drvdata },
> 	{ .compatible =3D "ti,dra7-d_can", .data =3D &dra7_dcan_drvdata },
> 	{ .compatible =3D "ti,am3352-d_can", .data =3D &am3352_dcan_drvdata },=

> 	{ .compatible =3D "ti,am4372-d_can", .data =3D &am3352_dcan_drvdata },=

> 	{ /* sentinel */ },
> };

You probably have to pass it via "struct c_can_priv" so that it's
available in the c_can.c

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--v1QXW5jEeOizdY2Gf64dDD33bLn4mSlJh--

--L8Cw1XMGI72qJhJ4eicrbChBaG8O2hc47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl04KWMACgkQWsYho5Hk
nSBWkgf/ewd8pvUqq2juUWx2Y5InHfSxIly9r0t5CyhJUYiBGy6etdKBVK6BUQTn
hAqK6D+NVLOweN95M9IOA5h721FYtN/5f4T7FbahooZFgHWWapwOETBX2q9Nipby
Fobu45M/ZBu4t5vkHAAXl3nHPat/gqpA0t19zz6eZzgAP7mze0GTIJZyfyfcMk54
LvrKBxSv0XxBKS+fSBLIDV/QLyuXngGG/wZRELpY9gHdND3pvu0d/eipxVovVDPj
mgMdDC+fJRhgNmnisPtpLLgqfdL5GCenFxQtTxB/y5i+d5HINTGjYy6yNdwqrmJ8
CVkYqFNxFFD10Zis4v0pQrAbDzpXgA==
=vEUi
-----END PGP SIGNATURE-----

--L8Cw1XMGI72qJhJ4eicrbChBaG8O2hc47--

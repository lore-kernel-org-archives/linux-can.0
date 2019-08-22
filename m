From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
Date: Thu, 22 Aug 2019 17:46:08 +0200
Message-ID: <6c2bf55f-e360-c51a-e7bb-effc86aa5b6c@pengutronix.de>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
 <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
 <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="b5orkHz9ibUbF7nWrPatgW4erJBEZbGjj"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b5orkHz9ibUbF7nWrPatgW4erJBEZbGjj
Content-Type: multipart/mixed; boundary="r0SgaKD5BGhUZBvMER0VMyVCgXsPI8g3V";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <6c2bf55f-e360-c51a-e7bb-effc86aa5b6c@pengutronix.de>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
 <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
 <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>
In-Reply-To: <ff9e007b-6e39-3d64-b62b-93c281d69113@ti.com>

--r0SgaKD5BGhUZBvMER0VMyVCgXsPI8g3V
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/22/19 4:20 PM, Dan Murphy wrote:
>>> +tcan4x5x: tcan4x5x@0 {
>>> +		compatible =3D "ti,tcan4x5x";
>>> +		reg =3D <0>;
>>> +		#address-cells =3D <1>;
>>> +		#size-cells =3D <1>;
>>> +		spi-max-frequency =3D <10000000>;
>>> +		bosch,mram-cfg =3D <0x0 0 0 32 0 0 1 1>;
>>> +		data-ready-gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;
>> Can you convert this into a proper interrupt property? E.g.:
>=20
> OK.=C2=A0 Do you want v13 or do you want patches on top for net-next?

Please use net-next/master as the base.

>>>                  interrupt-parent =3D <&gpio4>;
>>>                  interrupts =3D <13 0x2>;
>> See:
>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetre=
e/bindings/net/can/microchip,mcp251x.txt#L21
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git=
/tree/drivers/net/can/spi/mcp251x.c?h=3Dmcp251x#n945

I've removed the branch, as the patches are already upstream, have a
look here:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/d=
rivers/net/can/spi/mcp251x.c#n921

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--r0SgaKD5BGhUZBvMER0VMyVCgXsPI8g3V--

--b5orkHz9ibUbF7nWrPatgW4erJBEZbGjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1euMAACgkQWsYho5Hk
nSBRfgf/dgt6qwCU+00wQD4mEbAvVn39RyASlLw3AdaliduTEV6b3SDDe5Ip+Jp2
cbrZOTfhAZ2Q2zBhP0jR4HlpjLtjLjKVN/i+3Y/Qgb8GFAMvySPcU520e03w++ug
pzMnUP4hIFz2NuiG+eMgQ30mgTWEzjhyA0T5qVS3MSplYc+HNHwmy2BXnmTCsseA
Mw7K1LA482sPDye52qJNyfBCfSyD2nQImgKC4PMZ640WY4pKmj8XL9St8M/aB+WN
9RAQESJ60klKTxLCs9Oy7mbvTJzEOn1o+YQ18Qj+DFKKD859v+Tgbxc1Xvrd9jww
ldc2jaor6zSIvISR8/2ATnzT5E7ruw==
=t0jQ
-----END PGP SIGNATURE-----

--b5orkHz9ibUbF7nWrPatgW4erJBEZbGjj--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Sat, 7 Dec 2019 21:32:05 +0100
Message-ID: <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
 <DB7PR04MB461820120FF61E08B8B5B0B5E65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1u3OiIJVChW5nBIxb1gbCrznEs9U3YilY"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1u3OiIJVChW5nBIxb1gbCrznEs9U3YilY
Content-Type: multipart/mixed; boundary="TRsCnnnD2zkhgd5ksc59sKqdnvLPx4gYe";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
 <DB7PR04MB461820120FF61E08B8B5B0B5E65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
In-Reply-To: <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>

--TRsCnnnD2zkhgd5ksc59sKqdnvLPx4gYe
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/5/19 12:32 PM, Sean Nyekjaer wrote:
>> If yes, I think we don't need check stop mode in probe stage, since
>> issue has disappeared automatically.
>=20
> If one have devices deployed where:
> "can: flexcan: fix deadlock when using self wakeup" isn't applied.
> They could have devices stuck in stop-mode.

Ok.

But both patches:

    can: flexcan: fix deadlock when using self wakeup
    can: flexcan: try to exit stop mode during probe stage

are not yet mainline, so if "can: flexcan: fix deadlock when using self
wakeup" fixes the problem and goes into stable we don't need "can:
flexcan: try to exit stop mode during probe stage", right?

> That's what i meant by this patch doesn't do any harm to have the check=
=20
> included.

I don't want to have code in the driver that serves no purpose.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--TRsCnnnD2zkhgd5ksc59sKqdnvLPx4gYe--

--1u3OiIJVChW5nBIxb1gbCrznEs9U3YilY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3sDEUACgkQWsYho5Hk
nSCcywf/QK7QMPeN7cJ+hTYoU8s1lhJpyqKXDiA3WiREr0oxVuyi77xlEOA4g2FS
DAxb+fc7TbHef0wJbhgkdDcaswUxRxhNPE4vyEVQHbtbcp15cXCar53yaMJ1zKse
HQZvEBWHgR09tQoz6MNgb9bibqWGhYQseKacL73Pb6NJScCtqN6I286n/SHnWlWi
NTaXN3sR2k/rzZfKn5HTq4na/YTEdMQD+MoN8du1OJTcqdeKZ5n1jSV2GHM3JrWI
9fyotrQNyi6Qlhaiqs1lWE/SSZ03zbkP/Kz9CPTqFPrVjzqQvpTCXrPMje8a5/ia
Ulx+vcvQlMZOS2OhR3DkqN+7kSE6eQ==
=nx0N
-----END PGP SIGNATURE-----

--1u3OiIJVChW5nBIxb1gbCrznEs9U3YilY--

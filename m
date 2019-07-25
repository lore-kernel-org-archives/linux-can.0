From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
Date: Thu, 25 Jul 2019 09:53:20 +0200
Message-ID: <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xPSNjewHw4fFSUCG4v0BENcXGT8TKyWQ7"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xPSNjewHw4fFSUCG4v0BENcXGT8TKyWQ7
Content-Type: multipart/mixed; boundary="yPKWf4zhXneiJDVSXtVj4rq8kxPXTyKM1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx
 <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>

--yPKWf4zhXneiJDVSXtVj4rq8kxPXTyKM1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/25/19 9:38 AM, Joakim Zhang wrote:
> Kindly pinging...
>=20
> After you git pull request for linux-can-next-for-5.4-20190724, some pa=
tches are missing from linux-can-next/testing.
> can: flexcan: flexcan_mailbox_read() make use of flexcan_write64() to m=
ark the mailbox as read
> can: flexcan: flexcan_irq(): add support for TX mailbox in iflag1
> can: flexcan: flexcan_read_reg_iflag_rx(): optimize reading
> can: flexcan: introduce struct flexcan_priv::tx_mask and make use of it=

> can: flexcan: convert struct flexcan_priv::rx_mask{1,2} to rx_mask
> can: flexcan: remove TX mailbox bit from struct flexcan_priv::rx_mask{1=
,2}
> can: flexcan: rename struct flexcan_priv::reg_imask{1,2}_default to rx_=
mask{1,2}
> can: flexcan: flexcan_irq(): rename variable reg_iflag -> reg_iflag_rx
> can: flexcan: rename macro FLEXCAN_IFLAG_MB() -> FLEXCAN_IFLAG2_MB()
>=20
> You can refer to below link for the reason of adding above patches:
> https://www.spinics.net/lists/linux-can/msg00777.html
> https://www.spinics.net/lists/linux-can/msg01150.html
>=20
> Are you prepared to add back these patches as they are necessary for
> Flexcan CAN FD? And this Flexcan CAN FD patch set is based on these
> patches.

Yes, these patches will be added back.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--yPKWf4zhXneiJDVSXtVj4rq8kxPXTyKM1--

--xPSNjewHw4fFSUCG4v0BENcXGT8TKyWQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl05X/AACgkQWsYho5Hk
nSBjYgf+NBxUeZV5t74xknJvJagaAGreJ1ZK0kLwg8ZeF+F7lvcCoSsJpPoDEO/B
TF6uldvxYENOlpKBi8TzU24LGln1y/AK5fAM8W6AggZQI11jR20mdn8paz/sqAhL
cy3eT4hUC0kBTnCNb6NsNeZtr6DMWH5d43Lnnx6gilwUSUAAZLc4bxrneBNubAuJ
rgIde/dRQen25GNrsbp/8kW25unDgVrG8CskLNwJByWccio8U3rm1ZWFr2jiHuma
T46TH0Q/nBYnO6Uke0/4RCtMbLllSJ+RCq9j7Zr35LxHhoJG//mBXbLhBOb6NzaL
tWVITgtxO+PiTNlPolOPC2VAkbfTxg==
=cF7n
-----END PGP SIGNATURE-----

--xPSNjewHw4fFSUCG4v0BENcXGT8TKyWQ7--

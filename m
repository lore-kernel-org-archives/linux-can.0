From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
Date: Thu, 25 Jul 2019 12:37:05 +0200
Message-ID: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="u4IkX5Ie06c9SrWb94ZE9RBA6IYwhnM6v"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u4IkX5Ie06c9SrWb94ZE9RBA6IYwhnM6v
Content-Type: multipart/mixed; boundary="qGuZIf5lPtITr0mdKMxewU2Toy4gXun4s";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx
 <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <24eb5c67-4692-1002-2468-4ae2e1a6b68b@pengutronix.de>
Subject: Re: [PATCH 0/8] can: flexcan: add CAN FD support for NXP Flexcan
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB461831872271A98E741FF68AE6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>
In-Reply-To: <22ca8787-fa99-50bb-af1a-098866542e42@pengutronix.de>

--qGuZIf5lPtITr0mdKMxewU2Toy4gXun4s
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/25/19 9:53 AM, Marc Kleine-Budde wrote:
> On 7/25/19 9:38 AM, Joakim Zhang wrote:
>> Kindly pinging...
>>
>> After you git pull request for linux-can-next-for-5.4-20190724, some p=
atches are missing from linux-can-next/testing.
>> can: flexcan: flexcan_mailbox_read() make use of flexcan_write64() to =
mark the mailbox as read
>> can: flexcan: flexcan_irq(): add support for TX mailbox in iflag1
>> can: flexcan: flexcan_read_reg_iflag_rx(): optimize reading
>> can: flexcan: introduce struct flexcan_priv::tx_mask and make use of i=
t
>> can: flexcan: convert struct flexcan_priv::rx_mask{1,2} to rx_mask
>> can: flexcan: remove TX mailbox bit from struct flexcan_priv::rx_mask{=
1,2}
>> can: flexcan: rename struct flexcan_priv::reg_imask{1,2}_default to rx=
_mask{1,2}
>> can: flexcan: flexcan_irq(): rename variable reg_iflag -> reg_iflag_rx=

>> can: flexcan: rename macro FLEXCAN_IFLAG_MB() -> FLEXCAN_IFLAG2_MB()
>>
>> You can refer to below link for the reason of adding above patches:
>> https://www.spinics.net/lists/linux-can/msg00777.html
>> https://www.spinics.net/lists/linux-can/msg01150.html
>>
>> Are you prepared to add back these patches as they are necessary for
>> Flexcan CAN FD? And this Flexcan CAN FD patch set is based on these
>> patches.
>=20
> Yes, these patches will be added back.

I've cleaned up the first patch a bit, and pushed everything to the
testing branch. Can you give it a test.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qGuZIf5lPtITr0mdKMxewU2Toy4gXun4s--

--u4IkX5Ie06c9SrWb94ZE9RBA6IYwhnM6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl05hlEACgkQWsYho5Hk
nSAGjQf9Fbu0zJ+edTfTI/tu491WgJu4gVTHHnuVA+RBRWIXDx6mvzsYVr+hnmQd
OEmiuWwTTHMfqt4RQCFLb/RWBNBtva8BwCsAplIZOAx4kV/4Y+ki4ya9yqOu7HLD
QZuZWrUR/zawrhFWLLYzUB9JzeFHDspXa77JM7X5fn8HsqhJh0Lvtmgv3680aDHw
hiXyotE7q86ilP7EMjytSbbJgAjJ6cGpabpFFeGwXaPF2yauRP6gT2Uhanr5CtKU
pQlS6bKMpxoA1KIu18TVtLnneSCAVZI8EZiEwaKXeaoaRVLUxdd8aAKliFP2F735
itt0n9Yl5SFVi6btLkktoZzmtN994Q==
=tDGV
-----END PGP SIGNATURE-----

--u4IkX5Ie06c9SrWb94ZE9RBA6IYwhnM6v--

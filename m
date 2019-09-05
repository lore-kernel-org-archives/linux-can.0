From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
Date: Thu, 5 Sep 2019 17:24:48 +0200
Message-ID: <e54424a8-43b5-fe38-c198-04dee57ebe6c@pengutronix.de>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
 <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <1655f342-7aaf-5e36-d141-d00eee84f3ec@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CbQmkhlHDQDEiZdAbPxF06OJSPxSdFIVR"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1655f342-7aaf-5e36-d141-d00eee84f3ec@geanix.com>
Sender: netdev-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CbQmkhlHDQDEiZdAbPxF06OJSPxSdFIVR
Content-Type: multipart/mixed; boundary="NiynG8ateyLtrlKsX9HzKiq37c0eyguvU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, =?UTF-8?Q?Martin_Hundeb=c3=b8ll?=
 <martin@geanix.com>
Message-ID: <e54424a8-43b5-fe38-c198-04dee57ebe6c@pengutronix.de>
Subject: Re: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
 <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <1655f342-7aaf-5e36-d141-d00eee84f3ec@geanix.com>
In-Reply-To: <1655f342-7aaf-5e36-d141-d00eee84f3ec@geanix.com>

--NiynG8ateyLtrlKsX9HzKiq37c0eyguvU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/5/19 3:17 PM, Sean Nyekjaer wrote:
>=20
>=20
> On 05/09/2019 09.10, Joakim Zhang wrote:
>> Hi Sean,
>>
>> Could you update lastest flexcan driver using linux-can-next/flexcan a=
nd then merge below two patches from linux-can/testing?
>> d0b53616716e (HEAD -> testing, origin/testing) can: flexcan: add LPSR =
mode support for i.MX7D
>> 803eb6bad65b can: flexcan: fix deadlock when using self wakeup
>>
>> Best Regards,
>> Joakim Zhang
>=20
> The testing branch have some UBI bugs, when suspending it crashes...
> So will have to leave this, until they are resolved :-)

For what it's worth, I've rebased the testing branch to the latest
net/master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NiynG8ateyLtrlKsX9HzKiq37c0eyguvU--

--CbQmkhlHDQDEiZdAbPxF06OJSPxSdFIVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1xKMAACgkQWsYho5Hk
nSBfrgf8DwKoZ9jxmJhkx8Ijx6uORYex6O/JWQjwI59tQi/YWGCVAk237FFNiMSI
GJGNqhk1IbF+agCcLkDSLZA8RMsysQ7x1nS37vfPCOwMmugolR0e6YGHwzM/P0mK
6Ed/l+TWlzrEFTZ649WdkbFjoHNhIIwvcgPwSRo1rCTr8VUiG4s3tKpqii7mEQp7
5j/W3OzZVR0orLOSfEBpQIlr12tZeMcmvrnXsUiEqFPSCtYhQ9sXYMsW5W1tcESt
wjm/D0fDGntc2v5slVNloWFRzHMksyK4+kewecX0ULfA8629122GD00IVwkQ8zAt
nJQW+fwpHYVtFPWNPTFpF+EQqbv8qw==
=RoRe
-----END PGP SIGNATURE-----

--CbQmkhlHDQDEiZdAbPxF06OJSPxSdFIVR--

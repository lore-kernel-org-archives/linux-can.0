From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Date: Thu, 22 Nov 2018 12:07:14 +0100
Message-ID: <c5a6da81-74d1-b336-8ad7-60050496ae22@pengutronix.de>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
 <AM0PR04MB4211E93B707BEBADD5E5B63E80DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ERpgqWgxr5VJrbcpFct8L5phrDYn1I1t7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4211E93B707BEBADD5E5B63E80DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERpgqWgxr5VJrbcpFct8L5phrDYn1I1t7
Content-Type: multipart/mixed; boundary="SZWQNOERS4WQ2YBukapsjK00Qji2kUZFi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Aisheng DONG <aisheng.dong@nxp.com>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <c5a6da81-74d1-b336-8ad7-60050496ae22@pengutronix.de>
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
 <AM0PR04MB4211E93B707BEBADD5E5B63E80DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211E93B707BEBADD5E5B63E80DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>

--SZWQNOERS4WQ2YBukapsjK00Qji2kUZFi
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/22/18 12:01 PM, Aisheng DONG wrote:
> [...]
>>>> @@
>>>> -1437,10 +1552,18 @@ static int __maybe_unused flexcan_suspend(struc=
t
>>>> device *device)
>>>>  	int err =3D 0;
>>>>
>>>>  	if (netif_running(dev)) {
>>>> -		err =3D flexcan_chip_disable(priv);
>>>> -		if (err)
>>>> -			return err;
>>>> -		err =3D pm_runtime_force_suspend(device);
>>>> +		/* if wakeup is enabled, enter stop mode
>>>> +		 * else enter disabled mode.
>>>> +		 */
>>>> +		if (device_may_wakeup(device)) {
>>>> +			enable_irq_wake(dev->irq);
>>>> +			flexcan_enter_stop_mode(priv);
>>>> +		} else {
>>>> +			err =3D flexcan_chip_disable(priv);
>>>> +			if (err)
>>>> +				return err;
>>>> +			err =3D pm_runtime_force_suspend(device);
>>>
>>> This is mixed with runtime pm.
>>> I would suggestion you first upstream wakeup support.
>>> Then runtime pm later separately.
>>
>> In fact this patch is based on the patch "can: flexcan: Implement CAN =
Runtime
>> PM", which is still under review, too.
>=20
> Yes, please ignore rpm patch first.
> This patch will be re-made and not depends on rpm for easy review.
> After wakeup is ready, rpm patch will rebase on it.

ok.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SZWQNOERS4WQ2YBukapsjK00Qji2kUZFi--

--ERpgqWgxr5VJrbcpFct8L5phrDYn1I1t7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv2jeIACgkQk9IU1zQo
ZfG6CwgAk/KEnW95PtS6qzdZj9BVGHNpacvvRgeKAj1FzxW7pgRTw4iw2ucwQ/cL
xIcGufK68ZfonoSXVn1Fz1209yfobVbWhh5o0PYwMdnZcrpSSdC3PNmhACy5Rvin
hhi61uuGVgmOcoruwAeiuZCRxekOXl0QVIoZIFVrUgmT4lHvo/QmnwGnpA+Erykv
ROW/t6o8jbfUX7TtBJxG48cri2DXvRKE8acX6OJM1RnIt8HJ5gpo0SG5LoOrQhIz
4wnWhmmELhvScyn1iPKUMFoX+ZFOez7Dw3C165IIPaQozr3pjqhMjv8LaSELOhI4
G17cYTkQGUMznRivDHR6Monc6j2Lng==
=M2RZ
-----END PGP SIGNATURE-----

--ERpgqWgxr5VJrbcpFct8L5phrDYn1I1t7--

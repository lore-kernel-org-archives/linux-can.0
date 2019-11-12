From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
Date: Tue, 12 Nov 2019 21:10:50 +0100
Message-ID: <70a410f6-d57b-7586-b645-35d97680ac0b@pengutronix.de>
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
 <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
 <20191112114539.zjluqnpo3cynhssi@pengutronix.de>
 <5e561756-26b4-9a71-8fe2-c876e0e7d1af@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eMNh1igYGG4bzUYbu2KYGP7gB78exY0oT"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <5e561756-26b4-9a71-8fe2-c876e0e7d1af@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eMNh1igYGG4bzUYbu2KYGP7gB78exY0oT
Content-Type: multipart/mixed; boundary="CvSg4F7QtbR3ei47g1qefK1E9FliPeTyP";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 dev.kurt@vandijck-laurijssen.be, wg@grandegger.com, netdev@vger.kernel.org,
 kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <70a410f6-d57b-7586-b645-35d97680ac0b@pengutronix.de>
Subject: Re: [PATCH v1 1/9] can: af_can: export can_sock_destruct()
References: <20191112111600.18719-1-o.rempel@pengutronix.de>
 <20191112111600.18719-2-o.rempel@pengutronix.de>
 <20191112113724.pff6atmyii5ri4my@pengutronix.de>
 <1da06748-6233-b65e-9b02-da5a867a4ecb@pengutronix.de>
 <20191112114539.zjluqnpo3cynhssi@pengutronix.de>
 <5e561756-26b4-9a71-8fe2-c876e0e7d1af@hartkopp.net>
In-Reply-To: <5e561756-26b4-9a71-8fe2-c876e0e7d1af@hartkopp.net>

--CvSg4F7QtbR3ei47g1qefK1E9FliPeTyP
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/12/19 7:24 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 12/11/2019 12.45, Uwe Kleine-K=C3=B6nig wrote:
>> Hello Marc,
>>
>> On Tue, Nov 12, 2019 at 12:39:27PM +0100, Marc Kleine-Budde wrote:
>>> On 11/12/19 12:37 PM, Uwe Kleine-K=C3=B6nig wrote:
>>>> On Tue, Nov 12, 2019 at 12:15:52PM +0100, Oleksij Rempel wrote:
>>>>> +EXPORT_SYMBOL(can_sock_destruct);
>>>>
>>>> If the users are only expected to be another can module, it might ma=
ke
>>>> sense to use a namespace here?!
>>>
>>> How?
>>
>> Use
>>
>> 	EXPORT_SYMBOL_NS(can_sock_destruct, CAN)
>>
>> instead of the plain EXPORT_SYMBOL, and near the declaration of
>> can_sock_destruct or in the source that makes use of the symbol add:
>>
>> 	MODULE_IMPORT_NS(CAN);
>>
>> See https://lwn.net/Articles/760045/ for some details.
>=20
> Looks nice! Good idea!
>=20
> But I would tend to introduce the symbol namespaces for this and the=20
> other (existing) symbols via can-next and not within this patch set tha=
t=20
> addresses the j1939 fixes.

So I should take this series as is?

And the CAN namespace is introduced later?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--CvSg4F7QtbR3ei47g1qefK1E9FliPeTyP--

--eMNh1igYGG4bzUYbu2KYGP7gB78exY0oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3LEcsACgkQWsYho5Hk
nSBWKQgAlpFLnk1A4pZ8fJOB6EwY8rRPzA7ZllnjJa6ziGM0/6pUyHsgs8ap9nNM
8WcdGEYo/Os6sEO6Cg0X1AhTtDHlQwA3Sn2lQ2Mi8wZ2AAHoljhHK4bKOlDjTK5R
UAFZEgv4ey3nIgXayFK6QL5JPQ3BPkrftwXtgCu8wmw8OBUtg2bl7mcYUiaxKhom
Fv0SupnrUv69pB+MLfugrnAFpbXTnceSBZX07TiOT+/cVM4IFYXv+0x/L909vEnL
vBcy0T0iHmtU5cRCmMXNh6f+Jkvaw60QADdTSMr2B8Q5CQ3uecKFjf3q+XF8T2OM
e14Xk8KpoWrKvC8x4m57Ir0Mn25kQg==
=hXkj
-----END PGP SIGNATURE-----

--eMNh1igYGG4bzUYbu2KYGP7gB78exY0oT--

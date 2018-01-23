From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939 ACL
Date: Tue, 23 Jan 2018 16:31:10 +0100
Message-ID: <64857fdf-04a2-06fb-41b5-47f00cbd6773@pengutronix.de>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
 <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
 <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
 <20180122182641.GB1943@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="T4S1EnObIIaUpHmkOh57I7pQmUnffK04b"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49895 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeAWQpE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jan 2018 11:45:04 -0500
In-Reply-To: <20180122182641.GB1943@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>, Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T4S1EnObIIaUpHmkOh57I7pQmUnffK04b
Content-Type: multipart/mixed; boundary="9jplsjbg1QtU4HawPyB0QACW6Wl9M2MKZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?R=c3=a9my_Dziemiaszko?= <remy.dziemiaszko@smile.fr>,
 Oleksij Rempel <ore@pengutronix.de>, linux-can@vger.kernel.org
Message-ID: <64857fdf-04a2-06fb-41b5-47f00cbd6773@pengutronix.de>
Subject: Re: j1939 ACL
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <53295b55-bf98-4a59-08d2-ce19516e9084@smile.fr>
 <dee45c8c-6816-aa18-4fde-fd5f2239c62d@pengutronix.de>
 <20180120212809.GB3515@airbook.vandijck-laurijssen.be>
 <239f9ce7-9a1d-1907-e714-c6a9cade80fe@pengutronix.de>
 <20180122182641.GB1943@airbook.vandijck-laurijssen.be>
In-Reply-To: <20180122182641.GB1943@airbook.vandijck-laurijssen.be>

--9jplsjbg1QtU4HawPyB0QACW6Wl9M2MKZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 07:26 PM, Kurt Van Dijck wrote:
>> On 01/20/2018 10:28 PM, Kurt Van Dijck wrote:
>>>> after playing with jacd i have a bit more questions:
>>>> - do any one already using kernel j1939? any suggestions or request =
for
>>>> changes?
>>>
>>> A linux 3.10 version runs in production. Since then, a few changes we=
re
>>> requested and implemented.
>>> Recently, the stack had some serious retesting, you will find the
>>> latest state in my github (only a few minor commits from Marc's
>>> version).
>>
>> Oleksij and Basti are now working on the j1939 kernel and userspace. I=
'd
>> like to have top of development on the linux-can-next/j1939 branch.
>> Which branch in your linux repo is the newest one?
>=20
> can-next-j1939
>=20
> It builds upon your can-next/j1939, so I invested into that.

I've collected all patches up to

> a9ca675d555d (people/kurt-vd/can-next-j1939) can-j1939: fix foreign tra=
nsport protocol sessions

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9jplsjbg1QtU4HawPyB0QACW6Wl9M2MKZ--

--T4S1EnObIIaUpHmkOh57I7pQmUnffK04b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpnVT4ACgkQHv7KIOw4
HPaq3AgA0nwHfPMmz959JJ3EzYv/O+QIxNoVecGct9PvHavrELwQwF840T0ivmq9
gIDe1aBxmMJ4ZNS2wr89UmFXFUF28IiyVdHVoFymUO3IwgLRFxtrjVux/xSXnQLl
3KXeVe5l1mXSXvoKd7lVmIAFGXrHeKa7E27Q1Jpar0qqtUU2SHql4cq0mzWWLQg8
OI4orp41XxFyHV7h9f8xhfdQ5aT1N6NaJIgOTL0jxd3kuVoDflLgSageIKbms18C
kODf1fRbuXy4hRxRuthP2/+qQ5Bx1RrEUIIOE4j4AmiVU9oFdWp+0/L0abEoiOCv
r8fxJehYOqLcq3sD2o+uyAXtZPKEMw==
=0x9p
-----END PGP SIGNATURE-----

--T4S1EnObIIaUpHmkOh57I7pQmUnffK04b--

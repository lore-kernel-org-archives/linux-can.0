From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 13:10:04 +0100
Message-ID: <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
 <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
 <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XxAOnP1qt2uP2wrNijAFq0J5yPApjsWqp"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XxAOnP1qt2uP2wrNijAFq0J5yPApjsWqp
Content-Type: multipart/mixed; boundary="lWn3h5s88mOdAmgNIGfSemHhAfY5opEXT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
 <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
 <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
In-Reply-To: <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>

--lWn3h5s88mOdAmgNIGfSemHhAfY5opEXT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/11/19 12:28 PM, Sean Nyekjaer wrote:
> On 11/12/2019 10.44, Marc Kleine-Budde wrote:
>> On 12/11/19 10:13 AM, Sean Nyekjaer wrote:
>>>>> When the tcan device comes out of reset it comes out in standby mod=
e.
>>>>> The m_can driver tries to access the control register but fails due=
 to
>>>>> the device is in standby mode.
>>>>> So this patch will put the tcan device in normal mode before the m_=
can
>>>>> driver does the initialization.
>>>>>
>>>>> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before parsi=
ng the config")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>
>>>> Applied both to linux-can.
>>>
>>> Oh, the commit id for "can: tcan4x5x: Turn on the power before parsin=
g
>>> the config" have changed, since this morning :)
>>
>> Ahh, I see.
>>
>> Until there is a pull request (including a tag) the testing branch is
>> subject to rebase. Meaning, when there is a patch, that needs update I=
'm
>> happy to squash things into it.
>>
>> I'm squashing there two commits into one:
>=20
> It's two different authors :-)

No problem with me. I don't want to have a known broken patch in one
pull request that gets fixed by another patch in that pull request.

So we have to sort this out. :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--lWn3h5s88mOdAmgNIGfSemHhAfY5opEXT--

--XxAOnP1qt2uP2wrNijAFq0J5yPApjsWqp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3w3JwACgkQWsYho5Hk
nSDPGgf/UmqXKjwHmO8s3BLkZLhLkBYhuAgk+koBMIQBoc2HzujiT9ga6srvrYo2
ch4GNT1YwZIXsWFmo5o4XZtsd7rmYL/qK/M2GGbXI+nj/MCBxLQ4cruo36Aa6aWp
nowqvt24mBUjPWR+TnNVrd2YavSHijp/jDbXqJR17ixyam47hlF79L/cMvG3R2ld
vaKf6F+D7BQ1QkDe9vsk7UO8dOoCr3crpMixn4mbRiUz3rpLhpDYi8YxD1e0vptP
CFZ4dZeOoPm4JPVUrIvb1lj16z/m+NJBx9wunW2yXDBHXk6aLZ1yPiMOQw9kuT51
daHvdSl2uPJmOIxL2GOIt4C+CmHXMg==
=Fws0
-----END PGP SIGNATURE-----

--XxAOnP1qt2uP2wrNijAFq0J5yPApjsWqp--

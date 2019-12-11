From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Wed, 11 Dec 2019 13:35:26 +0100
Message-ID: <88802f23-b1a6-304b-e938-df9891b0962c@pengutronix.de>
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
 <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
 <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
 <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
 <56a20412-088c-de3e-0238-9648ed2a44c7@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OvHG6pYNrda1hx40XzE2f0TBIoG9mYJWD"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <56a20412-088c-de3e-0238-9648ed2a44c7@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OvHG6pYNrda1hx40XzE2f0TBIoG9mYJWD
Content-Type: multipart/mixed; boundary="x8Xb8bvOlbKeYVKku0HtzfQcfTnGzSuAX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, dmurphy@ti.com, linux-can@vger.kernel.org
Cc: martin@geanix.com, stable@vger.kernel.org
Message-ID: <88802f23-b1a6-304b-e938-df9891b0962c@pengutronix.de>
Subject: Re: [PATCH v3 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191211064208.84656-1-sean@geanix.com>
 <8b1682ad-c291-252e-c768-63a7a4801aff@pengutronix.de>
 <bc0014ec-7302-97f4-5d71-8d029b0fb1fb@geanix.com>
 <41d13619-fab8-ca19-c340-c80cd80d117e@pengutronix.de>
 <ae996f9a-e50d-8f31-7457-c7fb461f5c9e@geanix.com>
 <614104a2-b667-62aa-4e1d-abcef89a257e@pengutronix.de>
 <56a20412-088c-de3e-0238-9648ed2a44c7@geanix.com>
In-Reply-To: <56a20412-088c-de3e-0238-9648ed2a44c7@geanix.com>

--x8Xb8bvOlbKeYVKku0HtzfQcfTnGzSuAX
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/11/19 1:15 PM, Sean Nyekjaer wrote:
>=20
>=20
> On 11/12/2019 13.10, Marc Kleine-Budde wrote:
>> On 12/11/19 12:28 PM, Sean Nyekjaer wrote:
>>> On 11/12/2019 10.44, Marc Kleine-Budde wrote:
>>>> On 12/11/19 10:13 AM, Sean Nyekjaer wrote:
>>>>>>> When the tcan device comes out of reset it comes out in standby m=
ode.
>>>>>>> The m_can driver tries to access the control register but fails d=
ue to
>>>>>>> the device is in standby mode.
>>>>>>> So this patch will put the tcan device in normal mode before the =
m_can
>>>>>>> driver does the initialization.
>>>>>>>
>>>>>>> Fixes: a229abeed7f7 ("can: tcan4x5x: Turn on the power before par=
sing the config")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>>
>>>>>> Applied both to linux-can.
>>>>>
>>>>> Oh, the commit id for "can: tcan4x5x: Turn on the power before pars=
ing
>>>>> the config" have changed, since this morning :)
>>>>
>>>> Ahh, I see.
>>>>
>>>> Until there is a pull request (including a tag) the testing branch i=
s
>>>> subject to rebase. Meaning, when there is a patch, that needs update=
 I'm
>>>> happy to squash things into it.
>>>>
>>>> I'm squashing there two commits into one:
>>>
>>> It's two different authors :-)
>>
>> No problem with me. I don't want to have a known broken patch in one
>> pull request that gets fixed by another patch in that pull request.
>=20
> No problem with me, either.
> But it's not exactly the same problem they are fixing. They can exist=20
> separately.
>=20
> Just do a you find best...

If they do different things, you don't need a fixed tag from one to the
other...

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--x8Xb8bvOlbKeYVKku0HtzfQcfTnGzSuAX--

--OvHG6pYNrda1hx40XzE2f0TBIoG9mYJWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3w4o4ACgkQWsYho5Hk
nSDt7wf/RdKW5tPiPUBY0gk/or+OgTuFahVmItZ2IBxaKZaW6m+gCNRZ6sU68J7r
NNmyegP+dLDrZupGRfzZLJfeLsFxac29kT0ngKPeuLjiWvtuxXRmThQOlCqBbTcN
E8+K87ae7DWFfGkcZYbG4C4gt6KlZfXZiOKcWXHQb2XZj/sblDnlc4mOE6+olDDe
UgwfZKM8cS0WlpIXcchYh52J8Vt5xkyCtFY9WLSfwby/kXDycjV27EzJYqa8tLH4
UEFtXZSQ8DrI0vIIdaVNqE2tj/QkJlxwPqAtrmTTG5oHpbb6VNt5HqggkF+eQzSK
y/33v0xPUu8059tVyeav5ciB1WBXmQ==
=6LmH
-----END PGP SIGNATURE-----

--OvHG6pYNrda1hx40XzE2f0TBIoG9mYJWD--

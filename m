From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Fri, 22 Mar 2019 08:51:00 +0100
Message-ID: <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
 <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
Sender: netdev-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK
Content-Type: multipart/mixed; boundary="RwniMHbQrYgPxVol7aNT12neuXKAdjjzW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>,
 Per Christensen <pnc@deif.com>, Rasmus Villemoes
 <Rasmus.Villemoes@prevas.se>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Joakim Zhang <qiangqing.zhang@nxp.com>
Message-ID: <b03e9868-3070-ce35-3477-3119d691baec@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
 <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
 <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>
In-Reply-To: <4471c611-1a58-6365-2ab6-1b39c310265a@prevas.dk>

--RwniMHbQrYgPxVol7aNT12neuXKAdjjzW
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/22/19 8:45 AM, Rasmus Villemoes wrote:
> On 21/03/2019 16.30, Marc Kleine-Budde wrote:
>> On 3/21/19 3:34 PM, Rasmus Villemoes wrote:
>>> On 20/03/2019 14.18, Marc Kleine-Budde wrote:
>>>> On 3/7/19 4:00 PM, Rasmus Villemoes wrote:
>>>>> While trying to add support for the Flexcan modules on the MPC8309,=

>>>>> I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing=

>>>>> succeeds. Checking the leftover value of timeout with a primitive
>>>>>
>>>>>   pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);
>>>>>
>>>>> after the loop in chip_disable() typically shows values around 12-1=
4,
>>>>> i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit =
to
>>>>> appear. So a timeout value of about twice that seems reasonable.
>>>>>
>>>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>>
>>>> I've scheduled the patch by Joakim Zhang:
>>>>
>>>>     9daed89ae8a3 can: flexcan: fix timeout when set small bitrate
>>>>
>>>> that doubles the timeout to 100.
>>>
>>> Eh, ok, but that's not sufficient for the MPC8309 (I tried with 100 a=
t
>>> first, but as I write the minimally working timeout value turns out t=
o
>>> be about 140 us). Do you want me to send another patch on top of
>>> 9daed89ae8a3, or how should I interpret the above?
>>
>> Can you propose an updated commit message for Joakim Zhang's patch?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/comm=
it/?h=3Dtesting&id=3D9daed89ae8a3fc44ccd2b2bb9c3c4d3e3431904d
>>
>> I'll add it by hand and increase the timeout to 250. Ok?
>=20
> Sounds fine. In order not to change Joakim's commit log too much, how
> about adding something like (with your initials, since you're next in
> the sign-off chain)
>=20
> [mkl: Meanwhile, Rasmus Villemoes reported that even with a timeout of
> 100, flexcan_probe() fails on the MPC8309, which requires a value of at=

> least 140 to work reliably. 250 works for everyone.]
>=20
> ? Feel free to edit as you wish.

Thanks, I've added that to the commit message itself.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RwniMHbQrYgPxVol7aNT12neuXKAdjjzW--

--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyUk+QACgkQWsYho5Hk
nSAZBwf7BimsXBy5ZlVJP1bOHtZNEER7vpkKWD9FhECKnjeSGPKIv+PkAtScvWLX
w6U5UoJhdYkzrae+l1oP+PL9vbENNbJYaRumN89tq3OiBh+FNE14Wrt0ho79Hb9f
vzJa8OBKvt3sXM/mRzGyB08KzQ3raFRStqqWXiDd8tfh/uJi4VK6zJoTmbPK+30T
aBv6Q6CsDdYFcLzSn/bTMLM4zk+ET51TTHJPuPO5O+LO9WoQTQw1ZZ8qiaRhpt0D
NHTd6TFEZMwrD2Ic3tBaQa/TMGonqp2MvXp39PGjBqptDes4wOvcmGUU51HBSt40
pQ7xC+VV6W9mA8PeV8M/BVDLRSG+IQ==
=iFJD
-----END PGP SIGNATURE-----

--QbbbVd1nuxKJvHpv6YDGgJ6Eaco6CAzRK--

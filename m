From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
Date: Thu, 21 Mar 2019 16:30:37 +0100
Message-ID: <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="A0JHEiJgA7f8hvvZlVWbFa4NmbS232yde"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>
Cc: Thomas Winding <twi@deif.com>, Fabio Estevam <festevam@gmail.com>, Per Christensen <pnc@deif.com>, Rasmus Villemoes <Rasmus.Villemoes@prevas.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A0JHEiJgA7f8hvvZlVWbFa4NmbS232yde
Content-Type: multipart/mixed; boundary="NnJOsYLj5AWFAQQfbpal3lUh3LwexUhiQ";
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <f1fb86fb-1b6b-1860-899d-820d4bc672cf@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: bump FLEXCAN_TIMEOUT_US to 250
References: <20190307150024.23628-1-rasmus.villemoes@prevas.dk>
 <a418bbc9-186c-174a-20d8-18cedeaf0089@pengutronix.de>
 <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>
In-Reply-To: <5615c217-8ba6-e452-1aaa-1e3b32eb4cca@prevas.dk>

--NnJOsYLj5AWFAQQfbpal3lUh3LwexUhiQ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 3/21/19 3:34 PM, Rasmus Villemoes wrote:
> On 20/03/2019 14.18, Marc Kleine-Budde wrote:
>> On 3/7/19 4:00 PM, Rasmus Villemoes wrote:
>>> While trying to add support for the Flexcan modules on the MPC8309,
>>> I'm hitting ETIMEDOUT in flexcan_chip_disable(). With this, probing
>>> succeeds. Checking the leftover value of timeout with a primitive
>>>
>>>   pr_err("%s: timeout=3D=3D%d\n", __func__, timeout);
>>>
>>> after the loop in chip_disable() typically shows values around 12-14,=

>>> i.e. suggesting that it takes about 110-130 us for the LPM_ACK bit to=

>>> appear. So a timeout value of about twice that seems reasonable.
>>>
>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>
>> I've scheduled the patch by Joakim Zhang:
>>
>>     9daed89ae8a3 can: flexcan: fix timeout when set small bitrate
>>
>> that doubles the timeout to 100.
>=20
> Eh, ok, but that's not sufficient for the MPC8309 (I tried with 100 at
> first, but as I write the minimally working timeout value turns out to
> be about 140 us). Do you want me to send another patch on top of
> 9daed89ae8a3, or how should I interpret the above?

Can you propose an updated commit message for Joakim Zhang's patch?

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/commit/=
?h=3Dtesting&id=3D9daed89ae8a3fc44ccd2b2bb9c3c4d3e3431904d

I'll add it by hand and increase the timeout to 250. Ok?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--NnJOsYLj5AWFAQQfbpal3lUh3LwexUhiQ--

--A0JHEiJgA7f8hvvZlVWbFa4NmbS232yde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlyTriAACgkQWsYho5Hk
nSBZLwf/UpYs0SlA3EuG6By7y8W8wQ9KCp0Q5KRrazA1iXrY/T0wsY6hJaHdi+rb
VCrJ8h+DprrbRSvEaHNUo6LHNBhcvnYkf+65k99qlCTh5l9P7S/bN54cq5esFcIt
Z/RIdqJRgw2qZhk8YHqoYAdne7EPvGKwr45lc//cG+T8Vf0tARo4aKOUeK/8kO34
IuZ88BXZOUMuUShTltwSRJMRwW+Rkc+ch4EA8S1NffD/+6eEk5+29sXaRtVg7JSn
SfGYmLnKsJDzMXYmJatUWVnX1WsKLL255LXCT6PmR4dTdKj10WV5BmmDtaoaGHkZ
hwGqp3Jp7TTm4hIw7Mma3J/7BzfZIA==
=PyGM
-----END PGP SIGNATURE-----

--A0JHEiJgA7f8hvvZlVWbFa4NmbS232yde--

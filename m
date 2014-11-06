From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 02/14] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Thu, 06 Nov 2014 17:05:18 +0100
Message-ID: <545B9C3E.1010002@pengutronix.de>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>	<1415262853-22907-3-git-send-email-david@protonic.nl>	<545B3457.9030207@pengutronix.de> <20141106170330.54b6ed7e@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fdqTSrc1QI49KvRo3RkL3idJNi0kQaOe9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59639 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKFQF2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 11:05:28 -0500
In-Reply-To: <20141106170330.54b6ed7e@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fdqTSrc1QI49KvRo3RkL3idJNi0kQaOe9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2014 05:03 PM, David Jander wrote:
> On Thu, 06 Nov 2014 09:41:59 +0100
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 11/06/2014 09:34 AM, David Jander wrote:
>>> Signed-off-by: David Jander <david@protonic.nl>
>>> ---
>>>  drivers/net/can/dev.c   | 24 ++++++++++++------------
>>>  include/linux/can/dev.h | 12 ++++++------
>>>  2 files changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index c1e53e9..930b9f4 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -289,20 +289,20 @@ static unsigned int can_rx_fifo_inc(struct
>>> can_rx_fifo *fifo, unsigned int *val) return (*val)--;
>>>  }
>>> =20
>>> -static u32 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
>>> +static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
>>>  {
>>>  	if (fifo->inc)
>>> -		return ~0U >> (32 + fifo->low_first - fifo->high_first)
>>> << fifo->low_first;
>>> +		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
>>> << fifo->low_first; else
>>> -		return ~0U >> (32 - fifo->low_first + fifo->high_first)
>>> << (fifo->high_first + 1);
>>> +		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
>>> << (fifo->high_first + 1);
>>
>> Yesterday I stumbled over GENMASK_ULL
>> http://lxr.free-electrons.com/source/include/linux/bitops.h#L22
>> Does it make sense to use it here?
>=20
> Looks like its exactly what is needed here.... nice.
>=20
> Btw, there is a subtle bug in the line you linked to:
>=20
>> #define GENMASK_ULL(h, l)       (((U64_C(1) << ((h) - (l) + 1)) - 1) <=
< (l))
>=20
> The _ULL in the name of the macro seems to hint to "unsigned long long"=
, while
> the implementation seems to assume that it means U64_C. This is obvious=
ly
> wrong, although for most platforms that are currently capable of runnin=
g
> Linux, those are probably equivalent...

#define U64_C(x) x ## ULL

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fdqTSrc1QI49KvRo3RkL3idJNi0kQaOe9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW5w+AAoJECte4hHFiupU9/gP/0GOwZNddp3IX/P2YPjJghi0
TYJtje3azornGEUPcMmDoVZJHElyuCNRPr2PlrI7hmop9dp/syorRsugzHEqj9ET
mvy1HPBj77JzKxI73yCQAM89Ma6Q/cJwPuJojVPXHX7umOEPnFLYGGTioCfbye3X
OvDZO8gahxr8Ft26XN52aaKAHL3IOa1Y7Q+27FByQ+GuzfJcwbJopKjj7lBEHGLc
t84LGf6F0DIzABsSHFApeFsMOYHYbBeIXT9LNy+H45VIQay2SlCLlI13Eqa2mi5t
+fKlZBFEAqtr5HS44mZGJz1AcIevWeP8hlDVqV0mKSUW/uVulifCnFtcndVpD9eb
GbbqiV0rjp7LXY0JEbc7PyuVRbNlhZ0v6R/XIo2z+mM+mqCMQ6iDhstIrtPMV1Lh
jPA4D3ov6ez65narQBf3vsxyWkhxDQJLcyiBBK4P1NMR8R8i+Oyq2izYQjvWZS9z
9srlyyDUZvoVoMQ+7JdbfnNAGzH9cq6NAClTKZ2mMuUw4ISotr+UvAeDcXmjzcKg
hZSKbEQqPp7I8/iOMmPBdCzWMzBcGi9P/nTLtwM/RWr6jtyOwVyyQet6AA97sFhm
I9yoP/eg9mYDkk2015n0WLc46nQTQgZ5ZqGTx7p5IgVHd+Y8zSKGTkFDaQCZjO0w
LjxH/FgLmTSF4xrUTh3o
=o0zo
-----END PGP SIGNATURE-----

--fdqTSrc1QI49KvRo3RkL3idJNi0kQaOe9--

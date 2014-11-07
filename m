From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 02/14] can: rx-fifo: Increase MB size limit from 32 to
 64
Date: Fri, 07 Nov 2014 09:40:36 +0100
Message-ID: <545C8584.8000104@pengutronix.de>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>	<1415262853-22907-3-git-send-email-david@protonic.nl>	<545B3457.9030207@pengutronix.de>	<20141106170330.54b6ed7e@archvile>	<545B9C3E.1010002@pengutronix.de> <20141106172052.6299c1d1@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="buNLMpRfKVP1Ksxb4xjBJ3nTlBoN4ICei"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51185 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaKGIks (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Nov 2014 03:40:48 -0500
In-Reply-To: <20141106172052.6299c1d1@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--buNLMpRfKVP1Ksxb4xjBJ3nTlBoN4ICei
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2014 05:20 PM, David Jander wrote:
>>> Btw, there is a subtle bug in the line you linked to:
>>>
>>>> #define GENMASK_ULL(h, l)       (((U64_C(1) << ((h) - (l) + 1)) - 1)=
 <<
>>>> (l))
>>>
>>> The _ULL in the name of the macro seems to hint to "unsigned long lon=
g",
>>> while the implementation seems to assume that it means U64_C. This is=

>>> obviously wrong, although for most platforms that are currently capab=
le of
>>> running Linux, those are probably equivalent...
>>
>> #define U64_C(x) x ## ULL
>=20
> This line:
>=20
> http://lxr.free-electrons.com/source/include/asm-generic/int-ll64.h#L4
>=20
> ...seems to indicate, that it may not always be the case :-)
> AFAIK, C99 specifies that "long long" should at _least_ have 64 bit len=
gth,
> but says nothing about when it may be larger.
> OTOH, I have yet to find a machine/compiler combination that defines "l=
ong
> long" as more than 64bit... at least not running Linux.
> A correct definition should be trivial though:
>=20
> #define GENMASK_ULL(h, l)       (((1ULL << ((h) - (l) + 1)) - 1) << (l)=
)

That's what it does:

$ cat << EOF | gcc -xc -E -
#define U64_C(x) x ## ULL
#define GENMASK_ULL(h, l)   (((U64_C(1) << ((h) - (l) + 1)) - 1) << (l))
GENMASK_ULL(foo, bar)
EOF

Results in:
(((1ULL << ((foo) - (bar) + 1)) - 1) << (bar))

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--buNLMpRfKVP1Ksxb4xjBJ3nTlBoN4ICei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXIWEAAoJECte4hHFiupU9mAQAI65oEBTlLCOGO9xUo7wxHMe
6K+LvDzLyFkyQ6SA5qynsrs9awWiipQsztEXmQZU7zy9APf99uZnxH9CmdGQIYgw
JgfhTYsds0W0d0AArl6rpV1CvCrKkTX36L6R/Em2UAu8ffIP6h8JK0rcxNHKPkOF
ai+r+H2WkUcOvILt6qjBuqfTtnnaJumhXQ0+PBEDgBvqUs7viatoUIsFLWjZ8XCH
PSGcYvHkoFLKTaOYtKJfmmZXwejDQU3fHcw77XpdUB2Kx8jhsYDnY4xQ4CoC6Mqq
lCyxYt7HFLXXKlVfLgZCWJO7KoiOFyBZeLK42yqg1nz8OcJNyRxvhouxlZ0xOvds
kF9Ecuu9Pz6JgGyaQn+dSUtW2tAv0t/iFKMmv9MWEK6KYKWtmdmAdJ6MAczJwDER
zwwcqORd7mtKYX2cXtsnhziq1bGZ7EyWpqQajpGbOzALiatDEPbHLkwMSnSju4PF
t99Hc7sZP6znkTT70cqvF1O82FP4BP9QyMOBOixIy3vvdzhUeTJea+/99bqBELph
4dvPDh6pg0pXZl7jW7Shxz2oG0BkMxXK3Hgj8HgVhvLL8Ag28V2auswIrxCqpV2x
YCV0VaED5SGt5vh88sMGCf0v66uciFFRuQlXJ06YR3+de+M8rEsH/r2I9GtdQvhW
51yAMkwNvj6uDz9bnAVJ
=OBuR
-----END PGP SIGNATURE-----

--buNLMpRfKVP1Ksxb4xjBJ3nTlBoN4ICei--

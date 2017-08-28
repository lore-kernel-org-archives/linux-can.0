From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 06/14] can: af_can: rename find_rcv_list() to
 can_rcv_list_find()
Date: Mon, 28 Aug 2017 13:53:49 +0200
Message-ID: <e7a9a4ba-413a-406e-7f9a-c781f9b669d5@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-7-mkl@pengutronix.de>
 <068ceb4d-7a02-9a8a-2e1a-c4a2782310ca@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="akqbjdDACXDGNccBWF7Uw1WWIS17pM1iJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44023 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750866AbdH1Lxy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Aug 2017 07:53:54 -0400
In-Reply-To: <068ceb4d-7a02-9a8a-2e1a-c4a2782310ca@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--akqbjdDACXDGNccBWF7Uw1WWIS17pM1iJ
Content-Type: multipart/mixed; boundary="BgIXnfGp5EgkE0t042PFDabkxptJHOL3D";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de
Message-ID: <e7a9a4ba-413a-406e-7f9a-c781f9b669d5@pengutronix.de>
Subject: Re: [PATCH 06/14] can: af_can: rename find_rcv_list() to
 can_rcv_list_find()
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-7-mkl@pengutronix.de>
 <068ceb4d-7a02-9a8a-2e1a-c4a2782310ca@hartkopp.net>
In-Reply-To: <068ceb4d-7a02-9a8a-2e1a-c4a2782310ca@hartkopp.net>

--BgIXnfGp5EgkE0t042PFDabkxptJHOL3D
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 03:11 PM, Oliver Hartkopp wrote:
> On 08/02/2017 07:44 PM, Marc Kleine-Budde wrote:
>> This patch add the commonly used prefix "can_" to the find_rcv_list()
>> function and add the "find" to the end, as the function returns a stru=
ct
>> rcv_list. This improves the overall readability of the code.
>=20
> The function should be named according to it's natural function.
>=20
> If you want to move it to some kind of 'can' namespace I would suggest
>=20
> find_can_rcv_list()

Sadly C doesn't have native namespaces (and objects) like C++, so an
option is to put a can_ in front of every CAN related function....

>> -		rl =3D find_rcv_list(&can_id, &mask, dev_rcv_lists);
>> +		rl =3D can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
>=20
> find_... is better to understand than can_...

=2E..then the "object" or rather the variable the functions deals with,
here a "rcv_list" and then what it does "find". Looks a bit like RPN
calculator :)

> And this is a local function not visible to anyone else outside of=20
> af_can.c .

If you know the code, then it's clear, but if you don't know the code
you immediately see that this is a CAN specific function and not a
"generic" one from rest of the networking stack.

Convinced? :D

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BgIXnfGp5EgkE0t042PFDabkxptJHOL3D--

--akqbjdDACXDGNccBWF7Uw1WWIS17pM1iJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmkBE0ACgkQHv7KIOw4
HPYZaAf+I17OKEGoYwWnbzldeOvkc0CIlUW3/O9w+Ky1CPkiXM24mNPBstgAoJyW
OAtdrSM9euyCe4eU4WvwN/1SUs1eKBBFzSGJLmjotSFZhgm+0cV4/2RoU8ppiM5e
A5GrIn+rxwmedBiFMSddl2fEYPBKZFzNK1uW82xmTs+MFelzhwJKI9waX2GdlGfO
ZNnwBfV7hQKU1Ke+RN76Adj0yS6u2j7gfYw0Jt7bd+c9M/pvIHAgYCrnm4/8/UDs
uK6XjiDLdwNB0fmHZD8gNN7k13PKZdF5ZoYvNoimyj+rkeYUZ3wgHym9VzfIWXSg
MpfF8bjN2Zt0BANOaXo0ps88RbrAIg==
=Yx78
-----END PGP SIGNATURE-----

--akqbjdDACXDGNccBWF7Uw1WWIS17pM1iJ--

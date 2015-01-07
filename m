From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH stable] can_dev: fix crtlmode_supported check
Date: Wed, 07 Jan 2015 14:11:53 +0100
Message-ID: <54AD3099.3000505@pengutronix.de>
References: <54AACC7F.5070605@hartkopp.net> <54AD2E3D.2080908@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JaOxO9QeKf5FNRluhVIKTrOIgshEOBEeF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbAGNMA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 08:12:00 -0500
In-Reply-To: <54AD2E3D.2080908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JaOxO9QeKf5FNRluhVIKTrOIgshEOBEeF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/07/2015 02:01 PM, Marc Kleine-Budde wrote:
> On 01/05/2015 06:40 PM, Oliver Hartkopp wrote:
>> When changing flags in the CAN drivers ctrlmode the provided new conte=
nt
>> has to be checked whether the bits are allowed to be changed.
>> The bits that are to be changed are given as a bitfield in cm->mask.
>> Therefore checking against cm->flags is wrong as the content can hold
>> any kind of values.
>>
>> The iproute2 tool sets the bits in cm->mask and cm->flags depending on=

>> the detected command line options. To be robust against bogus user spa=
ce
>> applications additionally sanitize the provided flags with the provide=
d
>> mask.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> CC: Wolfgang Grandegger <wg@grandegger.com>
>=20
> Does not apply to net/master. However I've applied it by hand. v2 will
> follow.

> User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Ice=
dove/31.3.0

You should consider to use git send-email instead of thunderbird to post
your patches :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JaOxO9QeKf5FNRluhVIKTrOIgshEOBEeF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrTCZAAoJECte4hHFiupUE80P/ipzuwHJQ/ZZmSg7/MjmegyC
8JSQF+WZVZnQmGqGqxDeq4CPPOuFQQYx46VZJSRixxSVbOxyUf9o0BUfW5ESU8Pc
/YApiJgVz5RDA9RMx1LFX0Q+9zvowSfiu/5WN7dUVzjmlLKJnN1S0bjIooAxdCrw
6pLkdLAdeVNp0luKfdknKqwlY4NcT2W8jpioKZeDDokYL30FvN5UJ6UMdqCgvTq2
uWQPaNCY7omPBm+GhGyViAMfpy9QNy7+zcreJ5qYALh5sRM8/GaveYCee++HTcaX
h0GupNGJDUbWz10vYPJshzPlMISj/p8myCiDenvy04qLJedKj0chMTrodqIBgHtA
jC48r1Qa++XdHu4bwfEDMala5x2cyfmK3GEM1YHKs0EPTsQKQYI3MFEjWqWyan8d
os2FDC7ekEPCdSX3dbEA/SQYhHhUGYlZZxgPH+OXiqtVwrhrdw1zp3AwbJH3nTYB
9AFo7BoFN8QBpm5sBJ0D3Uro/GOxlqhWToj1pBNqQz7UOGbdzhd0kppbNgA/9O6w
/bQYkcmKfGIVOL5ksfwXULOA7ZP35crMqTQ2j95BjItA8KCRCyxQc3bb2Ld4/FiY
91h8LmV+2dh+lUBeM0FO/j4j2/5Gzkpz7DNF6ZdBHmmEY+oOcJxMoomhPZEaF+cU
pgrp6KdzZptjFoZr/iTT
=rmry
-----END PGP SIGNATURE-----

--JaOxO9QeKf5FNRluhVIKTrOIgshEOBEeF--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Sat, 07 Sep 2013 12:25:36 +0200
Message-ID: <522AFF20.6000501@pengutronix.de>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de> <ecac65a6d53af596b53d115a9e6552a0@grandegger.com> <20130906193744.GV24802@pengutronix.de> <522AFEA8.3020303@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xhrmiuRHH2rvXfNslBrh9OmgOjotONvWc"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39552 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3IGK0H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Sep 2013 06:26:07 -0400
In-Reply-To: <522AFEA8.3020303@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhrmiuRHH2rvXfNslBrh9OmgOjotONvWc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/07/2013 12:23 PM, Oliver Hartkopp wrote:
> On 06.09.2013 21:37, Uwe Kleine-K=C3=B6nig wrote:
>=20
>>>> I think it is necessary to get the Ack of the people mentioned in
>>>> the Cc: commit footers. @Wolfgang: I added a statement
>>>>
>>>>     The provided data structures and external interfaces from this c=
ode
>>>>     are not restricted to be used by software with a GPL compatible
>>>>     license.
>>>>
>>>> similar to the other can headers. Does that suit you?
>>>
>>> Is this the common phrase other public header files use as well?
>>> What's the motivation for that addition. Likely I might
>>> have missed some related discussion.=20
>> This is what the headers by Volkswagen are using, but it's only a
>> suggestion. So it's up to you.
>>
>=20
> Yep.
>=20
> To make clear that the CAN data structures should not be limited to be =
used in
> GPL code, this sentence has been added.
>=20
> E.g. to allow to implement a similar programming API for BSD, QNX or wh=
atever
> which are obviously not GPL ...
>=20
> Don't know if this it suitable for the netlink stuff anyway.

The usage of netlink.h in a closed source app might be a nother usecase.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xhrmiuRHH2rvXfNslBrh9OmgOjotONvWc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIq/yAACgkQjTAFq1RaXHM0kwCghZ4sdWOFjo0xX02s9yZ2u7Yu
KHMAn0ebUcvSoetcLn+YgoDnsIznB5N5
=kISS
-----END PGP SIGNATURE-----

--xhrmiuRHH2rvXfNslBrh9OmgOjotONvWc--

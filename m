From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN device filterting
Date: Tue, 04 Sep 2012 19:13:26 +0200
Message-ID: <504636B6.7070907@pengutronix.de>
References: <1346765466.5440.3.camel@punsfloyd-desktop> <504604E3.1040305@hartkopp.net> <504608CB.9080709@pengutronix.de> <50463205.8050705@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E0708A80B4199CC1F1179EF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55328 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab2IDRN3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Sep 2012 13:13:29 -0400
In-Reply-To: <50463205.8050705@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: puneet.sharma@moschip.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E0708A80B4199CC1F1179EF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2012 06:53 PM, Oliver Hartkopp wrote:
> On 04.09.2012 15:57, Marc Kleine-Budde wrote:
>=20
>> On 09/04/2012 03:40 PM, Oliver Hartkopp wrote:
>>> On 04.09.2012 15:31, Puneet Sharma wrote:
>>>
>>>> I need some guidance on implementing the CAN filtering of identifier=
 in
>>>> the driver code of CAN for atmel AT91SAM9263 board. Please guide me =
how
>>>> to proceed with it..
>>>
>>>
>>> Hm - i wrote that some days ago:
>>
>> I talked to Puneet in private before, if I understand him correctly he=

>> wants to implement hardware filtering, although software filtering is
>> available.
>=20
>=20
> Ah, ok.
>=20
>>
>> From my point of view it should become a per device callback, which yo=
u
>> (admin, i.e. the root user) can set when the device is down. You have =
to
>> extend the CAN netlink interface [1].
>=20
>=20
> Good idea.
>=20
>> Each device should identify what kind and how many hardware filters it=

>> supports:
>> a) mask+id
>> b) just id
>> c) ...
>> Analogue to ctrlmode [2][3].
>=20
>=20
> Yes. Could be ambitious. E.g. a 2048 bit bitfield is an option too :-)
>=20
> The question is, if the usual mailbox configurations in CAN controller
> IP-cores can be stripped down to 2-3 standard types of filters, so that=
 a good
> interface can be specified.

id+mask is quite common.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6E0708A80B4199CC1F1179EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBGNrYACgkQjTAFq1RaXHNBwgCeIk41UCa8qlQKzjvJO157v9rs
qb8An1Wl+tk3/Jx8bDgF7Dz4doC/aCkA
=Cy6W
-----END PGP SIGNATURE-----

--------------enig6E0708A80B4199CC1F1179EF--

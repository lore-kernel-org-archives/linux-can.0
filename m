From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:42:39 +0200
Message-ID: <50587A4F.5060105@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de> <50587987.3070308@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D8F08BB8D74070ADBE51CE3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2IRNmn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:42:43 -0400
In-Reply-To: <50587987.3070308@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D8F08BB8D74070ADBE51CE3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/18/2012 03:39 PM, Wolfgang Grandegger wrote:
> On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
>> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
>> [...]
>>
>>>> We have several customers who asked how to abort pending TX messages=
,
>>>> too. Which involves:
>>>> a) clear the TX-queue in Linux
>>>> b) clear queue in hardware
>>>> c) abort currently transmitting CAN frame
>>>>
>>>> I think c) would be a usecase of its own, too.
>>>
>>> I think you need c) for b), at least for some controllers. These
>>
>> Yes, if it's a hardware limitation so be it. But if we design an
>> interface it should support "clear everything" (a+b+c), but also just
>> only c.
>=20
> Yes, that you be nice. The only portable "clear everything" (a+b+c) I
> see is "ifconfig down -> up". This also answers you other related mail.=

>=20
> What do people really want/need and why? This is still not clear to me.=

> More input would be nice.

Heinz-J=FCrgen uses abort current TX Message on SJA1000, can you give us
more insight? I've talked to customers, e.g. they want to abort the
current frame if it takes "too long" to send it, because the frames CAN
id priority is too low.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2D8F08BB8D74070ADBE51CE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBYek8ACgkQjTAFq1RaXHOuxwCbBuArhQXN92CGaK4+6t3KU1S7
h6gAoIpm0QleKNejdUiUNeSFRftH/pdL
=Df12
-----END PGP SIGNATURE-----

--------------enig2D8F08BB8D74070ADBE51CE3--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 17:00:02 +0200
Message-ID: <5072EA72.9050308@pengutronix.de>
References: <6309304.MqJsLKDGaO@lisa> <5072BCFE.5000006@pengutronix.de> <1722972.yqiF7qX92T@lisa> <5072E9A5.2060908@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig01D58AEEB6492CA4DF2780AB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52981 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2JHPAy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 11:00:54 -0400
In-Reply-To: <5072E9A5.2060908@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Steffen Rose <ro@emtas.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01D58AEEB6492CA4DF2780AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/08/2012 04:56 PM, Wolfgang Grandegger wrote:
>>> Your program probably produces CAN frames faster than they could be
>>> delivered by your CAN hardware. Your choices are:
>>
>> I'm unsure.
>> My CPU load is high. My application polling is not optimal at the mome=
nt. But=20
>> the CAN busload is not so high.
>>
>> At the moment I would think, it is more a problem internal or on USB. =
I'm=20
>> unsure. I search information to analyze the current situation.
>>
>>> 2) Increase txqueue length to 10000 or so.
>>>    (ifconfig can0 txqueuelen 10000)
>>
>> I did it.
>>
>> after a little bit time...
>=20
> Did it run longer than before? Anyway, the candump utility shows how to=

> count messages dropped because the queue was full. Search for the optio=
n
> "-d".
>=20
>>
>> Now my error:
>> 	write: Interrupted system call
>=20
> Hm, who has interrupted the write system call? gdb?

Is your application making use of signals? This is not an error, just
restart the write.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig01D58AEEB6492CA4DF2780AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBy6nYACgkQjTAFq1RaXHN9uQCeJ+G1hOHjMMo0Hn5PAi9uA06L
8+AAn0HFrGVVCK1WrYYrx0Uu2qkqu8EE
=7rSJ
-----END PGP SIGNATURE-----

--------------enig01D58AEEB6492CA4DF2780AB--

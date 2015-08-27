From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Thu, 27 Aug 2015 15:23:05 +0200
Message-ID: <55DF0F39.10507@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="w6I4wQMQpA6RR6bAUcvIALXvjUBr4KQNr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59616 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbbH0NXP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Aug 2015 09:23:15 -0400
In-Reply-To: <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, Pankajkumar Misra <pankaj.kumar@in.bosch.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w6I4wQMQpA6RR6bAUcvIALXvjUBr4KQNr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2015 03:04 PM, Gerhard Bertelsmann wrote:
>> It it's sja1000 compatible, it should work out of the box with the
>> existing sja1000 device tree binding.
>=20
> the Allwinner CAN IP is very similar but not exactly a SJA1000, e g. th=
e
> registers differ and some are 32 bit wide and not 8 bit.

Which are the registers that have the upper 24 bit used?

> So the question is: change the sja1000 and the platform file for=20
> "quirks" or write a new independent one ?

Depends on the actual differences, but I'd go for quirks first.

> Which way do you prefer or better: which driver will be accepted for=20
> mainline ?

The github driver lacks a proper driver model binding, so that's not
mainline ready.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--w6I4wQMQpA6RR6bAUcvIALXvjUBr4KQNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV3w85AAoJEP5prqPJtc/HtiAH/184iE84S4NT/61UeKncXXfP
m2pmEbIJ/ZRX+RE6OQ6lIWEwWKeGmX0N4xSiee3tbH8peWSrqpz+8A75kaoRhIjD
G8DoCB4k8mWpg/zTavoTJmacT+1yYlWHe5JD1s/8kkAiN6JlS/qctT11pZi8qRie
ox4pq+oQuKcL4FU7RN0ZSTLwm30F0LOydPzlcD4QBZlI9VVbiD3GShc771/WjX6F
5nWmj4xJv/TIFnY8oIBhfkIviLzR1zMfIB4/AURnMf/OZLcrSKALmpbwz+11lHGY
cCpRDqgy2wSKNg6o1uoEk6jUHFOB+QwQa1U8t27x/LTyXqgYE1DCwhRSsaaTHbs=
=j6S0
-----END PGP SIGNATURE-----

--w6I4wQMQpA6RR6bAUcvIALXvjUBr4KQNr--

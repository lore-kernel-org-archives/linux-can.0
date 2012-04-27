From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ODB-II Interfaces and Linux CAN?
Date: Fri, 27 Apr 2012 15:00:37 +0200
Message-ID: <4F9A9875.50904@pengutronix.de>
References: <jndptc$9c5$1@ultimate100.geggus.net> <4F9A6DEA.5050900@pengutronix.de> <jne15j$bbr$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8E218809D8AE3CEB5B1F09E0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47007 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757446Ab2D0NAw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 09:00:52 -0400
In-Reply-To: <jne15j$bbr$1@ultimate100.geggus.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E218809D8AE3CEB5B1F09E0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2012 01:50 PM, Sven Geggus wrote:
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> The webpage talks about a "327 Chip" when searching for it, I find:
>> http://www.blafusel.de/obd/obd2elm327.html
>> http://www.elmelectronics.com/DSheets/ELM327DS.pdf
>=20
> Jepp this includes a description of the serial protocol.

>> This chip converts ODB (and CAN seems to be part of ODB) to serial. Th=
e
>> question is how the 327 in the autodia-e327 is converted to USB. They
>> probably use a standard USB-Serial converter chip.=20
>=20
> They almost certaily do.
>=20
>> There is support for serial attached CAN adapters in mainline (IIRC), =
but
>> I think it talks a different protocol.
>=20
> You are talking about slcan.c right?

Yes.

> Probably I should just get me one of these cheap Interfaces.

These serial CAN converters are probably quite slow, I haven't used any.
Maybe Oliver can comment on them.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8E218809D8AE3CEB5B1F09E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+amH4ACgkQjTAFq1RaXHMMRgCfULnm/rjZuI9q3QsDPP0ojAY0
E44An23N7dZaBPgljSfiuzSevhXwz3fw
=O1++
-----END PGP SIGNATURE-----

--------------enig8E218809D8AE3CEB5B1F09E0--

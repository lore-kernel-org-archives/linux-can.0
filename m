From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: ODB-II Interfaces and Linux CAN?
Date: Fri, 27 Apr 2012 11:59:06 +0200
Message-ID: <4F9A6DEA.5050900@pengutronix.de>
References: <jndptc$9c5$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B73A8621D93B66E7B2A0936"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33901 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755528Ab2D0J7M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 05:59:12 -0400
In-Reply-To: <jndptc$9c5$1@ultimate100.geggus.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B73A8621D93B66E7B2A0936
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/27/2012 11:46 AM, Sven Geggus wrote:
> Hello,
>=20
> cheap ODB-II Interfaces claiming to support CAN (at least up to 500 kbp=
s)
> are available for less than 20 Euros now.
>=20
> Here is one of them:
> http://www.autodia.de/produkte/autodia-e327/technische-daten

nice :)

> Will this already work with socketcan or would it be possible to implem=
ent
> support?

The webpage talks about a "327 Chip" when searching for it, I find:
http://www.blafusel.de/obd/obd2elm327.html
http://www.elmelectronics.com/DSheets/ELM327DS.pdf

This chip converts ODB (and CAN seems to be part of ODB) to serial. The
question is how the 327 in the autodia-e327 is converted to USB. They
probably use a standard USB-Serial converter chip. There is support for
serial attached CAN adapters in mainline (IIRC), but I think it talks a
different protocol. So if it's possible the send and receive CAN
messages with the 327 it should be possible to hack a driver that can
send/receive some CAN messages.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2B73A8621D93B66E7B2A0936
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+abe0ACgkQjTAFq1RaXHOyOACfdSvOwJz/Afs+GPcnO4qeROlc
MuAAnieJMzxutW6cdR4GbLxmJlUYJMu/
=QxqE
-----END PGP SIGNATURE-----

--------------enig2B73A8621D93B66E7B2A0936--

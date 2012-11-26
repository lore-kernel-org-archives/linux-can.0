From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91_can.c: Data transmission stops
Date: Mon, 26 Nov 2012 17:36:42 +0100
Message-ID: <50B39A9A.3020709@pengutronix.de>
References: <50B37C90.3040904@rosetechnology.dk> <50B389D6.4050308@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig84DB2CEA7480269AC19BB8C3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46187 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab2KZQgu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 11:36:50 -0500
In-Reply-To: <50B389D6.4050308@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Henrik Bork Steffensen <hbs@rosetechnology.dk>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84DB2CEA7480269AC19BB8C3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 04:25 PM, Wolfgang Grandegger wrote:
>> I am considering protecting tx objects as Wolfgang suggests in the
>> pch_can thread.
>=20
> This problem is with SMP in the first place. Can you show your .config.=

> The c_can driver uses similar code than the at91_can and they have
> therefore the same issues if the kernel is preemptable, IIUC. Should no=
t
> be a big deal to adapt the following patch:

=46rom my point of view, it should be possible to implement that algorith=
m
lock-free, as there is only one writer and one reader of the two
variables. I'll have a look at it tomorrow.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig84DB2CEA7480269AC19BB8C3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCzmp4ACgkQjTAFq1RaXHMrTQCeLRkdkVU2Ck4XjMlFyN0qgLIE
hgMAnRFdJ4CwA/t5MOcSjb+g7TroFb7k
=nopY
-----END PGP SIGNATURE-----

--------------enig84DB2CEA7480269AC19BB8C3--

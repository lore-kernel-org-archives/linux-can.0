From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Wed, 24 Apr 2013 23:27:09 +0200
Message-ID: <51784E2D.60209@pengutronix.de>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com> <51784851.1000208@orange.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QRERFDPQMNDVGSRIDQIL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40796 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073Ab3DXV1M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Apr 2013 17:27:12 -0400
In-Reply-To: <51784851.1000208@orange.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-15?Q?Fran=E7ois?= <fbeaulier@orange.fr>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QRERFDPQMNDVGSRIDQIL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/24/2013 11:02 PM, Fran=E7ois wrote:
> Stephane,
>=20
> This is what i have done in a open source project i have started, a web=

> can analyzer called ewecan (https://bitbucket.org/Mongo/ewecan):
> It parses /sys/class/net but unfortunately, as noted in comments, it
> cannot make the difference between up or down interfaces.
>=20
> /* Get a list of available socketcan interfaces and return them in
>    a string as a JS array like ["can0", "can1", "vcan"]
>    Returned string must be freed after use
>    BUG : it also returns interfaces that are present but down !
> */

Whan happens if I rename my ethernet interface to "can0"?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QRERFDPQMNDVGSRIDQIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF4Ti4ACgkQjTAFq1RaXHNBJwCgg3Nf1itNEL43sZCFRXf7pHBW
+7UAn0sjA2qUMqBM65OA1CrKSgb4Hx3j
=7Qa7
-----END PGP SIGNATURE-----

------enig2QRERFDPQMNDVGSRIDQIL--

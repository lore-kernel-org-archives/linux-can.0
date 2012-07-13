From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: janz-ican3: add support for one shot mode
Date: Fri, 13 Jul 2012 10:59:18 +0200
Message-ID: <4FFFE366.8000707@pengutronix.de>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu> <1342109732-4995-4-git-send-email-iws@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D6F9CACA90F85E2ACC51754"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45164 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab2GMI70 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 04:59:26 -0400
In-Reply-To: <1342109732-4995-4-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D6F9CACA90F85E2ACC51754
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/12/2012 06:15 PM, Ira W. Snyder wrote:
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
>=20
> The Janz VMOD-ICAN3 hardware has support for one shot packet
> transmission. This means that a packet will be attempted to be sent
> once, with no automatic retries.
>=20
> The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.

What happens to the queued to-be-echoed CAN frames if the device fails
to send a CAN frame, due to one shot mode?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6D6F9CACA90F85E2ACC51754
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk//42oACgkQjTAFq1RaXHOR8QCdGCZzR74idCoqXBXEkoC5r1O6
+bIAn3PD8PGfCpBxthKEOQ4HsAa0O2zK
=WRgq
-----END PGP SIGNATURE-----

--------------enig6D6F9CACA90F85E2ACC51754--

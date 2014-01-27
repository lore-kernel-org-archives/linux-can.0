From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-utils: Add exact CAN frame length calculation (including
 bitstuffing)
Date: Mon, 27 Jan 2014 10:26:52 +0100
Message-ID: <52E6265C.7040601@pengutronix.de>
References: <1390571983-16040-1-git-send-email-sojkam1@fel.cvut.cz> <52E3D619.4070702@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jkElsrd2foWCACXx4g9opvVWHhpIrAUO8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50074 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbaA0J1B (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Jan 2014 04:27:01 -0500
In-Reply-To: <52E3D619.4070702@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Michal Sojka <sojkam1@fel.cvut.cz>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jkElsrd2foWCACXx4g9opvVWHhpIrAUO8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2014 04:19 PM, Oliver Hartkopp wrote:
[...]

> https://gitorious.org/linux-can/can-utils/source/canbusload.c#L375
>=20
> E.g. some
>=20
> enum {
> 	NO_BITSTUFFING, /* plain bit calculation without bitstuffing */
> 	BITSTUFFING, /* with bitstuffing following Tindle estimation */
> 	PRECISE, /* precise calculation including bitstuffing in CRC */
> }

Please add a prefix to those enums.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jkElsrd2foWCACXx4g9opvVWHhpIrAUO8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLmJlwACgkQjTAFq1RaXHOQNACfcTbLyBkfHHws5ju0xKB8sXto
sCEAnAv5RIRdyJ0tF4iSbzk1XKDqrBvc
=aiCc
-----END PGP SIGNATURE-----

--jkElsrd2foWCACXx4g9opvVWHhpIrAUO8--

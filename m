From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 21:10:06 +0200
Message-ID: <4FDF7D0E.1000802@pengutronix.de>
References: <4FDF67B2.1090004@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig48612E3F5CAB1AEBFFC0BB07"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60748 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab2FRTKO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:10:14 -0400
In-Reply-To: <4FDF67B2.1090004@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48612E3F5CAB1AEBFFC0BB07
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 07:38 PM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> here's my first real git patch series adding support for CAN with flexi=
ble
> data rate (CAN FD).
>=20
> As there were no new remarks to my RFC v5 from 2012-05-28
>=20
> http://comments.gmane.org/gmane.linux.can/1297
>=20
> and it's tested and running on my machine for a while now it's IMHO tim=
e
> for net-next now.
>=20
> You can also pull the series ;-)

I can pull, but David want's to have a clean tree. So I have to pull and
rebase it on my tree.

> Git is hard for newbies but i gave my very best ...

Once you can use it, you don't want to code without it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig48612E3F5CAB1AEBFFC0BB07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ffRIACgkQjTAFq1RaXHPYBQCeNUQ6AndyTYdmcGfQ+cQHL7Vt
rs0An3XR43RrkHkZRmMrQm00EZZfU8lo
=pDqF
-----END PGP SIGNATURE-----

--------------enig48612E3F5CAB1AEBFFC0BB07--

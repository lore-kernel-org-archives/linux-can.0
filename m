From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Fri, 17 Feb 2012 21:27:24 +0100
Message-ID: <4F3EB82C.7080905@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA6B15B0208C749AEBDFBD0BF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37145 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2BQU12 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2012 15:27:28 -0500
In-Reply-To: <4F3BE2AC.9020108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6B15B0208C749AEBDFBD0BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/15/2012 05:51 PM, Oliver Hartkopp wrote:
> In the case of hotplug enabled devices (PCMCIA/PCIeC) the removal of th=
e
> hardware can cause an infinite loop in the common sja1000 isr.
>=20
> Use the already retrieved status register to indicate a possible hardwa=
re
> removal and double check by reading the mode register in sja1000_is_abs=
ent.
>=20
> v2: Create a new function to not print information in irq context.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks for the patch. I'm going to commit it to can-next. Any objections?=


Marc

P.S.:
Please make it based on can-next/master next time, it fails to apply due
to Wolfgang's dev_LEVEL -> netdev_LEVEL patch. But it's trivial to
apply, by hand :)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA6B15B0208C749AEBDFBD0BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+uC8ACgkQjTAFq1RaXHNnmgCgiBHSkCvbFHRFpv62Bnr4dQhK
UV8AniPCVXTyXi9uXQ36aZjwtzc3Cpzp
=cITt
-----END PGP SIGNATURE-----

--------------enigA6B15B0208C749AEBDFBD0BF--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: mcp251x: Remove redundant spi driver bus initialization
Date: Tue, 12 Mar 2013 13:20:06 +0100
Message-ID: <513F1D76.40707@pengutronix.de>
References: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QJNJUUKJEPCXDQTAOINE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40199 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932167Ab3CLMUO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Mar 2013 08:20:14 -0400
In-Reply-To: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QJNJUUKJEPCXDQTAOINE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/12/2013 01:13 PM, Lars-Peter Clausen wrote:
> In ancient times it was necessary to manually initialize the bus field =
of an
> spi_driver to spi_bus_type. These days this is done in spi_driver_regis=
ter() so
> we can drop the manual assignment.

Applied all three patches.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QJNJUUKJEPCXDQTAOINE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE/HXoACgkQjTAFq1RaXHMEuACeOuVL2fztIfYQ9zBWijyN0b0i
Ni8AnA8DNsR4WlsDhzyIIXGmhxmP7vsX
=ziQO
-----END PGP SIGNATURE-----

------enig2QJNJUUKJEPCXDQTAOINE--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000: Make sja1000_of_platform selectable and
 compilable on SPARC
Date: Thu, 04 Oct 2012 14:49:27 +0200
Message-ID: <506D85D7.8090801@pengutronix.de>
References: <1349183599-28734-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4C425DDB68C034108A8F6D18"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38443 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2JDMtj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 08:49:39 -0400
In-Reply-To: <1349183599-28734-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C425DDB68C034108A8F6D18
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/02/2012 03:13 PM, Andreas Larsson wrote:
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

On sparc32 (and others) this fails to compile with:

> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja10=
00_ofp_read_reg':
> linux/drivers/net/can/sja1000/sja1000_of_platform.c:64:2: error: implic=
it declaration of function 'in_8' [-Werror=3Dimplicit-function-declaratio=
n]
> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja10=
00_ofp_write_reg':
> linux/drivers/net/can/sja1000/sja1000_of_platform.c:70:2: error: implic=
it declaration of function 'out_8' [-Werror=3Dimplicit-function-declarati=
on]

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4C425DDB68C034108A8F6D18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBthdsACgkQjTAFq1RaXHOCXQCfRqipjuQ1PiLcAz+2SHvMtRxk
w/QAn0424z3LmJ5yoNSL/fq/laZvfk7Z
=Sjo1
-----END PGP SIGNATURE-----

--------------enig4C425DDB68C034108A8F6D18--

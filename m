From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2 v2] Add support of sja1000-based PEAK-System cards
Date: Sat, 03 Mar 2012 17:45:38 +0100
Message-ID: <4F524AB2.9030107@pengutronix.de>
References: <1330701680-2461-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE591F8271E6223129E0F23F0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42238 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab2CCQpp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 3 Mar 2012 11:45:45 -0500
In-Reply-To: <1330701680-2461-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE591F8271E6223129E0F23F0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/02/2012 04:21 PM, Stephane Grosjean wrote:
> That serie of patches includes support of some new PEAK-System cards
> that provide access to the CAN bus. First patch adds support for some
> new PCI cards as well as adds control to the leds of the=20
> PCAN-PCIExpressCard (PCAN-PCIeC). Last one adds full support for the=20
> PCAN-PC Card PCMCIA card.

Thanks, pushed to can-next/master.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE591F8271E6223129E0F23F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9SSrIACgkQjTAFq1RaXHMa7gCeJZfHI5pR0UxIizYMx/PfX3eF
zQ0AoIhArhvYpLQgqZf+JBG2+7Qn0ZsS
=Ebny
-----END PGP SIGNATURE-----

--------------enigE591F8271E6223129E0F23F0--

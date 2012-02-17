From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4.1] can/sja1000: add support for PEAK-System PCMCIA
 card
Date: Fri, 17 Feb 2012 10:36:03 +0100
Message-ID: <4F3E1F83.8020708@pengutronix.de>
References: <1329387042-4021-1-git-send-email-s.grosjean@peak-system.com> <20120217082455.GA5648@comet.dominikbrodowski.net> <4F3E1C10.8070207@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6AE187B70C5D23E91886C273"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45540 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077Ab2BQJgI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Feb 2012 04:36:08 -0500
In-Reply-To: <4F3E1C10.8070207@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6AE187B70C5D23E91886C273
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/17/2012 10:21 AM, Stephane Grosjean wrote:
> Hi Oliver,
>=20
> I've got one (newbie) question: what is the next step? I mean, should I=

> post the same patch again but with this "Acked-by"? Or what? Should I
> wait for any linux-can Acked-by ?

No need to repost so soon. A Tested-by from Oliver under heavy load
detaching together with the Fix unplug Patch would be fine.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6AE187B70C5D23E91886C273
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8+H4YACgkQjTAFq1RaXHMuGACeOIB9O3pR9xGjzm1ZBPNtMS6m
/FYAn170fpQ8VaNb6RA3UO7n5aIM3t9j
=FlAP
-----END PGP SIGNATURE-----

--------------enig6AE187B70C5D23E91886C273--

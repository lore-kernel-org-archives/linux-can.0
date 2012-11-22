From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Thu, 22 Nov 2012 12:30:48 +0100
Message-ID: <50AE0CE8.6020809@pengutronix.de>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com> <50A13766.7040407@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A73991687B893733FF1B4B0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48591 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064Ab2KVTTs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Nov 2012 14:19:48 -0500
In-Reply-To: <50A13766.7040407@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: software@gaisler.com, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A73991687B893733FF1B4B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/2012 06:52 PM, Andreas Larsson wrote:
> As of v3.7-rc5, this patch now works properly (of_address_to_resource i=
s
> now once again available for sparc). It would be nice to have it
> applied, unless the work on integrating sja1000_of_platform into
> sja1000_platform will be applied soon (and work for sparc). I'll be
> happy to test new versions on that initiative if that is the way you
> want to go.
>=20
> It would be nice to get sja1000 to work on sparc soon in some way or
> another.

For now, I've applied the patch to linux-can-next/master. But in the
short term I'll try to give the my other patch another try and merge the
of_platform driver to the existing platform driver. I hope you can test
on sparc then. :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9A73991687B893733FF1B4B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCuDOgACgkQjTAFq1RaXHMPewCcCmJ10fPvHOu+1kwxMT8NsD5W
eW0AniSGnA2GVOs2eUr1+CkRXwTPT2W5
=wKxw
-----END PGP SIGNATURE-----

--------------enig9A73991687B893733FF1B4B0--

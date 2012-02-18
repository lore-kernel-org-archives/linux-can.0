From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Sat, 18 Feb 2012 18:00:26 +0100
Message-ID: <4F3FD92A.20109@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB389.7050104@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4C927168E01E39A7D9A9B30B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43437 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab2BRRA1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Feb 2012 12:00:27 -0500
In-Reply-To: <4F3FB389.7050104@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C927168E01E39A7D9A9B30B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/18/2012 03:19 PM, Oliver Hartkopp wrote:
>> Thanks for the patch. I'm going to commit it to can-next. Any objectio=
ns?
>=20
>=20
> Indeed it should go into stable 3.2 too, as it was the first kernel, wh=
ere the
> EMS PCMCIA driver was integrated.
>=20
> So putting it into Daves net-tree for 3.3rc fixes and announce it for s=
table
> 3.2 seems correct to me.

Ahh, thanks for the info, I wasn't aware of that.

>=20
>> P.S.:
>> Please make it based on can-next/master next time, it fails to apply d=
ue
>=20
>> to Wolfgang's dev_LEVEL -> netdev_LEVEL patch. But it's trivial to
>> apply, by hand :)
>=20
>=20
> The patch was based on the latest 3.3rc3 from Linus's tree, which was m=
y
> intention (see above).

got it :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4C927168E01E39A7D9A9B30B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8/2SoACgkQjTAFq1RaXHNLzwCcDce7J3TXFteTyUyDtBd591nL
6J8AoI0XEITod6UQ1oudQ6LSAMcTGYs5
=s/e1
-----END PGP SIGNATURE-----

--------------enig4C927168E01E39A7D9A9B30B--

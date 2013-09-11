From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 21:34:49 +0200
Message-ID: <5230C5D9.7080302@pengutronix.de>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de> <1378923967-sup-6565@pruts.nl> <5230B897.7020807@pengutronix.de> <5230C1D2.2080700@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ESm5xUXVk0bpg6mqDIeST1NhNheomPkP0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55662 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3IKTkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 15:40:32 -0400
In-Reply-To: <5230C1D2.2080700@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ico Doornekamp <can@zevv.nl>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ESm5xUXVk0bpg6mqDIeST1NhNheomPkP0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/11/2013 09:17 PM, Oliver Hartkopp wrote:
> I wonder if the used of an unsigned long data type for the u32 can_id
> and the use of kstrtoul() might cause an issue on 64 bit platforms?!?

No, only if the CAN id is > 2^32  :D

> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/can/slcan.c#n146
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/can/slcan.c#n164

> The 'unsigned long' conversion was introduced in 2009 due to a report o=
f Kurt van Dijck:
>=20
> http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/s=
lcan.c?op=3Drevision&rev=3D919
> http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/s=
lcan.c?op=3Ddiff&rev=3D919&peg=3D919

I think Kurt's solution to use an intermediate is correct.

> but maybe kstrtouint()
>=20
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/lib=
/kstrtox.c#n202
>=20
> would be the better choice now.

Oh, thanks, I didn't know that this library exists! Send patches :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ESm5xUXVk0bpg6mqDIeST1NhNheomPkP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIwxdkACgkQjTAFq1RaXHNX1gCeNVVyhEjG+OR1wG1gtIWpAtB6
muIAn3yHeKQc62naTDrTjMvKVD6vC2FR
=HUU0
-----END PGP SIGNATURE-----

--ESm5xUXVk0bpg6mqDIeST1NhNheomPkP0--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000: Make sja1000_of_platform selectable
 and compilable on SPARC
Date: Thu, 04 Oct 2012 16:42:53 +0200
Message-ID: <506DA06D.3070003@pengutronix.de>
References: <506D9266.6010707@gaisler.com> <1349359150-18012-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9B555C9D2715874DBBD6F471"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47091 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964885Ab2JDOnI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Oct 2012 10:43:08 -0400
In-Reply-To: <1349359150-18012-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B555C9D2715874DBBD6F471
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/04/2012 03:59 PM, Andreas Larsson wrote:
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Looks better. However on sparc and sparc64, I'm seeing this warning.
=46rom my point of view a false positive.

> linux/drivers/net/can/sja1000/sja1000_of_platform.c: In function 'sja10=
00_ofp_remove':
> linux/include/linux/ioport.h:165:18: warning: 'res.end' is used uniniti=
alized in this function [-Wuninitialized]
> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note: 'res.e=
nd' was declared here
> linux/include/linux/ioport.h:165:2: warning: 'res.start' is used uninit=
ialized in this function [-Wuninitialized]
> linux/drivers/net/can/sja1000/sja1000_of_platform.c:78:18: note: 'res.s=
tart' was declared here

I'm using these compilers:
http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/x86_64-gcc-4=
=2E6.3-nolibc_sparc-linux.tar.xz
http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/x86_64-gcc-4=
=2E6.3-nolibc_sparc64-linux.tar.xz

Can you please compile your kernel with these and test if this works:

    while true; do rmmod sja1000_of_platform; modprobe sja1000_of_platfor=
m; done

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9B555C9D2715874DBBD6F471
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBtoHAACgkQjTAFq1RaXHO12QCglHFkzZlHbKrKCKoZhKmK309D
0YEAn1YYDjAVO9PSfWmHiKaNCHA+tqYl
=Up9a
-----END PGP SIGNATURE-----

--------------enig9B555C9D2715874DBBD6F471--

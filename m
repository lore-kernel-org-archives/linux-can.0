From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: adding can4linux to drivers/char
Date: Sat, 21 Sep 2013 15:38:15 +0200
Message-ID: <523DA147.7090403@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8knRVlTbAPi5KtDSrjuPGf0u4wkLgm8Sg"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42307 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3IUNiZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Sep 2013 09:38:25 -0400
In-Reply-To: <1881932.U1kQQJkqCz@heinz.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?SGVpbnotSsO8cmdlbiBPZXJ0ZWw=?= <hj.oertel@t-online.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8knRVlTbAPi5KtDSrjuPGf0u4wkLgm8Sg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/21/2013 01:03 AM, Heinz-J=C3=BCrgen Oertel wrote:
> long before SocketCAN, which now is part of the Linux kernel drivers,
> can4linux was available as the CAN device driver for Linux.
>=20
> I now like to add it to the kernel source tree as well. What to you
> think about it. And how should I start and proceed?

I suggest to port you existing applications to linux-can. I'm sure
you'll find help here and there are several companies out there who
offer commercial support on this.

=46rom my point of view, it quite unlikely that this code will be merged
to mainline, as there is already a working solution.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--8knRVlTbAPi5KtDSrjuPGf0u4wkLgm8Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlI9oUcACgkQjTAFq1RaXHOTcgCgk4o4mxK1OHDkHUgQcZ4xaymN
rcAAnRh71VgMN0TkdSnFqV2yScL8y3pK
=O3g9
-----END PGP SIGNATURE-----

--8knRVlTbAPi5KtDSrjuPGf0u4wkLgm8Sg--

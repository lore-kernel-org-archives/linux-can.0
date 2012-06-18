From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] canfd: add new data structures and constants
Date: Mon, 18 Jun 2012 21:55:47 +0200
Message-ID: <4FDF87C3.5010209@pengutronix.de>
References: <4FDF67C3.6020201@hartkopp.net> <4FDF7DE1.6000803@pengutronix.de> <4FDF7F25.8040605@hartkopp.net> <4FDF8614.9040707@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBB1A67F4DC91F90300D8901"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47958 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab2FRTzt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:55:49 -0400
In-Reply-To: <4FDF8614.9040707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBB1A67F4DC91F90300D8901
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 09:48 PM, Marc Kleine-Budde wrote:
> If you want to be super clean you can first make a patch that changes
> the existing __attribute__((aligned(8))) to __aligned(8), and then add
> your canfd series. If not, just mention it in the patch description
> (While being here change can_fd to __aligned(8)).
>=20
> Err..this is a userspace header, I just tested it, headers_install
> doesn't remove it. And userspace fails to compile with this. For now
> stick to __attribute__((aligned(8))).

BTW: and it fails to compile due to a __kernel_sa_family_t which isn't
defined on my ubuntu with 2.6.32er headers

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCBB1A67F4DC91F90300D8901
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/fh8MACgkQjTAFq1RaXHPaoACeKb4xTiAX57tYkx/9Pq9sfOpo
yFEAnjsfM0pv/3M4hyvNb54JYdFWaPAL
=ucmD
-----END PGP SIGNATURE-----

--------------enigCBB1A67F4DC91F90300D8901--

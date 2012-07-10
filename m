From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] can: gw: Netlink related fixes
Date: Tue, 10 Jul 2012 22:55:39 +0200
Message-ID: <4FFC96CB.4060709@pengutronix.de>
References: <cover.1341489914.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig727731C3150D3F6C420D190E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33119 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2GJUzr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 16:55:47 -0400
In-Reply-To: <cover.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig727731C3150D3F6C420D190E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/05/2012 02:19 PM, Thomas Graf wrote:
> Hi
>=20
> These patches fix some Netlink quirks in the CAN gateway code.
> Unfortunately I do not own any CAN hardware so this is compile
> tested only. I'm fairly confident though as the changes are
> mostly straight forward. I would appreciate if someone could
> run them through a test suite or something though.
>=20
>=20
> Thomas Graf (4):
>   can: Don't bump nlmsg_len manually
>   can: Use nla_policy to validate netlink attributes
>   can: Properly fill the netlink header when responding to RTM_GETROUTE=

>   can: Remove pointless casts

Thanks applied to linux-can-next.

Thanks, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig727731C3150D3F6C420D190E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/8ls8ACgkQjTAFq1RaXHONEwCdEmZVpLaIHl7v4uf/x1uSjcLs
tgkAn3qkjSi7II/vGklOYeMSdIRCwP5j
=PG0+
-----END PGP SIGNATURE-----

--------------enig727731C3150D3F6C420D190E--

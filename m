From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: share thought on socketcan for flexcan driver on imx6 platform
Date: Tue, 13 May 2014 16:36:21 +0200
Message-ID: <53722DE5.6040103@pengutronix.de>
References: <536A2408.70608@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rdwRUVNEODw4oE6oqrlcjChh4ftH3dnne"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbaEMOgb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 May 2014 10:36:31 -0400
In-Reply-To: <536A2408.70608@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rdwRUVNEODw4oE6oqrlcjChh4ftH3dnne
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/07/2014 02:16 PM, Ratheendran wrote:
> The mail I  write  to get more insight on socketcan implementation for
> flexcan driver on imx6 platform.
>=20
> Our customer need mode change implementation to be implemented on the
> driver.
> Freeze -> Listen-Only

Listen only mode ist supported by the driver, you can use iproute2's ip
utility, canconfig for shell, or libsocketcan for C.

    canconfig can0 ctrlmode listen-only on
    ifconfig can0 up

> Freeze -> Normal

it's just a normal ifconfig up, just to be sure switch listen only mode o=
ff:

    canconfig can0 ctrlmode listen-only off
    ifconfig can0 up

> Listen-Only -> Normal

    ifconfig can0 down
    canconfig can0 ctrlmode listen-only off
    ifconfig can0 up

> Normal ->Freeze
> Freeze -> Disable

ifconfig down is whatever state, usually normal -> freeze, then disable

    ifconfig can0 down

> Disable -> Freeze

This happens during ifconfig up, but then the device goes straight into
normal mode.

> I very well know this can be achieved with iproute2 utilities with the
> existing driver implementation.

Not quite, we don't distinguish between disable and freeze.

> I can also tweak the driver code to bring in this mode changes with the=

> implementation of ioctl calls,the thought bothers me to go ahead is thi=
s
> changes with lead to undesired consequences on socketcan stack.
> for example debugging an application with ipoute2 related commands will=

> not give the correct status on the on below stack below when the mode
> changes occurs at the c code level.

ioctls are out of fashion, nowadays we use netlink to control the
network devices.

> So I need to understand any better way to achieve the scope apart from
> command line tools, probably by enhancing the upper layer stack to
> accommodate the mode change ioctl implementation.
>=20
> I will be great help if you all can share your valuable thoughts.

Use libsocketcan for a C interface.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rdwRUVNEODw4oE6oqrlcjChh4ftH3dnne
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNyLeUACgkQjTAFq1RaXHPsMQCgiL8wFZJtZSLCzoc+7SCh3DIK
eOsAn02gWk4ufwoJHY/R/4Du9GfMnw7A
=h0qg
-----END PGP SIGNATURE-----

--rdwRUVNEODw4oE6oqrlcjChh4ftH3dnne--

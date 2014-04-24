From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v1] can: c_can: Enable interrupts only when initialization
 has been completed
Date: Fri, 25 Apr 2014 00:07:04 +0200
Message-ID: <53598B08.1090100@pengutronix.de>
References: <1396459685-8133-1-git-send-email-oleksandr.tyshchenko@globallogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6Tlc8Q8LcHfdlUS9RlHrVD6NxMhW6GDsf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53528 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756575AbaDXWHJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 18:07:09 -0400
In-Reply-To: <1396459685-8133-1-git-send-email-oleksandr.tyshchenko@globallogic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksandr Tyshchenko <oleksandr.tyshchenko@globallogic.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Tlc8Q8LcHfdlUS9RlHrVD6NxMhW6GDsf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 07:28 PM, Oleksandr Tyshchenko wrote:
> In current driver realization we enable interrupts twice from c_can_sta=
rt().
> First time in c_can_start()->c_can_chip_config() during set operating m=
ode.
> Second time in the end of c_can_start() after finish basic controller
> configuration.
>=20
> Enabling interrupts in first place (while initialization is ongoing)
> may cause to interrupts when the CAN chip is not completely initialized=
=2E
> Also if basic controller configuration failed with error,
> we will leave initialization sequence with interrupts enabled.
>=20
> We have to enable interrupts only when initialization has been complete=
d.
> So, don't enable interrupts while initialization is ongoing.
>=20
> Signed-off-by: Oleksandr Tyshchenko <oleksandr.tyshchenko@globallogic.c=
om>

Can you please rebase this to
git://gitorious.org/linux-can/linux-can.git
tags/linux-can-fixes-for-3.15-20140424

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6Tlc8Q8LcHfdlUS9RlHrVD6NxMhW6GDsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNZiwgACgkQjTAFq1RaXHOWiACgjVMi71cR5Pr8pW+c4S7KD7Dp
dOgAniIG78WOT0KQ5LVHegbYwRpfssEV
=thPs
-----END PGP SIGNATURE-----

--6Tlc8Q8LcHfdlUS9RlHrVD6NxMhW6GDsf--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: only rename enabled led triggers when changing the
 netdev name
Date: Wed, 28 May 2014 10:06:33 +0200
Message-ID: <53859909.4090904@pengutronix.de>
References: <1401190256-2963-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rb63Mj2uNSpv4sCvO9Huh3PrNW9he2OCP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44810 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaE1INU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 May 2014 04:13:20 -0400
In-Reply-To: <1401190256-2963-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: dev.kurt@vandijck-laurijssen.be, fabio.baltieri@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rb63Mj2uNSpv4sCvO9Huh3PrNW9he2OCP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/27/2014 01:30 PM, Oliver Hartkopp wrote:
> Commit a1ef7bd9fce8 ("can: rename LED trigger name on netdev renames") =
renames
> the led trigger names according to the changed netdevice name.
>=20
> As not every CAN driver supports and initializes the led triggers, chec=
king for
> the CAN private datastructure with safe_candev_priv() in the notifier c=
hain is
> not enough.
>=20
> This patch adds a check when CONFIG_CAN_LEDS is enabled and the driver =
does not
> support led triggers.
>=20
> For stable 3.9+
>=20
> CC: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: Fabio Baltieri <fabio.baltieri@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rb63Mj2uNSpv4sCvO9Huh3PrNW9he2OCP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOFmQ0ACgkQjTAFq1RaXHNBqwCfbDlloeJX19W/QeFDkY7kogD/
iUoAnRfr56zvTQ/OIPmZ7STumL5F5lMC
=TcFQ
-----END PGP SIGNATURE-----

--rb63Mj2uNSpv4sCvO9Huh3PrNW9he2OCP--

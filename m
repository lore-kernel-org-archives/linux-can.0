From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 09:18:33 +0200
Message-ID: <51BEB849.3020409@pengutronix.de>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com> <51BEA863.1040704@hostmobility.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FMBNKKIUKNGCDCRVRSDP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56532 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab3FQHSj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 03:18:39 -0400
In-Reply-To: <51BEA863.1040704@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FMBNKKIUKNGCDCRVRSDP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/17/2013 08:10 AM, Mirza Krak wrote:
> Aah off course. The low-level device driver is sja1000_platform.c. The
> functions I am using are sp_read_reg8 and sp_write_reg8 which I have
> slightly modified. Since I don't use multiplexed bus functionality I
> write the address first.
>=20
>   static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
> {
>     iowrite8(reg, priv->reg_base);
      ^^^^^^^^
>     return ioread8(priv->reg_base + 0x20);
> }
>=20
> static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 =
val)
> {
>     iowrite8(reg, priv->reg_base);
      ^^^^^^^^
>     iowrite8(val, (priv->reg_base + 0x20));
> }

Can you post a proper patch, so that we can see what you have changed?

You probably have a nice race condition here. The two iowrites have to
be atomic.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FMBNKKIUKNGCDCRVRSDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlG+uEkACgkQjTAFq1RaXHMQOwCdG4SXfJpq86jqGwUYZK79Qd92
6V0AnjAvjPD9t7+XN5Y4Iw+/Xph9HZzj
=TOrR
-----END PGP SIGNATURE-----

------enig2FMBNKKIUKNGCDCRVRSDP--

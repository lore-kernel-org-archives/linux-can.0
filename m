From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: sja1000_isa: add locking for indirect register access
 mode
Date: Thu, 17 Apr 2014 21:23:16 +0200
Message-ID: <53502A24.7020500@pengutronix.de>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net> <534D270D.5060705@pengutronix.de> <534D31EF.6050107@hartkopp.net> <534D3748.6060602@pengutronix.de> <534D6C98.4020109@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xjjAP8N3NnmLk1Pr8Fc74avKcxoQKAPxm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58678 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaDQTXU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 15:23:20 -0400
In-Reply-To: <534D6C98.4020109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>
Cc: khurram gulzar <khurramgulzar@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xjjAP8N3NnmLk1Pr8Fc74avKcxoQKAPxm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 07:30 PM, Oliver Hartkopp wrote:
> When accessing the SJA1000 controller registers in the indirect access =
mode,
> writing the register number and reading/writing the data has to be an a=
tomic
> attempt.
>=20
> As the sja1000_isa driver is an old style driver with a fixed number of=

> instances the locking variable depends on the same index like all the o=
ther
> configuration elements given on the module command line.
>=20
> As a positive side effect dev->dev_id is populated by the instance inde=
x,
> which was missing in 3e66d0138c05d9 ("can: populate netdev::dev_id for =
udev
> discrimination").
>=20
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can/master.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xjjAP8N3NnmLk1Pr8Fc74avKcxoQKAPxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQKiQACgkQjTAFq1RaXHNfUQCeKLvUFYV28xcJTgphpHZwX9EX
SmEAnRa0qT+CrhvlI8L56InfeL9C1MbH
=L8cW
-----END PGP SIGNATURE-----

--xjjAP8N3NnmLk1Pr8Fc74avKcxoQKAPxm--

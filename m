From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH v2] can: sja1000: use common prefix for all sja1000
 defines
Date: Tue, 16 Apr 2013 12:40:59 +0200
Message-ID: <516D2ABB.4000300@pengutronix.de>
References: <5169B395.2070703@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2OKOOODWXIDHFNQPBMXGO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43882 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab3DPKlG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Apr 2013 06:41:06 -0400
In-Reply-To: <5169B395.2070703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2OKOOODWXIDHFNQPBMXGO
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/13/2013 09:35 PM, Oliver Hartkopp wrote:
> This is a follow up patch to:
>=20
>     f901b6b can: sja1000: fix define conflict on SH
>=20
> That patch fixed a define conflict between the SH architecture and the =
sja1000
> driver, by addind a prefix to one macro only. This patch consistently r=
enames
> the prefix of the SJA1000 controller registers from "REG_" to "SJA1000_=
".
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> ---
>=20
> Hello Marc,
>=20
> to not miss the current net-next window, here's a well formatted patch =
for my
> REG_ rename proposal. It renames the formerly register defines from REG=
_ to
> SJA1000_ and leaves the content definitions of the registers as-is.
> This is because of all content definitions would have to be changed in =

> sja1000.h AND include/linux/can/platform/sja1000.h to have a consistent=

> naming scheme.

Looks good, I've fixed the indention in
drivers/net/can/sja1000/sja1000.h. I'll send a pull request to David soon=
=2E

Thanks, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2OKOOODWXIDHFNQPBMXGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFtKr4ACgkQjTAFq1RaXHODOgCfbgazJ+u+C1krlTgbaZ9V/YI7
15YAoJQEz2ur51jkS6zI8u19X2mXkJUk
=gV0w
-----END PGP SIGNATURE-----

------enig2OKOOODWXIDHFNQPBMXGO--

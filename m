From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/4] can: sja1000: Add support for CAN_CTRLMODE_LOOPBACK
Date: Tue, 15 Jul 2014 09:35:24 +0200
Message-ID: <53C4D9BC.80009@pengutronix.de>
References: <53BEA26D.2040007@pengutronix.de> <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JcNmUjTaf5IG4rlwCph0lvT0a9nOE0HJD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43127 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbaGOHff (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jul 2014 03:35:35 -0400
In-Reply-To: <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JcNmUjTaf5IG4rlwCph0lvT0a9nOE0HJD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2014 02:13 PM, Nikita Edward Baruzdin wrote:
> This adds support for hardware loopback in SJA1000 by utilising its sel=
f
> reception request (SRR) feature. Upon SRR the message is transmitted an=
d
> received simultaneously, meaning you can't have hardware loopback
> without actually sending a message to the CAN bus in case of SJA1000.
>=20
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>

Thanks, applied to can-next. Do you care to provide patches for ip and
libsocketcan, too?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JcNmUjTaf5IG4rlwCph0lvT0a9nOE0HJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPE2bwACgkQjTAFq1RaXHO/awCfVqcD69yayWLtWj1U36tCYycX
ebEAmwdxfsGCdC9KEql4XLaVr/E7ermF
=UeD0
-----END PGP SIGNATURE-----

--JcNmUjTaf5IG4rlwCph0lvT0a9nOE0HJD--

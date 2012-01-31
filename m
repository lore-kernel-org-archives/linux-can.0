From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can/sja1000: Add PEAK-System PCIe/PCIeC and miniPCI
 boards
Date: Tue, 31 Jan 2012 14:25:25 +0100
Message-ID: <4F27EBC5.3060805@pengutronix.de>
References: <1328015960-14744-1-git-send-email-s.grosjean@peak-system.com> <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A2F5023CC1E381C041DF29D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49514 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab2AaNZd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 08:25:33 -0500
In-Reply-To: <1328015960-14744-2-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A2F5023CC1E381C041DF29D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/31/2012 02:19 PM, Stephane Grosjean wrote:
> This patch adds the support of some new PEAK-System Technik sja1000 boa=
rds
> (http://www.peak-system.com):
>=20
> PCAN-PCI Express (1 or 2 channels)
> PCAN-ExpressCard (1 or 2 channels)
> PCAN-miniPCI (1 or 2 channels)
>=20
> All of these boards are compliant with CAN specifications 2.0A (11-bit =
ID) and
> 2.0B (29-bit ID).
>=20
> This patch also fixes the management of the channels list.

Without looking further at the patch, please make it a seperate patch. A
detailed review will follow.


Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3A2F5023CC1E381C041DF29D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8n68gACgkQjTAFq1RaXHO5XgCfVFJnXI313D4Ebcc8qJx7D+74
ym8AoJazH0FylbqEJs6A99UrlzaQ/ovK
=2Olf
-----END PGP SIGNATURE-----

--------------enig3A2F5023CC1E381C041DF29D--

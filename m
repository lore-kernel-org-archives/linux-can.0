From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/sja1000: Add miniPCIe/cPCI PC/104Plus PCI/104e PEAK-System
 boards
Date: Wed, 24 Oct 2012 11:08:29 +0200
Message-ID: <5087B00D.2070900@pengutronix.de>
References: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8B8B4625CCD0A6A9888491FD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35358 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124Ab2JXJIg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Oct 2012 05:08:36 -0400
In-Reply-To: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8B8B4625CCD0A6A9888491FD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/23/2012 12:37 PM, Stephane Grosjean wrote:
> This patch adds the support for 4 new PCI boards based on the SJA1000 C=
AN
> controller, from PEAK-System Technik:
>=20
> . PCAN-miniPCIe (PCI-Express Mini slots, available as single or dual-ch=
annel)
> . PCAN-cPCI (CompactPCI format, available as single or dual-channel)
> . PCAN-PC/104-Plus (PC/104-Plus system, av. as 1, 2 or 4 channels)
> . PCAN-PCI/104-Express (PCI/104-Express system, av. as 1 or 2 channels)=

>=20
> This patch also fixes a typo in existing "PEAK_MPCI_DEVICE_ID" identifi=
er
> (missing "E" for Express). Finally, it also adds another author as well=
 as it
> updates the module supported devices list.

Thanks. I've taken the patch, tuned the commit message as Oliver pointed
out, changed the Author as Wolfgang suggested and updated the commit
message accordingly.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8B8B4625CCD0A6A9888491FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCHsBEACgkQjTAFq1RaXHN3DQCfdRNxRZ5Ns0JT3x6Eged2ENPU
nTMAn2tK5y+2MO33wdbhLbcFRhHNmMQm
=XtiT
-----END PGP SIGNATURE-----

--------------enig8B8B4625CCD0A6A9888491FD--

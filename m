From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] peak_pci: Fix the way channels are linked together
Date: Wed, 01 Feb 2012 11:16:48 +0100
Message-ID: <4F291110.7040804@pengutronix.de>
References: <1328090748-17459-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig898DC6FBB0E82FCD50EE0D68"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59354 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986Ab2BAKQu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 05:16:50 -0500
In-Reply-To: <1328090748-17459-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig898DC6FBB0E82FCD50EE0D68
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 11:05 AM, Stephane Grosjean wrote:
> Change the way channels objects are linked together by peak_pci_probe()=

> avoiding any kernel oops when driver is removed. Side effect is that
> the list is now browsed from last to first channel.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

applied to can-next
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig898DC6FBB0E82FCD50EE0D68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pERAACgkQjTAFq1RaXHNHowCgjVeVRnGNCdWqt+PVsK2PJ4ws
KHIAoIf30jJ49JL/zeBqvrrJ7XDq2/N1
=c+i5
-----END PGP SIGNATURE-----

--------------enig898DC6FBB0E82FCD50EE0D68--

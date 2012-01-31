From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] ems_usb: Removed double netif_device_detach
Date: Tue, 31 Jan 2012 23:03:48 +0100
Message-ID: <4F286544.1050809@pengutronix.de>
References: <4EF3B5ED.3040202@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig88C48B7B60CAD75EDA629FAE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46562 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2AaWDt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 17:03:49 -0500
In-Reply-To: <4EF3B5ED.3040202@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88C48B7B60CAD75EDA629FAE
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12/22/2011 11:57 PM, Sebastian Haas wrote:
> From fc832ed7b4c824007f73dc8618915bdfd6375e07 Mon Sep 17 00:00:00 2001
> From: Sebastian Haas <dev@sebastianhaas.info>
> Date: Thu, 22 Dec 2011 22:48:27 +0100
> Subject: [PATCH 1/2] ems_usb: Removed double netif_device_detach
>=20
> netif_device_attched is called twice when ems_usb_start fails with -ENO=
DEV
>=20
> Signed-off-by: Sebastian Haas <dev@sebastianhaas.info>

Can you please send with "git send-email" the next time. Your mailer
converts tabs to spaces. I applied your patch by hand.

Applied to can-next.
tnx Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig88C48B7B60CAD75EDA629FAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZUQACgkQjTAFq1RaXHNYogCeOSV8WJWFl+jNG009Gq3OCjAm
ZTwAn1utO5SDjnIwhuuWQQMihjGFk0o3
=sQdN
-----END PGP SIGNATURE-----

--------------enig88C48B7B60CAD75EDA629FAE--

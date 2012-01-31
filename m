From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] ems_usb: Improved memory handling on ems_usb_start
Date: Tue, 31 Jan 2012 23:04:03 +0100
Message-ID: <4F286553.3030704@pengutronix.de>
References: <4EF3B61A.5010404@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig73BEDAA12C97F2E095486C77"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46573 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2AaWEE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 17:04:04 -0500
In-Reply-To: <4EF3B61A.5010404@sebastianhaas.info>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: Linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73BEDAA12C97F2E095486C77
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 12/22/2011 11:58 PM, Sebastian Haas wrote:
> From 9d0d92d279255eed7f14b9fd70d1f0d181d4b301 Mon Sep 17 00:00:00 2001
> From: Sebastian Haas <dev@sebastianhaas.info>
> Date: Thu, 22 Dec 2011 23:27:47 +0100
> Subject: [PATCH 2/2] ems_usb: Improved memory handling on ems_usb_start=

>=20
> Do not return from ems_usb_start if allocation fails. If not all URBs
> could be allocated use the one already submitted.
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


--------------enig73BEDAA12C97F2E095486C77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZVMACgkQjTAFq1RaXHNGFgCdH6ENkpc7ncIXkRZHGro8ze/k
Jk8An2/dcyVvpoRCJu+OV67bm50QzVqq
=uv/t
-----END PGP SIGNATURE-----

--------------enig73BEDAA12C97F2E095486C77--

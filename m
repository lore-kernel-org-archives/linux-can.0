From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ti_hecc: use netif_rx in the interrupt
Date: Wed, 01 Feb 2012 11:00:50 +0100
Message-ID: <4F290D52.8070104@pengutronix.de>
References: <4F290ADF.90204@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6779B949683D881FA5067CE0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38363 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab2BAKAz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 05:00:55 -0500
In-Reply-To: <4F290ADF.90204@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6779B949683D881FA5067CE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 10:50 AM, Wolfgang Grandegger wrote:
> This patch fixes locking problems by using netif_rx() instead of
> netif_receive_skb() in ti_hecc_error() called from the interrupt
> context.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

applied to can-next
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6779B949683D881FA5067CE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pDVUACgkQjTAFq1RaXHN5nwCdHa5guFcjQMp+LwPekdNTqtkS
+GAAn2YPrnLbjcmZqdGZYPFIQG70NO3y
=Qj0c
-----END PGP SIGNATURE-----

--------------enig6779B949683D881FA5067CE0--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] import kernel header files into tree
Date: Wed, 11 Jan 2012 13:26:24 +0100
Message-ID: <4F0D7FF0.5020306@pengutronix.de>
References: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8DBBA3DD92DC2D60023A7C23"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57688 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab2AKM03 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 07:26:29 -0500
In-Reply-To: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-core@lists.berlios.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DBBA3DD92DC2D60023A7C23
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/2011 02:16 PM, Marc Kleine-Budde wrote:
> Hello,
>=20
> this patch series imports the kernel header files into the can-utils tr=
ee
> and adopts both Makefile and autotools. The autotools complete the
> "make distcheck" test and are tested for cross compildation.
> Plain old makefile support is still working, too.
>=20
> Please test and comment,
> regards, Marc

I've pushed the series to master + another patch replacing the contact
email by linux-can@vger.kernel.org.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8DBBA3DD92DC2D60023A7C23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8Nf/MACgkQjTAFq1RaXHOvvQCfSPIJ9JoLpdfMHxK9AUUffzPb
3hAAn1KRC9QzLvZE0bt4Ythjx3W1vT71
=/S50
-----END PGP SIGNATURE-----

--------------enig8DBBA3DD92DC2D60023A7C23--

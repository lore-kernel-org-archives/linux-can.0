From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: exclusive access to can interface
Date: Mon, 07 Jan 2013 19:16:20 +0100
Message-ID: <50EB10F4.6070308@pengutronix.de>
References: <2412937.XVpYjfC7zz@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1E4F0D0F329C73A36E0C97DC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58342 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab3AGSQ1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jan 2013 13:16:27 -0500
In-Reply-To: <2412937.XVpYjfC7zz@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1E4F0D0F329C73A36E0C97DC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/07/2013 05:52 PM, Alexander Stein wrote:
> is there a way to get exclusive (write) access to a CAN interface, so
> that only one bound socket can write CAN frames on the bus?

No, what's the use case?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1E4F0D0F329C73A36E0C97DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDrEPgACgkQjTAFq1RaXHPKZACbBi9OUobYwkkAXNdqbyx3Ei8u
pY8An0xGMzN6NoMzrmsUfah2wbYSJcCx
=m/eW
-----END PGP SIGNATURE-----

--------------enig1E4F0D0F329C73A36E0C97DC--

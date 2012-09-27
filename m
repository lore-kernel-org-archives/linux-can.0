From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: fix segfault during rmmod
Date: Thu, 27 Sep 2012 16:43:17 +0200
Message-ID: <50646605.8080909@pengutronix.de>
References: <1348748698-5635-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7F072552A1731C9807705D81"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41917 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab2I0On2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Sep 2012 10:43:28 -0400
In-Reply-To: <1348748698-5635-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F072552A1731C9807705D81
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/27/2012 02:24 PM, AnilKumar Ch wrote:
> This patch fixes an oops which occurs during unloading the driver.
> unregister_c_can_dev() is doing c_can/d_can module interrupts
> disable, which requires module clock enable. c_can/d_can interrupts
> enable/disable is handled properly in c_can_start and c_can_stop,
> so removing from unregister_c_can_dev().
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Thanks, I've added a reference to the commit that added the runtime pm
support. I'll send a pull request to David soon.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7F072552A1731C9807705D81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBkZgkACgkQjTAFq1RaXHPk8wCdFEgQoBn/SEVJBPzHrs/yKkan
P0YAnR6xbkFOGN26CXMi0RDCzBZ1xJpr
=xoNj
-----END PGP SIGNATURE-----

--------------enig7F072552A1731C9807705D81--

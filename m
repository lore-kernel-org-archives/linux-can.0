From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can-utils: add Makefile for Android build system
Date: Tue, 20 Mar 2012 11:08:55 +0100
Message-ID: <4F685737.6090700@pengutronix.de>
References: <1332236859-22204-1-git-send-email-yegorslists@googlemail.com> <1332236859-22204-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9783B8AF2A4F1C47B12627C5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59379 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab2CTKJK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Mar 2012 06:09:10 -0400
In-Reply-To: <1332236859-22204-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9783B8AF2A4F1C47B12627C5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/20/2012 10:47 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Looks a bit ugly to me (as a non Android developer) repeating some
variables so many times. Is it usual to write android makefiles like this=
?

There are some trailing whitespaces. No need to recommit the patch, I've
removed them.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig9783B8AF2A4F1C47B12627C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9oVzoACgkQjTAFq1RaXHPe6ACghrD7kpSdezIxTV16/dBEIaYD
n/0An11lNYG5jPa1jQGKut4JIuSdWR0B
=UpSm
-----END PGP SIGNATURE-----

--------------enig9783B8AF2A4F1C47B12627C5--

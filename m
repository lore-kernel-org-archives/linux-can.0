From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: 2.6 mscan driver
Date: Wed, 17 Jul 2013 19:12:36 +0200
Message-ID: <51E6D084.9010002@pengutronix.de>
References: <CACJ51z09w=Vb2+T9GT3fsf7XfS2Q9QX6yVA-Fr4a02QPUV_mrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2PXTHFWCQWUHSICICQLHI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42358 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab3GQRMo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Jul 2013 13:12:44 -0400
In-Reply-To: <CACJ51z09w=Vb2+T9GT3fsf7XfS2Q9QX6yVA-Fr4a02QPUV_mrw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Bell <andrew.bell.ia@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2PXTHFWCQWUHSICICQLHI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2013 06:56 PM, Andrew Bell wrote:
> I need to upgrade an old mscan driver that will run on version 2.6 of
> linux.  Can someone tell me where the current repository is for
> socketcan, and how I might obtain the "best" driver for 2.6?

The current mscan driver is mainline:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/

Old stuff can be found:
https://gitorious.org/linux-can/can-modules

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2PXTHFWCQWUHSICICQLHI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHm0IQACgkQjTAFq1RaXHN9LgCcD6vouHvjAy+UovkczGE0qpEF
GDoAmwc+Jk+JfmDG+DHQqY6PzkHzlBk7
=qy1H
-----END PGP SIGNATURE-----

------enig2PXTHFWCQWUHSICICQLHI--

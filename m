From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: request to queue "9b3d423 ARM: i.MX6q: fix the wrong parent of can_root
 clock" for stable
Date: Thu, 28 Nov 2013 11:24:01 +0100
Message-ID: <529719C1.7030402@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="drxRS0ARjDTA5ENebsp8PEGkqPm8ENiVF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55967 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3K1KYP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Nov 2013 05:24:15 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: stable@vger.kernel.org
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Jiada Wang <jiada_wang@mentor.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--drxRS0ARjDTA5ENebsp8PEGkqPm8ENiVF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Greg,

can you please queue

    9b3d423 ARM: i.MX6q: fix the wrong parent of can_root clock

for the stable trees.

This patch (and another, which is not yet upstream) is needed for
flexcan on mx6 to work properly.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |






--drxRS0ARjDTA5ENebsp8PEGkqPm8ENiVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKXGcEACgkQjTAFq1RaXHObMQCfS45nQM66ju4KEpmmAA6JCeoO
yvgAnRdZ8emj7bKkyduShkESydfUU4qQ
=eodV
-----END PGP SIGNATURE-----

--drxRS0ARjDTA5ENebsp8PEGkqPm8ENiVF--

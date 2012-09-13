From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v10] can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN
 controller
Date: Thu, 13 Sep 2012 11:27:54 +0200
Message-ID: <5051A71A.6080800@pengutronix.de>
References: <1347525263-28414-1-git-send-email-mkl@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2E2E3@DBDE01.ent.ti.com> <5051A40F.2090205@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA2E345@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig158543753990B478F701904F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34447 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686Ab2IMJ2B (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Sep 2012 05:28:01 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA2E345@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig158543753990B478F701904F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/13/2012 11:20 AM, AnilKumar, Chimata wrote:
[...]

>>> While committing "Adopt pinctrl support" patch on top
>>> of this patch I saw some error, can you fix that?
>>
>> Sure, already done :) I'll force push that on net-next/master

Done, can you please retest.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig158543753990B478F701904F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBRpx4ACgkQjTAFq1RaXHN7iwCeLwRU0lKsCQ7inDTSyGMzAniJ
EO8Ania1mDxjzGJdDScKaUxuWC3ws4K+
=wKR2
-----END PGP SIGNATURE-----

--------------enig158543753990B478F701904F--

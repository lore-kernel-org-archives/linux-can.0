From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gs_usb: Fix typo in function name
Date: Wed, 1 Jul 2015 10:05:31 +0200
Message-ID: <55939F4B.8030504@pengutronix.de>
References: <1435619397-9333-1-git-send-email-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9g6WGMANi0ldgDddPRn8gCnLgAnuHboJJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36495 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbbGAIFl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Jul 2015 04:05:41 -0400
In-Reply-To: <1435619397-9333-1-git-send-email-nikolas@gnu.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nik Nyby <nikolas@gnu.org>, wg@grandegger.com, linux-can@vger.kernel.org, trivial@kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9g6WGMANi0ldgDddPRn8gCnLgAnuHboJJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2015 01:09 AM, Nik Nyby wrote:
> This fixes typos in gs_usb.c where 'receive' is misspelled
> as 'recieve'.

Applied to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9g6WGMANi0ldgDddPRn8gCnLgAnuHboJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVk59LAAoJEP5prqPJtc/HzgwH/iTYpptbINzyXhOtx7YApkzw
+TIp4/3+Lq+FqEH571jxD4hOHvzztGZZhizS77O264MH9snHXXIjg6z2lPhd3bLf
ckVKGYS9MOpqQwxPyik769flCqcpwlkwzKwlZZouEU/gVFH4eOS/nqFKXZHpdYoy
sGVBWE0AdCUcpy4WLtH7L7CbjLV8g4Jsn4/pt1/TBPifJqNxPoJRJpN5kzoPVChO
AdBG6thZMKBI5bGaDssfVLf+RSbcfvk0Y7rHVOwJpvPqJdXlWp76Ahme69sDEjmu
H/1FHOHZisAxquDae9n45rkN0yRiFw9w27sTfAaJ0TAdY8R048+t7xAIeFd4cI4=
=vs72
-----END PGP SIGNATURE-----

--9g6WGMANi0ldgDddPRn8gCnLgAnuHboJJ--

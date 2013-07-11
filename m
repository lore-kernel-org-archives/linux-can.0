From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: slcan2d
Date: Thu, 11 Jul 2013 11:30:29 +0200
Message-ID: <51DE7B35.90807@pengutronix.de>
References: <CAGm1_kt9Pd_JjfBJSWMHMJaq3eyKE2LpBjk5323Waksz1vQYPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XJEQVVQSWTFPSWMDCLNS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50682 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab3GKJai (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 11 Jul 2013 05:30:38 -0400
In-Reply-To: <CAGm1_kt9Pd_JjfBJSWMHMJaq3eyKE2LpBjk5323Waksz1vQYPg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XJEQVVQSWTFPSWMDCLNS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2013 10:38 AM, Yegor Yefremov wrote:
> Trying to commit slcan2d.c
> (https://github.com/yegorich/can-utils/commits/slcan2d) and my git
> 1.7.7 renames slcand.c because it looks quite similar. How can I
> prevent this? So far I found no option for git commit command.

Do you mean commit "90c9b2f slcan2d: add new slcan daemon"? git doesn't
rename Files if you don't tell git to do so. However git may optimize
and treat your new slcan2d as a copy+modifications of slcand.

If I check out commit 90c9b2f, there is slcand.c and slcan2d.c:

> =E2=9E=9C (pts/25) frogger@hardanger:gitorious/can-utils (master) git c=
heckout 90c9b2fcf644b9c5924983114f951b334039f665
> Note: checking out '90c9b2fcf644b9c5924983114f951b334039f665'.
[...]
> HEAD is now at 90c9b2f... slcan2d: add new slcan daemon
> =E2=9E=9C (pts/25) frogger@hardanger:gitorious/can-utils ((90c9b2f...))=
 ll slcan*d.c
> -rwxr-xr-x 1 frogger frogger 12022 Jul 11 11:27 slcan2d.c
> -rw-r--r-- 1 frogger frogger  7777 Feb 12 17:57 slcand.c

You probably want to remove the executable bit from your slcan2d.c :) So
far everything looks good.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XJEQVVQSWTFPSWMDCLNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHeezUACgkQjTAFq1RaXHPtUwCeI28Oty1ViQ0xGc++czc9d6ht
1BsAnjYUiDsMx71M3lhKyquwDfI2f909
=4jZ7
-----END PGP SIGNATURE-----

------enig2XJEQVVQSWTFPSWMDCLNS--

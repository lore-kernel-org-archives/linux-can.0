From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: resolve signedness warnings
Date: Thu, 19 Apr 2012 18:03:30 +0200
Message-ID: <4F903752.1080709@pengutronix.de>
References: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com> <4F8FD2C1.8010903@pengutronix.de> <4F903362.3070703@hartkopp.net> <4F9035E8.1020704@pengutronix.de> <20120419160138.GC24987@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig19C92988081C8553D6B86C12"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab2DSQDf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 12:03:35 -0400
In-Reply-To: <20120419160138.GC24987@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, yegorslists@googlemail.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig19C92988081C8553D6B86C12
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/19/2012 06:01 PM, Wolfram Sang wrote:
>>> What would be the right way to apply it with your Acked-by too?
>>
>> I usually do a $(git commit --amend) after the $(git am -s) and paste
>> the Acked-by. Maybe there are some more elaborative ways to do so :)
>=20
> That's usually handwork.

If you have to add you S-o-b to a huge branch you can use things like
git filte-branch

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig19C92988081C8553D6B86C12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+QN1IACgkQjTAFq1RaXHO6OACgghTA4yVw9BzoNZ1wdJUDY2wx
CF8AoJdnxdYeFdTrNFk1YyErwm5zloXm
=kJZA
-----END PGP SIGNATURE-----

--------------enig19C92988081C8553D6B86C12--

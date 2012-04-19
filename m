From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] candump: resolve signedness warnings
Date: Thu, 19 Apr 2012 17:57:28 +0200
Message-ID: <4F9035E8.1020704@pengutronix.de>
References: <1334821446-2925-1-git-send-email-yegorslists@googlemail.com> <4F8FD2C1.8010903@pengutronix.de> <4F903362.3070703@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9E6BE09CA6F3FF2FD4BBA32"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50931 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2DSP5g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Apr 2012 11:57:36 -0400
In-Reply-To: <4F903362.3070703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: yegorslists@googlemail.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9E6BE09CA6F3FF2FD4BBA32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/19/2012 05:46 PM, Oliver Hartkopp wrote:
>> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> Oliver do you want to take the patch?

> Yes. I applied it to the git repo.
>=20
> I did it with
>=20
> git am --signoff < candump.patch

You can save some precious keystrokes:

git am -s candump.patch

> using the original mail from Yegor.
>=20
> Unfortunately that missed your Acked-by: ...

No problem.

> What would be the right way to apply it with your Acked-by too?

I usually do a $(git commit --amend) after the $(git am -s) and paste
the Acked-by. Maybe there are some more elaborative ways to do so :)

> I assume applying your answered mail won't have made it, right?

Hehe :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB9E6BE09CA6F3FF2FD4BBA32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+QNesACgkQjTAFq1RaXHPLvQCeMs8etU6E232+IPNHwwQQCuMh
d0gAoJns9mUqQNW3i4c+7xw2A78E17Le
=yAr8
-----END PGP SIGNATURE-----

--------------enigB9E6BE09CA6F3FF2FD4BBA32--

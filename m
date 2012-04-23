From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Update of linux-can-next
Date: Mon, 23 Apr 2012 09:15:45 +0200
Message-ID: <4F9501A1.10901@pengutronix.de>
References: <4F93C956.5030008@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig70BD524ABB50D7013E26D618"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43004 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2DWHPy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Apr 2012 03:15:54 -0400
In-Reply-To: <4F93C956.5030008@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig70BD524ABB50D7013E26D618
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/22/2012 11:03 AM, Oliver Hartkopp wrote:
> i created myself a personal clone of linux-can-next for some CAN FD exp=
eriments.
>=20
> Doing that i thought it should be a good idea to update the linux-can-n=
ext
> tree, so i did:

Yes - good idea.

> linux-can-next$ git pull
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git master=

>=20
> linux-can-next$ git push

As long as you don't have any modifications on your master that's correct=
=2E

> Now the latest commit from net-next appears here, as expected:
>=20
> https://gitorious.org/linux-can/linux-can-next/commits/master

I updated my repo and I see linux-can-next/master is the same as the
current net-next/master. So your push worked.

> Which is good in the first place :-)
>=20
> But i don't see myself in the activities from linux-can-next tree here:=

>=20
> https://gitorious.org/linux-can/linux-can-next
>=20
> Did i miss anything?

Hmm strange. I basically do the same when pushing updates to
linux-can-next. I just deleted an old branch and this shows up in the
activities: https://gitorious.org/linux-can/linux-can-next

Maybe there is some kind of privacy option in the profiles?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig70BD524ABB50D7013E26D618
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+VAaUACgkQjTAFq1RaXHOuPgCfZu8X2flXToZZIEAIJ3hlaX18
BcUAnRrCFECzMc5eNQ7meq97JO0C2qfy
=DZng
-----END PGP SIGNATURE-----

--------------enig70BD524ABB50D7013E26D618--

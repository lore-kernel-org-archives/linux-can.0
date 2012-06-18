From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 21:27:30 +0200
Message-ID: <4FDF8122.8050608@pengutronix.de>
References: <4FDF67B2.1090004@hartkopp.net> <4FDF7D0E.1000802@pengutronix.de> <4FDF7E10.9050301@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1ED096DC9E85D24693608920"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60847 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2FRT1f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:27:35 -0400
In-Reply-To: <4FDF7E10.9050301@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1ED096DC9E85D24693608920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/18/2012 09:14 PM, Oliver Hartkopp wrote:
>>> You can also pull the series ;-)
>>
>> I can pull, but David want's to have a clean tree. So I have to pull a=
nd
>> rebase it on my tree.
>=20
>=20
> I created a branch 'canfd' on a clone of *your* can-next.

No need for that. git pull --rebase works.
>=20
> What's not clean there?
>=20
> You can pull Daves net-next and then pull the canfd branch, right?

Yes, but David wants to have a clean linear series of patches, not with
merges in it.

>>> Git is hard for newbies but i gave my very best ...
>>
>> Once you can use it, you don't want to code without it.

> Yes -  it's getting better. Indeed it looks like Thunderbird mangles th=
e mails
> when editing the draft mails.

Don't do that :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1ED096DC9E85D24693608920
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/fgSUACgkQjTAFq1RaXHM9lwCeP8o7om7xqLS3W9D6QSkJl1pq
T5kAnjC/CtYOHGKNN1MKBRXI/8tgPbX4
=PyyA
-----END PGP SIGNATURE-----

--------------enig1ED096DC9E85D24693608920--

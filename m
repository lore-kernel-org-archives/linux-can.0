From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Adding new CAN driver
Date: Wed, 2 Nov 2016 09:48:32 +0100
Message-ID: <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rGh7xMGw89G6feft9mXJJ3d2EOO3aGL7m"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48290 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752550AbcKBIsm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 04:48:42 -0400
In-Reply-To: <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rGh7xMGw89G6feft9mXJJ3d2EOO3aGL7m
Content-Type: multipart/mixed; boundary="Km2I72KRAEdUbSl3r8On6H08vmTkM2Rsj";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>,
 Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ddb4ed13-819f-ad8c-8ce2-da7585a79098@pengutronix.de>
Subject: Re: Adding new CAN driver
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
 <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
 <CAKT-o-cZryPfqkU2rOPu1SdEp8imkTke_NzVgwgghOY6RxrZmg@mail.gmail.com>
 <22552.25820.453841.413376@gargle.gargle.HOWL>
 <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>
In-Reply-To: <CAKT-o-d_tLkZgAuJz7rrRaDPxmi3hDiLmVhLcpjNBc1weDLvyg@mail.gmail.com>

--Km2I72KRAEdUbSl3r8On6H08vmTkM2Rsj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/02/2016 08:23 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
> Hi Uwe,
>=20
> Not sure if you are asking about termination or about the driver
> itself, so let me give two answers.
>=20
> I'll try to send the patch till end of this week. In the meantime you
> may still use the driver from the github repository
> (https://github.com/rkollataj/mcba_usb). I am keeping it up to date.
>=20
> I didn't get a chance to work on adding support for termination to
> "ip". Before investing any effort I would prefer to get confirmation
> from Oliver of Marc that the direction is right. Anyway setting up
> termination via sysfs works just fine. It is described in readme file
> in repository.

I'd like to see a netlink interface for this. Oliver what about adding
it to CTRL_MODE?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Km2I72KRAEdUbSl3r8On6H08vmTkM2Rsj--

--rGh7xMGw89G6feft9mXJJ3d2EOO3aGL7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJYGahgAAoJED07qiWsqSVqAiIH/A7Ml1wGpcQPORbtCOmus0eI
ZTcvhnyCMkW9VDersbntLo21U8kjltcdsROs+E0sjZqXmsvKcBfQw1JIfq9etOG0
qmYL8+uXsCnf9c5Z7Kf4knhJ6gqg2uer9jfekQqW8qCTcOfEW5inX+1LBY9MnwsN
+rl6a2oij2I+c1vEteF7qwoE++2PP3cjhPLNKaqV2U7LQ7sQRo6oQhQKt/CLVBEB
zLWe5fGN//3T9F+SECQ1TKTIhabVBG5AHcgNINkpQNnm9O/OeoO0bTYE+PFjixtG
zhKM+/lik506HZRPb/lgdjbsvlZvalivuhWtSxCZb7dljMrgconnphM7swmddb0=
=GINB
-----END PGP SIGNATURE-----

--rGh7xMGw89G6feft9mXJJ3d2EOO3aGL7m--

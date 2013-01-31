From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] beginner question: can more than one application
 use one SocketCAN CAN Interface at the same time??
Date: Thu, 31 Jan 2013 11:15:37 +0100
Message-ID: <510A4449.2000706@pengutronix.de>
References: <2B7735628AAB044EBC7362D10ED87CE2C850BA11F9@haex.Hamm.lokal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GCADDTCSFVPBJAOXWRXX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab3AaKPj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Jan 2013 05:15:39 -0500
In-Reply-To: <2B7735628AAB044EBC7362D10ED87CE2C850BA11F9@haex.Hamm.lokal>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus.Golbs@hamm.eu
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GCADDTCSFVPBJAOXWRXX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Markus,

please use linux-can@vger.kernel.org (Cc'ed), as the berlios list is
outdated.

On 01/31/2013 09:45 AM, Markus.Golbs@hamm.eu wrote:
> I=92m new by using SocketCAN. The shell communication on an arm board w=
ith
> SocketCAN works well, but I=92m only use one access task/program to one=

> CAN Interface.
>
> My question is, can I use the SocketCAN network Interface from more as
> on application on the same time? I want create two ANCI-C application o=
n
> this board for different functions. The two applications to integrate i=
n
> one, is it not possible. If it possible that both applications use the
> same CAN Interface at the same time? About information I=92m very happy=
=2E

You can open as many sockets from as many applications to CAN as you
want (until you memory runs out) and send and receive CAN messages.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




------enig2GCADDTCSFVPBJAOXWRXX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEKREkACgkQjTAFq1RaXHN5AwCfRhBMceaC71AnTrTLGL6P6Asn
v8wAnix1Dscd+0a178BQW1fXkHV6zXF7
=Wno8
-----END PGP SIGNATURE-----

------enig2GCADDTCSFVPBJAOXWRXX--

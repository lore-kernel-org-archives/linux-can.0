From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: skbuff panic
Date: Fri, 11 Jul 2014 19:48:46 +0200
Message-ID: <53C0237E.7010504@pengutronix.de>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com> <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com> <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com> <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net> <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com> <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com> <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com> <53BFE637.2030905@hartkopp.net> <CANGgnMYJ+eLGeMiLuTXQONpC6B1GSW6gPkk-u=ATcVNijLN5rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4DjTF79FEI2KDPxRC9u5vop2HJW4KJH3K"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45069 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbaGKRs5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 13:48:57 -0400
In-Reply-To: <CANGgnMYJ+eLGeMiLuTXQONpC6B1GSW6gPkk-u=ATcVNijLN5rA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Austin Schuh <austin@peloton-tech.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4DjTF79FEI2KDPxRC9u5vop2HJW4KJH3K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2014 04:58 PM, Austin Schuh wrote:
> On Fri, Jul 11, 2014 at 6:27 AM, Oliver Hartkopp <socketcan@hartkopp.ne=
t> wrote:
>> Thanks for testing, Austin!
>>
>> I'll cook a patch for stable to add these settings.
>> Even if we do not know why someone requests obviously all netdev skbs =
and
>> treats them to be Ethernet/IP packets we should fix it in our code.
>>
>> If we fix it somewhere else it will last one year until some of the
>> is-there-anything-else-than-ethernet-networking guys will break it aga=
in.
>> ;-)
>=20
> Is it worth debugging why as well?  Defense in layers?

Anything new about the kernel-dhcp?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4DjTF79FEI2KDPxRC9u5vop2HJW4KJH3K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPAI34ACgkQjTAFq1RaXHMAJgCdFuBcoPaR9VXWbYYGbxaBrrzo
jpEAnArxim7zWrREMyV41lDT6/IpRzpI
=zSro
-----END PGP SIGNATURE-----

--4DjTF79FEI2KDPxRC9u5vop2HJW4KJH3K--

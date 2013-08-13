From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Booting issue
Date: Tue, 13 Aug 2013 15:25:04 +0200
Message-ID: <520A33B0.9030408@pengutronix.de>
References: <CANdmM3ONppmuVUrvaMmBXhJktT8r7JXsB3Bw-yyM4i7M7MaJSg@mail.gmail.com> <520A3365.4050909@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BmIcMWmsoJFdDeBTaBPUpc0J9KtbosQve"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55555 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757753Ab3HMNZG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Aug 2013 09:25:06 -0400
In-Reply-To: <520A3365.4050909@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kedari Appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BmIcMWmsoJFdDeBTaBPUpc0J9KtbosQve
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/13/2013 03:23 PM, Marc Kleine-Budde wrote:
> On 08/13/2013 01:21 PM, Kedari Appana wrote:
>> Hi,
>>                I am able to boot the linux for my SOC which contains
>> CAN.After booting i can see it in dmesg as well as in ifconfig can0
>> command .When i using ifconfig can0 up command system hang up.What was=

>> the problem.Is there any solution for it

Which SoC are you using?
Which CAN controller is on that SoC?
Which Kernel version are you using?
Who provided you the kernel?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BmIcMWmsoJFdDeBTaBPUpc0J9KtbosQve
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIKM7AACgkQjTAFq1RaXHOUGACgk7Kd0Za+F12F/4T6U05BzwfI
SVsAn3JPKhnOfSC+GHgeGo1ZG96QJY/K
=6JFl
-----END PGP SIGNATURE-----

--BmIcMWmsoJFdDeBTaBPUpc0J9KtbosQve--

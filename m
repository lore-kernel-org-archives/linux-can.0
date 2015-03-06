From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: MOVED TO GITHUB: Linux-CAN user space source repositories
Date: Fri, 06 Mar 2015 09:03:00 +0100
Message-ID: <54F95F34.7090708@pengutronix.de>
References: <CAGm1_ksdokuRQ8kAfX+EsjYAzZj3UXn5XH2duS2TMX_NjaYnUg@mail.gmail.com> <54F8A933.1040309@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VQAxwADeUhDFd8CU7ncM5j3rUFkENSUp7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58671 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbCFIDI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Mar 2015 03:03:08 -0500
In-Reply-To: <54F8A933.1040309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VQAxwADeUhDFd8CU7ncM5j3rUFkENSUp7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/05/2015 08:06 PM, Oliver Hartkopp wrote:
> As Gitorious is to be acquired by GitLab and gitorious.org will shut do=
wn at=20
> end of May the Linux-CAN / SocketCAN git repositories have to be moved =
away=20
> from https://gitorious.org/linux-can/
>=20
> As many of you already have a GitHub account Marc and I agreed on follo=
wing=20
> Yegors suggestion to move the Linux-CAN / SocketCAN repos to GitHub.
>=20
> You can now find the Linux-CAN repositories at:
>=20
> 	https://github.com/linux-can/

I'll prepare a patch for MAINTAINERS. While there I want to add myself
as a maintainer for the networking layer aswell, so that I'll be on Cc
when get_maintainer.pl is used. Objections?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VQAxwADeUhDFd8CU7ncM5j3rUFkENSUp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU+V83AAoJECte4hHFiupU8esP/3UOQZc1+RyYgepQ/pzdpa8h
8j2cqc/7O0jdaxIpkpX2+6nEO25X7xVCbhTBnzUuUZNTOUVfMRCUhE/qJHWf0ht8
yAEe1EFwKScqDEYqLHbiBdqm8TRHg05/nuHVLptxzzRa/LWaAH/oIaXeUGu3QrbI
EFH9EzVN64FqbIb9OfXUxYgAX85RJzO7ENPfUuV+2JC9LqmoWOUfgRtsgDta5Uaw
OE9FRTK4tWAZLHf3woQmYZwSdqkYdvX4c5tVhiFhKyIExb0SGMEK7rTBX8Erl+Yg
MAu9ogs8iGOIfqdO3ukogs2xH08M1LTTPaqVLl/mZPXOw7WIR06UIl37X6zU7A0o
xkE5U1P5Jo77AfgW5MHyuPNzU647TLxzkUg5G9W220HBSgPC0Xt9mB7i0/qXYtS4
iX4iC1WVUnMdZpHAtKrYtpIcxEGzEBkygP1wEHK3O/CZM769o+xaEfzBbo8rL0JN
dtCL5bb3QpGP2stZWY09XPR3e99Ou+HdNP+Jd0Hl99AeJRp7e5j280HFE/igHClE
kS9k/bOa7UlWhSRPVS03x8JPuqESYiXu261cSv2UFhR3VEU56xoqjijJicbZUH39
VGMGha50HGu7zKZ6oKh7VCw8LZIhKiTWtBG6ODbOJG0NaUmXmJZEbHnQ25K9X4mm
PxtxAYe7t2qA0BLx2qXs
=qY1e
-----END PGP SIGNATURE-----

--VQAxwADeUhDFd8CU7ncM5j3rUFkENSUp7--

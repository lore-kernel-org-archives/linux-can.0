From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
Date: Thu, 8 Feb 2018 16:05:17 +0100
Message-ID: <a03d5020-b257-4a81-1b59-bb91102ebe5a@pengutronix.de>
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <480B3397-A3D5-4B24-901A-AA9C23DC43C1@vandijck-laurijssen.be>
 <CAHChkrtVGAUG=xwcD6c3YLZ8kvGi9EoucbtvY4H2_GU=i8Q7wg@mail.gmail.com>
 <b42195d6-7d59-edce-1eef-0e3d272e5495@hartkopp.net>
 <20180206201650.GD1198@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gWYeCbLXqKWYFmsbNf2M2daMbvui46KxX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46833 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeBHPGI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Feb 2018 10:06:08 -0500
In-Reply-To: <20180206201650.GD1198@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWYeCbLXqKWYFmsbNf2M2daMbvui46KxX
Content-Type: multipart/mixed; boundary="LeXwTzVM5wGhogNz6axQOgHUAUoiyXEWw";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org
Message-ID: <a03d5020-b257-4a81-1b59-bb91102ebe5a@pengutronix.de>
Subject: Re: j1939: Attempt to make j1939 network namespace-aware
References: <CAHChkrvE+uczdhu66snkAt8p2AfgM=sKraaxFJTRDCSXjdS24g@mail.gmail.com>
 <480B3397-A3D5-4B24-901A-AA9C23DC43C1@vandijck-laurijssen.be>
 <CAHChkrtVGAUG=xwcD6c3YLZ8kvGi9EoucbtvY4H2_GU=i8Q7wg@mail.gmail.com>
 <b42195d6-7d59-edce-1eef-0e3d272e5495@hartkopp.net>
 <20180206201650.GD1198@airbook.vandijck-laurijssen.be>
In-Reply-To: <20180206201650.GD1198@airbook.vandijck-laurijssen.be>

--LeXwTzVM5wGhogNz6axQOgHUAUoiyXEWw
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 02/06/2018 09:16 PM, Kurt Van Dijck wrote:
>> Elenita is right. The idea is to have different network namespaces (e.=
g. to
>> be used in (Docker-)containers) where each namespace has its own priva=
te
>> view to the network.
>=20
> So absolutely nothing is/should be shared between the namespaces
> from the userspace point of view?
>=20
> So the ideal j1939 implementation that shares nothing between
> interfaces only needs to forward an extra namespace parameter?
>=20
> How about ... /proc parameters? or Module parameters?
> or is that the main argument against them?

For now all proc related stuff is removed. There are two clean patches
to add things back or rather have them for reference in the j1939-proc
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/lo=
g/?h=3Dj1939-proc

> Can different namespaces re-use interface numbers (ifindex)?
>=20
> Anyway, I can start to take a look.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--LeXwTzVM5wGhogNz6axQOgHUAUoiyXEWw--

--gWYeCbLXqKWYFmsbNf2M2daMbvui46KxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlp8Zy8ACgkQk9IU1zQo
ZfHNrwf/U6RZ7r3oWXnBg5VK01mDW9b7RqsYA7sz9DxrqA8Ibtqv+wcrgN2a7yIH
DxdTtk3raSuvTi/it4xsG9gnofeaGPKZp0VmzNqOVrjwhLEy/F5nS9LF34aScgQG
SMZvnpgKgevlFxEkE+RHSjt2QG9uSW8KHXv9XiLOucvvhgu+Yx9jYOvdwUF4cA42
SpIY9NA8WFwcBkqvPIFMJDPRtKo8P5RXeuQaCK3czVJNjgfsdTsRNLJD1IxSIpJB
SYUcqmN5NUSQ8UNLxvi4sM+o/G7wodyrPmoPxPLuF19PLomllUnrYlfKMTQ2hyW3
9tT3/WtUX2Y3qvlzaYOHi9kh84Nltg==
=D8KW
-----END PGP SIGNATURE-----

--gWYeCbLXqKWYFmsbNf2M2daMbvui46KxX--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Tue, 15 Aug 2017 10:14:18 +0200
Message-ID: <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GkXo2iGxAa0b6b37j4bJs9dvTvv9JLrkE"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48983 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751175AbdHOIO1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Aug 2017 04:14:27 -0400
In-Reply-To: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GkXo2iGxAa0b6b37j4bJs9dvTvv9JLrkE
Content-Type: multipart/mixed; boundary="WEiMt8AalqUrcJEpVQXkjMpTJdDiUdMCi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 linux-can <linux-can@vger.kernel.org>
Cc: David Jander <david@protonic.nl>
Message-ID: <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
In-Reply-To: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>

--WEiMt8AalqUrcJEpVQXkjMpTJdDiUdMCi
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 07:37 PM, Marc Kleine-Budde wrote:
> - Should a second bind() be allowed on a previously bind() socket?
>=20
> As far as I understand the code, there's some support, but when the
> interface is switched, j1939_ifindex_stop() is not called.

Ah, there's a check, that you cannot re-bind() to another interface:

> 		if (bound_dev_if !=3D addr->can_ifindex)

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WEiMt8AalqUrcJEpVQXkjMpTJdDiUdMCi--

--GkXo2iGxAa0b6b37j4bJs9dvTvv9JLrkE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmSrVsACgkQHv7KIOw4
HPYbowf/fb5JF2JXm3aGlSGYbVT9hogc0VaydImzDLDC/8pbpkOBXjThJSrrhvxu
duxMxhr1Lw6WibKIQJJKoTEVj4GpQh3x6nNIslx4ek7y21rAE9u5Bn7MEaRl/4YH
usthG5WxlFGMpxj5Brnu/uRW/g8CWmmV8VG9FEZC1jqvoe6OjgokAK6HNc4ipm4D
bmMujyX1A67Td2tkbWWvr5QeaH4LcJZffTSWZJwHHM7arKL7FYMa8SObLawyISM8
vo1FDkMoYYAxm52/oIVRIkNJOvKr0nTas7P7q1gwQv+2qIPQL6Om8OEtI91avff8
HyPw4o2oanz8tj7P9ABLzeDDPJR2Jg==
=cSO1
-----END PGP SIGNATURE-----

--GkXo2iGxAa0b6b37j4bJs9dvTvv9JLrkE--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Wed, 16 Aug 2017 12:06:50 +0200
Message-ID: <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7mmnf7Na4wSqWVjbETW6fcsj5mCml71WO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57035 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbdHPKG6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 06:06:58 -0400
In-Reply-To: <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7mmnf7Na4wSqWVjbETW6fcsj5mCml71WO
Content-Type: multipart/mixed; boundary="d5MB5IPq8IkF0BeSetrR2k3WGxX4Rp8nf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
In-Reply-To: <20170816093454.GC32670@airbook.vandijck-laurijssen.be>

--d5MB5IPq8IkF0BeSetrR2k3WGxX4Rp8nf
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 11:34 AM, Kurt Van Dijck wrote:
>> Hello Kurt,
>>
>> I've a few questions about the j1939 socket model:
>>
>> - Should bind() be allowed to any interface, i.e. with can_ifindex =3D=
=3D 0?
>>
>> I don't think so, but it's never checked for this.
>=20
> I'll explain a bit what I tried to accomplish:
> * allow bind to any interface, for receive packets only (obviously)
> * for rx/tx, only bind to 1 interface.

Have you tested this? If I understand the code correctly
j1939_ifindex_start() will not be called. So you will only receive
packages from interfaces someone has other socket has bind() to, thus
called j1939_ifindex_start(). And you'll stop receiving packages once
the last socket on that interfaces is closed.

>> - Should a connect() without a previous bind() be allowed?
>>
>> It's not checked for, but the error handling in sk_connect doesn't tak=
e
>> that into account.
>=20
> Like UDP will auto-bind to the first known local address ...
> Then an application would not need to know the local address to use.

Which will be:

> static int j1939sk_init(struct sock *sk)
> {
[...]
> 	jsk->addr.sa =3D J1939_NO_ADDR;
> 	jsk->addr.da =3D J1939_NO_ADDR;
> 	jsk->addr.pgn =3D J1939_NO_PGN;
[...]
> }

> static int j1939sk_connect(struct socket *sock, struct sockaddr *uaddr,=

> 			   int len, int flags)
[...]
> 		j1939_name_local_get(priv, jsk->addr.src);
> 		j1939_addr_local_get(priv, jsk->addr.sa);

right? Does this work, as sendmsg tests:

> static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, siz=
e_t size)
> {
[...]
> 	if (jsk->addr.sa =3D=3D J1939_NO_ADDR && !jsk->addr.src)
> 		/* no address assigned yet */
> 		return -EBADFD;
>=20

>> - Should a second bind() be allowed on a previously bind() socket?
>=20
> Yes, definitely.
> This is required to support dynamic addressing without possible losing
> relevant messages.

With changing the interface or not?

>> As far as I understand the code, there's some support, but when the
>> interface is switched, j1939_ifindex_stop() is not called.
>>
>> - Should a second conect() be allowed on a previously connect() socket=
?
>=20
> Never thought on that. This would equally be necessary when the remote
> changes SA, but I consider this not a core requirement, since changing
> SA implies possible glitches in the upper applications anyway.
> closing socket and reopening a new one is allowed in that case.

So I'll add a check against a re-connect().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--d5MB5IPq8IkF0BeSetrR2k3WGxX4Rp8nf--

--7mmnf7Na4wSqWVjbETW6fcsj5mCml71WO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmUGToACgkQHv7KIOw4
HPYgcgf+NbYRknaGGDeCMyE6qa/XUPNuR+99i1RLj91uqnDAub6BkFT25qW3uBgY
b9fKvuYrzxJtsFak8NPhDRlxkBaiGO+Og2JSvZSdADtFPv+zJ4sos2geCoK17p6Y
FA3TlfDjpgz5nQ23HIAo2abDr0bv1AsvHyq1gu+5cYTqCt6v2NskeEkFDk46JgDo
WRZjw9smJ8qlL6xaS0wJYnBDX8uUt7nDDvu69O+oOi4PjZjv7zZzjwu1yPCLpA9n
itZY6KdaCqHwZEVbZCallNQ8cs2Q5U1OGBqF5OLUFipOkIXR7T5c7TVY4zOEWb3Z
egx6nsDH9vC14qdRZP5HCOEgSHQuQA==
=sS/b
-----END PGP SIGNATURE-----

--7mmnf7Na4wSqWVjbETW6fcsj5mCml71WO--

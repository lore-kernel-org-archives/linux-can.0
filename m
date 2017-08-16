From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: j1939: bind() and connect()
Date: Wed, 16 Aug 2017 12:47:14 +0200
Message-ID: <29c93555-7aff-ec3c-d917-69b36c1c0125@pengutronix.de>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
 <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IXR1kV8Dm6b6q0QGpqApBOcJTcuSsXu9D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48173 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbdHPKrT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Aug 2017 06:47:19 -0400
In-Reply-To: <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IXR1kV8Dm6b6q0QGpqApBOcJTcuSsXu9D
Content-Type: multipart/mixed; boundary="4idDe2Jk2pxdrwwRFBJs9tHbAQURq4KJ9";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>
Message-ID: <29c93555-7aff-ec3c-d917-69b36c1c0125@pengutronix.de>
Subject: Re: j1939: bind() and connect()
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <20170816093454.GC32670@airbook.vandijck-laurijssen.be>
 <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>
In-Reply-To: <69814fe9-0e29-96d7-9ae2-cc4a600f3729@pengutronix.de>

--4idDe2Jk2pxdrwwRFBJs9tHbAQURq4KJ9
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/16/2017 12:06 PM, Marc Kleine-Budde wrote:

>>> - Should a connect() without a previous bind() be allowed?
>>>
>>> It's not checked for, but the error handling in sk_connect doesn't ta=
ke
>>> that into account.
>>
>> Like UDP will auto-bind to the first known local address ...
>> Then an application would not need to know the local address to use.
>=20
> Which will be:
>=20
>> static int j1939sk_init(struct sock *sk)
>> {
> [...]
>> 	jsk->addr.sa =3D J1939_NO_ADDR;
>> 	jsk->addr.da =3D J1939_NO_ADDR;
>> 	jsk->addr.pgn =3D J1939_NO_PGN;
> [...]
>> }
>=20
>> static int j1939sk_connect(struct socket *sock, struct sockaddr *uaddr=
,
>> 			   int len, int flags)
> [...]
>> 		j1939_name_local_get(priv, jsk->addr.src);
>> 		j1939_addr_local_get(priv, jsk->addr.sa);
>=20
> right? Does this work, as sendmsg tests:
>=20
>> static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, si=
ze_t size)
>> {
> [...]
>> 	if (jsk->addr.sa =3D=3D J1939_NO_ADDR && !jsk->addr.src)
>> 		/* no address assigned yet */
>> 		return -EBADFD;
>>

sendmsg() will fail, as it checks if the socket is in bound state.

> static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, siz=
e_t size)
> {
> 	struct sock *sk =3D sock->sk;
> 	struct j1939_sock *jsk =3D j1939_sk(sk);
> 	struct sockaddr_can *addr =3D msg->msg_name;
> 	struct j1939_sk_buff_cb *skcb;
> 	struct sk_buff *skb;
> 	struct net_device *dev;
> 	int ifindex;
> 	int ret;
>=20
> 	/* various socket state tests */
> 	if (!(jsk->state & J1939_SOCK_BOUND))
> 		return -EBADFD;
>=20
Receiving doesn't work, but I don't know why.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4idDe2Jk2pxdrwwRFBJs9tHbAQURq4KJ9--

--IXR1kV8Dm6b6q0QGpqApBOcJTcuSsXu9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlmUIrIACgkQHv7KIOw4
HPb3Cwf9Hiym6ooiNrcDpo1N3v/2QAETCdIDSepDEVIMFlJnd+8anSvdXU/NybHB
zb9wm520IoVL3nOBjHKuxrMbT0nvhLtQMrO+yCiYDj23y6TXZvXmkpBRvNnEI9x7
yd+3Y/KG+2RN/sNwai1U8wVfmIWwA4kXVhjYl/SqhKlA3cOdXNKaGSZgLbx1uSKl
p9omft0+HHYxK0NG2oKr4SiG2/V9bFOe0V/3HMCHlICgBbTwpgF+TsqE5w/RsYAB
t23lBLitbdhLuGwKBtcocB2HxUxowR8IGgBkqhbntS8c0n0sGu90T40JxG3b2u68
5uip4WKFXxeuqtFtHxyA7KUQOrylCg==
=qtuL
-----END PGP SIGNATURE-----

--IXR1kV8Dm6b6q0QGpqApBOcJTcuSsXu9D--

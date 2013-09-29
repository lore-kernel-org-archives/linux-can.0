From: =?ISO-8859-1?Q?Heinz=2DJ=FCrgen?= Oertel <hj.oertel@t-online.de>
Subject: Re: adding can4linux to drivers/char
Date: Sun, 29 Sep 2013 18:28 +0200
Message-ID: <2109885.0l6dWmo4a5@heinz.site>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1515370.TVJAfvYzGt"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64980 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3I2Q2M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 12:28:12 -0400
In-Reply-To: <523DF9C1.30300@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


--nextPart1515370.TVJAfvYzGt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


Hello

Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegger:
> I think you need *strong* arguments to get it accepted.=20

I have some good arguments for this kind of driver
- it is much more simple in design than others,
  simplicity is one of the Linux design goals
- It has a simple user API
- It does not need any other infrastructure than the kernel API
- It is mature

I agree, it would be nice to share the low level CAN controller related=
=20
experiences of the developers. That is may be something we can share if=
 we=20
could agree of a set of CAN controller header files with shared registe=
r=20
#defines. And a set of very basic functions like initialize and activat=
e CAN,=20
set acceptance filters, transmit and receive, read out error register o=
r=20
whatever.
But to stay simple, I don't like the idea to have another additional la=
yer=20
around SocketCAN as layer below the can4linux API.

Linux offers real diversity on the desktop, why not with drivers? Linux=
 also=20
has different sound devices and architectures.  Why not offering two di=
fferent=20
CAN driver concepts to the application programmer,
let she decide what to use.

--=20
mit freundlichen Gr=FC=DFen
       Heinz-J=FCrgen Oertel
--nextPart1515370.TVJAfvYzGt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJSSFUXAAoJENViPQy9fcm7Og8IAPGfZvYNkGi8zERVWLPbSwLB
tN4ru3FK7vJRkOuhg4BcEAucRD27jKeHYD9rL8jfTc2OKehRnbN3cq/sDrC3PpXR
y07a7yMcYvxZZObqEJOR/k0qoRxF9FOIE1LMxL4thov3LPq3ADqcd8jzcUA2fxla
EJDcTJLJOlfw5Ndwr8to9A6yn8nPkXb+B86pS1KrS7b10rw63ebG8OUhmN4v94i2
y1JMf8l7RYWnegKr+0qE0HKFEJ32zHJCEUj/n4NnODufvdYGqSc7GYwmVUts2KhE
WL9LDP1SlbmVQkICXC+YWn+8uh9RniqTWhYVjoGQ7uSgxR1REjy63v6bv6yIwzU=
=8XpP
-----END PGP SIGNATURE-----

--nextPart1515370.TVJAfvYzGt--


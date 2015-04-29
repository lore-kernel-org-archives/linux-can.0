From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 07:20:03 +0200
Message-ID: <55406A03.9060105@pengutronix.de>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de> <loom.20150429T040002-878@post.gmane.org> <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com> <loom.20150429T063429-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="E3KHMLdFglA8WtswkSWaTDbTclxE4BTwf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141AbbD2FVh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Apr 2015 01:21:37 -0400
In-Reply-To: <loom.20150429T063429-693@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E3KHMLdFglA8WtswkSWaTDbTclxE4BTwf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/29/2015 06:39 AM, Leo Stan wrote:
> Hi Austin, thanks for your reply.
>=20
> My ifconfig -a returns :=20
>=20
> eth0      Link encap:Ethernet  HWaddr 44:8a:5b:6d:50:8d =20
>           inet addr:131.181.70.9  Bcast:131.181.70.255  Mask:255.255.25=
5.0
>           inet6 addr: fe80::468a:5bff:fe6d:508d/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:3869 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1783 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000=20
>           RX bytes:1268663 (1.2 MB)  TX bytes:481256 (481.2 KB)
>           Interrupt:19=20
>=20
> lo        Link encap:Local Loopback =20
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:65536  Metric:1
>           RX packets:228 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:228 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
>           RX bytes:37579 (37.5 KB)  TX bytes:37579 (37.5 KB)
>=20
> wlan0     Link encap:Ethernet  HWaddr e8:2a:ea:de:3b:ae =20
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000=20
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
>=20
> So I don't think it detected the Leaf...
>=20
> Now that I check my /dev/ folder there is actually leaf0 in it. Maybe=20
> installing the drivers from Kvaser prevents me from using SocketCan?

This can be the problem. Please try with the mainline drivers only.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--E3KHMLdFglA8WtswkSWaTDbTclxE4BTwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVQGoHAAoJECte4hHFiupU1ZYP/2xhjYneHZpLF3OSjJJuu0B5
qOkBsSDlsA4j/7tAFyQhEiz06xEAdphnJADzcqQvLIEA/XEc7xD+qFKjVz0uy+vD
kIQpxWhYmePO5r6/O/VrKn5zSsmvgEz7pEitw8TkZR2A094sRNoS+utEjn8SdG8T
XpdpqjothnOVj6KB7JUvCoPUgHTSXqO2lYbzRuGFCauYq4ZhO2xZ/XbxqsSAb71O
1+n1dhqRTs1twjXcxRkSdTz4m+zEyM3HYdOLcWXZ20RHrdRPE0Vc1NdX5sOclSMv
uK7TXw7FvuJBCnSSdghWKJREW/BwAvFHaFiaKuyd9YbmHCGSN86upQ78+seJENyU
o1iWar+dh2w8Z6fyYfBY6CwZ8GbD2LH2RA5NsoEgAM55V53/FM9VvmB9ARvXLY9I
IHp+LLe8yLGKW1DUxCZ/UvJCNtmpVtQkA4ggcQM1rTgJhM1sASNhrub8Y8LkIhse
1eJusw1Xu6kZR/BlHXxjNPD1uKNM3s8VaD/RFYopyGZRt8/Q1as8/NejCjFixg6f
WgDxyHGB1KyWzfwymqXH/0X0JsSmeutIw9wJEQEOqJtTJmrH+WssgF1AdFHb15eH
rLmBQAOw4CWRLvr3W2l6ElJVg4ghinwms4JSjQpOSUmNxKfUTnc2RmwfpErSZjs6
mwbKftIhBtMIqLamNCcP
=hJZI
-----END PGP SIGNATURE-----

--E3KHMLdFglA8WtswkSWaTDbTclxE4BTwf--

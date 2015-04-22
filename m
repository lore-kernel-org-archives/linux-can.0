From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 22 Apr 2015 10:03:52 +0200
Message-ID: <553755E8.20704@pengutronix.de>
References: <loom.20150422T090300-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1qF9D7QHQPaA8aHGkTe4BH0GTmskW7TTB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40032 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbbDVIED (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Apr 2015 04:04:03 -0400
In-Reply-To: <loom.20150422T090300-352@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: max <max.jacob@alternalab.it>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1qF9D7QHQPaA8aHGkTe4BH0GTmskW7TTB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/22/2015 09:31 AM, max wrote:
> I'm trying to connect to a Kvaser Leaf Light V2 (product_id=3D15) adapt=
er on=20
> linux from python3.4, and for that purpose I've planned to use SocketCA=
N.=20
>=20
> I have downloaded and compiled the kvaser drivers v.5.9, my kernel is a=
=20
> 3.13.0-49-generic, and according to the information I've fund so far, t=
he=20
> system requirements should all be met.=20

Where do you download the driver from? I suggest to use a recent
mainline kernel. Support for the Kvaser Leaf v2 was added in v3.16 and a
_lot_ of bugfixes were added in later versions. Switching to a recent
ubuntu kernel (v3.19) is probably a good idea.

> And in fact, when I connect the adapter, the leaf kernel module is=20
> correctly loaded (I see it in lsmod) and the /usr/sbin/leaf.sh is start=
ed=20
> (I desume this from the fact that if I try to start it manually it tell=
s me=20
> it has already been started), and also the /dev/leaf0 device is created=
=2E=20

A /dev/leaf0 is not created by the mainline driver...

> So far so good. But what's next? What I have understood is that at this=
=20
> point there should be the kvaser_usb module that comes into play for=20
> mapping the device to a network interface that can be brought up and us=
ed=20
> by SocketCAN.=20
>=20
> But the kvaser_usb module is not loaded automatically, and if I modprob=
e it=20
> manually, nothing seems to happen.
>=20
> Here is what goes on in the kernel log when connecting the adapter:
>=20
> [46464.671385] usb 3-2: new high-speed USB device number 4 using xhci_h=
cd
> [46464.689616] usb 3-2: New USB device found, idVendor=3D0bfd, idProduc=
t=3D0120
> [46464.689627] usb 3-2: New USB device strings: Mfr=3D0, Product=3D2,=20
> SerialNumber=3D0
> [46464.689633] usb 3-2: Product: Kvaser Leaf Light v2
> [46467.738639] usbcore: registered new interface driver leaf
>=20
> And this when I modprobe the kvaser_usb module:
>=20
> [46545.271520] usbcore: registered new interface driver kvaser_usb
>=20
> If I invert the order of the two operations, it is exactly the same. I'=
ve=20
> also tryed with and without an actual can device connected to the other=
 end=20
> of the adapter, but this doesn't change anything either.
>=20
> So, it looks I am still missing something... Can anyone tell me what=20
> further steps are necessary to finally get a can0 interface to show up?=

>=20
> Thank's a lot for any hint pointing me to the right direction...

Use a recent mainline kernel, then everything should work out of the
box, without any external drivers and manual module loading.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1qF9D7QHQPaA8aHGkTe4BH0GTmskW7TTB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVN1XoAAoJECte4hHFiupUlxMP/0A+boi4XdE1LVgnlXkodfdh
ewS0dDchTyDggZt5czIQdmqTDzlJircIR4VQdi58hVWWg6DoEcfVKY4yD1rjoQzl
QmoJhNm2HdydwjnRWsEIpbxzEqlEa2KVZy8tXzZ/bXOhR8j9BJyFZNYx0E0QzaLl
v2QQFUFcsBrThFrKP0eWjcftslq5zEHfD3UzSI3cwg4HEgItQXKvbPtp6libm6i/
IEzNyMFDJqZ2HHdGMVg4oVpsA2NPcn5/bCjxA4ZsxDz4pBByuJVLS9r8BmxeCmVq
n+HhFxvdwbmG6U4C3h6mI0VZnjXwzTwD+WwDJm5Xw905qRKqXmudkSwTIuWd9FP+
YQE2ekqb4VQd3D/FQtxJVp7l3qtA7X/U3J67G3WLQv+TnIQZUEPZEE3BgKSI+B7W
R30cGPGSP5Rg5T/kYS+cqTGdwUJEZCaCFC6IGVHGqOlDQXIiv1TkbxqLnDDfTw7H
bgYIeEdBP0kXjX2qhE8d+75/P23J9PGBMdLudFHdIbRHjXH3SWJqrrdKIXpTHfus
tt5ienKOjsvQ31pNpGeSu4VJZK6LNL1+KWN3SiED/DmiNuuLhWStISwm9D7l56ez
C3A+RjoiYqi44rpFX4aEyESa96Y3P+7nWR9YeHItKoQNF2nHfCM/UpWeMBWJmg0o
yaxwGAfZl1J51yWK6F5/
=ezm1
-----END PGP SIGNATURE-----

--1qF9D7QHQPaA8aHGkTe4BH0GTmskW7TTB--

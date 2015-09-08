From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 13:13:01 +0200
Message-ID: <55EEC2BD.6010302@pengutronix.de>
References: <55EEAD8D.3070603@engineeredarts.co.uk>
 <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DXpaNU2xoh6HakpdNq7xgHWIOIrdjd5hB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36789 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbIHLNL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 07:13:11 -0400
In-Reply-To: <55EEBB4E.6080104@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DXpaNU2xoh6HakpdNq7xgHWIOIrdjd5hB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2015 12:41 PM, Daniel Squires wrote:
> On my laptop and Desktop PC I have not seen it happen.

> Both the application PC (NUC) and the Laptop are running Ubuntu kernel =

> 3.19.0-26-generic
>=20
> The NUC has the kernel rebuilt without xhci due to problems it causes=20
> with another USB peripheral.
>=20
> I am not entirely sure what you mean by which can core I am using but i=
f=20
> it helps i am opening the socket as follows :

I mean what kind of CAN adapter...

>=20
>      sock =3D socket(PF_CAN,SOCK_RAW,CAN_RAW);
>=20
> in a small standalone test application which I wrote after having=20
> difficulty with our main application.
>=20
> I am using custom hardware/firmware and am using the kernel module foun=
d=20
> here : https://github.com/fabiobaltieri/open-usb-can
> though it has a small change to stop the net queue at the top of=20
> open_usb_can_start_xmit as otherwise its prone to loosing TX packets=20
> when loaded.

Yes, this looks racy - You should ask then to mainline working the driver=
=2E

> I can see the packets coming in the correct order in wireshark and it i=
s=20
> not immediately obvious to me how the kernel module could mix up the=20
> order, so it seems that it must be something that happens at the socket=
=20
> level?

The kernel module "produces" the CAN frames, so if you see them in the
correct order in wireshark, they have left the module in the right order.=


> candump can3 -tz
> <snip>
>   (003.088648)  can3  043   [8]  F7 2D 00 00 00 00 00 00
>   (003.089149)  can3  045   [8]  F9 2D 00 00 00 00 00 00
>   (003.088897)  can3  044   [8]  F8 2D 00 00 00 00 00 00

The timestamps are in the correct order. Maybe Oliver can help here,
he's an expert when it comes to strange reordering :)

> On the top level I am using CANFestival for CANOpen implementation, so =

> it has occurred to me I could implement a CANFestival "driver" using=20
> libusb and completely bypass the kernel module and socket can layers,=20
> but I hope not to have to do this.

Na, you don't want to do this.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DXpaNU2xoh6HakpdNq7xgHWIOIrdjd5hB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7sK9AAoJEP5prqPJtc/H4bcIAKMP2Uy5hKUrZXfoT5HA1GRU
HeWJ2K+S3KKcnNQc87P/djrGRpvXtqqX53iy2pv5P8c7yeae7WR7XJc6HyIA7yIR
HfdUDDIGalLKYVlQRT00zpilB0n+dABhmpxrZt+1vepSULZAa7ie1JYpRjaqMkcK
I+dyKszZWQUK0SNgv/ufF+ZtoUrTuwDAKU5RFlGpihr1H60ujrB/rt4fb6morlLE
zAcJ2aBieZ9/OUWIvePffNoZogh2/NtqVjTzuHX9tBwreK7tJOL2JjBb8b+NUIUF
j4wb6PVgoEIDgRj3tEfRIYrpUGx4kCPs0/xiUiO9jOuiWWsLOx02m8rw8gSY7KY=
=z5yF
-----END PGP SIGNATURE-----

--DXpaNU2xoh6HakpdNq7xgHWIOIrdjd5hB--

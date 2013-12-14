From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: baudrate detection
Date: Sat, 14 Dec 2013 14:29:02 +0100
Message-ID: <52AC5D1E.2010802@pengutronix.de>
References: <20131212184012.GA18112@griso.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gna9WAES7lb4rUoue2lpdOrJ68fGvWeRR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55602 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab3LNN3K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Dec 2013 08:29:10 -0500
In-Reply-To: <20131212184012.GA18112@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gna9WAES7lb4rUoue2lpdOrJ68fGvWeRR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2013 07:40 PM, John Whitmore wrote:
> I'm coming from the embedded micro controller end of using CAN and have=
 created
> my own CAN Network nodes. Now I'm working with a MCP2515 connected to t=
he
> Raspberry Pi, so looking at the Linux Kernel.

A SPI based CAN adapter like the mcp2515 are known to have bad
performance, you probably will have better CAN experience with an USB
adapter.

> On my existing nodes the Initialisation of the CAN device the node eith=
er knows
> the baudrate to setup or it does not. A node that is a fixed node on th=
e
> network knows the baudrate of the network, although this can be changed=
 on the
> fly. Other devices are not a fixed part of the network and are connecte=
d
> dynamically to the network for testing or management purposes. These no=
des
> don't know the baudrate of the network so automatically detect it. When=
 they
> detect the baudrate they then connect and inform the higher application=
 code
> that the network is connected, so they can proceed.
>=20
> I was thinking of adding this auto baudrate detection functionality to =
the
> RaspberryPi but being new to Linux development I'm struggling with whet=
her
> this functionality should be in Kernel or User Space. I was initially t=
hinking
> User Space but given that numerous applications can be using the CAN Ne=
twork
> you really want to centralise this functionality. That possibly means K=
ernel
> Space?
>
> So before I start to do something I thought I'd ask the experts. Does
> automatic baudrate detection belong in Kernel Space or out in Userland?=
 Maybe
> it's already in the existing Kernel I've just missed it.

I think for prototyping the algorithm you should start in userspace, the
you can present it here and then we can discuss if it's better suited in
a library or in the kernel space.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gna9WAES7lb4rUoue2lpdOrJ68fGvWeRR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKsXR4ACgkQjTAFq1RaXHPiTQCZAYgJSh6Vi2CtYAQDEi138Jjs
ExUAnic4dcFByYZ68RQzmPlPtf2JJbwk
=XJ3e
-----END PGP SIGNATURE-----

--gna9WAES7lb4rUoue2lpdOrJ68fGvWeRR--

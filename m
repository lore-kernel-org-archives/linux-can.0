From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: vcan multithreaded problem testing
Date: Sun, 16 Feb 2014 12:16:11 +0100
Message-ID: <53009DFB.5060302@pengutronix.de>
References: <20140216100428.GC5440@griso.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EPx4Kd6DSClDhKqqkX2tJB3wMEnsBSrPs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54123 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbaBPLQR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Feb 2014 06:16:17 -0500
In-Reply-To: <20140216100428.GC5440@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EPx4Kd6DSClDhKqqkX2tJB3wMEnsBSrPs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/16/2014 11:04 AM, John Whitmore wrote:
> Hello all, I'll try keep this short. I'm using vcan to test code I'm po=
rting
> from my embedded hardware. My embedded code has a simple dispatcher whi=
ch
> process all messages received from the Network. Higher layers of the
> Application register an interest in certain CAN ids or ranges.
>=20
> I don't need this dispatcher as Socket CAN filters already so in portin=
g my
> application the higher layers now simply create a new linux thread and =
socket
> to listen for CAN Frames that they have an interest in.
>=20
> My problem is that in testing with vcan if my core process thead sends =
a CAN
> id which a child thread is filtering on then the child thread receives =
the
> message. I've looked at vcan code and it simply consumes the sent frame=
s back
> into the linux networking stack.
>=20
> At present a single process will not receive a CAN Frame which is sends=
 but
> it's child threads will recive the frame. Is there a way to restrict th=
is? I
> might have to wait until I get back to Hardware and test there but it w=
ould be
> very handy to be able to use vcan.

The CAN stack doesn't care about thread or processes, it's all about
sockets.

By default a socket doesn't receive the CAN frame it sends. When a CAN
frame is successfully send, by default all other sockets receive the
locally created CAN frames, too. You can change both defaults. Have a
look at the can.txt documentation in the Linux kernel:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L18=
4
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L50=
2
http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L51=
3

Feel free to ask, if you need more information.

cheers,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EPx4Kd6DSClDhKqqkX2tJB3wMEnsBSrPs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMAnfsACgkQjTAFq1RaXHN/FACfb7dxtz60Y5xOXdcpDRpLrH/m
eBIAn3dAtnaZrOTWCo6J0eNWIXUH0nNy
=dDvq
-----END PGP SIGNATURE-----

--EPx4Kd6DSClDhKqqkX2tJB3wMEnsBSrPs--

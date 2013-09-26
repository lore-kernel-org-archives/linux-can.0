From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: D_CAN problems after devm_ioremap_resource conversion.
Date: Thu, 26 Sep 2013 09:12:15 +0200
Message-ID: <5243DE4F.7070407@pengutronix.de>
References: <CAF03EBdqih4s1iUwZXqZtgNHx-btBdfrNoHy2z9xVuaS-ki41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="U6jAU7FNk0PFFRmeNBrO9JMwRW3tRObIl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40413 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab3IZHMZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Sep 2013 03:12:25 -0400
In-Reply-To: <CAF03EBdqih4s1iUwZXqZtgNHx-btBdfrNoHy2z9xVuaS-ki41Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: T Thayer <tthayer.linux@gmail.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, davem@davemloft.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U6jAU7FNk0PFFRmeNBrO9JMwRW3tRObIl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2013 10:36 PM, T Thayer wrote:
> I've run into a problem with the Altera CycloneV SoCFPGA D_CAN driver
> implementation after the devm_request_and_ioremap() to
> devm_ioremap_resources() change (git commit
> 32766fff24a761079636bb96c389411d24a334c6. As another data point, I do
> not have problems with 3.10 (which did not have the
> devm_ioremap_resources() change).

That's good, you can use git bisect to find the patch that introduces
the problem. Use:

    git bisect 32766fff24a761079636bb96c389411d24a334c6 v3.10

then

    <build kernel>
    <test kernel>

if CAN doesn't work anymore

    git bisect bad

if kernel is still functional

    git bisect good

goto <build kernel>.

> I looked through the CAN mailing list archives but could not find any
> issues that matched my symptoms.
>=20
> Board #1 running 3.11 (git commit
> d25903f894849fa799141e774c4ad34199e3e6a1) that I configure as:
> canconfig can0 bitrate 500000
> canconfig can0 start
> candump can0
>=20
>=20
> Board #2 running 3.10 that I configure as:
> canconfig can0 bitrate 500000
> canconfig can0 start
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
>=20
> But nothing appears on the Board#1 dump.
>=20
> The strange thing is that if I type something (ie. the letter "A") in
> Board#1's terminal window and then change to Board#2's terminal window
> and do another
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88

How's your terminal connected?
What happens if you send some ping packges to board#1 instead of typing
a letter?

> then 2 messages show up on the candump (the original one and the one
> just sent). From then on, typing
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
>=20
> shows up on Board#1. It almost seems like typing any character in
> Board#1's terminal (which is waiting for data via candump) frees up
> the candump buffer printout.

> I don't know if this is an issue with candump or with the CAN driver.
> It doesn't seem like a candump issue because it works OK if I revert
> and rebuild the kernel before the above commit.  (and it breaks if I
> update my tree to after the above commit and rebuild).

Instead of doing the bisect, you can checkout v3.11.1 and revert
32766fff24a761079636bb96c389411d24a334c6.

    git checkout v3.11.1
    git revert 32766fff24a761079636bb96c389411d24a334c6

    <build kernel>
    <test kernel>

Does the kernel work as expected?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--U6jAU7FNk0PFFRmeNBrO9JMwRW3tRObIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJD3lMACgkQjTAFq1RaXHOEqgCfWCJMTT0dtVUlhQrQSam2PuIv
jgYAn1sJBKSgaq4oA4pymxckL4N3pbEe
=sQfO
-----END PGP SIGNATURE-----

--U6jAU7FNk0PFFRmeNBrO9JMwRW3tRObIl--

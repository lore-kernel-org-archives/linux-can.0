From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can-utils from
Date: Tue, 03 Dec 2013 12:45:39 +0100
Message-ID: <529DC463.9080409@pengutronix.de>
References: <d74513b2-5338-463a-9af9-d4b7f6b5aa90@CH1EHSMHS021.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bEVjqRqv9fr6VRv8ub7rPFFCfuE69HKE5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55106 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab3LCLpq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Dec 2013 06:45:46 -0500
In-Reply-To: <d74513b2-5338-463a-9af9-d4b7f6b5aa90@CH1EHSMHS021.ehs.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bEVjqRqv9fr6VRv8ub7rPFFCfuE69HKE5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/03/2013 12:35 PM, Appana Durga Kedareswara Rao wrote:
> Hi Marc,
>=20
>         Is there any way to compile the canutils downloaded from the ht=
tps://gitorious.org/linux-can/can-utils.

You need automake, autoconf and libtool, then

    ./autogen.sh
    ./configure
    make
    sudo make install

If this doesn't work you can download a tarball from pengutronix:

http://www.pengutronix.de/software/ptxdist/temporary-src/can-utils-2012.0=
1.0.tar.bz2

Marc

P.S.: Please use the linux-can@vger.kernel.org mailing list for CAN
related question.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--bEVjqRqv9fr6VRv8ub7rPFFCfuE69HKE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKdxGQACgkQjTAFq1RaXHNnKwCeNQDdtM5pksBvQuwZxLSXqIHT
GCYAnjnwkuOthCcBLaZfQ9VwnLXPVq+r
=N1xz
-----END PGP SIGNATURE-----

--bEVjqRqv9fr6VRv8ub7rPFFCfuE69HKE5--

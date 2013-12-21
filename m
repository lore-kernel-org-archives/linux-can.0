From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 3/3] drivers/net/can/ti_hecc.c:909:7: warning:
 assignment makes pointer from integer without a cast
Date: Sat, 21 Dec 2013 22:58:57 +0100
Message-ID: <52B60F21.5070502@pengutronix.de>
References: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qQbRBj5cCcRddxNsxA7125w3w2BXcv4nU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40657 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab3LUV7G (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Dec 2013 16:59:06 -0500
In-Reply-To: <52b60e29.e6MbNbPY4sH1N+Ql%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qQbRBj5cCcRddxNsxA7125w3w2BXcv4nU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/21/2013 10:54 PM, kbuild test robot wrote:
> tree:   git://gitorious.org/linux-can/linux-can-next for-davem
> head:   5dd64fac3ff28aab5e92548a066c175e00cc9da4
> commit: 5dd64fac3ff28aab5e92548a066c175e00cc9da4 [3/3] can: ti_hecc: Us=
e the OMAP2PLUS dependency for omap2plus devices
> config: make ARCH=3Dum allyesconfig
>=20
> All warnings:
>=20
>    drivers/net/can/ti_hecc.c: In function 'ti_hecc_probe':
>    drivers/net/can/ti_hecc.c:909:2: error: implicit declaration of func=
tion 'ioremap' [-Werror=3Dimplicit-function-declaration]
>      addr =3D ioremap(mem->start, resource_size(mem));
>      ^
>>> drivers/net/can/ti_hecc.c:909:7: warning: assignment makes pointer fr=
om integer without a cast [enabled by default]
>      addr =3D ioremap(mem->start, resource_size(mem));
>           ^
>    drivers/net/can/ti_hecc.c:974:2: error: implicit declaration of func=
tion 'iounmap' [-Werror=3Dimplicit-function-declaration]
>      iounmap(addr);
>      ^
>    cc1: some warnings being treated as errors

Should we go back to "depends on ARM"?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qQbRBj5cCcRddxNsxA7125w3w2BXcv4nU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlK2DyEACgkQjTAFq1RaXHMFHACghBpz2gExI+e6vnX0PToo0oiU
S5UAnRxc1s4O2/XaGazAetvV+Je4KDvD
=7j2v
-----END PGP SIGNATURE-----

--qQbRBj5cCcRddxNsxA7125w3w2BXcv4nU--

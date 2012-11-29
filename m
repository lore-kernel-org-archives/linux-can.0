From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can:for-davem 3/5] drivers/net/can/usb/ems_usb.c:903:6: warning:
 unused variable 'err'
Date: Thu, 29 Nov 2012 14:29:16 +0100
Message-ID: <50B7632C.3030705@pengutronix.de>
References: <50b76293.9VF7dj0y5in3n8rs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC2B675CACF8D844635B2B534"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50430 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466Ab2K2N3S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:29:18 -0500
In-Reply-To: <50b76293.9VF7dj0y5in3n8rs%fengguang.wu@intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC2B675CACF8D844635B2B534
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/29/2012 02:26 PM, kbuild test robot wrote:
> tree:   git://gitorious.org/linux-can/linux-can-next for-davem
> head:   31f03931a244878209a41ab337f7260d8b4da6a6
> commit: 8c9a8243358bf335df940d5273363360358148a9 [3/5] can: ems_usb: re=
move obsolete variable open_time
> config: make ARCH=3Dx86_64 allyesconfig
>=20
> All warnings:
>=20
> drivers/net/can/usb/ems_usb.c: In function 'ems_usb_set_mode':
> drivers/net/can/usb/ems_usb.c:903:6: warning: unused variable 'err' [-W=
unused-variable]

Doh - tnx
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC2B675CACF8D844635B2B534
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEUEARECAAYFAlC3YywACgkQjTAFq1RaXHPfzACfemno25wIrNjm2+mfOfxIBOpV
DmkAlAqHJKPpaqQ2/j7+rQsLOmebjC0=
=4pIq
-----END PGP SIGNATURE-----

--------------enigC2B675CACF8D844635B2B534--

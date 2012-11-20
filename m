From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: linsocketcan
Date: Tue, 20 Nov 2012 14:29:26 +0100
Message-ID: <50AB85B6.3090702@pengutronix.de>
References: <003501cdc71f$aca1c950$05e55bf0$@wp.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2654E8EE538B61FA7E8E5143"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42939 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619Ab2KTN3c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Nov 2012 08:29:32 -0500
In-Reply-To: <003501cdc71f$aca1c950$05e55bf0$@wp.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert <robercik@wp.eu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2654E8EE538B61FA7E8E5143
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey Robert,

please use the linux-can mailinglist (Cc'ed). Don't post HTML mails there=
=2E

On 11/20/2012 02:05 PM, Robert wrote:
> Hi,
>=20
> I try use libsocketcan  in my android application to work with CANbus
>  (ti_HECC ) in HMI device TH-1535  based on ARM3517 Sitara .
>=20
> OS Android IceCream  Linux kernel 2.6.37
>=20
> =20
>=20
> Add libsocketcan.c  to my  jni  folder and build library
>   libsocketcan.so  use  ndk-build (all ok no errors)
>=20
> =20
>=20
> If  use *can_set_bitrate**(=93can0=94, 125000),*function*send_mod_reque=
st
> return -1 (errno =3D 1,  err->error =3D 2).*

If the libsocketcan isn't buggy here, and errno equals 1, you should
have a look at the errno definition[1]. An errno of 1 means "Operation
not permitted". In non Android Linux systems you need to be the root
user to set the bitrate.

[1] http://lxr.free-electrons.com/source/include/asm-generic/errno-base.h=
#L4

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2654E8EE538B61FA7E8E5143
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCrhboACgkQjTAFq1RaXHO7xQCfSlrbS1a5J9IXTWtpBO4Li0B9
PCYAn3bHjE01NilNuHNyZPPzVfMd/4BS
=q2zD
-----END PGP SIGNATURE-----

--------------enig2654E8EE538B61FA7E8E5143--

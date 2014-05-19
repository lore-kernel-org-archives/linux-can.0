From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] c_can: remove obsolete STRICT_FRAME_ORDERING Kconfig
 option
Date: Mon, 19 May 2014 09:07:36 +0200
Message-ID: <5379ADB8.5000403@pengutronix.de>
References: <53691FC2.3080200@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AvU4vJ5G9BA4cbIf8oe5oXgEH0dSnX80B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47828 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaESHHq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 03:07:46 -0400
In-Reply-To: <53691FC2.3080200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvU4vJ5G9BA4cbIf8oe5oXgEH0dSnX80B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/06/2014 07:45 PM, Oliver Hartkopp wrote:
> In 2b9aecdce2 ("can: c_can: Disable rx split as workaround") a new Kcon=
fig
> option was introduced as a workaround. The tests performed by Alexander=
 Stein
> confirmed this option to be obsolete with all the other cleanups and fi=
xes
> that had been discussed that time:
> http://marc.info/?l=3Dlinux-can&m=3D139746476821294&w=3D2
>=20
> Both (author and tester) agreed to remove this Kconfig option again:
> http://marc.info/?l=3Dlinux-can&m=3D139883820714229&w=3D2
>=20
> As some more cleanups took place since then a simple revert is not poss=
ible.
> This patch removes the entire option as it would behave when disabled.
> Further beautification=E2=80=99s can be done later.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied to can.

Tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AvU4vJ5G9BA4cbIf8oe5oXgEH0dSnX80B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5rbgACgkQjTAFq1RaXHOyigCglAxODALsz1jPkPesWKR8euZS
VsoAn3f1m6lgno55H0MMoOFn794v3T+8
=n/Zv
-----END PGP SIGNATURE-----

--AvU4vJ5G9BA4cbIf8oe5oXgEH0dSnX80B--

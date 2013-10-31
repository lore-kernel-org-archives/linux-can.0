From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can-next] can: add broadcast manager documentation
Date: Thu, 31 Oct 2013 20:55:01 +0100
Message-ID: <5272B595.3090102@pengutronix.de>
References: <52625C90.6030508@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fxhRjwEQ88umwwRN0dnkHiapOLhjsjvj7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53964 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab3JaTzK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 Oct 2013 15:55:10 -0400
In-Reply-To: <52625C90.6030508@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Brian Thorne <hardbyte@gmail.com>, Daniele Venzano <linux@brownhat.org>, Andre Naujoks <nautsch2@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fxhRjwEQ88umwwRN0dnkHiapOLhjsjvj7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2013 12:18 PM, Oliver Hartkopp wrote:
> Signed-off-by: Brian Thorne <hardbyte@gmail.com>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> CC: Daniele Venzano <linux@brownhat.org>
> CC: Andre Naujoks <nautsch2@gmail.com>
>=20
> ---
>=20
> Hi all,
>=20
> after the latest attempt from Brian i reworked a CAN BCM documentation =
based
> on Brians patch: http://marc.info/?l=3Dlinux-can&m=3D138119382015496&w=3D=
2
>=20
> It's a bit shorter than the original documentation that has been transl=
ated
> and reworked by Daniele here: http://brownhat.org/docs/socketcan.html
>=20
> I hope, i was able to catch all the provided functionalities and typos =
:-)
>=20
> Thanks for your support and patience.

I added credits you listed here to the patch's description, because
these mentioned won't get into the kernel and some maintainers and me
think that a patch shouldn't have an empty description :)

The patch description now looks like this:

---

can: add broadcast manager documentation

This patch adds documentation about the broadcast manager. It's based on =
Brian
Thorne's initial patch http://marc.info/?l=3Dlinux-can&m=3D13811938201549=
6&w=3D2 and
Daniele Venzano's work http://brownhat.org/docs/socketcan.html .

Signed-off-by: Brian Thorne <hardbyte@gmail.com>
Cc: Daniele Venzano <linux@brownhat.org>
Cc: Andre Naujoks <nautsch2@gmail.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

----

Any objections?
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fxhRjwEQ88umwwRN0dnkHiapOLhjsjvj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJytZUACgkQjTAFq1RaXHMVDACeKKhomMwZEDUgerccNcBC2PZg
5AMAnR+WfpAD7oSe21+RP8NUq+KPZH/4
=2bTd
-----END PGP SIGNATURE-----

--fxhRjwEQ88umwwRN0dnkHiapOLhjsjvj7--

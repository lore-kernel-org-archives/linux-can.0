From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: GS_USB
Date: Fri, 04 Oct 2013 15:23:11 +0200
Message-ID: <524EC13F.3050802@pengutronix.de>
References: <1380889887.22484.2.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mXEMK7tHkTG3A6xowbCpX51d2dnEOnhLm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41276 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3JDNXS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Oct 2013 09:23:18 -0400
In-Reply-To: <1380889887.22484.2.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mXEMK7tHkTG3A6xowbCpX51d2dnEOnhLm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2013 02:31 PM, Max S. wrote:
> I forgot to set a subject for this email last time i sent it :/
> It probably never made it out of anyone=E2=80=99s spam filters.
> Here it is again
>=20
> Hello All,
>=20
> Whats the protocol for getting a driver into the mainline kernel?

Posting the driver, inline not attached, is preferred. Nagging the
maintainers after some days if they are not responding :)

> I've reached a working and fairly stable state with the CAN adapter I'm=

> working on, and would like to get its driver mainlined.

I'm currently working on the CAN subsystem, too. I think find some time
during the weekend to look at your code.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mXEMK7tHkTG3A6xowbCpX51d2dnEOnhLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJOwT8ACgkQjTAFq1RaXHNhYQCfaKT6BwWv4EAEuBCEoMmjEP49
/HUAn3MtL1/8FgqD/deWT1ufpzuUgwr8
=U16x
-----END PGP SIGNATURE-----

--mXEMK7tHkTG3A6xowbCpX51d2dnEOnhLm--

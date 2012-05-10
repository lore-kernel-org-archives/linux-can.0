From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/4] can: c_can: fix an interrupt thrash issue with
 c_can driver
Date: Thu, 10 May 2012 21:13:46 +0200
Message-ID: <4FAC136A.6040705@pengutronix.de>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com> <1336649657-4152-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D819C55322E898BC7BC73A9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60415 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480Ab2EJTOJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 May 2012 15:14:09 -0400
In-Reply-To: <1336649657-4152-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D819C55322E898BC7BC73A9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

05/10/2012 01:34 PM, AnilKumar Ch wrote:
> This patch fixes an interrupt thrash issue with c_can driver.
>=20
> In c_can_isr() function interrupts are disabled and enabled only in
> c_can_poll() function. c_can_isr() & c_can_poll() both read the
> irqstatus flag. However, irqstatus is always read as 0 in c_can_poll()
> because all C_CAN interrupts are disabled in c_can_isr(). This causes
> all interrupts to be re-enabled in c_can_poll() which in turn causes
> another interrupt since the event is not really handled. This keeps
> happening causing a flood of interrupts.
>=20
> To fix this, read the irqstatus register in isr and use the same cached=

> value in the poll function.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Can you or someone else please test this patch on c_can hardware, and
add her/his Tested-by? This patch is a stable candidate, isn't it?

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

cheers, Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6D819C55322E898BC7BC73A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+sE3UACgkQjTAFq1RaXHNeeQCfTeRtvwu6uzWFUH3VY6oYgxqH
hwEAmwbrBwsI/qm8N0S75f8PBFz/YbLF
=cGAw
-----END PGP SIGNATURE-----

--------------enig6D819C55322E898BC7BC73A9--

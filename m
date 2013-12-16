From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_usb: fix mem leak in pcan_usb_pro_init()
Date: Mon, 16 Dec 2013 11:12:43 +0100
Message-ID: <52AED21B.2020907@pengutronix.de>
References: <1387029597-16783-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4ddAiV3xFpduipSxi1ltMDNm2QUdIVTo2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60355 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3LPKVG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 05:21:06 -0500
In-Reply-To: <1387029597-16783-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, s.grosjean@peak-system.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4ddAiV3xFpduipSxi1ltMDNm2QUdIVTo2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/14/2013 02:59 PM, Marc Kleine-Budde wrote:
> This patch fixes a memory leak in pcan_usb_pro_init(). In patch
>=20
>     f14e224 net: can: peak_usb: Do not do dma on the stack
>=20
> the struct pcan_usb_pro_fwinfo *fi and struct pcan_usb_pro_blinfo *bi w=
ere
> converted from stack to dynamic allocation va kmalloc(). However the
> corresponding kfree() was not introduced.
>=20
> This patch adds the missing kfree().
>=20
> Reported-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Cc: linux-stable <stable@vger.kernel.org> # v3.10
> Cc: Stephane Grosjean <s.grosjean@peak-system.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

St=C3=A9phane, can I have your Acked-by?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4ddAiV3xFpduipSxi1ltMDNm2QUdIVTo2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKu0hsACgkQjTAFq1RaXHNOKACfdNbGWdmdcPmAphfRXZSrjyXW
uv4AmwdHSGm20ilrIN7xQZK3l4YJf0M6
=dxhO
-----END PGP SIGNATURE-----

--4ddAiV3xFpduipSxi1ltMDNm2QUdIVTo2--

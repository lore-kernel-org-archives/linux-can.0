From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5] flexcan: add err_irq handler for flexcan
Date: Thu, 03 Jul 2014 11:14:56 +0200
Message-ID: <53B51F10.4040900@pengutronix.de>
References: <1404354180-46431-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="87Q4CxoqtOM3wjgLsRxU0xLDLsBb8dxjX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36153 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbaGCJPN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Jul 2014 05:15:13 -0400
In-Reply-To: <1404354180-46431-1-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, wg@grandegger.com, linux-can@vger.kernel.org, B07421@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--87Q4CxoqtOM3wjgLsRxU0xLDLsBb8dxjX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2014 04:23 AM, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use a space instead of tab
> 	- use flexcan_poll_state instead of print
> Changes for v3:
> 	- return IRQ_HANDLED if err is triggered
> 	- stop transmitted packets when there is an err_interrupt=20
> Changes for v4:
> 	- call flexcan_irq=20
> Changes for v5:
> 	- move err_int_handling code from flexcan_irq to flexcan_err_irq
> 	- call flexcan_err_irq from flexcan_irq

Why do you move the RX IRQ handling into the error IRQ function? If I
understand you correctly you only want to do error interrupt handling
the error IRQ function, right?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--87Q4CxoqtOM3wjgLsRxU0xLDLsBb8dxjX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO1HxEACgkQjTAFq1RaXHO5TACgjBRadhnrz9W6sy8alYPSGg3H
iH0AnRDp6H7tUKGgwMKyPbFC4xjjDJOe
=Bkej
-----END PGP SIGNATURE-----

--87Q4CxoqtOM3wjgLsRxU0xLDLsBb8dxjX--

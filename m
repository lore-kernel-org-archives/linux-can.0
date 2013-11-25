From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6] can: sja1000: fix {pre,post}_irq() handling and IRQ
 handler return value
Date: Mon, 25 Nov 2013 09:54:41 +0100
Message-ID: <52931051.90502@pengutronix.de>
References: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="I81UXJt6LK987XjFX5TDIP8aOBlU1S08i"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35322 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3KYIyu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 03:54:50 -0500
In-Reply-To: <1385334220-31887-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, austin@peloton-tech.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I81UXJt6LK987XjFX5TDIP8aOBlU1S08i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2013 12:03 AM, Marc Kleine-Budde wrote:
> From: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> It has been reported that on PREEMPT_RT enabled system the peak SJA1000=

> hardware can trigger "irq X: nobody cared" errors.
>=20
> This patch fixes the issue that the sja1000_interrupt() function may ha=
ve
> returned IRQ_NONE without processing the optional pre_irq() and post_ir=
q()
> function before. Further the irq processing counter 'n' is moved to the=
 end of
> the while statement to return correct IRQ_[NONE|HANDLED] values at erro=
r
> conditions.

Austin, can you test if this patch solves your problem.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--I81UXJt6LK987XjFX5TDIP8aOBlU1S08i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKTEFEACgkQjTAFq1RaXHMv2QCgk51NqIRQmCB6xaX1QJ7p6YPl
JIoAn1ZqgQ0fsaZIpX6MhjiDwx2OAbW6
=70F7
-----END PGP SIGNATURE-----

--I81UXJt6LK987XjFX5TDIP8aOBlU1S08i--

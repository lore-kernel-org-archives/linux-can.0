From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH] can: mcp251x: add missing IRQF_ONESHOT to request_threaded_irq
Date: Fri, 12 Apr 2013 13:16:48 +0200
Message-ID: <5167ED20.5060107@pengutronix.de>
References: <51666B21.10109@pengutronix.de> <1365669410-8101-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FGGTOVUHGULPMNEKRSKI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab3DLLQw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Apr 2013 07:16:52 -0400
In-Reply-To: <1365669410-8101-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Mylene.Josserand@navocap.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FGGTOVUHGULPMNEKRSKI
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/11/2013 10:36 AM, Marc Kleine-Budde wrote:
> Since commit:
>=20
>     1c6c695 genirq: Reject bogus threaded irq requests
>=20
> threaded irqs must provide a primary handler or set the IRQF_ONESHOT fl=
ag.
> Since the mcp251x driver doesn't make use of a primary handler set the
> IRQF_ONESHOT flag.
>=20
> /* Cc: linux-stable <stable@vger.kernel.org> # >=3D v3.5 */
> Reported-by: Mylene Josserand <Mylene.Josserand@navocap.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Myl=E8ne, added your Tested-by and send a pull request to David.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FGGTOVUHGULPMNEKRSKI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFn7SAACgkQjTAFq1RaXHM6bgCfWoFnoqqDANDxqhshgk5kQYHV
ZKUAoIP1lTOelmJ0rp+7B1w/uH8gNbm4
=LOZ1
-----END PGP SIGNATURE-----

------enig2FGGTOVUHGULPMNEKRSKI--

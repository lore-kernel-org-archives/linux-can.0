From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] net can softing: drop 'channel' sysfs attribute
Date: Thu, 24 Apr 2014 22:56:09 +0200
Message-ID: <53597A69.3010007@pengutronix.de>
References: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="G8IrRXr6RVimuTjhTLrunAhmMtUDVe65o"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46364 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbaDXU4Q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 16:56:16 -0400
In-Reply-To: <1396466269-28444-1-git-send-email-dev.kurt@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G8IrRXr6RVimuTjhTLrunAhmMtUDVe65o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 09:17 PM, Kurt Van Dijck wrote:
> netdev->dev_id obsoletes this property.
> None of the remaining properties contribute to udev detection methods.
> The regular calls for the sysfs group can thus safely be restored.
>=20
> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>

Both applied to can-next/master

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--G8IrRXr6RVimuTjhTLrunAhmMtUDVe65o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNZemkACgkQjTAFq1RaXHMsYwCfRSdq1rzK7IGT63x2laz/22Z5
27gAn1t/dCkl1wvDLvN76jEt6wK1qk+u
=U+85
-----END PGP SIGNATURE-----

--G8IrRXr6RVimuTjhTLrunAhmMtUDVe65o--

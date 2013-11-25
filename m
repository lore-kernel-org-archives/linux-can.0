From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: don't call pm_runtime_get_sync() from IRQ
 handler
Date: Mon, 25 Nov 2013 09:48:54 +0100
Message-ID: <52930EF6.8040606@pengutronix.de>
References: <1385333617-30842-1-git-send-email-mkl@pengutronix.de> <2A43324E02E34840B044C9DC9221448009056812@AMDTCEX12.actuant.pri>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="I1t3mKM5Eco8J9LhRg8gIXg2J4VOIh39O"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41329 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab3KYItF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 03:49:05 -0500
In-Reply-To: <2A43324E02E34840B044C9DC9221448009056812@AMDTCEX12.actuant.pri>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Glen, Andrew" <AGlen@bepmarine.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I1t3mKM5Eco8J9LhRg8gIXg2J4VOIh39O
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

please keep the mailing list on Cc.

On 11/25/2013 01:27 AM, Glen, Andrew wrote:
> There were a couple of mistakes in your patch, a missing semi-colon
> and missing call to 'struct c_can_priv *priv =3D netdev_priv(dev);' in
> ' c_can_get_berr_counter()'

Doh, it was probably too late :)

> I'm new to the formal procedures and am keen to learn. I'd like to
> post an updated patch. If this is ok, do I make a complete new post
> with a similar subject except with [Patch v2]?

Yes, please post the corrected patch, [PATCH v2] as subject, add your
Singned-off-by and, if it fixes your problem add a Tested-by, too.

The "formal procedure" is outlined in Documentation/SubmittingPatches in
the Kernel tree.

thanks,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--I1t3mKM5Eco8J9LhRg8gIXg2J4VOIh39O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKTDvkACgkQjTAFq1RaXHNOSgCdE6mlpUcZ3F99MsXbKYGwSO34
CFcAn3IF/R0/EqiOGcgHIb6ixYhjyHwz
=qFsh
-----END PGP SIGNATURE-----

--I1t3mKM5Eco8J9LhRg8gIXg2J4VOIh39O--

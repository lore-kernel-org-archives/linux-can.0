From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 2/2] can: sja1000: fix return value of interrupt handler
Date: Sun, 24 Nov 2013 23:44:47 +0100
Message-ID: <5292815F.6050505@pengutronix.de>
References: <1385329501-28021-1-git-send-email-mkl@pengutronix.de> <1385329501-28021-3-git-send-email-mkl@pengutronix.de> <c5cb898e-a4c9-4f0c-9a6b-24f5ae939451@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2sbrKNLRrN8NeUCNcRNauSAkR9aHU0tna"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49285 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3KXWow (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 17:44:52 -0500
In-Reply-To: <c5cb898e-a4c9-4f0c-9a6b-24f5ae939451@email.android.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2sbrKNLRrN8NeUCNcRNauSAkR9aHU0tna
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/24/2013 11:38 PM, Oliver Hartkopp wrote:
> the reason why Kurt asked to split my patch was because of i added a
> change in pre_irq () to return a value. splitting up the patch as you
> did here IMO makes no sense. That is why I sent a new patch some days
> ago only addressing the fix without the 'return value enhancement'.

Thanks for the clarification,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2sbrKNLRrN8NeUCNcRNauSAkR9aHU0tna
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKSgV8ACgkQjTAFq1RaXHNT8ACfYhAU8Uc0p/mpqT5uTQCsiRFx
OcIAn0xD8DOtGV7RSuDCDAOd4kKuh7/i
=KFzH
-----END PGP SIGNATURE-----

--2sbrKNLRrN8NeUCNcRNauSAkR9aHU0tna--

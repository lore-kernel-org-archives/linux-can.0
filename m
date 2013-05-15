From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] drivers: net: can: grcan: use devm_ioremap_resource()
Date: Wed, 15 May 2013 11:12:22 +0200
Message-ID: <51935176.7020601@pengutronix.de>
References: <1368458871-7402-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XBWSEMHMNHGLBVGGESLH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56675 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab3EOJMZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 05:12:25 -0400
In-Reply-To: <1368458871-7402-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Laurent Navet <laurent.navet@gmail.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XBWSEMHMNHGLBVGGESLH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/13/2013 05:27 PM, Laurent Navet wrote:
> Replace a call to deprecated devm_request_and_ioremap by devm_ioremap_r=
esource.
> dev_err() message is no more needed since it's already displayed in
> devm_ioremap_resource().
>=20
> Signed-off-by: Laurent Navet <laurent.navet@gmail.com>

Tnx, applied to linux-can-next.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XBWSEMHMNHGLBVGGESLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTUXYACgkQjTAFq1RaXHODhQCgkcZrUt927CdlmRzeERfThveE
29AAn0gKm8BPeY7xxguZiPV4W+PnFNP4
=oosW
-----END PGP SIGNATURE-----

------enig2XBWSEMHMNHGLBVGGESLH--

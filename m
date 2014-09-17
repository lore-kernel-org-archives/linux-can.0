From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCHv2] can: at91_can: prepare and unprepare the clock
Date: Wed, 17 Sep 2014 22:16:51 +0200
Message-ID: <5419EC33.7050802@pengutronix.de>
References: <1410956808-1964-1-git-send-email-davidcdueck@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TH4dlIK3JNo1gNnnCpjMaw6P1rJldrwrU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbaIQURF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Sep 2014 16:17:05 -0400
In-Reply-To: <1410956808-1964-1-git-send-email-davidcdueck@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Dueck <davidcdueck@googlemail.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, wg@grandegger.com, nicolas.ferre@atmel.com, Anthony Harivel <anthony.harivel@emtrion.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TH4dlIK3JNo1gNnnCpjMaw6P1rJldrwrU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2014 02:26 PM, David Dueck wrote:
> Make the driver work with the common clock framework.
>=20
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>

Added with a some more prose commit message to the linux-can tree.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TH4dlIK3JNo1gNnnCpjMaw6P1rJldrwrU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQZ7DMACgkQjTAFq1RaXHONdACfXuQ+9h15gs0Jo3nAV0YMaddw
aKkAnj9nPtNL9HK363Kpom6KSlZ47L1z
=r/hz
-----END PGP SIGNATURE-----

--TH4dlIK3JNo1gNnnCpjMaw6P1rJldrwrU--

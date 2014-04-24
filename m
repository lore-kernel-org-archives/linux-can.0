From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5] can: slcan: Fix spinlock variant
Date: Thu, 24 Apr 2014 22:32:57 +0200
Message-ID: <535974F9.3070700@pengutronix.de>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com> <1397573468-7619-2-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cWRKXPNkIj7cSusmcvmmTmgmvIkRCTTFG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49699 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaDXUdA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 16:33:00 -0400
In-Reply-To: <1397573468-7619-2-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWRKXPNkIj7cSusmcvmmTmgmvIkRCTTFG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2014 04:51 PM, Alexander Stein wrote:
> slc_xmit is called within softirq context and locks sl->lock, but
> slcan_write_wakeup is not softirq context, so we need to use
> spin_[un]lock_bh!
> Detected using kernel lock debugging mechanism.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied to can/master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--cWRKXPNkIj7cSusmcvmmTmgmvIkRCTTFG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNZdPkACgkQjTAFq1RaXHPGVQCggbjU3JyG3bM5zQIuqc39kSLq
bVQAmwapEQLwn7oDHROt8Zz+sZsjPJAo
=1IvO
-----END PGP SIGNATURE-----

--cWRKXPNkIj7cSusmcvmmTmgmvIkRCTTFG--

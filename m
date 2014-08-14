From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4 RESEND] can: flexcan: Disable error interrupt when
 bus error reporting is disabled
Date: Thu, 14 Aug 2014 12:21:01 +0200
Message-ID: <53EC8D8D.4070209@pengutronix.de>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="m51wpgBJbsiUCNJBIEKQgd9b1VnxLUTte"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42843 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaHNKVE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 06:21:04 -0400
In-Reply-To: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m51wpgBJbsiUCNJBIEKQgd9b1VnxLUTte
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 03:43 PM, Alexander Stein wrote:
> In case we don't have FLEXCAN_HAS_BROKEN_ERR_STATE and the user set
> CAN_CTRLMODE_BERR_REPORTING once it can not be unset again until reboot=
=2E
> So in case neither hardware nor user wants the error interrupt disable
> the bit.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

For completeness: Applied to can, see other mail.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--m51wpgBJbsiUCNJBIEKQgd9b1VnxLUTte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPsjY0ACgkQjTAFq1RaXHPKJACfZY/K2DeRT6nitOFUF2K+M7Ep
qZAAn3c6fCmNKrA7vphUVvRnSi+F7JfF
=viaL
-----END PGP SIGNATURE-----

--m51wpgBJbsiUCNJBIEKQgd9b1VnxLUTte--

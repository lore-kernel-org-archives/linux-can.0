From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Disable error interrupt when bus error
 reporting is disabled
Date: Thu, 14 Aug 2014 12:13:34 +0200
Message-ID: <53EC8BCE.2030709@pengutronix.de>
References: <1407833241-26850-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fPRcpBj2LMh9f28olBDajTwGI5UnTdMm4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbaHNKNg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 06:13:36 -0400
In-Reply-To: <1407833241-26850-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fPRcpBj2LMh9f28olBDajTwGI5UnTdMm4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 10:47 AM, Alexander Stein wrote:
> In case we don't have FLEXCAN_HAS_BROKEN_ERR_STATE and the user set
> CAN_CTRLMODE_BERR_REPORTING once it can not be unset again until reboot=
=2E
> So in case neither hardware nor user wants the error interrupt disable
> the bit.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Doh! Right the FLEXCAN_CTRL_ERR_MSK is not affected by the soft-reset of
the core.

Applied to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fPRcpBj2LMh9f28olBDajTwGI5UnTdMm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPsi84ACgkQjTAFq1RaXHP/8wCfYDZkjjkvitWVh48VCoEtPR6d
QUcAnREZkJztrpuje2BkZmilmhkyUWFe
=x9P1
-----END PGP SIGNATURE-----

--fPRcpBj2LMh9f28olBDajTwGI5UnTdMm4--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: Do not call dev_put if restart timer is running
 upon close
Date: Wed, 28 Nov 2012 16:05:55 +0100
Message-ID: <50B62853.9080903@pengutronix.de>
References: <1354002754-5971-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA4F28B2447D306C7127D2DE0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41753 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab2K1PF6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:05:58 -0500
In-Reply-To: <1354002754-5971-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA4F28B2447D306C7127D2DE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/27/2012 08:52 AM, Alexander Stein wrote:
> If the restart timer is running due to BUS-OFF and the device is
> disconnected an dev_put will decrease the usage counter to -1 thus
> blocking the interface removal, resulting in the following dmesg
> lines repeating every 10s:
> can: notifier: receive list not found for dev can0
> can: notifier: receive list not found for dev can0
> can: notifier: receive list not found for dev can0
> unregister_netdevice: waiting for can0 to become free. Usage count =3D =
-1
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Looks good, I'll put stable on Cc.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigA4F28B2447D306C7127D2DE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC2KFMACgkQjTAFq1RaXHNAGQCgmLgGxvxsiuLx+x3GPS4Pm8jB
AX0AnimU99zTpQslH4XVfrBpkGR7qYw+
=vYjU
-----END PGP SIGNATURE-----

--------------enigA4F28B2447D306C7127D2DE0--

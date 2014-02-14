From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/4] can: netlink send bittiming data only when bittiming_const
 is available
Date: Fri, 14 Feb 2014 22:26:35 +0100
Message-ID: <52FE8A0B.6090405@pengutronix.de>
References: <1392411447-9105-1-git-send-email-socketcan@hartkopp.net> <1392411447-9105-2-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V8mOmPi5BN1QxC69sArwKXELWF8cIn0eO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55754 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbaBNV0n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2014 16:26:43 -0500
In-Reply-To: <1392411447-9105-2-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V8mOmPi5BN1QxC69sArwKXELWF8cIn0eO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2014 09:57 PM, Oliver Hartkopp wrote:
> The bittiming information is only valid when the CAN driver has a valid=

> structure of bittiming_const. Therefore provide the information of the
> bittiming only when bittiming_const exists.

What about intelligent CAN controllers which only support fixed
bitrates? We once hat such a device and it was a design goal to support
such devices.

> This is also a preparation for the CAN FD specific bittiming_const stru=
cture
> which is not existing in non-FD drivers. Therefore all the CAN FD bitti=
ming
> stuff has to be disabled when the CAN FD specific bittiming_const struc=
ture is
> missing.

Can we use bitrate =3D=3D 0 as an indicator?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--V8mOmPi5BN1QxC69sArwKXELWF8cIn0eO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlL+igsACgkQjTAFq1RaXHPzKwCdHUaZE2x6b55TPDafgZLlk3Qb
RAIAniiCQASU2APlSeNFHh2PR5aB84EM
=2nXo
-----END PGP SIGNATURE-----

--V8mOmPi5BN1QxC69sArwKXELWF8cIn0eO--

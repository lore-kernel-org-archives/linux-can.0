From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/4] can: netlink: Add CAN_CTRLMODE_PRESUME_ACK flag
Date: Thu, 10 Jul 2014 16:12:05 +0200
Message-ID: <53BE9F35.9060509@pengutronix.de>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com> <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com> <53BE9DF7.6020608@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AuRFulsqljcwajn1D5UCE19hndVOwEIb6"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59845 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaGJOMT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Jul 2014 10:12:19 -0400
In-Reply-To: <53BE9DF7.6020608@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, wg@grandegger.com
Cc: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AuRFulsqljcwajn1D5UCE19hndVOwEIb6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2014 04:06 PM, Oliver Hartkopp wrote:
> what do you think about this extension.
>=20
> From my side the patchset makes sense.
>> +#define CAN_CTRLMODE_PRESUME_ACK    0x40    /* Ignore missing CAN
>> ACKs */

Is this a good name? Does anyone come up with an alternative/better one?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AuRFulsqljcwajn1D5UCE19hndVOwEIb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO+nzUACgkQjTAFq1RaXHNFHACfREwbAI0ft9j0d0IaKnvtiTVt
G2MAn2r2j++XBwXY46rwPY6EFcU93yN3
=SB+6
-----END PGP SIGNATURE-----

--AuRFulsqljcwajn1D5UCE19hndVOwEIb6--

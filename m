From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Thu, 16 Jan 2014 17:30:10 +0100
Message-ID: <52D80912.1090700@pengutronix.de>
References: <52D6CB48.9010206@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4RW4b4vOMJNlcBTX0I6GMS2a1oWPOuvt1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60715 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbaAPQaM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:30:12 -0500
In-Reply-To: <52D6CB48.9010206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4RW4b4vOMJNlcBTX0I6GMS2a1oWPOuvt1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2014 06:54 PM, Oliver Hartkopp wrote:
> Introduce a second set of bitrate configuration for the (potential diff=
erent)
> data bitrate. The CAN FD arbitration bitrate is stored in the existing
> bittiming configuration space.
>=20
> TODO:
> The functions can_calc_bittiming(), can_fixup_bittiming() should change=
 their
> parameters from
>=20
> 	(struct net_device *dev, struct can_bittiming *bt)
> to
> 	(struct can_bittiming *bt, const struct can_bittiming_const *btc, cons=
t struct can_clock *clk)

Are there any netdev_printk()? I don't want to loose the explicit device
information.

Otherwise looks good so far.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4RW4b4vOMJNlcBTX0I6GMS2a1oWPOuvt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYCRIACgkQjTAFq1RaXHMPXwCfbJ5+7/7ulyxE8+mV9hTzSF2Y
aJgAnjxoR9v+Kp1soZf2325DfI4ET5Pm
=R+o0
-----END PGP SIGNATURE-----

--4RW4b4vOMJNlcBTX0I6GMS2a1oWPOuvt1--

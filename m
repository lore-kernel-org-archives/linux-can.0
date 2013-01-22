From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/4] CAN sk_buff and can-gw enhancements
Date: Tue, 22 Jan 2013 22:41:53 +0100
Message-ID: <50FF07A1.1070909@pengutronix.de>
References: <50F83848.4090006@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2XUXSOWCRKSVLRUVRNHIL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47160 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395Ab3AVVlz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 16:41:55 -0500
In-Reply-To: <50F83848.4090006@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2XUXSOWCRKSVLRUVRNHIL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/17/2013 06:43 PM, Oliver Hartkopp wrote:
> From 0cb44d2bda7d3aeb96ce45eb7ee24a139bf40f78 Mon Sep 17 00:00:00 2001
> From: Oliver Hartkopp <socketcan@hartkopp.net>
> Date: Thu, 17 Jan 2013 17:51:48 +0100
> Subject: [PATCH 0/4] CAN sk_buff and can-gw enhancements
>=20
> Hi all,
>=20
> after the discussion with DaveM about the skb_iif usage here's my alter=
native
> to support the new can-gw functionalities:
>=20
> - make routing to the incoming CAN interface configurable
> - add a variable limit for CAN frame routings
> - indicate and count deleted frames due to misconfiguration
>=20
> I added some private space to CAN sk_buffs. See commit messages.
>=20
> It can be pulled from the cangw branch of ollis-can-next:
>=20
> https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commits/cangw

Applied.

Tnx,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2XUXSOWCRKSVLRUVRNHIL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/B6EACgkQjTAFq1RaXHONBwCdGjf4t3ZuOOk4iVZ38mx5Idpy
N9wAoIdpTwf/N8mpZwrKbqvDGniWEe1W
=0S+U
-----END PGP SIGNATURE-----

------enig2XUXSOWCRKSVLRUVRNHIL--

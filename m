From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can-utils] J1939 v6 (#7)
Date: Tue, 29 Sep 2015 20:46:41 +0200
Message-ID: <560ADC91.1090408@pengutronix.de>
References: <linux-can/can-utils/pull/7@github.com>
 <linux-can/can-utils/pull/7/c144149208@github.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qIOBhFQ4eQ9ql2m2nrMW4BjIeDbt1ka4w"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50916 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935252AbbI2Sqy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Sep 2015 14:46:54 -0400
In-Reply-To: <linux-can/can-utils/pull/7/c144149208@github.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can/can-utils <reply+001c342f19a5bb0b961514b7b0770b27aa4808e234c8be2992cf0000000112229b9d92a169ce0672fa57@reply.github.com>, linux-can/can-utils <can-utils@noreply.github.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qIOBhFQ4eQ9ql2m2nrMW4BjIeDbt1ka4w
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2015 08:34 PM, Oliver Hartkopp wrote:
> Hi Kurt,
>=20
> I'm sorry but I still think that your implementation and configuration
> is way to complex and not intuitive.
> If you look at http://elinux.org/J1939
> $ modprobe can-j1939
> $ ip link set can0 j1939 on
> still looks weird. Adding addresses to CAN interfaces is not common -
> and if you think about this kind of assignment, it should be implemente=
d
> inside the j1939 stuff and not in af_can.c. The can-gw routing netlink
> API was integrated in gw.c too. IMO the sockaddr_can extension would be=

> ok - but the other implementation should be made without af_can.[ch]
> changes.
>=20
> I remember our discussion about the address claiming but I wonder if we=

> really follow the requirement to only put functionality into the kernel=

> that really has to be implemented there.
>=20
> Did you take a look at https://github.com/ISOBlue/isoblue-software -
> which is far simpler - whether it can fulfill the basic functionalities=

> (segmentation, etc.) to enable j1939 for Linux?

Can we switch to the mailinglist for the discussion.

Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qIOBhFQ4eQ9ql2m2nrMW4BjIeDbt1ka4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWCtyRAAoJEP5prqPJtc/H0P4H/iEnf5hMQ3YLCebFex9EJ9Uo
79ZUD83ORcf9U52GspLs0gmYLTdLBMYqdSjOAVBVanVx1odQ17VvC3THWCPGLfo8
kJCgygbBs35MrL269DV3xfEbsw6nBAKLDAopXPiL5KJ2VX6crWdNwqMDO/L0ZLMY
LvQW49lH9/havFHWVax8Sa512puRdeJgdF/hStBbU0dH3ijD/XhCLEjQ7TsdXdeO
4SU5KscbhCnTnHv1ji0dznoVSFKSJSZxZS1JmiELeOOHp8W5UVV5hhOwe7OnDfmf
uzehryYaU/OQp36A+0Jcq6+Tq5MqOdW4BMtsljat/l3xcFdxGvu3xGiTPAEoT+8=
=EyNW
-----END PGP SIGNATURE-----

--qIOBhFQ4eQ9ql2m2nrMW4BjIeDbt1ka4w--

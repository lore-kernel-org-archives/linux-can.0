From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Socketcan correct way to bootup...
Date: Wed, 09 Jul 2014 13:16:31 +0200
Message-ID: <53BD248F.5030608@pengutronix.de>
References: <53BD1BE1.8050403@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XvHvowK9T8TEROuV1hMkaPqnp27IS63jJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36108 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbaGILQj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 07:16:39 -0400
In-Reply-To: <53BD1BE1.8050403@eurekelettronica.it>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: gianluca <gianlucarenzi@eurekelettronica.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XvHvowK9T8TEROuV1hMkaPqnp27IS63jJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2014 12:39 PM, gianluca wrote:
> I was wondering if there is some "Offical" way to bring-up a socketcan
> interface during bootup of a Linux System. Actually I write a simple
> script BEFORE running my application in this way:

Depends on your Distribution/init system.

> # run.sh 125000 75 can0
>=20
> [ run.sh ]
> #!/bin/sh
> BITRATE=3D$1
> SAMPLE=3D".$2"
> INTERFACE=3D$3
> ip link set $INTERFACE up type can bitrate ${BITRATE} sample-point
> ${SAMPLE}
> ip -details link show $INTERFACE
> while [ true ];
> do
>     ./myapplication
> done
>=20
> Are there some guidelines on how to approach this startup? i.e. I was
> thinking about similar to ifup /etc/network/interface but with the
> addendum of the bitrate and sample point...

On recent Debian based Distris you can use ifup/ifdown for CAN
interfaces. See the man page of interfaces.

If you use busybox's ifup/ifdown you can fall back to the "inet manual"
mode and specify /sbin/ip commands to configure and up/down your
interface. On systemd you can add a service that starts CAN and runs
before your actual program.

Marc

BTW: you probably want to integrate your application into the automatic
startup via an init script or in new designs with systemd...and _not_
start it by hand.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--XvHvowK9T8TEROuV1hMkaPqnp27IS63jJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO9JI8ACgkQjTAFq1RaXHP55QCfbsGCEnLUuUZ8S14/mikViW+q
5cwAoIeP28QIqfHVnk6boO6zpfioHwwB
=TgaX
-----END PGP SIGNATURE-----

--XvHvowK9T8TEROuV1hMkaPqnp27IS63jJ--

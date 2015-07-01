From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC] can: replace timestamp as unique skb attribute
Date: Wed, 1 Jul 2015 10:01:18 +0200
Message-ID: <55939E4E.8050908@pengutronix.de>
References: <1435312699-25999-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hngQMGBIx21ugeUbDkoQoxVTHKqoV9eRm"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36458 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbGAIBj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Jul 2015 04:01:39 -0400
In-Reply-To: <1435312699-25999-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: manfred.schlaegl@gmx.at, tom_usenet@optusnet.com.au, s.grosjean@peak-system.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hngQMGBIx21ugeUbDkoQoxVTHKqoV9eRm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2015 11:58 AM, Oliver Hartkopp wrote:
> Commit 514ac99c64b "can: fix multiple delivery of a single CAN frame fo=
r
> overlapping CAN filters" requires the skb->tstamp to be set to check fo=
r
> identical CAN skbs.
>=20
> Without timestamping to be required by user space applications this tim=
estamp
> was not generated which lead to commit 36c01245eb8 "can: fix loss of CA=
N
> frames in raw_rcv" - which forces the timestamp to be set in all CAN re=
lated
> skbuffs by introducing several __net_timestamp() calls.
>=20
> This forces e.g. out of tree drivers to add __net_timestamp() after skb=
uff
> creation to prevent the frame loss fixed in mainline Linux.
>=20
> This patch removes the timestamp dependency and uses an atomic counter =
to
> create an unique identifier together with the skbuff pointer.
>=20
> Btw. the new skbcnt element introduced in struct can_skb_priv has to be=

> initialized with zero in out-of-tree drivers too.

=2E..but only if they don't use alloc_can{,fd}_skb().=09

Looks much better than the timestamp approach. I'll apply it to
can/master if there aren't any objections. What about stable?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hngQMGBIx21ugeUbDkoQoxVTHKqoV9eRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVk55OAAoJEP5prqPJtc/HtfsH/3VGW1TkKnpBLY5XS9cqJn9p
gWSQGA+7hXMpZ6Alb2OiBstAlYMV3DqbcNKmKAIGhp0Bgkma05rYyp2p+b7pA+rF
oVO4O7QRPvsoY1ERr/MWMv3WI3J9bCIzXGvflwSbtMAqcn+mzvap54xYO5HrYFG2
izK3ohPqkxdxulB0RjXzS18hT/W0Q9BYW1J1GoRCueDtuHNbKKj39JqNur2gZ0AC
BOmPbQY7QrppXyYsa2oUOVuRbH1DM9YZmFcYD4siEahlgiW3+skKi7ONhNXrr1L/
Uw8beDfR2poqwGoDi+J+Id+V/A+uvNu/Q1IJpaT2cPRnHEg1nRmmdYrJcTG0sFI=
=Eap3
-----END PGP SIGNATURE-----

--hngQMGBIx21ugeUbDkoQoxVTHKqoV9eRm--

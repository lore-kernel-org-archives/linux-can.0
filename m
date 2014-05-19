From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 0/3] can: add support for hash based access to EFF
 frame filters
Date: Mon, 19 May 2014 08:24:41 +0200
Message-ID: <5379A3A9.6050704@pengutronix.de>
References: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5PPADHNEPpdPTJmOp6v5gmGod1GungL3u"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37281 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaESGYo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 May 2014 02:24:44 -0400
In-Reply-To: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5PPADHNEPpdPTJmOp6v5gmGod1GungL3u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 08:25 PM, Oliver Hartkopp wrote:
> In contrast to the direct access to the single SFF frame filters (which=
 are
> indexed by the SFF CAN ID itself) the single EFF frame filters are arra=
nged
> in a single linked hlist. To reduce the hlist traversal in the case of =
many
> filter subscriptions a hash based access is introduced for single EFF f=
ilters.
>=20
> This patch set enhances and documents the hash based EFF filter sets in=

> af_can.c .
>=20
> Changes in v2:
> Some coding style fixes, like
> - indroduce spaces arround shift operations
> - use ARRAY_SIZE(d->rx_sff) instead of CAN_SFF_RCV_ARRAY_SZ
> - use ARRAY_SIZE(d->rx_eff) instead of CAN_EFF_RCV_ARRAY_SZ
> - change to forward hash function as suggested by Marc
>=20
> Oliver Hartkopp (3):
>   can: proc: make array printing function indenpendent from sff frames
>   can: add hash based access to single EFF frame filters
>   can: add documentation for CAN filter usage optimisation
>=20
>  Documentation/networking/can.txt | 35 ++++++++++++++++++
>  net/can/af_can.c                 | 31 +++++++++++++---
>  net/can/af_can.h                 |  9 +++--
>  net/can/proc.c                   | 76 ++++++++++++++++++++++++++++++++=
--------
>  4 files changed, 129 insertions(+), 22 deletions(-)
>=20
Applied all three patches to can-next

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5PPADHNEPpdPTJmOp6v5gmGod1GungL3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlN5o6kACgkQjTAFq1RaXHPeaQCfdFOrSYxXLBKFIvNBElt/9p13
0jsAmgNvGJChm7bC1EEJCY4868YOc24+
=4iwa
-----END PGP SIGNATURE-----

--5PPADHNEPpdPTJmOp6v5gmGod1GungL3u--

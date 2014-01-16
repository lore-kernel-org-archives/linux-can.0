From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] slcand: reimplement daemonize routine
Date: Thu, 16 Jan 2014 17:19:26 +0100
Message-ID: <52D8068E.90002@pengutronix.de>
References: <1389603245-24023-1-git-send-email-yegorslists@googlemail.com> <1389603245-24023-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PWJrXmVUktQcOWs9wf2G7FVgdi5Gx4bip"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58483 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbaAPQT2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 Jan 2014 11:19:28 -0500
In-Reply-To: <1389603245-24023-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net, u.kleine-koenig@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PWJrXmVUktQcOWs9wf2G7FVgdi5Gx4bip
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2014 09:54 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Replace daemonize() routine with daemone() system call, because of
> conflicting licenses. daemonize() routine was derived from under
> GNU Free Documentation License licensed code. This license is
> incompatible with GPL-2+.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Applied to master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PWJrXmVUktQcOWs9wf2G7FVgdi5Gx4bip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLYBo4ACgkQjTAFq1RaXHPizQCeJMg2rjqCW5M+P3oULggtspfy
DxIAn1uuKLbZ8iD5flZEy4z/9Nv8CyJV
=6bDR
-----END PGP SIGNATURE-----

--PWJrXmVUktQcOWs9wf2G7FVgdi5Gx4bip--

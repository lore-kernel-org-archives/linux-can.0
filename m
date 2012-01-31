From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: cc770: store echo skb before starting the
 transfer
Date: Tue, 31 Jan 2012 22:59:09 +0100
Message-ID: <4F28642D.8040204@pengutronix.de>
References: <4EE618A4.80104@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1FF18C96F42179519849E3B2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58265 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab2AaV7L (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:59:11 -0500
In-Reply-To: <4EE618A4.80104@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1FF18C96F42179519849E3B2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/12/2011 04:07 PM, Wolfgang Grandegger wrote:
> On slow systems and high CAN bitrates, the error message
> "can_put_echo_skb: BUG! echo_skb is occupied!" did show up because
> can_put_echo_skb() was called after starting the transfer.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Applied to can-next.
tnx Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1FF18C96F42179519849E3B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZC0ACgkQjTAFq1RaXHMUvgCfUvUBIs37EMXA5Py/WjC+ukCk
mE8An27M5riZiAb0tMiuevS/XDCEkbM4
=geeG
-----END PGP SIGNATURE-----

--------------enig1FF18C96F42179519849E3B2--

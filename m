From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix irq flooding by clearing all interrupt
 sources
Date: Tue, 31 Jan 2012 22:59:34 +0100
Message-ID: <4F286446.2070706@pengutronix.de>
References: <4EE61928.10608@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2DB4965E9E4A6A47F6DEDB3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58278 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab2AaV7g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:59:36 -0500
In-Reply-To: <4EE61928.10608@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Reuben Dowle <Reuben.Dowle@navico.com>, =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2DB4965E9E4A6A47F6DEDB3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/12/2011 04:09 PM, Wolfgang Grandegger wrote:
> As pointed out by Reuben Dowle and Lothar Wa=DFmann, the TWRN_INT,
> RWRN_INT, BOFF_INT interrupt sources need to be cleared as well
> to avoid interrupt flooding, at least for the Flexcan on i.MX28
> SOCs. Furthermore, the interrupts are only cleared, if really one
> of those interrupt sources are pending (which is not the case for
> rx and tx done).
>=20
> CC: Reuben Dowle <Reuben.Dowle@navico.com>
> CC: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

Applied to can-next.
tnx Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE2DB4965E9E4A6A47F6DEDB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZEYACgkQjTAFq1RaXHMNUwCgiOOyKj8rzGvuUON7wbJxXXeH
DJ0An0AN69kTcAajdezIXr5HkPcNoBhF
=Wn95
-----END PGP SIGNATURE-----

--------------enigE2DB4965E9E4A6A47F6DEDB3--

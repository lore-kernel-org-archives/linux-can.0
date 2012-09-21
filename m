From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can: Add d_can suspend resume support
Date: Fri, 21 Sep 2012 12:11:22 +0200
Message-ID: <505C3D4A.5030205@pengutronix.de>
References: <1348221541-28878-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig993F889F88C6FF045D38D150"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54734 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944Ab2IUKLd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 06:11:33 -0400
In-Reply-To: <1348221541-28878-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig993F889F88C6FF045D38D150
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/21/2012 11:59 AM, AnilKumar Ch wrote:
> Adds suspend resume support to DCAN driver which enables
> DCAN power down mode bit (PDR). Then DCAN will ack the local
> power-down mode by setting PDA bit in STATUS register.

Applied to can-next. I've updated the master branch in the can-next
repo. AnilKumar, I think I should squash patch "of: Modify c_can binding
documentation" into "can: c_can: Add device tree support to Bosch
C_CAN/D_CAN controller". What do you think?

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig993F889F88C6FF045D38D150
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBcPU4ACgkQjTAFq1RaXHNyMACfbo5lZWBBEoQh/czRIqKCs9bl
AkQAn2rY2WsZ9/p+bk0KiOAVirlGyFig
=DgDM
-----END PGP SIGNATURE-----

--------------enig993F889F88C6FF045D38D150--

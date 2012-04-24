From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: c_can: Add support for Bosch D_CAN controller
Date: Tue, 24 Apr 2012 10:10:30 +0200
Message-ID: <4F965FF6.2020201@pengutronix.de>
References: <1334915902-30253-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA6FB1C90034E4B9FBA3D198"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2DXIKg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 04:10:36 -0400
In-Reply-To: <1334915902-30253-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA6FB1C90034E4B9FBA3D198
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/20/2012 11:58 AM, AnilKumar Ch wrote:
> This patch adds the support for D_CAN controller driver to the existing=

> C_CAN driver.
>=20
> Bosch D_CAN controller is a full-CAN implementation which is compliant
> to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can b=
e
> obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
> ipmodules_1/can/d_can_users_manual_111.pdf
>=20
> The following are the design choices made while adding D_CAN to C_CAN
> driver:
> A new overlay structure is added for d_can controller and care is taken=

> to make sure its member names match with equavalent c_can structure
> members (even if the d_can specification calls them slightly differentl=
y).
> Note that d_can controller has more registers, so structure members of
> d_can are more than those in c_can.
>=20
> A new set if read/write macros are used to access the registers common
> between c_can and d_can. To get the basic d_can functionality working
> it is sufficient to access just these registers.

I don't like macros. I've two further possible solutions:

a) Access the registers via an array. The array index is a "virtual"
   register, the array's value the physical offset within the c_can or
   d_can controller.
b) AFAICS you need more than three registers to get the CAN core
   working. Another possibility is to implement an accessor function
  for each register.

Other, hopefully better, solutions are open for discussion.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFA6FB1C90034E4B9FBA3D198
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+WX/YACgkQjTAFq1RaXHO7iACeNnkQr2PvERcC2EtvgpMGBnG8
868AnRfTmFAxhmxFRqe1nbYmBroeWeK3
=hXYT
-----END PGP SIGNATURE-----

--------------enigFA6FB1C90034E4B9FBA3D198--

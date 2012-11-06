From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FW: (Case 11280) Open source =?ISO-8859-1?Q?st=F6d_f=F6r_?=
 =?ISO-8859-1?Q?Kvaser_Leaf_Light_HS?=
Date: Tue, 06 Nov 2012 18:43:17 +0100
Message-ID: <50994C35.7010408@pengutronix.de>
References: <D06C8F8BF0DB1D42B8270DA292E92569285239F9@VMPREVAS1.prevas.se> <509936b5.0192980a.622a.ffff9440@mx.google.com> <D06C8F8BF0DB1D42B8270DA292E9256928523A11@VMPREVAS1.prevas.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBF110771CFD96E7A6D3C1FAF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41573 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab2KFRnT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Nov 2012 12:43:19 -0500
In-Reply-To: <D06C8F8BF0DB1D42B8270DA292E9256928523A11@VMPREVAS1.prevas.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Kjell_Str=F6m?= <Kjell.Strom@prevas.se>
Cc: "'linux-can@vger.kernel.org'" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBF110771CFD96E7A6D3C1FAF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/06/2012 05:13 PM, Kjell Str=F6m wrote:
> Hi,
> Is there any support for Kvaser Leaf Light to be downloaded?

Yes, Olivier posted a driver a month ago...which was not treated with
the attention it deserved from us, the reviewers. The patch is:

"[PATCH v5] can: kvaser_usb: Add support for Kvaser CAN/USB devices"

I just forwarded it to you,

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBF110771CFD96E7A6D3C1FAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCZTDUACgkQjTAFq1RaXHN6DgCfWV5EzGmZgZyyOoPKJ7jUK2ff
VX0AoIhjxyHGpc/iwbQPcna4BbL2oNnm
=S82B
-----END PGP SIGNATURE-----

--------------enigBF110771CFD96E7A6D3C1FAF--

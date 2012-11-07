From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: FW: (Case 11280) Open source =?ISO-8859-1?Q?st=F6d_f=F6r_?=
 =?ISO-8859-1?Q?Kvaser_Leaf_Light_HS?=
Date: Wed, 07 Nov 2012 09:51:11 +0100
Message-ID: <509A20FF.90002@pengutronix.de>
References: <D06C8F8BF0DB1D42B8270DA292E92569285239F9@VMPREVAS1.prevas.se> <509936b5.0192980a.622a.ffff9440@mx.google.com> <D06C8F8BF0DB1D42B8270DA292E9256928523A11@VMPREVAS1.prevas.se> <50994C35.7010408@pengutronix.de> <509A0B63.90002@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig83090C155C85C0B41D00CD0F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36910 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab2KGIvX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 03:51:23 -0500
In-Reply-To: <509A0B63.90002@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: =?ISO-8859-1?Q?Kjell_Str=F6m?= <Kjell.Strom@prevas.se>, "'linux-can@vger.kernel.org'" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83090C155C85C0B41D00CD0F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/07/2012 08:18 AM, Wolfgang Grandegger wrote:
> Hi Marc,
>=20
> On 11/06/2012 06:43 PM, Marc Kleine-Budde wrote:
>> On 11/06/2012 05:13 PM, Kjell Str=F6m wrote:
>>> Hi,
>>> Is there any support for Kvaser Leaf Light to be downloaded?
>>
>> Yes, Olivier posted a driver a month ago...which was not treated with
>> the attention it deserved from us, the reviewers. The patch is:
>=20
> Yes, that was also my conclusion. What is the status? Do we need anothe=
r
> round of reviews? IIRC, error handling and most other things looked goo=
d.

I'll look at this patch today, promised. I first have to fix a total
system freeze with the flexcan on ifconfig down.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig83090C155C85C0B41D00CD0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCaIQMACgkQjTAFq1RaXHMofACcCPdxSwZtIz3PHxv8PjezvGO8
AtQAn2BcZ1bRakW2pnFEEEzeVo17flNK
=/Gez
-----END PGP SIGNATURE-----

--------------enig83090C155C85C0B41D00CD0F--

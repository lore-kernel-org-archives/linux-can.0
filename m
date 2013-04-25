From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 11:23:42 +0200
Message-ID: <5178F61E.9040506@pengutronix.de>
References: <5169B395.2070703@hartkopp.net> <516D2ABB.4000300@pengutronix.de> <5177A090.6010904@peak-system.com> <20130424144929.GA2077@vandijck-laurijssen.be> <5178D00C.70507@grandegger.com> <20130425072429.GA448@vandijck-laurijssen.be> <5178DE98.7040408@grandegger.com> <20130425091421.GD448@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MAURCJGTFNCPESAITMHD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54778 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab3DYJXt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 05:23:49 -0400
In-Reply-To: <20130425091421.GD448@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MAURCJGTFNCPESAITMHD
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/25/2013 11:14 AM, Kurt Van Dijck wrote:
> I was just thinking that it has not that much to do with CAN altogether=
,
> and may deserve a seperate git tree.
>=20
> I'm just rewriting the code a bit to work without callback, and be more=
 like
> if_nameindex().

Would be cool if the functions follows the same semantics as
if_nameindex(), i.e. it could be named canif_nameindex() and just return
CAN interfaces, not all.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MAURCJGTFNCPESAITMHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF49iMACgkQjTAFq1RaXHPJfwCfegPDYINnlXViiGt8aN3izt0n
lvAAoIccphG6ylkuKI7HY1y6yw8YrfJk
=N9Bk
-----END PGP SIGNATURE-----

------enig2MAURCJGTFNCPESAITMHD--

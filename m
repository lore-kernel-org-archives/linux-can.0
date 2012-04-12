From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: linux-can patches for vanilla kernel
Date: Thu, 12 Apr 2012 11:42:52 +0200
Message-ID: <4F86A39C.7080900@pengutronix.de>
References: <jm65ct$57g$1@ultimate100.geggus.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF78BE9CF4DC1B5663EF00E1B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47657 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762428Ab2DLJm6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 05:42:58 -0400
In-Reply-To: <jm65ct$57g$1@ultimate100.geggus.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sven Geggus <lists@fuchsschwanzdomain.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF78BE9CF4DC1B5663EF00E1B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2012 10:57 AM, Sven Geggus wrote:
> I'm a little bit confused which git tree I would need to clone if my ta=
rget
> is a vanilla stable Kernel (currently 3.3.1) but with the latest and
> greatest can bus driver stack (peak-usb support in my case).

Use mainline.
Peak usb support was added to mainline in v3.3-rc6-1180-g1ccba21 a.k.a.
v3.4-rc1~177^2~53^2, which means that you need at least v3.4-rc1. So use
latest v3.4.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF78BE9CF4DC1B5663EF00E1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+Go58ACgkQjTAFq1RaXHPrrgCfRV2PFP7fPvUFclgH1dnH0mts
EH4An2A/pvjCls1i4NHtNb1Cd66gaoph
=RUd4
-----END PGP SIGNATURE-----

--------------enigF78BE9CF4DC1B5663EF00E1B--

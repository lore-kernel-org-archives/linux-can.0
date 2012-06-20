From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: af_can: fix sparse warning for can_rx_alldev_list
Date: Wed, 20 Jun 2012 18:05:34 +0200
Message-ID: <4FE1F4CE.1060305@pengutronix.de>
References: <1340136320-30840-1-git-send-email-mkl@pengutronix.de> <1340136320-30840-4-git-send-email-mkl@pengutronix.de> <4FE1460F.8040409@hartkopp.net> <4FE1830A.3020605@pengutronix.de> <4FE1F070.4060305@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB892315EBF1740724FE4BA6C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37824 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951Ab2FTQFm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jun 2012 12:05:42 -0400
In-Reply-To: <4FE1F070.4060305@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB892315EBF1740724FE4BA6C
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: quoted-printable

On 06/20/2012 05:46 PM, Oliver Hartkopp wrote:
> So this would fix the sparse warning then?

Yes it does. Can I add your S-o-b?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB892315EBF1740724FE4BA6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/h9NIACgkQjTAFq1RaXHMeowCfXw6shkkoFxE3Tjfp+Q0O/EUU
BDYAn3217fMkJU8rFY+mX+HCZX4XY68S
=BHZX
-----END PGP SIGNATURE-----

--------------enigB892315EBF1740724FE4BA6C--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN Driver
Date: Thu, 06 Dec 2012 10:44:55 +0100
Message-ID: <50C06917.9000401@pengutronix.de>
References: <1346761707.5009.4.camel@punsfloyd-desktop>  <5045F53F.7070209@pengutronix.de>  <1354779353.5010.2.camel@punsfloyd-desktop>  <50C05F2D.8060903@pengutronix.de> <1354785999.5871.8.camel@punsfloyd-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB18EB3D45A9B0623901E0511"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54568 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422691Ab2LFJpB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 04:45:01 -0500
In-Reply-To: <1354785999.5871.8.camel@punsfloyd-desktop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: puneet.sharma@moschip.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB18EB3D45A9B0623901E0511
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 10:26 AM, Puneet Sharma wrote:
> Thanks a lot for the immediate response. I cannot test the controller
> in kernel as it increases the abstraction which is not desirable in
> my case.

YMMV :)

> My intention is to write simple test cases which can test the
> controller thereby exploiting the basic functionalities of the
> controller.
>=20
> If you can give me some points namely some minimum functions that can
> help me to do so.

You're using a at91sam9263, right?. Then have a look at the linux driver.=


To setup the controller:
at91_can_probe();
at91_open();

To send a message:
at91_start_xmit();

To receive a message:
at91_poll_rx();

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB18EB3D45A9B0623901E0511
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAaRoACgkQjTAFq1RaXHPDxQCeMWZhqQ2FsmcoOctNSSre0aZM
TbwAmwY0rdmSiU7M8os5MR/390IDPA54
=rR5Q
-----END PGP SIGNATURE-----

--------------enigB18EB3D45A9B0623901E0511--

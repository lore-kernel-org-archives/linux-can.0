From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: sja1000 fix isr hang when hw is unplugged under
 load
Date: Tue, 21 Feb 2012 10:03:33 +0100
Message-ID: <4F435DE5.8000600@pengutronix.de>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de> <4F3BE2AC.9020108@hartkopp.net> <4F3EB82C.7080905@pengutronix.de> <4F3FB389.7050104@hartkopp.net> <4F422841.3070901@pengutronix.de> <4F4350BB.4090408@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE73897748DFBA5418C14A5F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37516 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab2BUJHy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2012 04:07:54 -0500
In-Reply-To: <4F4350BB.4090408@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE73897748DFBA5418C14A5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/21/2012 09:07 AM, Oliver Hartkopp wrote:
> Are you sure you sent it CC to stable?

Something must have gone wrong there. I added a Cc: to the patch descipti=
on.

> Didn't see that in the mail.

I'll resend it manually.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigDE73897748DFBA5418C14A5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9DXekACgkQjTAFq1RaXHNfowCfZN4ChqA4MaiUU7Er8AJP4bln
U5kAoJne7GxrAsbhw+AZaylP2crLcdVh
=F7Wo
-----END PGP SIGNATURE-----

--------------enigDE73897748DFBA5418C14A5F--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: linsocketcan
Date: Wed, 21 Nov 2012 09:18:10 +0100
Message-ID: <50AC8E42.3080501@pengutronix.de>
References: <003501cdc71f$aca1c950$05e55bf0$@wp.eu> <50AB85B6.3090702@pengutronix.de> <004401cdc72c$4bd2ff60$e378fe20$@wp.eu> <50AB95F1.9000108@pengutronix.de> <001d01cdc7be$17730520$46590f60$@wp.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1C06FA44E9450FE86FF7FF3"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47861 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab2KUISQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 03:18:16 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1Tb5Vf-0004wY-Er
	for linux-can@vger.kernel.org; Wed, 21 Nov 2012 09:18:15 +0100
Received: from [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b] (hardanger.wlan.blackshift.org [IPv6:2001:6f8:105b:1122:21d:e0ff:fe39:f61b])
	(using TLSv1 with cipher ECDHE-ECDSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 3A54D5E860
	for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 09:18:15 +0100 (CET)
In-Reply-To: <001d01cdc7be$17730520$46590f60$@wp.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1C06FA44E9450FE86FF7FF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

for the protocol, problem solved:

On 11/21/2012 08:59 AM, Robert wrote:
>> A rooted devices doesn't mean that every process runs as root. Have yo=
u
>> started your program as root?

> All ok, CANbus is Up. Thanks for suggestions.

\o/

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF1C06FA44E9450FE86FF7FF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCsjkYACgkQjTAFq1RaXHME6wCfaYGhypsNOt+ZX5IeslG7qawi
6aYAni/t7nXqwtqnB930rz6xHMqG/Zcq
=RtUO
-----END PGP SIGNATURE-----

--------------enigF1C06FA44E9450FE86FF7FF3--

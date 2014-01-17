From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Kvazer USB CAN driver
Date: Fri, 17 Jan 2014 15:00:56 +0100
Message-ID: <52D93798.2050804@pengutronix.de>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com> <1389107792.5708.9.camel@blackbox> <85d7d20e09a64996a182e491c6d250e0@AMSPR06MB053.eurprd06.prod.outlook.com> <52CDC307.1020102@hartkopp.net> <64b7875c88bc4d9c914241f2fac0d448@AMSPR06MB053.eurprd06.prod.outlook.com> <20140116110204.GA5286@hposo> <eaaaec0611754c7ba17e961905ca3990@AMSPR06MB053.eurprd06.prod.outlook.com> <52D8FCC9.3050905@pengutronix.de> <eb86d5cebc2e43f2935fc5b97cf507ad@AMSPR06MB053.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gPA83KMJL1oF9kNBWIa38KNXdhg1xosI0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55555 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbaAQOjk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 09:39:40 -0500
In-Reply-To: <eb86d5cebc2e43f2935fc5b97cf507ad@AMSPR06MB053.eurprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>, Olivier Sobrie <olivier@sobrie.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Daniel Berglund <db@kvaser.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPA83KMJL1oF9kNBWIa38KNXdhg1xosI0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2014 02:50 PM, GARNERO, PIERRE (P.) wrote:
> Yes. I will try to do so. However, I am a newbie in this area, so a
> pointer on how to proceed will be more than welcome (maybe in a
> private mail in order not to pollute the mailing list ?).

No :) This discussion should take place on the mailinglist, as there
might be more people here, who want to learn something. And this
mailinglist is really low traffic.

I think the first step should be to make the structs describing the USB
messages compatible.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gPA83KMJL1oF9kNBWIa38KNXdhg1xosI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLZN5gACgkQjTAFq1RaXHMVOwCfZuLWeVFNyMzFpMQkPcJo4tSz
/+0An3hNx6IV7qVRUOZIyysG12w6fSmr
=cHso
-----END PGP SIGNATURE-----

--gPA83KMJL1oF9kNBWIa38KNXdhg1xosI0--

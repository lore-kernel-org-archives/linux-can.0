From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN Driver
Date: Thu, 06 Dec 2012 11:09:06 +0100
Message-ID: <50C06EC2.3000609@pengutronix.de>
References: <1346761707.5009.4.camel@punsfloyd-desktop>  <5045F53F.7070209@pengutronix.de>  <1354779353.5010.2.camel@punsfloyd-desktop>  <50C05F2D.8060903@pengutronix.de>  <1354785999.5871.8.camel@punsfloyd-desktop>  <50C06917.9000401@pengutronix.de> <1354787514.6620.3.camel@punsfloyd-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE52B928683D95A88F4EFD046"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53582 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab2LFKJN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 05:09:13 -0500
In-Reply-To: <1354787514.6620.3.camel@punsfloyd-desktop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: puneet.sharma@moschip.com, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE52B928683D95A88F4EFD046
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

please keep the mailinglist on Cc.

On 12/06/2012 10:51 AM, Puneet Sharma wrote:
> I have read the driver code (at91_can.c) but what i want is some
> simple application which will make use of this driver in u-boot to
> test the Controller.

Have you already ported the CAN driver to u-boot?

> For eg. the application can continously send CAN frames in binary,
> dec or Hex format thereby incrementing the CAN ID everytime or doing
> some similar thing. Is it possible to do such things in u-boot. I
> know in linux this can be achieved via SOCKET CAN.

I think you haev to first invent some kind of interface from your
application to the driver, e.g.:

can_init();
can_write(struct can_frame *cf);
can_read_timeout(struct can_frame *cf, unsinged long timeout);

All these functions should be blocking (with timeout in the read case).
Then you can write an application against that API. You have to write
some glue code to attach the API to the driver. For testing applications
have a look the the can-utils at gitorious [1].

Marc

[1] https://gitorious.org/linux-can/can-utils

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigE52B928683D95A88F4EFD046
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDAbsYACgkQjTAFq1RaXHP9oACgjny9/8cL3toIjikkMogCLCcW
iBgAn2Zom0DdQGrKBgc+o18cT/gRCg2T
=Ox/T
-----END PGP SIGNATURE-----

--------------enigE52B928683D95A88F4EFD046--

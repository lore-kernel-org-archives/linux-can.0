From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Kvazer USB CAN driver
Date: Fri, 17 Jan 2014 10:50:01 +0100
Message-ID: <52D8FCC9.3050905@pengutronix.de>
References: <a8d74bed340445f081325afedf044bb5@AMSPR06MB053.eurprd06.prod.outlook.com> <1389107792.5708.9.camel@blackbox> <85d7d20e09a64996a182e491c6d250e0@AMSPR06MB053.eurprd06.prod.outlook.com> <52CDC307.1020102@hartkopp.net> <64b7875c88bc4d9c914241f2fac0d448@AMSPR06MB053.eurprd06.prod.outlook.com> <20140116110204.GA5286@hposo> <eaaaec0611754c7ba17e961905ca3990@AMSPR06MB053.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9BHxiJUBcd3PNoiRJ8SnBt0fpeICUvTks"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaAQJuL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 04:50:11 -0500
In-Reply-To: <eaaaec0611754c7ba17e961905ca3990@AMSPR06MB053.eurprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "GARNERO, PIERRE (P.)" <pgarnero@visteon.com>, Olivier Sobrie <olivier@sobrie.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Daniel Berglund <db@kvaser.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9BHxiJUBcd3PNoiRJ8SnBt0fpeICUvTks
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On 01/17/2014 10:36 AM, GARNERO, PIERRE (P.) wrote:
> I have been able to test my modification of kvaser_usb.c file on
> Fedora 17/x86 (see attachment). This module is able to read CAN
> messages coming from a Kvaser canUSB Rugged device (which is enough
> for my goal).

The diff to the original driver isn't that big, if you want to get it
mainlined you should work on integrating it into the original driver.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9BHxiJUBcd3PNoiRJ8SnBt0fpeICUvTks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLY/MkACgkQjTAFq1RaXHM50wCfa4kQf/ZbKtBQLMSqHD8Y5rfk
eSAAn1k8FVc1IHnNJ8iZlujnMInWGvsD
=Wi76
-----END PGP SIGNATURE-----

--9BHxiJUBcd3PNoiRJ8SnBt0fpeICUvTks--

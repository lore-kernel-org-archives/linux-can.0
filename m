From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Tue, 10 Jul 2012 12:20:47 +0200
Message-ID: <4FFC01FF.3030801@pengutronix.de>
References: <20120703232328.GD6616@ovro.caltech.edu> <4FF40A6E.1040709@grandegger.com> <20120704120736.GB417@vandijck-laurijssen.be> <4FF46E12.8060102@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72A248515E71A695B2669024"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45481 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab2GJKVC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jul 2012 06:21:02 -0400
In-Reply-To: <4FF46E12.8060102@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72A248515E71A695B2669024
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/04/2012 06:23 PM, Oliver Hartkopp wrote:
> Anyway we currently have the flexcan and the ican3 hardware that genera=
lly
> supports a loopback on hardware level but looses the reference to the t=
x-skb
> and therefore to the sk pointer which is used to identify the originati=
ng
> socket for recv-own-msgs support.

For the record:
Since v3.4-rc1 flexcan implements proper loopback. (The flexcan driver
has been added before recv-own-msgs support has been implemented, so it
didn't make any difference back then.)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig72A248515E71A695B2669024
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/8AgMACgkQjTAFq1RaXHN6iACeM+dYrNK0qY0C46fcxHm1UjGI
MDEAn22AvkO0zQ6Q204IYk1PxiCMZMYN
=yEru
-----END PGP SIGNATURE-----

--------------enig72A248515E71A695B2669024--

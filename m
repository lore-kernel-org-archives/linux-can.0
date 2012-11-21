From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: peak_usb: timestamp issue
Date: Wed, 21 Nov 2012 16:58:45 +0100
Message-ID: <50ACFA35.90804@pengutronix.de>
References: <50ACF47E.7010004@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F854BB97E55EE6481B10D80"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36602 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2KUP6v (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 10:58:51 -0500
In-Reply-To: <50ACF47E.7010004@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F854BB97E55EE6481B10D80
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/21/2012 04:34 PM, Oliver Hartkopp wrote:
> Hi Stephane,
>=20
> i was working with the PEAK USB adapter today and got the problem of di=
fferent
> timestamps with 'candump -x -ta can0':
>=20
> Timestamps of received CAN frames looked like my system 'uptime'.
> Send CAN frames had the real system time.
>=20
> The problem is, that you insert the hardware timestamp of the PEAK USB
> adapters into skb->tstamp ...
>=20
> This is wrong. For hardware timestamps (RX/TX) there's a special handli=
ng in
> the Linux Kernel, see at
>=20
> 	linux/Documentation/networking/timestamping.txt
>=20
> For now i just removed the setting of your HW timestamps on my Linux bo=
x (see
> attached patch).
>=20
> Please fix the HW timestamp handling in your driver by supporting the H=
W
> timstamp API correctly.

Oliver can you prepare a proper patch, which removes the broken time
stamping, I'd like to get this into 3.7.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4F854BB97E55EE6481B10D80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCs+jkACgkQjTAFq1RaXHNPrgCeJH9PL2VxkUNa9KTZVUf4xpRG
HpgAnib7Oglvzgl+DJ7AILNG9sn6jGZ0
=YtE6
-----END PGP SIGNATURE-----

--------------enig4F854BB97E55EE6481B10D80--

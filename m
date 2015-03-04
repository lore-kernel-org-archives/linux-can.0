From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_usb: fix missing ctrlmode_ init for every dev
Date: Wed, 04 Mar 2015 10:19:11 +0100
Message-ID: <54F6CE0F.50503@pengutronix.de>
References: <1425293678-22217-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fb5CBcs0XKIpJLJOENhI6rdPwHXQM9KWD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43440 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759671AbbCDJT0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Mar 2015 04:19:26 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1YT5Se-000410-MY
	for linux-can@vger.kernel.org; Wed, 04 Mar 2015 10:19:24 +0100
In-Reply-To: <1425293678-22217-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fb5CBcs0XKIpJLJOENhI6rdPwHXQM9KWD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2015 11:54 AM, Stephane Grosjean wrote:
> Fixes a missing initialization of ctrlmode and ctrlmode_supported field=
s,
> for all other CAN devices than the first one. This fix only concerns
> the PCAN-USB Pro FD dual-channels CAN-FD device made by PEAK-System.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--fb5CBcs0XKIpJLJOENhI6rdPwHXQM9KWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU9s4PAAoJECte4hHFiupU5u0P/26oPzzSVUQ/DJibooAi382f
HVfHEaXhRtPJj5t2tyC7cF3YC24I++S+mt0ESSYmXVgdnr634ONAZ0sg9M5vatN8
sNwipEKKeKaksx07/1RFiFcFTBhfoF/s5mgvOkgPAMXNEtx1/qm3LE7RYcTxB4bW
q2XAbwcj7p1xemqgy8+1De0MVNs/RawzD4oYtLcHtpa6nz03pWf8/I1D56yASrpM
w0a9U3xVDAamBzYN1HNHgnLrgPdcNL+JJLWtj1gEQbsywEMTk4PV6374SMrtMLLk
umm1BicLWb4Gk7N/WmNCfHnsKv4Z3Fsz00K0Wq1onAf7WFDbxKkm8Min1aHynt6n
fvsfgxz50U5ZUPqLKSNpc/dm3hEMxe2VZwZ4Q4mlw6IFoHlrVe/8UIfQ8oDNvDVe
wuonFh9HQWOhHPpVX6rV2j5/x4oOufh5/Eo2rJkRiUt8378unwkDuna2erO6e4KI
3R7vgnM/ugUeGvYVbjboOEfhe99GmtZYFbNvdZZigIhy4DNIhN9EUrjHJJ1ix4Tk
qhLag81dfKZ+GrKB+GWPpXGJeXTUey0xEoi8Hqk3s1I76vZNuUNVsYvW6rhGzmy3
zDGIoduol1UbRqmK6vhCOi3PUrEd7uUh1eqsz8LFsCcSqEuKt2r2tZsPAyrWl4Pk
KyQLiT9g+f1qMr9BFggJ
=27do
-----END PGP SIGNATURE-----

--fb5CBcs0XKIpJLJOENhI6rdPwHXQM9KWD--

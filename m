From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: C-Can or Other SocketCAN Issue
Date: Mon, 03 Mar 2014 20:16:02 +0100
Message-ID: <5314D4F2.4010405@pengutronix.de>
References: <d634b30117cf40dfb954c723bef01b65@BN1PR01MB071.prod.exchangelabs.com>,<5314AF7F.3010701@pengutronix.de>,<4179fe0897d74eccba72d6c9ba63694c@BN1PR01MB071.prod.exchangelabs.com> <914f07d33a6c473ba415edb4bd05f7b5@BN1PR01MB071.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nBVteKL3EH4D0DRJHwTKNN1BbcIOTm9kA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49736 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbaCCTQH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 14:16:07 -0500
In-Reply-To: <914f07d33a6c473ba415edb4bd05f7b5@BN1PR01MB071.prod.exchangelabs.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Harrington, Sean M." <harrington.234@buckeyemail.osu.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nBVteKL3EH4D0DRJHwTKNN1BbcIOTm9kA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2014 06:31 PM, Harrington, Sean M. wrote:
>>> The Beaglebone Black should be running Ubuntu 13.04. I'm willing to
>>> rebuild the kernel and install the latest distribution if I can some
>>> feedback on the proper method to get SocketCAN functional and if it
>>> would most likely resolve the issue.
>=20
>> Which Kernel version are you using?
>=20
> Here is what uname -a returned:
> Linux arm 3.8.13-bone35 #2 SMP Sat Jan 4 10:18:07 PST 2014 armv7l armv7=
l armv7l GNU/Linux

Your kernel is probably missing the following patch:

> 5d0f801 can: c_can: Fix RX message handling, handle lost message before=
 EOB

You should update to at least the newest v3.10.x or v3.13.x. You might
also cherry-pick the above patch into you kernel.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nBVteKL3EH4D0DRJHwTKNN1BbcIOTm9kA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlMU1PIACgkQjTAFq1RaXHMEYwCaAkj+f5BOAr4g0UpyYOdOFDyI
EGIAn1sWyK19PA6v7Gr1gsbMc/TvmSBt
=8CKH
-----END PGP SIGNATURE-----

--nBVteKL3EH4D0DRJHwTKNN1BbcIOTm9kA--

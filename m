From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Patch for libsocketcan
Date: Tue, 07 Aug 2012 09:43:48 +0200
Message-ID: <5020C734.2090008@pengutronix.de>
References: <6D9074C1-4B77-4D4B-BCF5-F13625B6DC05@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35FECED3077169B68F94A726"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45476 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2HGHoA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Aug 2012 03:44:00 -0400
In-Reply-To: <6D9074C1-4B77-4D4B-BCF5-F13625B6DC05@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andrew Beard <abeard@ovro.caltech.edu>
Cc: Ira Snyder <iws@ovro.caltech.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35FECED3077169B68F94A726
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

I've added linux-can on Cc.

On 08/03/2012 08:23 PM, Andrew Beard wrote:
> Hi Marc,
> Attached is a patch for what I believe is a bug in libsocketcan.
> Please let me know if you have any questions.

Yes, it's a bug, Alexander Stein fixed it already, but I didn't apply
his patch. Your patch, is the way better solution. You did not follow
quite the kernel coding style, and put some variable definition into the
loop. I fixed that an will commit it to the repo. Can I add your
Signed-off-by[1] to the patch?

Marc

[1]
http://lxr.free-electrons.com/source/Documentation/SubmittingPatches#L298=

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig35FECED3077169B68F94A726
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAgxzcACgkQjTAFq1RaXHOIOwCfSJ9Y/6SPnqtHuJ7t8ADX6qFn
UYkAn0/VcVjIjHM2+6gwjRIkbSulWU8w
=d3ge
-----END PGP SIGNATURE-----

--------------enig35FECED3077169B68F94A726--

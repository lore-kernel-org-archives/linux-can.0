From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: cansend app will block while it is sending RTR frames
Date: Fri, 30 Aug 2013 09:27:07 +0200
Message-ID: <5220494B.8040203@pengutronix.de>
References: <loom.20130828T111851-325@post.gmane.org>, <521DED99.6010606@pengutronix.de> <201308301520148531275@embedinfo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rwoN08A6ufWqv72ElBcW1XgvvqQvSFVWf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38287 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3H3H1M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Aug 2013 03:27:12 -0400
In-Reply-To: <201308301520148531275@embedinfo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: xuewt <xuewt@embedinfo.com>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rwoN08A6ufWqv72ElBcW1XgvvqQvSFVWf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2013 09:20 AM, xuewt wrote:
> I found that I didn't free the skb buffer for RTR frame. It was resolve=
d.

Please don't top post. Oh, you're writing a new driver. What hardware
are you supporting? If you post it here, we'll review it.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--rwoN08A6ufWqv72ElBcW1XgvvqQvSFVWf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIgSUsACgkQjTAFq1RaXHO72gCfXbkiFNMzp0EcnmzJXDtZmoF/
84gAoIHWt60TemwAowiE9JvuYiUZV/vX
=MwGy
-----END PGP SIGNATURE-----

--rwoN08A6ufWqv72ElBcW1XgvvqQvSFVWf--

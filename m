From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] canutils: candump: Add error frame's handling
Date: Tue, 10 Jan 2012 14:40:50 +0100
Message-ID: <4F0C3FE2.9060606@pengutronix.de>
References: <1326201911-18255-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD9DB472C376CC07069C7B467"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48299 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935Ab2AJNk6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2012 08:40:58 -0500
In-Reply-To: <1326201911-18255-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: m.kleine-budde@pengutronix.de, r.schwebel@pengutronix.de, linux-can@vger.kernel.org, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD9DB472C376CC07069C7B467
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/10/2012 02:25 PM, AnilKumar Ch wrote:
> This patch adds the error handling capability to candump utility
> by adding error flags for displaying all kind of error frames
> like tx_timeout, lost arbitration, controller problems, buserrors,
> bus warnings etc.
>=20
> Usage of candump for error frame display on console:
> candump [<can-interface>] [Options]
> Ex: candump can0 --error
>=20
> This patch is created on top of canutils-4.0.6 tag from
> http://git.pengutronix.de/?p=3Dtools/canutils.git

Tnx, applied

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigD9DB472C376CC07069C7B467
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8MP+UACgkQjTAFq1RaXHN3QACfYgNKykqYO2DGvG90VB1jTVkF
jK4AniS51k1OlyG/XuG6gs3ntRs6IeG8
=TupC
-----END PGP SIGNATURE-----

--------------enigD9DB472C376CC07069C7B467--

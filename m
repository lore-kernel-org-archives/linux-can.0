From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Tue, 16 Sep 2014 16:29:25 +0200
Message-ID: <54184945.90900@pengutronix.de>
References: <1409755642-28233-1-git-send-email-david@protonic.nl>	<54081940.6060402@pengutronix.de>	<20140904104440.5766d764@archvile>	<5418238B.6010600@pengutronix.de> <20140916142846.2ae8335c@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1kVpETSGn23KllDpLBDSTBHeb8bgBjA4I"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57881 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbaIPO3b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:29:31 -0400
In-Reply-To: <20140916142846.2ae8335c@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1kVpETSGn23KllDpLBDSTBHeb8bgBjA4I
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2014 02:28 PM, David Jander wrote:
> Is it time to revisit my other patch(es) yet? If so, from where should =
I pull
> the base?

Please review the flexcan series (v4) I just sent around. That will go
into net/master then.

For new the new flexcan features please use this as your base:

git://gitorious.org/linux-can/linux-can-next.git flexcan-next

It's net-next merged to the latest can patches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1kVpETSGn23KllDpLBDSTBHeb8bgBjA4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQYSUUACgkQjTAFq1RaXHNDuwCfQMhnZevm35OCiannMxEEZybh
Na8AniY9cUw8B6YEIB4oJwtZTae4n/U6
=A1Hz
-----END PGP SIGNATURE-----

--1kVpETSGn23KllDpLBDSTBHeb8bgBjA4I--

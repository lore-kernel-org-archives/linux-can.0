From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: slcand: tty device name
Date: Thu, 23 Jan 2014 09:16:54 +0100
Message-ID: <52E0CFF6.5080701@pengutronix.de>
References: <CAGm1_ks=hrhb4WTs9jiqgViYOmAAC+dnLCc5LpXP8TWMe65Yrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5qgm564fORCXELb6x19cUJ4ThMxn2dQEN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50370 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaAWIRA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 03:17:00 -0500
In-Reply-To: <CAGm1_ks=hrhb4WTs9jiqgViYOmAAC+dnLCc5LpXP8TWMe65Yrw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5qgm564fORCXELb6x19cUJ4ThMxn2dQEN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2014 08:21 AM, Yegor Yefremov wrote:
> Hi Oliver and Marc,
>=20
> what is the reason for slcand accepting only tty* and not both
> variants tty* and /dev/tty*?

I don't know, it was added this way to the repository. Ask Robert Haddon
<robert.haddon@verari.com>, the original author. I think you can
contribute a patch so that it accepts /dev/tty*, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5qgm564fORCXELb6x19cUJ4ThMxn2dQEN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLgz/YACgkQjTAFq1RaXHMIrwCfVzpF5+H2WlOkTlYCBZiCtkgB
CwwAn14SVrUgTHkV3WmfSg7MqpnAF2W5
=7AGu
-----END PGP SIGNATURE-----

--5qgm564fORCXELb6x19cUJ4ThMxn2dQEN--

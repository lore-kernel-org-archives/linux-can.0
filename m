From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Wed, 06 Mar 2013 17:36:39 +0100
Message-ID: <51377097.4000108@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <2B7D120CFC15DC438D721B998AD9D9E90971062B@SEGOTNC5180-N2.vcn.ds.volvo.net> <51376C4E.3020105@pengutronix.de> <2B7D120CFC15DC438D721B998AD9D9E909710649@SEGOTNC5180-N2.vcn.ds.volvo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2JKSCVNLXBPMGKJSHXDEP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40589 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab3CFQgs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Mar 2013 11:36:48 -0500
In-Reply-To: <2B7D120CFC15DC438D721B998AD9D9E909710649@SEGOTNC5180-N2.vcn.ds.volvo.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sako Youssouf <youssouf.sako@renault-trucks.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2JKSCVNLXBPMGKJSHXDEP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/2013 05:25 PM, Sako Youssouf wrote:
> Ok! And do you know the way to know how many frames are in the Queue?=20

Why do you need this information?

Just keep reading until read() blocks. If you don't like blocking, put
the socket into non blocking mode and read() will return -EAGAIN.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2JKSCVNLXBPMGKJSHXDEP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE3cJsACgkQjTAFq1RaXHOiPQCfVH/3eUOuB96+bcvNVawa+hYX
pJsAnRBERZeLihUWyZsGFZxmdqTKm4iB
=5hYj
-----END PGP SIGNATURE-----

------enig2JKSCVNLXBPMGKJSHXDEP--

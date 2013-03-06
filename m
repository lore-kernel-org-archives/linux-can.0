From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Wed, 06 Mar 2013 17:18:22 +0100
Message-ID: <51376C4E.3020105@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <2B7D120CFC15DC438D721B998AD9D9E90971062B@SEGOTNC5180-N2.vcn.ds.volvo.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2WWDCMKOKTLBSPXFGLVOG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41497 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab3CFQS3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Mar 2013 11:18:29 -0500
In-Reply-To: <2B7D120CFC15DC438D721B998AD9D9E90971062B@SEGOTNC5180-N2.vcn.ds.volvo.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sako Youssouf <youssouf.sako@renault-trucks.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2WWDCMKOKTLBSPXFGLVOG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/06/2013 05:03 PM, Sako Youssouf wrote:
> What's your usecae? What do you want to do with that information?
>=20
> Actually I'm in a multithreaded application and my goal is to lose no
> frame. If I had direct access to the hardware, I would go  get the
> new frame after hardware interrupt. But I think it's not possible. So
> I want to find the better way to get all frames in a multithreaded
> application.

The driver takes care of loosing no frame. In you application you just
have to read() or recv() from the socket. It doesn't matter if you app
is multithreaded or not.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2WWDCMKOKTLBSPXFGLVOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE3bFEACgkQjTAFq1RaXHNj3wCfV2U0ep0AEWaPeNGPuY0Yr98z
bRgAnRgz+oqWUv6Fje5hawBqfAEIU/AC
=ZGKP
-----END PGP SIGNATURE-----

------enig2WWDCMKOKTLBSPXFGLVOG--

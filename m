From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Socketcan correct way to bootup...
Date: Wed, 09 Jul 2014 14:36:54 +0200
Message-ID: <53BD3766.6090202@pengutronix.de>
References: <53BD1BE1.8050403@eurekelettronica.it> <53BD248F.5030608@pengutronix.de> <CAGm1_kuBTJEsTjrYCtop6vcdB+pyNe64bjVgMbz6F0bXsGsHeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FTMrfq2iXENHfQvWjMdOs48djGH9hH0G8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45139 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbaGIMhB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 08:37:01 -0400
In-Reply-To: <CAGm1_kuBTJEsTjrYCtop6vcdB+pyNe64bjVgMbz6F0bXsGsHeg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: gianluca <gianlucarenzi@eurekelettronica.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FTMrfq2iXENHfQvWjMdOs48djGH9hH0G8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2014 02:29 PM, Yegor Yefremov wrote:
>> BTW: you probably want to integrate your application into the automati=
c
>> startup via an init script or in new designs with systemd...and _not_
>> start it by hand.
>=20
> You can also use libsocketcan or libnl to configure CAN interface
> directly from your application.

Good point.

here's libsocketcan's API:

http://git.pengutronix.de/?p=3Dtools/libsocketcan.git;a=3Dblob;f=3Dinclud=
e/libsocketcan.h;h=3Ddc52053b824d1a8976126b043de4ee5d843c1401;hb=3D0c9194=
0da1c16e01e8220e9fa18c703852ba6d1b

http://www.pengutronix.de/software/libsocketcan/download/

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FTMrfq2iXENHfQvWjMdOs48djGH9hH0G8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO9N2YACgkQjTAFq1RaXHNk6gCbBP/P5NTvKoiRA8qYeH1is4EW
8UcAoIlL84j2yqK2Mq/AnAOaw9/OU+i5
=iVzh
-----END PGP SIGNATURE-----

--FTMrfq2iXENHfQvWjMdOs48djGH9hH0G8--

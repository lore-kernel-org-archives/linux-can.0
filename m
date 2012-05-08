From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: changing bit timings from C program
Date: Tue, 08 May 2012 23:35:49 +0200
Message-ID: <4FA991B5.90602@pengutronix.de>
References: <CABHoAv=Q70Uegejcapk=ntFitR6--XaS05Wubsm4FTwZeCZ0dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5D362C37478792E02CCBCE4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33324 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab2EHVgL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 17:36:11 -0400
In-Reply-To: <CABHoAv=Q70Uegejcapk=ntFitR6--XaS05Wubsm4FTwZeCZ0dg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5D362C37478792E02CCBCE4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 11:18 PM, Michael Economides wrote:
> In the socketCAN documentation it says we should use the netlink
> interface (from the command line) to change can bit timings:
>=20
> http://lxr.linux.no/linux+v3.1.1/Documentation/networking/can.txt#L742
>=20
> But I would like to know if there is an API I can call directly from
> my C program to do it.

http://www.pengutronix.de/software/libsocketcan/download/

http://git.pengutronix.de/?p=3Dtools/libsocketcan.git;a=3Dblob;f=3Dinclud=
e/libsocketcan.h;h=3Ddc52053b824d1a8976126b043de4ee5d843c1401;hb=3D5b990a=
47714ea21911538304f9350edefe349299

cheers, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF5D362C37478792E02CCBCE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pkcYACgkQjTAFq1RaXHPV4ACgkAFa+8WW/gTBOebrTmzEO5L0
E90AnRtZof6eKKWWZ/Po+royR/w3RtKk
=winD
-----END PGP SIGNATURE-----

--------------enigF5D362C37478792E02CCBCE4--

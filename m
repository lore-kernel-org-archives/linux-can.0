From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can.h: make padding given by gcc explicit
Date: Tue, 5 May 2015 09:06:03 +0200
Message-ID: <55486BDB.7040902@pengutronix.de>
References: <554797BA.6080506@hartkopp.net>
 <1430809381-3497-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FjufNRXqxC01lbO9piCHucV7bumJKUlGe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37277 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbbEEHGz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 May 2015 03:06:55 -0400
in-reply-to: <1430809381-3497-1-git-send-email-shawn@churchofgit.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FjufNRXqxC01lbO9piCHucV7bumJKUlGe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2015 09:03 AM, Shawn Landden wrote:
> The current definition of struct can_frame has a 16-byte size, with 8-b=
yte
> alignment, but the 3 bytes of padding are not explicit like the similar=
 2 bytes
> of padding of struct canfd_frame. Make it explicit so it is easier to r=
ead.
>=20
> v2: match analogous padding fields in canfd_frame
>     update Documentation

Can you add your S-o-b?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FjufNRXqxC01lbO9piCHucV7bumJKUlGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVSGvbAAoJECte4hHFiupUW38P/j66xD5elLT7NF3w216pt2Re
Q6gkW4OjAzME7P0P/WnmksTCZ0+XtPVarCLOjdZRdJP9TUkoL5Yv0x9AtMPy6faM
GdxmsDz+slkr1bdRfQcy0O+etTtLAr7YtrL98hzk4Ih7zgFDX3WQ/H9O/QrsaOYI
vDQcMVYtJf1F+z4vMwBOTz9L7Y+siSprnWU5fZpSyglB8Je+fQXrc2z4iioie4z4
lPr0i82cLz8pncijMAcKFOj7jLnITm6x+ovg7nJMprzR0lsQApQc+/AdglbtAWyq
SpLZ+DCMMYRRmhbH4z2cZNpOpsceIB1gLNhOkH0RCQ4hjSoclw8+YGw9duO199Yz
cUJZ1CEZlzQK/hXU1qaN9tNQlIjuBzCRDc/esdDE1+tjf3A1qdgPdURF12gMbofc
OqY0+xdC0z5ACTA81QgCu3KwEF63grXh3g/6PZr0e9rpA3zkTE8/rA7mtEzejMYT
x9zGKuz2BlFS2Azfp9FSyjYw27coQVi0Uxnoa9h0T9d3gRAc9pk4aJdyxU3rudJD
oYyiFa/+GZe4P4LTTpdiMAn6zJ5OuHeLB88/c/XB4xyZysldFISD6YsqPVvxWvsf
Pg/vyw1zeoA0PybqtQ3dtR2cOBc5qzTWn9D5QNSJu8BzAysYW9qWggH/v1kJ2t7P
z0mbYbpgNDrOJ33/qLcK
=JrG4
-----END PGP SIGNATURE-----

--FjufNRXqxC01lbO9piCHucV7bumJKUlGe--

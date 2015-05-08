From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Raw CAN socket support in LXC?
Date: Fri, 8 May 2015 14:31:41 +0200
Message-ID: <554CACAD.9070604@pengutronix.de>
References: <554C6FDE.6080706@actia.se> <554C73C8.5070705@pengutronix.de>
 <554C7790.1000302@actia.se> <554C79D4.8000901@pengutronix.de>
 <554C9B67.1030201@actia.se> <554CA3FB.6070307@pengutronix.de>
 <554CAAF1.3040707@actia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eQLjFrLkg1aW51rRUBtOa8qs39MDtRfGT"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35656 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbEHMbu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 May 2015 08:31:50 -0400
in-reply-to: <554CAAF1.3040707@actia.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Adam_Engstr=c3=b6m?= <adam.engstrom@actia.se>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eQLjFrLkg1aW51rRUBtOa8qs39MDtRfGT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2015 02:24 PM, John Ernberg wrote:
> I first tried to figure out what kind of settings that would be the mos=
t=20
> appropriate to tinker with, but I could not find anything more relevant=
=20
> so I copied the ethernet example in the end.
> I will dig into the LXC code and see what can be done in terms of=20
> getting the CAN network interfaces through.

It probably sets up an etherner bridge and some kind of virtual ethernet
device between the container and the host.

Can you start a container with a working ethernet setup and post the
output of:

    brctl show

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eQLjFrLkg1aW51rRUBtOa8qs39MDtRfGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVTKywAAoJECte4hHFiupUxy4P/AoizAEjCXd+2fsy794ALZs+
Oq7+k2TV1lLk4ddfuC8CKG8hT+8YECLfyOiVmscbvRlZ8hVDddYFnZ6XyORsKDzO
fvr+gK+tTz5jw3zcYKJAKmG886bJjNiVHZ+OrbHTZUpqC73ETpFU6YxrUo/51jx4
8TZBRLkhQzKkqwg9Z1TZ+LcQf1q5+vWLX16gPXBcgNhR4nepmNmoHvOKE1zOVU/n
roSPFCMTVZwwPWwDe8mZSOhhFb4nHRlG6q1tAtnFoO+AveJ81Kw4pPh8g9djk5LT
tgbjMP6l8By8u99Kd3J+Quk88C4fWkPwncPVTaJ1KoFCc4WBvTL/Mk792DDbcHsb
KVEBa0STSUYHyie3MfDC18xi+iU5sXbYf63KErxmwbJotwNYVE5ANqmwTKDidKI6
F2yibYv4LHADxa+VI87TlVxNGQNyxIh8O9Tc0BR8TLcU2MIifr56deTllg+lLDrT
t/jgq5zjMOu6DOy4DNheeNB+8KmboJULo+OP9fcLx3pMrYGcXoVs96QeXvYK8egV
AiJR3cFZ/amYAKCtTc7mJTPbvw5Euh4Ik4lup8RJ/yGv1iV9TUkyIK9lP3QYi3ol
VdIR9xFo9J62Fcrjszbjm332RhB/KLaR4JweCQhU/TD/fQ8ZPwwaFKjXvi4+QyMd
J2iZOsSww97Ebn7En6qL
=KVJQ
-----END PGP SIGNATURE-----

--eQLjFrLkg1aW51rRUBtOa8qs39MDtRfGT--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
Date: Wed, 14 Feb 2018 22:20:55 +0100
Message-ID: <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HJgDbZ9nmWLlm3pNEzB4JtJQcOPlKOwYe"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44727 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVVo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 14 Feb 2018 16:21:44 -0500
In-Reply-To: <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, o.rempel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HJgDbZ9nmWLlm3pNEzB4JtJQcOPlKOwYe
Content-Type: multipart/mixed; boundary="IMb1wwEfK6HyrouuVeOPd8h5ROkIMoQTt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Elenita Hinds <ecathinds@gmail.com>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be,
 o.rempel@pengutronix.de
Message-ID: <829cca5a-626a-a53e-a448-99a0d7e021f5@pengutronix.de>
Subject: Re: [PATCH] j1939: Fix to softirq tasklet race condition when session
 is destroyed
References: <CAHChkrvWdUN6KYg9fbnfA2Mg3ie=PNOPuaSvEwqOzj7uG8xJ3A@mail.gmail.com>
 <6674d322-c632-d1de-793e-694e51b706fc@pengutronix.de>
 <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>
In-Reply-To: <CAHChkrs7_=t5Dgz4b19BSO1sFxAzG0cqsJRiJFMfPVbUe8Zbuw@mail.gmail.com>

--IMb1wwEfK6HyrouuVeOPd8h5ROkIMoQTt
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 02/14/2018 10:20 PM, Elenita Hinds wrote:
> Thanks, Kurt and Oliver, for the feedback. The newest bcm changes look =
better.
>=20
> Marc:  I'm sorry ... forgot to sign the patch. Hope re-attaching below =
is ok:

Sure.

> Signed-off-by: Elenita Hinds <ecathinds@gmail.com>

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IMb1wwEfK6HyrouuVeOPd8h5ROkIMoQTt--

--HJgDbZ9nmWLlm3pNEzB4JtJQcOPlKOwYe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlqEqDcACgkQk9IU1zQo
ZfF9Rwf/Q+2ItZGep7HOgAIARazgGv+wOrwtkvVyOAMrk7QqzvFx2jxx/VFmV+Xd
mNGFgBZd+cbPku50B4Za2/I5csYkydn+cljaDepQoKB0dDq5R1hGKPLrI/Ry9DFG
GJeoooXemZzFFj07jt+C/7AlzUzsQDH6RO2YXGLaTpmmaM90YBuOlND/bd3MH1UG
NTOFo618n7fWsts80Qj7oL5zjZ+gJN9ZrSBN+NsnNisqxHPSanGTf94GipWXAA0o
1afeJgZ4XZZtjqlOLBIaIt/E+SiDEQuEtuX3rA0d5++8UPDFvaXqYUVBq1/RS6SX
RJuYeMB7N0I7vxwD+Hw9T4JXJYIrag==
=LwJ2
-----END PGP SIGNATURE-----

--HJgDbZ9nmWLlm3pNEzB4JtJQcOPlKOwYe--

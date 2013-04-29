From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] Socketcan and LinCAN benchmarks
Date: Mon, 29 Apr 2013 12:39:12 +0200
Message-ID: <517E4DD0.7030606@pengutronix.de>
References: <200909021218.42692.sojkam1@fel.cvut.cz> <4A9E9F46.2030207@hartkopp.net> <35346264.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NKHWLQVOEREPSGDWUHDP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33074 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab3D2KjS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 06:39:18 -0400
In-Reply-To: <35346264.post@talk.nabble.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedareswara rao <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NKHWLQVOEREPSGDWUHDP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello kedareswara rao,

On 04/29/2013 12:13 PM, kedareswara rao wrote:
> I am new to can i wrote a socketcan driver for my hardware .But still i=

> didn't clearly understand the flow from userspace to kernel space and f=
orm
> there to hardware please explain me the flow.Waiting for ur response.my=
 mail
> id is:kedare06@gmail.com

I've written a paper about the basics of socketcan:

http://www.can-cia.org/fileadmin/cia/files/icc/13/kleine-budde.pdf

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NKHWLQVOEREPSGDWUHDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF+TdEACgkQjTAFq1RaXHMJqwCfXL4+He/s/HaJ9PWz15sgqUzU
8qoAoJROLJ2C2heULmc9Pze6sY/so+Jy
=mKoP
-----END PGP SIGNATURE-----

------enig2NKHWLQVOEREPSGDWUHDP--

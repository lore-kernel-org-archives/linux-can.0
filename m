From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 11:36:14 +0200
Message-ID: <559E408E.3080700@pengutronix.de>
References: <559D35CA.2050402@uweschneider.de>
 <CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
 <559E3E3E.7080603@uweschneider.de>
 <CAOpc7mHREmGPhM7xK3DO_t=SdieBt9fpQ4MtyTgWiRQ6iErX+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wuSEm8jNPBD8TAc0Vd7app6Q1e1ugGMBv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbGIJgU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 05:36:20 -0400
In-Reply-To: <CAOpc7mHREmGPhM7xK3DO_t=SdieBt9fpQ4MtyTgWiRQ6iErX+Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wuSEm8jNPBD8TAc0Vd7app6Q1e1ugGMBv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/09/2015 11:32 AM, Holger Schurig wrote:
> Thorsten,
>=20
> after pondering a bit on this I'd just say give up.
>=20
> The FlexCAN driver is in a state of limbo. For many months
> occassionally people submit some path, but nothing really changes,
> only minor things get accepted and applied to the kernel. I see two
> reasons:
>=20
> * some people have the picture of a "one big patch series that saves
> the world" view. But this one is complex, and so it never
> materialized. For example my KFIFO patch was not dismissed because of
> technical reasons, but because this big patch will eventually come.
> Marc said "I'll look into it at the end of the week", but that was
> optimistic

Sorry - I'm not full time paid to work on linux-can. But there soon will
be another end-of-the-week to look at the code.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--wuSEm8jNPBD8TAc0Vd7app6Q1e1ugGMBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVnkCOAAoJEP5prqPJtc/H/CYIAKu2IhX5RAqiCy5GI7sy3Zun
VLZNWpvtidAjMeo+yP/klxENuM8l1BUh+QE9wPOINU1duU0Hi1/cjqjtIyxCFQoR
0qp/83rEcu9o5c7JedMqjZlPSQ5nNZz/mvH15ot9HMxKKHrDZZsTbQd1PEFnoGqC
j/zLkJfyXeNreutEQ9azDnnyn+ZYvhYyQ9lw2M8cdV/CCQ3fCDzibbJAZ22n8Ns7
db8VdU4GWWAH2hHAUTwxn/PU/VZWLtGZ9WA7Or9lGsOL6k32b7GoLlUywJrnIFHz
q0EDuE4D6Kgtj/O3FE1BGn+2xq/9K/H8j+iWnTbBwlYYNV7CwnIQPCg/gY2T8CM=
=hddn
-----END PGP SIGNATURE-----

--wuSEm8jNPBD8TAc0Vd7app6Q1e1ugGMBv--

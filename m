From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: c_can: wrong frame order reception
Date: Wed, 21 Oct 2015 16:33:41 +0200
Message-ID: <5627A245.50401@pengutronix.de>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein>
 <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein>
 <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com>
 <loom.20151021T111146-165@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eG2UcATsqjcSFVGWjT93sUOHsQ0EXNn3g"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58276 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbbJUOdt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2015 10:33:49 -0400
In-Reply-To: <loom.20151021T111146-165@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wouter van herpen <wouter.van.herpen@prodrive-technologies.com>, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eG2UcATsqjcSFVGWjT93sUOHsQ0EXNn3g
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/21/2015 11:19 AM, wouter van herpen wrote:
> I am currently working on the Intel atom platform with EG20T.
>=20
> Using the c_can driver from the main line 4.1.10 kernel sources, I stil=
l see
> frames received in a swapped order.
>=20
> It looks like all the patches mentioned in the list above are already
> applied in this main line c_can driver.
>=20
> Is the frame order swapping still a known issue? Are there any addition=
al
> patches regarding this issue that I'm not aware off?

Maybe Oliver can help. What's needed on a v4.1.10 SMP system to fix the
RX order?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--eG2UcATsqjcSFVGWjT93sUOHsQ0EXNn3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBCgAGBQJWJ6JFAAoJEP5prqPJtc/HdEUH+O/V9bi2PGUvTkaJbtu6h8qJ
lb/Zs+R2BdpgcFK5U0DAV6ieoHRNaH9StIr1KT3WEQj7sSzVbZSaI6JMGYi2s1l8
GCmeqVo8Lu/JvzRmo4WOKgY+ve+U8aZvQcZvH8OkBXP4QFhPgw+FQU4GJKWvuT/a
0BjNF4yLPuiqB63A2Ibni13/G/twuEbOVNyRUG1aXF/pxCcuFKwlCMamPKkbZ+SJ
Z8iZNQQ+Rkwcx6lYcSO4FGOvwSxiOFLuPtEKMBFssZT+hAh63FycB0l7My1kWigj
zC05LrL5aGntmuAs96TU/T7q4ISJx/moim/t25UiWN1TnYZBulgl610l0mKvxg==
=p3id
-----END PGP SIGNATURE-----

--eG2UcATsqjcSFVGWjT93sUOHsQ0EXNn3g--

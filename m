From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: c_can: wrong frame order reception
Date: Wed, 21 Oct 2015 16:12:06 +0200
Message-ID: <56279D36.7000107@pengutronix.de>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein>
 <533B067A.3030609@hartkopp.net> <1451869.V7QBi99RiY@ws-stein>
 <cdaa71c3255e192a2dea2e4f3f26e49a@grandegger.com>
 <loom.20151021T111146-165@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ow0fn3qRDKBb0gnQ3QLSHGmIxR2qbTrAp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50724 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbJUOMO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2015 10:12:14 -0400
In-Reply-To: <loom.20151021T111146-165@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wouter van herpen <wouter.van.herpen@prodrive-technologies.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ow0fn3qRDKBb0gnQ3QLSHGmIxR2qbTrAp
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

Are you on an SMP system?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ow0fn3qRDKBb0gnQ3QLSHGmIxR2qbTrAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWJ502AAoJEP5prqPJtc/H5QYH/AvAW2FStMJKNSttrS/tOyKn
an7MUpwuMnI3E8aaDZ050UIEfw2Z/sh1oUd6X5eITn3McZAjYtTwS2MHsVHK3H3Q
ggq3z6DEjqEKWBJqBfndP/xQyZhx9EsPA1HHgX/PRKAr8fW8mWoFoNbHhA8fYXfH
JwJBpx7TgE3MRCUoK+eW8iEWwjzqs5En2GU8HImZk2GoAxjVipCNESCXpdVCNllw
28YeS1dwQIYLgf3ccYtKHaN3Hb9pswvLl5P+opib4hIGvhelVyCqrUK8qgul9dSA
eoB/rrf2Qhxu8UlFu7ft4saSojpS8Kk3+ZKC44oHvqadqmqGjXbvB29wGeLEqdg=
=Zfs2
-----END PGP SIGNATURE-----

--ow0fn3qRDKBb0gnQ3QLSHGmIxR2qbTrAp--

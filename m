From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-j1939: fix ecu allocation at bad time
Date: Thu, 9 Mar 2017 11:23:41 +0100
Message-ID: <d883b9e9-dc7e-7d54-d66a-2bcc47eac9b0@pengutronix.de>
References: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0rklTBkV64WtG17SqKlxOPnNGLAWC6bXU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33089 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754137AbdCIKYJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 05:24:09 -0500
In-Reply-To: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0rklTBkV64WtG17SqKlxOPnNGLAWC6bXU
Content-Type: multipart/mixed; boundary="edrlVAillPJnR0s32k7KjpFIR461MsTGo";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Maxime Jayat <maxime.jayat@mobile-devices.fr>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: linux-can@vger.kernel.org
Message-ID: <d883b9e9-dc7e-7d54-d66a-2bcc47eac9b0@pengutronix.de>
Subject: Re: [PATCH] can-j1939: fix ecu allocation at bad time
References: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>
In-Reply-To: <20170309093304.31542-1-maxime.jayat@mobile-devices.fr>

--edrlVAillPJnR0s32k7KjpFIR461MsTGo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2017 10:33 AM, Maxime Jayat wrote:
> In _j1939_ecu_get_register, create_if_necessary was ignored, which
> lead to memory corruption (because of a bad refcount) when rebinding a
> socket to a NAME corresponding to an ecu which had been unregistered
> by an external address claim.
>=20
> During the bind, in j1939_name_local_put, the ecu was reallocated, adde=
d
> to the list of ecus and then freed immediately. So the list contained a=
n
> invalid item.
>=20
> For instance, this created the problem:
>=20
> - Bind a J1939 socket to source address 0x80 with name
>     0x7777777777777777
> - Send an address claim for this source address
> - Another "external" ECU sends an address claim for 0x80 with name
>     0x1111111111111111 (which has higher priority, so "wins" the source=

>     address).
> - Re-bind the J1939 socket to source address 0x81.
>=20
> Signed-off-by: Maxime Jayat <maxime.jayat@mobile-devices.fr>

Added to linux-can-next/j1939.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--edrlVAillPJnR0s32k7KjpFIR461MsTGo--

--0rklTBkV64WtG17SqKlxOPnNGLAWC6bXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljBLS0ACgkQHv7KIOw4
HPYvOQf/STW8JmwwYcHqWLoOF02KL2z5aDealf0UQG9INu1CwJRi60fsRpjWS+rj
UbMJZXMF0CqNWgkjH/vmj4M34XWto74bF3e0DBnYTqPGTA1Y6scShYw94SSqg8yS
ccxha3XaOU6nrAY/nRoolxYT8j46OaT0lmXwGI3wIdNBV6clFVEZbsQD7lprXtUJ
24qZKkhm00fRg8TiTZ4p7+iyH0zY0j8P5DILufzLch0e/jsH65v01ghcAZjQVd+n
2iw0MjYs9rTO2CtWR5Q1aFApY+wmv4CQT636RsSiiYCHL743siYySaHtLiq5rGkD
euHtKJJ/hPz4Y3JxDOe5Yx3GxnDZeQ==
=FvY8
-----END PGP SIGNATURE-----

--0rklTBkV64WtG17SqKlxOPnNGLAWC6bXU--

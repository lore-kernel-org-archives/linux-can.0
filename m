From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak/pcie_fd: fix potential bug in restarting tx
 queue
Date: Fri, 8 Dec 2017 10:46:51 +0100
Message-ID: <1dd39f4b-ec8f-bb0f-de30-80f633afefcb@pengutronix.de>
References: <20171207151343.26923-1-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ws24rIvHV5sEbnhBqbUPn4m4dl5WnRnws"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52885 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753878AbdLHJrA (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 8 Dec 2017 04:47:00 -0500
In-Reply-To: <20171207151343.26923-1-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ws24rIvHV5sEbnhBqbUPn4m4dl5WnRnws
Content-Type: multipart/mixed; boundary="sstJUmxnmUNFfrRV899QOOj2b52FEdhaq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <1dd39f4b-ec8f-bb0f-de30-80f633afefcb@pengutronix.de>
Subject: Re: [PATCH] can: peak/pcie_fd: fix potential bug in restarting tx
 queue
References: <20171207151343.26923-1-s.grosjean@peak-system.com>
In-Reply-To: <20171207151343.26923-1-s.grosjean@peak-system.com>

--sstJUmxnmUNFfrRV899QOOj2b52FEdhaq
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 04:13 PM, Stephane Grosjean wrote:
> Don't rely on can_get_echo_skb() return value to wake the network tx
> queue up: can_get_echo_skb() returns 0 if the echo array slot was not
> occupied, but also when the DLC of the released echo frame was 0.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sstJUmxnmUNFfrRV899QOOj2b52FEdhaq--

--Ws24rIvHV5sEbnhBqbUPn4m4dl5WnRnws
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloqX4sACgkQHv7KIOw4
HPZ4qgf/ddDeO3DOU+qJwXcm1Q5OGXEPpKyc4upiK/gY7D//cdFbKvW/BuBMaSrD
XgPfOeaWBJX+whY5gsIZLh/D0za6V0tr2yutr/WIm4lU/xhIlPwLulFdJ/RROOUC
cR3fM3xSKXfh/F+6Z9jL/cmFp89mexFqkim2selx/FyjZXW0ppxcKv7xkMQ47IjO
5AEkR83907T93bGJBB3IeUKTBiOelUP+Fg6MlxeG0yYEzWkVYrgWA65DIFMns0nF
e/BT1qi0wGnnwXm06G1eRkMGeRT8+egAniWX1vJ+Sln8kiw2Z3ATBFLXc3PC7PPo
eJ9IvDrABQukCh1PHTvWui4FtJ9djQ==
=plno
-----END PGP SIGNATURE-----

--Ws24rIvHV5sEbnhBqbUPn4m4dl5WnRnws--

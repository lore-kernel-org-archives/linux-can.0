From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
Date: Mon, 13 Mar 2017 15:23:05 +0100
Message-ID: <cf48efa1-c332-bdb6-6dcc-87a08949fbec@pengutronix.de>
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
 <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
 <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
 <3ce9a121-ec02-c671-b2b7-0b259238da82@lipowsky.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7cKJxmJ1dFu2QcFImTVRmk932LeFtCLgO"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58175 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752004AbdCMOXN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Mar 2017 10:23:13 -0400
In-Reply-To: <3ce9a121-ec02-c671-b2b7-0b259238da82@lipowsky.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Efim Monjak <emonjak@lipowsky.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7cKJxmJ1dFu2QcFImTVRmk932LeFtCLgO
Content-Type: multipart/mixed; boundary="w61TIDVMPktowELx2VMkfOmbWjD4sBnru";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Efim Monjak <emonjak@lipowsky.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <cf48efa1-c332-bdb6-6dcc-87a08949fbec@pengutronix.de>
Subject: Re: at91 driver lost CAN messages
References: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
 <ee9c0d9d-6cd6-f93b-2f2b-8306777781c3@hartkopp.net>
 <1cfeef11-69e0-53c1-f95a-0340cce5803e@pengutronix.de>
 <5e786553-271f-6fdc-3bd9-2422f93757f5@lipowsky.de>
 <1b40816e-7102-739a-4738-30547d68b523@pengutronix.de>
 <3ce9a121-ec02-c671-b2b7-0b259238da82@lipowsky.de>
In-Reply-To: <3ce9a121-ec02-c671-b2b7-0b259238da82@lipowsky.de>

--w61TIDVMPktowELx2VMkfOmbWjD4sBnru
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 04:17 PM, Efim Monjak wrote:
> I am using Kernel 4.4.27. By getsocketopt() it is possible to get=20
> maximum receive buffer size in bytes.

Yes, that limits the memory that's used for skbs, not only the CAN frames=
=2E

> if (getsockopt(sock, SOL_SOCKET, SO_RCVBUF, (void*)&n, &m) =3D=3D 0)   =
  =20
> fprintf(stderr, "\nCAN Rx Bufsize %u bytes", n);
>=20
> As I understand as long as no CAN frame is read from socket by user=20
> application all received CAN frames will be stored into this buffer by =

> CAN driver.

Not directly by the CAN driver, but by the networking stack.

> If more CAN frames are received as receive buffer able to
> contain a buffer overflow occurs and CAN frames goes lost.

Yes, on this socket the CAN frames are lost.

> For test proposes the application opened  a socket and was stopped by d=
ebugger
> after it. The result of getsockopt() was a bit more as 163000 bytes.=20
> After it CAN frames was sent for about 1..2 min. It is enough time to=20
> get receive buffer overflow. Now sending of CAN frames was stopped and =

> the application have read all CAN frames stored in the socket and=20
> counted them. It was 320. For test I have set size of receive buffer to=
=20
> value was read from socket (about 163000). After it number of received =

> CAN frames was 640.
> I think skbs are stored into receive buffer/queue.

yes

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--w61TIDVMPktowELx2VMkfOmbWjD4sBnru--

--7cKJxmJ1dFu2QcFImTVRmk932LeFtCLgO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljGq0kACgkQHv7KIOw4
HPZwPQf/aD6TAv5TzJ52ZG64aOyUOwfPyUIuPoKEIn0zDwp9/CT1rdgMcZhhPrmn
yeBV9KIwvB0jDuKJWIJ+zv16iy2ek7Psc0gOMJIV7YG9CqAEUhYkqcKcdMMnwvMo
xM8+Ae0q+Ihm8dASnVQOJvdYcqPiTagzk0fS9gVxiXkEYjBSHuZpi0WH6eGiEfKa
eyqkIc89XAJwnTYn9md8CnjTYk3+58uwmz4e0nq/ck4ewJmCHxaFP0qf1UjRTLyb
fwUiMq7abUESTSMvb+iGFDNi81B+xLzhe1ce9J5pGvrmATgR+Z5HFBqpiZe5w/LY
TOO2nF6JKRaOxzQRgKGLo3QdqxalVg==
=j5PC
-----END PGP SIGNATURE-----

--7cKJxmJ1dFu2QcFImTVRmk932LeFtCLgO--

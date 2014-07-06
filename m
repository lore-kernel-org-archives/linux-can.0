From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: skbuff panic
Date: Sun, 06 Jul 2014 21:38:21 +0200
Message-ID: <53B9A5AD.8050403@pengutronix.de>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com> <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com> <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com> <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ef7qDvVFf5eun0pA1prABC8XNd4wB3QVb"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35875 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbaGFTid (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 Jul 2014 15:38:33 -0400
In-Reply-To: <53B97598.50400@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Austin Schuh <austin@peloton-tech.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ef7qDvVFf5eun0pA1prABC8XNd4wB3QVb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/06/2014 06:13 PM, Oliver Hartkopp wrote:
> Answering myself:
>=20
> I tested the latest 3.16.0-rc3-00149-g034a0f6 with tst-packet.c and it =
works
> like charm. Receiving and sending with tst-packet is no problem.
> I was using the SJA1000 based EMS PCMCIA card in my laptop for this tes=
t.
>=20
> So I really wonder why (obviously) a CAN frame is processed by the PF_P=
ACKET
> reception handler at the start of your system?!?

What about a dhcp client or the kernel's autoip functionality?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ef7qDvVFf5eun0pA1prABC8XNd4wB3QVb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO5pa0ACgkQjTAFq1RaXHO/yACfcLPKLu/bSJFCXl9cXw3DtMfR
nK8AnAu0R0BGhPDryA3lvfAmYEJqRqAQ
=5XEK
-----END PGP SIGNATURE-----

--ef7qDvVFf5eun0pA1prABC8XNd4wB3QVb--

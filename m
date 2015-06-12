From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN question: how to trace frame errors?
Date: Fri, 12 Jun 2015 11:34:54 +0200
Message-ID: <557AA7BE.6040004@pengutronix.de>
References: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mOCqKT45qWsriKU4VKoCexJIkwv2JoNvv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54508 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbFLJfB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Jun 2015 05:35:01 -0400
In-Reply-To: <CAOpc7mFv6ePXqkCZxRkCOC+BuY-PC14nAopZyFpEKHvj5gN_tw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mOCqKT45qWsriKU4VKoCexJIkwv2JoNvv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/12/2015 11:29 AM, Holger Schurig wrote:
> Hi people,
>=20
> I have two i.MX6 based boards with built-in FLEXCAN. On both boards I
> loaded can_raw.
>=20
> When I now run "cangen can0 -g 0 -x" one one board, I get frame errors
> on the others (no matter if I run candump on the receiving side).
>=20
>=20
> root@left:~# ifconfig can0; ip -s link show can0
> can0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>           UP RUNNING NOARP  MTU:16  Metric:1
>           RX packets:20249437 errors:6 dropped:0 overruns:0 frame:6
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10
>           RX bytes:116445504 (111.0 MiB)  TX bytes:0 (0.0 B)
>           Interrupt:142
>=20
> 3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
> UNKNOWN mode DEFAULT group default qlen 10
>     link/can
>     RX: bytes  packets  errors  dropped overrun mcast
>     116445504  20249437 6       0       6       0

These are probably RX-FIFO overrun errors:

>         /* FIFO overflow */                                            =
         =20
>         if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {             =
         =20
>                 flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->if=
lag1);   =20
>                 dev->stats.rx_over_errors++;                           =
         =20
>                 dev->stats.rx_errors++;                                =
         =20
>         }                                                              =
         =20

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--mOCqKT45qWsriKU4VKoCexJIkwv2JoNvv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVeqe+AAoJEP5prqPJtc/HP1wH/j+mwZeDsJEZSjrQjUKSCzSp
LCtrWzEo+dtQZWgVQTlKXvpkSlXBkGpZNaqb7j1sI3lHA2WwyW3jxAhG1Bh9hSLd
rf8ZG4dnXWb4AvJeG7hn3hUz95RG4J7SN718cjW2jBTO5rJ8bZ+BZbT37U/es1Ju
cARiLWrNmUEs0CmEn7c2oybeG7ufHL2ygRwPw1YE7S1gItsbDkxdsHzoywfaIHbn
J87RQEHyEPNwoB6vOemcOTgZVtcv0fgskFvampB1LDxv6Nh445dWXdpMBTx2XmSY
rRj0eRaDyccTpoZ8XGLJFeO2/bIWmTeyCdHVGUDZZbqaCx6FhEg3Jg2e3302IDA=
=jndi
-----END PGP SIGNATURE-----

--mOCqKT45qWsriKU4VKoCexJIkwv2JoNvv--

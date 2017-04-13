From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
Date: Thu, 13 Apr 2017 16:46:35 +0200
Message-ID: <f6351940-757a-a44b-fa74-9131e665c8d7@pengutronix.de>
References: <1484839867-2050-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MUcXH7w14l4UQkTHwA0uAVhGC1h7lrkII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48029 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751139AbdDMVcb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 13 Apr 2017 17:32:31 -0400
In-Reply-To: <1484839867-2050-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MUcXH7w14l4UQkTHwA0uAVhGC1h7lrkII
Content-Type: multipart/mixed; boundary="OdW97nGliF4gnaNhMrt7uKisogbKwShjf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <f6351940-757a-a44b-fa74-9131e665c8d7@pengutronix.de>
Subject: Re: [PATCH v4 0/4] can: peak: Add support for PCAN-PCIe FD cards
References: <1484839867-2050-1-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1484839867-2050-1-git-send-email-s.grosjean@peak-system.com>

--OdW97nGliF4gnaNhMrt7uKisogbKwShjf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 04:31 PM, Stephane Grosjean wrote:
> These patches add the support for the PCAN-PCI Express FD cards made by=

> PEAK-System. Since these new cards run the same CAN-FD IP than the USB
> CAN-FD interfaces, some common definitions are moved into a (newly crea=
ted)
> common header file, under include/linux/can/dev.
>=20
> Stephane Grosjean (4):
>   can: peak: fix usage of usb specific data type
>   can: peak: fix usage of const qualifier in pointers args
>   can: peak: move header file to new can common subdir
>   can: peak: add support for PEAK PCAN-PCIe FD CAN-FD boards
>=20
>  drivers/net/can/Kconfig                       |   1 +
>  drivers/net/can/Makefile                      |   1 +
>  drivers/net/can/peak_canfd/Kconfig            |  13 +
>  drivers/net/can/peak_canfd/Makefile           |   5 +
>  drivers/net/can/peak_canfd/peak_canfd.c       | 801 ++++++++++++++++++=
++++++
>  drivers/net/can/peak_canfd/peak_canfd_user.h  |  55 ++
>  drivers/net/can/peak_canfd/peak_pciefd_main.c | 842 ++++++++++++++++++=
++++++++
>  drivers/net/can/usb/peak_usb/pcan_ucan.h      | 244 --------
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c    |  25 +-
>  include/linux/can/dev/peak_canfd.h            | 308 ++++++++++
>  10 files changed, 2039 insertions(+), 256 deletions(-)
>  create mode 100644 drivers/net/can/peak_canfd/Kconfig
>  create mode 100644 drivers/net/can/peak_canfd/Makefile
>  create mode 100644 drivers/net/can/peak_canfd/peak_canfd.c
>  create mode 100644 drivers/net/can/peak_canfd/peak_canfd_user.h
>  create mode 100644 drivers/net/can/peak_canfd/peak_pciefd_main.c
>  delete mode 100644 drivers/net/can/usb/peak_usb/pcan_ucan.h
>  create mode 100644 include/linux/can/dev/peak_canfd.h

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OdW97nGliF4gnaNhMrt7uKisogbKwShjf--

--MUcXH7w14l4UQkTHwA0uAVhGC1h7lrkII
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljvj0sACgkQHv7KIOw4
HPZ8PQf/Ws3el+Fcb46ovfLtxfWSObojL8rAX2uBUbVgy6ZA0vAsVF6LaNV7zxC5
bQBt62Cb1JcYZcvW5NK7sorO6q/2uxL/Uw3mVnhPbSCVwFGSIj04e7eQLN6utwM9
othpaIA6Z7V9mvNJHfHZ5h1lyRWYxzyFIgK92YnZ6yI7+GLUmhTsWlfDkS9+He0T
Vh3jrD6JyEYfXRZIKRZrmqNsrpbeyfKh8XliTqTlU8thS81CCELouZsxtrkYy9Iw
HMbM4T1yTIRejW8Sg8fU2eXUCI5HYtH/k0hkKo/Sz8/NnYKpnhXLCaCRIcaBWa1I
46eInv+DD+kz5HseXpChSIftrKl0cQ==
=lkK5
-----END PGP SIGNATURE-----

--MUcXH7w14l4UQkTHwA0uAVhGC1h7lrkII--

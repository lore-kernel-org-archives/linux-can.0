From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC 0/6] pch_can/c_can: fix races and add PCH support to c_can
Date: Mon, 26 Nov 2012 09:47:40 +0100
Message-ID: <50B32CAC.4050501@pengutronix.de>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7A1BCB04C6BDC18FAC89B5B2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48384 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab2KZIrt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:47:49 -0500
In-Reply-To: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7A1BCB04C6BDC18FAC89B5B2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/26/2012 09:23 AM, Wolfgang Grandegger wrote:
> Hello,
>=20
> as you might have already realized, Michael has reported problems with
> the PCH_CAN driver. With his help we try to fix these issues and add
> PCH PCI support to the C_CAN driver replacing the PCH_CAN driver sooner=

> than later. Here follows my current patch stack for the records. When
> Michael's tests are successful, I'm going to post final patches.
>=20
> For Michael I have prepared out-of-tree driver sources allowing to
> easily build the drivers also for older 3.x kernel versions. More
> tester are welcome.
>=20
> As also pointed out by Casper, the problems are obvisouly due to races
> with stop and wakeup of the netif tx queue, managing tx_next and
> concurrent register accesses. For the moment I have fixed the races by
> adding "spin[un]lock_irqsave/restore" but, thinking more about it,
> "spinlock_bh" should be enough to protect against softirq context.
>=20
> With the C_CAN driver I realized some other minor issues:
>=20
> - The C/D_CAN type handling is common code and could go to
>   alloc_c_can_dev() or register_c_can_dev().
>=20
> Comments are welcome.

Please make the patches based on linux-can-next/for-davem

Marc
>=20
> Wolfgang.
>=20
> Wolfgang Grandegger (6):
>   pch_can: add spinlock to protect tx objects
>   c_can: add spinlock to protect tx and rx objects
>   c_can: add optional reset callback
>   c_can_pci: introduce board specific PCI bar
>   c_can_pci: enable PCI bus master only for MSI
>   c_can_pci: add support for PCH CAN on Intel EG20T PCH
>=20
>  drivers/net/can/c_can/c_can.c     |   24 ++++++++++++++++-
>  drivers/net/can/c_can/c_can.h     |    2 ++
>  drivers/net/can/c_can/c_can_pci.c |   54 +++++++++++++++++++++++++++++=
+++++---
>  drivers/net/can/pch_can.c         |   11 ++++++++
>  4 files changed, 87 insertions(+), 4 deletions(-)
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig7A1BCB04C6BDC18FAC89B5B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCzLLAACgkQjTAFq1RaXHOnBgCcDYHj9z9newJtSoJ+sMrFQsaE
TaMAn2e4JcP07Rdn98ao5OZp4Gz09j02
=fTfn
-----END PGP SIGNATURE-----

--------------enig7A1BCB04C6BDC18FAC89B5B2--

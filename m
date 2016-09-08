From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: sja1000: Optimise register accesses
Date: Thu, 8 Sep 2016 14:07:45 +0200
Message-ID: <dced7a99-ade8-caf5-22e7-49be91577fbd@pengutronix.de>
References: <20160908080613.3997-1-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pIfxbt9TSLPjiK4ejGKm9JhF45fKs83vM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35817 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964861AbcIHMHv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2016 08:07:51 -0400
In-Reply-To: <20160908080613.3997-1-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pIfxbt9TSLPjiK4ejGKm9JhF45fKs83vM
Content-Type: multipart/mixed; boundary="1HHaRL6aGV7XrdMiWn3sRgMmO4OX5K71X"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org
Message-ID: <dced7a99-ade8-caf5-22e7-49be91577fbd@pengutronix.de>
Subject: Re: [PATCH v3] can: sja1000: Optimise register accesses
References: <20160908080613.3997-1-nebaruzdin@gmail.com>
In-Reply-To: <20160908080613.3997-1-nebaruzdin@gmail.com>

--1HHaRL6aGV7XrdMiWn3sRgMmO4OX5K71X
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/08/2016 10:06 AM, Nikita Edward Baruzdin wrote:
> Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
> instead of consecutive ioread8()/iowrite8() calls seems reasonable.
>=20
> Thus, this patch introduces [read|write]_reg_rep() interface functions
> that are used to read/write CAN ID and payload data.
>=20
>   * For plx_pci driver this interface is implemented as
>     plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
>     register accesses as much as possible to improve driver performance=
=2E
>=20
>   * For other drivers the default implementation,
>     sja1000_[read|write]_reg_rep(), is used for now. These functions
>     still access registers in a series of ioread8()/iowrite8() calls.
>=20
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>

Please compile with C=3D2 and fix these warnings. You need to cast to
__XXYY if you want to use it in XXYY_to_cpu.

>   CHECK   /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja=
1000.c
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326=
:32: warning: incorrect type in assignment (different base types)
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326=
:32:    expected unsigned int [unsigned] [usertype] <noident>
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:326=
:32:    got restricted __be32 [usertype] <noident>
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331=
:32: warning: incorrect type in assignment (different base types)
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331=
:32:    expected unsigned short [unsigned] [short] [usertype] <noident>
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:331=
:32:    got restricted __be16 [usertype] <noident>
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:374=
:22: warning: cast to restricted __be32
> /srv/work/frogger/socketcan/linux/drivers/net/can/sja1000/sja1000.c:380=
:22: warning: cast to restricted __be16

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1HHaRL6aGV7XrdMiWn3sRgMmO4OX5K71X--

--pIfxbt9TSLPjiK4ejGKm9JhF45fKs83vM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJX0VSRAAoJED07qiWsqSVqwmMIALERRhYHjUwg44Z8Dt1v+NFK
Q9yrsPoW+LcWJ4SdzrIbuGzuR8vWR5wdTlCGFe3oINrwu1GWEh4XmWztuUCw5KO/
P2j5Zq5JJYvZh+l1f71hniEBLGqUhmCRzEi1ktQ1JGAtv4OREYsZ62WSwZbmnHbt
lzOAIFXJtBbc9WxxeMFo8urQt7OtPzf0ltpudPyl9Q+RbLLzDufjB/6wl2QDhsUl
hfWyrOZBN63lWj0e31hYcpUVaBDALDcD5Oi3PBS3i+NQ1ujAKxSRrTP/9kbsCchX
pdCwDDTeXXd7+/R5BxE4AqHR3yk5RnhBBC3UjixynWrdNhRHOGp3ORKLXXlW0es=
=AUkN
-----END PGP SIGNATURE-----

--pIfxbt9TSLPjiK4ejGKm9JhF45fKs83vM--

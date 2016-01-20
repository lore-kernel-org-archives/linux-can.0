From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Wed, 20 Jan 2016 15:11:20 +0100
Message-ID: <569F9588.2090809@pengutronix.de>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1qCRG9INqmLX4q8mD8985AabccsQmtC68"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37871 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933132AbcATOL2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2016 09:11:28 -0500
In-Reply-To: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1qCRG9INqmLX4q8mD8985AabccsQmtC68
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/20/2016 12:15 PM, Stephane Grosjean wrote:
> This patch installs a workaround when the driver detects one of the
> following PEAK-System CAN interfaces, running a firmware < v1.3.0:

Is the problem fixed on FW >=3D 1.3.0? Is it possible to update the
firmware? If so, what about printing a warning message about known
problem with the firmware?

> PCAN-PCI Express 1/2/4 CAN; DeviceID 0x0003
> PCAN-PCI/104 Express 1/2/4 CAN; DeviceID 0x0007
> PCAN-miniPCIe 1/2 CAN; DeviceID 0x0008
> PCAN-PCI Express OEM 1/2/4 CAN; DeviceID 0x0009
> PCAN-ExpressCard 34 1 CAN; DeviceID 0x000A
>=20
> This fixes potential loss of one tx frame in Linux SMP when some other
> task does another Command Register write (e.g. Release Receive Buffer)
> in between the triggering Tx Request and the next Sample Point.
>=20
> This workaround is useless thus *NOT* installed when the firmware
> has been upgraded to v1.3.0 or higher, nor if the CAN interface is equi=
pped
> with true SJA1000 controller(s).
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/peak_pci.c | 34 ++++++++++++++++++++++++++++++=
+++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja10=
00/peak_pci.c
> index 131026f..84f7d3a 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -30,6 +30,15 @@
> =20
>  #include "sja1000.h"
> =20
> +#define VERSION_REG1		0x40
> +#define VERSION_REG2		0x44
> +
> +#define VERSION_REG2_MASK	0xfff0

Nitpick:
Please add PCAN_ prefixes to the defines.

> +#define PCAN_PCI_FW(x, y, z)	((((u16 )(x) & 0xf) << 12) | \
> +				 (((u16 )(y) & 0xf) << 8)  | \
> +				 ((      (z) & 0xf) << 4))
> +#define PCAN_PCI_FW_VER(v)	((v) & VERSION_REG2_MASK)
> +
>  MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
>  MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards")=
;
>  MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");=

> @@ -540,6 +549,19 @@ static void peak_pci_write_reg(const struct sja100=
0_priv *priv,
>  	writeb(val, priv->reg_base + (port << 2));
>  }

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1qCRG9INqmLX4q8mD8985AabccsQmtC68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWn5WJAAoJEP5prqPJtc/H4f4H/0RAzxYT7gEA083+171TZyW+
BBF/zOkEcRi0B9d3+wMD5MFVmvcJEiWQPBbOznxJ9k3xxT9J3FlNifkvnRZ0VHci
YeByWVO0L2zpdj1KJ2//QQWpdbUHAbYnV9Bqz4x1YgMhxzZnVKebO0dmhe/2GUNF
DGKGvqx3SDzjCfJC+juWcGiVoDeCczxINVBpXMOWuRr6xbrcQFLBpCiasQ8irRGW
SsFbaCmWH4xYSHjfTbZrOWFuZcdw9G9QcRjw0Xny1P6Dw/9pN7TuhxGvUpJqwYQa
/Z6CKEENfns+j8l1ycFkO0hvzOQ7agtcYbxOS6ls+hF3q4DMnPrUbh4zqpAXXyI=
=QYNO
-----END PGP SIGNATURE-----

--1qCRG9INqmLX4q8mD8985AabccsQmtC68--

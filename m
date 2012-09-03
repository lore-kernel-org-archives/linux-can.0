From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: mcp251x.c : patch to avoid repeated frame bug
Date: Mon, 03 Sep 2012 14:11:49 +0200
Message-ID: <50449E85.5060200@pengutronix.de>
References: <503B6FF5.6000800@pouic.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBB02FA4EA69FA64A0C0E2E7E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36695 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab2ICMMJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Sep 2012 08:12:09 -0400
In-Reply-To: <503B6FF5.6000800@pouic.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Benoit <benoit@pouic.eu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBB02FA4EA69FA64A0C0E2E7E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/27/2012 03:02 PM, Benoit wrote:
> Hello,
>=20
> The MCP2515 has a silicon bug causing repeated frame transmission, see
> section 5 of MCP2515 Rev. B Silicon Errata Revision G (March 2007).
>=20
> Basically, setting TXBnCTRL.TXREQ in either SPI mode (00 or 11) will
> eventually cause the bug. The workaround proposed by Microchip is to us=
e
> mode 00 and send an RTS command on the SPI bus to initiate the
> transmission. Accordingly, I have modified the transmission routine as
> follows in file mcp251x.c:

I've some questions about the code:

> --- drivers/net/can/mcp251x.c-original    2012-08-26 15:00:28.000000000=

> +0200
> +++ drivers/net/can/mcp251x.c    2012-08-26 20:42:58.000000000 +0200
> @@ -83,6 +83,10 @@
>  #define INSTRUCTION_LOAD_TXB(n)    (0x40 + 2 * (n))
>  #define INSTRUCTION_READ_RXB(n)    (((n) =3D=3D 0) ? 0x90 : 0x94)
>  #define INSTRUCTION_RESET    0xC0
> +#define    RTS_TXB0        0x01
> +#define    RTS_TXB1        0x02
> +#define    RTS_TXB2        0x04
          ^^^^
Please use a space between define and RTS_

> +#define INSTRUCTION_RTS(txb)    (0x80 | ((txb) & 0x07))
> =20
>  /* MPC251x registers */
>  #define CANSTAT          0x0e
> @@ -394,9 +398,20 @@
>      }
>  }
> =20
> +
> +/*
> + * CAN frame is now sent using instruction RTS over SPI to work around=

> + * repeated frame problem as per MCP2515 Rev B. Silicon Errata revisio=
n G
> + * (March 2007) about repeated frames (see section 5 of document).
> + * Note that repeated frames can still occur if using SPI mode 11. It
> seems
> + * however that spi mode is forcibly set to 0, so it looks safe.
> + *
> + */

I think we don't need this in the code it will go into the commit
message. A short note before the priv->spi_tx_buf[0] should be enough.

>  static void mcp251x_hw_tx(struct spi_device *spi, struct can_frame *fr=
ame,
>                int tx_buf_idx)
>  {
> +    struct mcp251x_priv *priv =3D dev_get_drvdata(&spi->dev);
> +    int ret;
>      u32 sid, eid, exide, rtr;
>      u8 buf[SPI_TRANSFER_BUF_LEN];
> =20
> @@ -418,7 +433,12 @@
>      buf[TXBDLC_OFF] =3D (rtr << DLC_RTR_SHIFT) | frame->can_dlc;
>      memcpy(buf + TXBDAT_OFF, frame->data, frame->can_dlc);
>      mcp251x_hw_tx_frame(spi, buf, frame->can_dlc, tx_buf_idx);
> -    mcp251x_write_reg(spi, TXBCTRL(tx_buf_idx), TXBCTRL_TXREQ);
> +
> +    priv->spi_tx_buf[0] =3D INSTRUCTION_RTS(1 << tx_buf_idx);
> +    ret =3D spi_write(spi, priv->spi_tx_buf, 1);

Why don't you use mcp251x_spi_trans() here?

> +    if (ret) {
> +        dev_err(&spi->dev, "RTS failed: ret =3D %d\n", ret);
> +    }
>  }
> =20
>  static void mcp251x_hw_rx_frame(struct spi_device *spi, u8 *buf,
>=20
>=20
>=20
> Would it be possible to integrate this patch into mainstream mcp251x.c?=

>=20
> Kind Regards,
>=20
> Beno=EEt

I'll send an updated version of your proposed patch.

regards, Marc
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBB02FA4EA69FA64A0C0E2E7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBEnogACgkQjTAFq1RaXHOp5ACeJ0sumSqIjlCGy2q18gdL2FDU
IB0AnA8YboD8gPtCECvZMbKa1uloGhEf
=nhAU
-----END PGP SIGNATURE-----

--------------enigBB02FA4EA69FA64A0C0E2E7E--

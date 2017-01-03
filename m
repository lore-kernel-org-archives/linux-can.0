From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Tue, 3 Jan 2017 15:54:04 +0100
Message-ID: <b4d5886f-5a1b-2f6c-0fae-0c310093d399@pengutronix.de>
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gkgWACiLRvEgoWT40cwJ4hcA6to0GqOwW"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33523 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758586AbdACOyo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Jan 2017 09:54:44 -0500
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gkgWACiLRvEgoWT40cwJ4hcA6to0GqOwW
Content-Type: multipart/mixed; boundary="qxK1DrQewe7FLlUdX5RSfwJq8ls1dfaGi";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <b4d5886f-5a1b-2f6c-0fae-0c310093d399@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>

--qxK1DrQewe7FLlUdX5RSfwJq8ls1dfaGi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/02/2017 01:34 PM, Stephane Grosjean wrote:
> This patch adds the support of the PCAN-PCI Express FD boards made
> by PEAK-System, for computers using the PCI Express slot.
>=20
> The PCAN-PCI Express FD has one or two CAN FD channels, depending
> on the model. A galvanic isolation of the CAN ports protects
> the electronics of the card and the respective computer against
> disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operate=
d
> with ambient temperatures in a range of -40 to +85 =C2=B0C.
>=20
> Such boards run an extented version of the CAN-FD IP running into USB
> CAN-FD interfaces from PEAK-System, so this patch adds several new comm=
ands
> and their corresponding data types to the PEAK CAN-FD common definition=
s
> header file too.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

[...]

> +/* probe for CAN-FD channel #pciefd_board->can_count */
> +static int pciefd_can_probe(struct pciefd_board *pciefd)
> +{
> +	struct net_device *ndev;
> +	struct pciefd_can *priv;
> +	u32 clk;
> +	int err;
> +
> +	/* allocate the candev object */
> +	ndev =3D alloc_peak_canfd_dev(sizeof(*priv), CANFD_ECHO_SKB_MAX,
> +				    pciefd->can_count);
> +	if (!ndev) {
> +		dev_err(&pciefd->pci_dev->dev,
> +			"failed to alloc candev object\n");
> +		goto failure;
> +	}
> +
> +	priv =3D netdev_priv(ndev);
> +
> +	/* fill-in candev private object: */
> +
> +	/* setup PCIe-FD own callbacks */
> +	priv->ucan.write_cmd =3D pciefd_write_cmd;
> +	priv->ucan.enable_tx_path =3D pciefd_enable_tx_path;
> +	priv->ucan.alloc_tx_msg =3D pciefd_alloc_tx_msg;
> +	priv->ucan.write_tx_msg =3D pciefd_write_tx_msg;
> +
> +	/* setup PCIe-FD own command buffer */
> +	priv->ucan.cmd_buffer =3D &priv->pucan_cmd;
> +	priv->ucan.cmd_maxlen =3D sizeof(priv->pucan_cmd);
> +
> +	priv->board =3D pciefd;
> +
> +	/* CAN config regs block address */
> +	priv->reg_base =3D pciefd->reg_base + PCIEFD_CANX_OFF(priv->ucan.inde=
x);
> +
> +	/* allocate non-cacheable DMA'able 4KB memory area for Rx */
> +	priv->rx_dma_vaddr =3D dma_alloc_coherent(&pciefd->pci_dev->dev,
> +						PCIEFD_RX_DMA_SIZE,
> +						&priv->rx_dma_laddr,
> +						GFP_KERNEL);

use dmam_alloc_coherent() instead

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qxK1DrQewe7FLlUdX5RSfwJq8ls1dfaGi--

--gkgWACiLRvEgoWT40cwJ4hcA6to0GqOwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhruw0ACgkQPTuqJayp
JWo4zAf/YM8vpRYbBV9koRFEgk2VaaztVflrcai+ymOE0XnyhyvKBzgLSHKlyTXW
m+qYq1pp2lUnj4VsAq3hWgChPwZJ0mAbBM/NsIcltORAgupXDuPHHnCr4GzUhi68
vejigZ9azQ019/LgnBUmE1EgrRs9mj8eTWABIoq4FLhNbOxAbLvbrEM62MX5qcpG
3qubjr/ganUgmnt0W4blwNvcr5RKWzo0iByHv3QsIquE6Lql5xJksz3HJsJLWgmv
mWWNmVeB2H5FqyD9r1XsKyfWm+l5aokVfC6zBq2DwsxczVY1h68SduElN/gfLLt/
ELSVHcDDiv9RHngD430SHeBuYZiq6Q==
=l7KD
-----END PGP SIGNATURE-----

--gkgWACiLRvEgoWT40cwJ4hcA6to0GqOwW--

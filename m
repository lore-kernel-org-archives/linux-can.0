From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Tue, 3 Jan 2017 15:25:46 +0100
Message-ID: <a86ff34f-856a-b63a-4b6a-8106728d176b@pengutronix.de>
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gxdpSAwGW1cA9hool4mxNcBQV0wdxXdef"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56661 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752218AbdACO0X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Jan 2017 09:26:23 -0500
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gxdpSAwGW1cA9hool4mxNcBQV0wdxXdef
Content-Type: multipart/mixed; boundary="H8gmh1R9V1wshvEvNUhdR0FwckpOctScf";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <a86ff34f-856a-b63a-4b6a-8106728d176b@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1483360491-31682-1-git-send-email-s.grosjean@peak-system.com>
 <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1483360491-31682-5-git-send-email-s.grosjean@peak-system.com>

--H8gmh1R9V1wshvEvNUhdR0FwckpOctScf
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

> +/* CAN-FD channel object */
> +struct pciefd_board;
> +struct pciefd_can {
> +	struct peak_canfd_priv ucan;	/* must be the first member */
> +	void __iomem *reg_base;		/* channel config base addr */
> +	struct pciefd_board *board;	/* reverse link */
> +
> +	struct pucan_command pucan_cmd;	/* command buffer */
> +
> +	u32 flags;

not used.

> +
> +	dma_addr_t rx_dma_laddr;	/* DMA virtual and logical addr */
> +	void *rx_dma_vaddr;		/* for Rx and Tx areas */
> +	dma_addr_t tx_dma_laddr;
> +	void *tx_dma_vaddr;
> +
> +	struct pciefd_page tx_pages[PCIEFD_TX_PAGE_COUNT];
> +	u16 tx_pages_free;		/* free Tx pages counter */
> +	u16 tx_page_index;		/* current page used for Tx */
> +
> +	struct pciefd_irq_status irq_status;	/* current irq status */
> +	u32 irq_tag;				/* next irq tag */
> +};

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--H8gmh1R9V1wshvEvNUhdR0FwckpOctScf--

--gxdpSAwGW1cA9hool4mxNcBQV0wdxXdef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhrtGoACgkQPTuqJayp
JWoAGggAvj/aPNd4h3Ysa0YQK2zqo6uMrGPJYMBEOLb9jQ9IOCtvJC1Os0goZHuT
NQl2wlPZGOGFdSRv75ASWHYK+jMKuEd/vywtmeov9JOMfyYEz97Pl1ihSTKQkWSI
tTruSq+Jy+W3tq40MsTIcliedGg18naqHnSxKBnDv7U09IZx0XCwD0WfR/bQ4x3P
WmX53/PLqPZGNEtpZT2vNt7MYU0vy9JzFMDIQ1Q3icjOKenyQbWSwrHN3bbF/7uY
V532s0t8ITSwIRnmgxrFrKnlhWXhqCLTfBmSU0pxJbK0plKHiqK3VtNKPkiGr+o6
HQNqBWbnOIGOSKqbCV63NvPj0OACjQ==
=rNwe
-----END PGP SIGNATURE-----

--gxdpSAwGW1cA9hool4mxNcBQV0wdxXdef--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V5 1/1] can: Add support for esd CAN PCIe/402 card
Date: Tue, 17 Mar 2015 22:27:50 +0100
Message-ID: <55089C56.1040406@pengutronix.de>
References: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oaCra4jLQiBUIS4h54tEpaTiFgAcBTMNP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44928 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbbCQV2H (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 17:28:07 -0400
In-Reply-To: <1426508113-14904-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Thomas_K=c3=b6rper?= <thomas.koerper@esd.eu>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oaCra4jLQiBUIS4h54tEpaTiFgAcBTMNP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2015 01:15 PM, Thomas K=C3=B6rper wrote:
> This patch adds support for the CAN PCIe/402 card from esd electronic
> system design gmbh: FPGA based CAN controller, supporting up to 4
> nets, MSI and bus mastering. See http://esd.eu/en/products/can-pcie402
> for details.

I assume all packed strucks are coming from the hardware, do you have to
take care of the endianess? I'll consult a colleague of mine, too. Can
you explain me how endianess is handled in the driver/hw? What's the
purpose of the __LITTLE_ENDIAN? Have you actually tested on any BE platfo=
rm?

Your TX path flow control is broken, you should stop the queue before
enabling the tx-ready IRQ (or sending the CAN frame) if all your HW
buffers are used. Enable the queue after freeing your HW buffer in tx
complete.

Why do you split your driver into two .c files? Probably to have a
separation of low level functions, but this can be done in one .c file,
too. But you might convince me in this point :). Your .h file can be
cleaned up, please put only the bare minimum into the header, defines
and structs that are only used in one .c file should go there.

Please re-arange your .c file, so that you don't need any forward
declarations of functions.

> Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
> ---
>  drivers/net/can/Kconfig          |   2 +
>  drivers/net/can/Makefile         |   1 +
>  drivers/net/can/esd/Kconfig      |   7 +
>  drivers/net/can/esd/Makefile     |   3 +
>  drivers/net/can/esd/esd402_pci.c | 453 +++++++++++++++++++++++++++++
>  drivers/net/can/esd/esdacc.c     | 600 +++++++++++++++++++++++++++++++=
++++++++
>  drivers/net/can/esd/esdacc.h     | 428 ++++++++++++++++++++++++++++
>  7 files changed, 1494 insertions(+)
>  create mode 100644 drivers/net/can/esd/Kconfig
>  create mode 100644 drivers/net/can/esd/Makefile
>  create mode 100644 drivers/net/can/esd/esd402_pci.c
>  create mode 100644 drivers/net/can/esd/esdacc.c
>  create mode 100644 drivers/net/can/esd/esdacc.h
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 58808f6..54d9ce8 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -153,6 +153,8 @@ source "drivers/net/can/usb/Kconfig"
> =20
>  source "drivers/net/can/softing/Kconfig"
> =20
> +source "drivers/net/can/esd/Kconfig"
> +
>  endif
> =20
>  config CAN_DEBUG_DEVICES
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index c533c62..c691233 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -13,6 +13,7 @@ can-dev-$(CONFIG_CAN_LEDS)	+=3D led.o
>  obj-y				+=3D spi/
>  obj-y				+=3D usb/
>  obj-y				+=3D softing/
> +obj-y				+=3D esd/
> =20
>  obj-$(CONFIG_CAN_SJA1000)	+=3D sja1000/
>  obj-$(CONFIG_CAN_MSCAN)		+=3D mscan/
> diff --git a/drivers/net/can/esd/Kconfig b/drivers/net/can/esd/Kconfig
> new file mode 100644
> index 0000000..cebd5ae
> --- /dev/null
> +++ b/drivers/net/can/esd/Kconfig
> @@ -0,0 +1,7 @@
> +config CAN_ESD_402_PCI
> +	tristate "esd gmbh CAN PCIe/402 support"
> +	default y

I think no default would be a sensible default here.

> +	depends on PCI && HAS_DMA
> +	---help---
> +	  Support for CAN PCIe/402 card from esd electronic system design gmb=
h
> +	  (http://esd.eu/en)
> diff --git a/drivers/net/can/esd/Makefile b/drivers/net/can/esd/Makefil=
e
> new file mode 100644
> index 0000000..80d970e
> --- /dev/null
> +++ b/drivers/net/can/esd/Makefile
> @@ -0,0 +1,3 @@
> +esd_402_pci-y :=3D esdacc.o esd402_pci.o
> +
> +obj-$(CONFIG_CAN_ESD_402_PCI) +=3D esd_402_pci.o
> diff --git a/drivers/net/can/esd/esd402_pci.c b/drivers/net/can/esd/esd=
402_pci.c
> new file mode 100644
> index 0000000..d2b5600
> --- /dev/null
> +++ b/drivers/net/can/esd/esd402_pci.c
> @@ -0,0 +1,453 @@
> +/* Copyright (C) 2015 esd electronic system design gmbh
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/netdevice.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include "esdacc.h"
> +
> +#define DRV_NAME			"esd_402_pci"
> +
> +#define ESD_PCI_DEVICE_ID_PCIE402	0x0402
> +
> +#define PCI402_FPGA_VER_MIN		0x0025
> +#define PCI402_FPGA_VER_NEWBTR		0x0032
> +#define PCI402_MAX_CORES		4
> +#define PCI402_BAR			0
> +#define PCI402_IO_OV_OFFS		0
> +#define PCI402_IO_PCIEP_OFFS		0x10000
> +#define PCI402_IO_LEN_TOTAL		0x20000
> +#define PCI402_IO_LEN_CORE		0x2000
> +#define PCI402_PCICFG_MSICAP_CSR	0x52
> +#define PCI402_PCICFG_MSICAP_ADDR	0x54
> +#define PCI402_PCICFG_MSICAP_DATA	0x5c
> +
> +#define PCI402_DMA_MASK			(DMA_BIT_MASK(32) & 0xffff0000)
> +#define PCI402_DMA_SIZE			ALIGN(0x10000, PAGE_SIZE)
> +#define PCI402_DMA_FIFO_ITEMSIZE	32
> +
> +#define PCI402_PCIEP_OF_INT_ENABLE	0x0050
> +#define PCI402_PCIEP_OF_BM_ADDR_LO	0x1000
> +#define PCI402_PCIEP_OF_BM_ADDR_HI	0x1004
> +#define PCI402_PCIEP_OF_MSI_ADDR_LO	0x1008
> +#define PCI402_PCIEP_OF_MSI_ADDR_HI	0x100c
> +
> +struct pci402_card {
> +	/* Actually mapped io space, all other iomem derived from this */
> +	void __iomem *addr;
> +	void __iomem *addr_pciep;
> +
> +	void *dma_buf;
> +	dma_addr_t dma_hnd;
> +
> +	struct acc_ov ov;
> +	struct acc_core core[PCI402_MAX_CORES];
> +
> +	bool msi_enabled;
> +};
> +
> +static irqreturn_t pci402_interrupt(int irq, void *dev_id)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata((struct pci_dev *)dev_id=
);

The cast is not needed.
> +
> +	return acc_card_interrupt(&card->ov, card->core);

Can you integrate acc_card_interrupt() here?

> +}
> +
> +static int pci402_set_msiconfig(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	u32 addr_lo_offs =3D 0;
> +	u32 addr_lo =3D 0;
> +	u32 addr_hi =3D 0;
> +	u32 data =3D 0;
> +	u16 csr =3D 0;
> +	int err;
> +
> +	err =3D pci_read_config_word(pdev, PCI402_PCICFG_MSICAP_CSR, &csr);
> +	if (err)
> +		goto failed;
> +
> +	err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP_ADDR, &addr_=
lo);
> +	if (err)
> +		goto failed;
> +	err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP_ADDR + 4,
> +				    &addr_hi);
> +	if (err)
> +		goto failed;
> +
> +	err =3D pci_read_config_dword(pdev, PCI402_PCICFG_MSICAP_DATA, &data)=
;
> +	if (err)
> +		goto failed;
> +
> +	addr_lo_offs =3D addr_lo & 0x0000ffff;
> +	addr_lo &=3D 0xffff0000;
> +
> +	if (addr_hi)
> +		addr_lo |=3D 1; /* Enable 64-Bit addressing in address space */
> +
> +	if (!(csr & 0x0001)) /* Enable bit */
> +		goto failed;
> +
> +	iowrite32(addr_lo, card->addr_pciep + PCI402_PCIEP_OF_MSI_ADDR_LO);
> +	iowrite32(addr_hi, card->addr_pciep + PCI402_PCIEP_OF_MSI_ADDR_HI);
> +	acc_ov_write32(&card->ov, ACC_OV_OF_MSI_ADDRESSOFFSET, addr_lo_offs);=

> +	acc_ov_write32(&card->ov, ACC_OV_OF_MSI_DATA, data);
> +
> +	return 0;
> +
> +failed:
> +	dev_warn(&pdev->dev, "Error while setting MSI configuration:\n"
> +		 "CSR: 0x%.4x, addr: 0x%.8x%.8x, data: 0x%.8x\n",
> +		 csr, addr_hi, addr_lo, data);
> +
> +	return -1;

Please use sensible -ERRNO in the kernel.

> +}
> +
> +static int pci402_init_card(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +
> +	card->ov.addr =3D card->addr + PCI402_IO_OV_OFFS;
> +	card->addr_pciep =3D card->addr + PCI402_IO_PCIEP_OFFS;
> +
> +	acc_reset_fpga(&card->ov);
> +	acc_init_ov(&card->ov, &pdev->dev);
> +
> +	if (card->ov.version < PCI402_FPGA_VER_MIN) {
> +		dev_err(&pdev->dev,
> +			"FPGA version (0x%.4x) outdated, please update\n",
> +			card->ov.version);
> +		return -EINVAL;
> +	}
> +
> +	if (card->ov.active_cores > PCI402_MAX_CORES) {
> +		dev_warn(&pdev->dev, "Card has more active cores than supported by d=
river, %u core(s) will be ignored\n",
> +			 card->ov.active_cores - PCI402_MAX_CORES);
> +		card->ov.active_cores =3D PCI402_MAX_CORES;
> +	}
> +
> +	card->ov.deprecated_btr =3D card->ov.version < PCI402_FPGA_VER_NEWBTR=
;
> +
> +#ifdef __LITTLE_ENDIAN
> +	/* So card converts all busmastered data to LE for us: */
> +	acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> +			ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE);
> +#endif
> +
> +	return 0;
> +}
> +
> +static int pci402_init_interrupt(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	int err;
> +
> +	err =3D pci_enable_msi(pdev);
> +	if (!err) {
> +		err =3D pci402_set_msiconfig(pdev);
> +		if (!err) {
> +			card->msi_enabled =3D 1;

please use true/false as it's a bool

> +			acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> +					ACC_OV_REG_MODE_MASK_MSI_ENABLE);
> +			dev_info(&pdev->dev, "MSI enabled\n");
> +		}
> +	}
> +
> +	err =3D request_irq(pdev->irq, pci402_interrupt,
> +			  IRQF_SHARED, DRV_NAME, pdev);

please use dev->name instead of DRV_NAME
please use devm_request_irq function

> +	if (err)
> +		goto failure_msidis;
> +
> +	iowrite32(1, card->addr_pciep + PCI402_PCIEP_OF_INT_ENABLE);
> +
> +	return 0;
> +
> +failure_msidis:
> +	if (card->msi_enabled) {
> +		acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> +				  ACC_OV_REG_MODE_MASK_MSI_ENABLE);
> +		pci_disable_msi(pdev);
> +		card->msi_enabled =3D 0;
> +	}
> +
> +	return err;
> +}
> +
> +static void pci402_finish_interrupt(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +
> +	iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_INT_ENABLE);
> +	free_irq(pdev->irq, pdev);
> +
> +	if (card->msi_enabled) {
> +		acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> +				  ACC_OV_REG_MODE_MASK_MSI_ENABLE);
> +		pci_disable_msi(pdev);
> +		card->msi_enabled =3D 0;
> +	}
> +}
> +
> +static int pci402_init_dma(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	int err;
> +
> +	err =3D pci_set_consistent_dma_mask(pdev, PCI402_DMA_MASK);
> +	if (err) {
> +		dev_err(&pdev->dev, "dma set mask failed!");
> +		return err;
> +	}
> +
> +	card->dma_buf =3D pci_alloc_consistent(pdev, PCI402_DMA_SIZE,
> +					     &card->dma_hnd);
> +	if (!card->dma_buf) {
> +		dev_err(&pdev->dev, "dma alloc failed!");
> +		return -ENOMEM;
> +	}
> +
> +	acc_init_bm_ptr(&card->ov, card->core, card->dma_buf);
> +
> +	iowrite32((u32)card->dma_hnd,
> +		  card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_LO);
> +	iowrite32((u32)(card->dma_hnd >> 32),
> +		  card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_HI);
> +
> +	acc_ov_set_bits(&card->ov, ACC_OV_OF_MODE,
> +			ACC_OV_REG_MODE_MASK_BM_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void pci402_finish_dma(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	int i;
> +
> +	acc_ov_clear_bits(&card->ov, ACC_OV_OF_MODE,
> +			  ACC_OV_REG_MODE_MASK_BM_ENABLE);
> +
> +	iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_LO);
> +	iowrite32(0, card->addr_pciep + PCI402_PCIEP_OF_BM_ADDR_HI);
> +
> +	card->ov.bmfifo.messages =3D NULL;
> +	card->ov.bmfifo.irq_cnt =3D NULL;
> +	for (i =3D 0; i < card->ov.active_cores; ++i) {
> +		struct acc_core *core =3D &card->core[i];
> +
> +		core->bmfifo.messages =3D NULL;
> +		core->bmfifo.irq_cnt =3D NULL;
> +	}
> +
> +	pci_free_consistent(pdev, PCI402_DMA_SIZE, card->dma_buf,
> +			    card->dma_hnd);
> +	card->dma_buf =3D NULL;
> +}
> +
> +static int pci402_init_cores(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	int num_register_ok =3D 0;
> +	int err;
> +	int i;
> +
> +	for (i =3D 0; i < card->ov.active_cores; ++i) {
i++ common style (and doesn't make a difference here)
> +		struct acc_core *core =3D &card->core[i];
> +		struct acc_net_priv *priv;
> +		struct net_device *netdev;
> +		u32 fifo_config;
> +
> +		core->addr =3D card->ov.addr + (i + 1) * PCI402_IO_LEN_CORE;
> +
> +		fifo_config =3D acc_read32(core, ACC_CORE_OF_TXFIFO_CONFIG);
> +		core->tx_fifo_size =3D (u8)(fifo_config >> 24);
cast not needed
> +		BUG_ON(core->tx_fifo_size <=3D 1);

better exit more gracefully here

> +
> +		netdev =3D alloc_candev(sizeof(*priv), core->tx_fifo_size);
> +		if (!netdev) {
> +			err =3D -ENOMEM;
> +			goto failure;
> +		}
> +		core->net_dev =3D netdev;
> +
> +		netdev->flags |=3D IFF_ECHO;
> +		netdev->netdev_ops =3D &acc_netdev_ops;
> +		SET_NETDEV_DEV(netdev, &pdev->dev);
> +
> +		priv =3D netdev_priv(netdev);
> +		priv->can.state =3D CAN_STATE_STOPPED;
> +		priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
> +						CAN_CTRLMODE_LOOPBACK |
> +						CAN_CTRLMODE_BERR_REPORTING;
> +		priv->can.clock.freq =3D card->ov.core_frequency / 2;
> +		priv->can.bittiming_const =3D (card->ov.deprecated_btr) ?
> +				&acc_bittiming_const_pci402_old :
> +				&acc_bittiming_const_pci402;
> +		priv->can.do_set_bittiming =3D acc_set_bittiming;
> +		priv->can.do_set_mode =3D acc_set_mode;
> +		priv->can.do_get_berr_counter =3D acc_get_berr_counter;
> +
> +		priv->core =3D core;
> +		priv->ov =3D &card->ov;
> +
> +		err =3D register_candev(netdev);
> +		if (err)

free the candev here.....

> +			goto failure;
> +
> +		netdev_info(netdev, "registered\n");
> +		num_register_ok++;
> +	}
> +
> +	return 0;
> +
> +failure:
> +	for (i =3D 0; i < card->ov.active_cores; ++i) {

=2E..and iterate backwards: for(i--; i >=3D 0; i--)

then you don't need num_registered_ok anymore.

> +		struct acc_core *core =3D &card->core[i];
> +
> +		if (!core->net_dev)
> +			continue;
> +
> +		if (i < num_register_ok) {
> +			netdev_info(core->net_dev, "unregistering...\n");
> +			unregister_candev(core->net_dev);
> +		}
> +
> +		free_candev(core->net_dev);
> +		core->net_dev =3D NULL;
> +	}
> +
> +	return err;
> +}
> +
> +static void pci402_finish_cores(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +	int i;
> +
> +	for (i =3D 0; i < card->ov.active_cores; ++i) {
> +		struct acc_core *core =3D &card->core[i];
> +
> +		unregister_candev(core->net_dev);
> +		free_candev(core->net_dev);
> +		core->net_dev =3D NULL;
> +	}
> +}
> +
> +static int pci402_probe(struct pci_dev *pdev, const struct pci_device_=
id *ent)
> +{
> +	struct pci402_card *card =3D NULL;
> +	int err;
> +
> +	BUILD_BUG_ON(PCI402_DMA_FIFO_ITEMSIZE !=3D sizeof(struct acc_bmmsg));=

> +
> +	err =3D pci_enable_device(pdev);
> +	if (err)
> +		goto failure;
> +
> +	pci_set_master(pdev);
> +
> +	card =3D kzalloc(sizeof(*card), GFP_KERNEL);
devm_kzalloc()
> +	if (!card)
> +		goto failure;
> +
> +	pci_set_drvdata(pdev, card);
> +
> +	err =3D pci_request_regions(pdev, DRV_NAME);
> +	if (err)
> +		goto failure_disable_pci;
> +
> +	card->addr =3D pci_iomap(pdev, PCI402_BAR, PCI402_IO_LEN_TOTAL);
> +	if (!card->addr) {
> +		err =3D -ENOMEM;
> +		goto failure_release_regions;
> +	}
> +
> +	err =3D pci402_init_card(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err =3D pci402_init_dma(pdev);
> +	if (err)
> +		goto failure_unmap;
> +
> +	err =3D pci402_init_interrupt(pdev);
> +	if (err)
> +		goto failure_finish_dma;
> +
> +	err =3D pci402_init_cores(pdev);
> +	if (err)
> +		goto failure_finish_interrupt;
> +
> +	return 0;
> +
> +failure_finish_interrupt:
> +	pci402_finish_interrupt(pdev);
> +
> +failure_finish_dma:
> +	pci402_finish_dma(pdev);
> +
> +failure_unmap:
> +	pci_iounmap(pdev, card->addr);
> +
> +failure_release_regions:
> +	pci_release_regions(pdev);
> +
> +failure_disable_pci:
> +	pci_disable_device(pdev);
> +
> +failure:
> +	kfree(card);
> +
> +	return err;
> +}
> +
> +static void pci402_remove(struct pci_dev *pdev)
> +{
> +	struct pci402_card *card =3D pci_get_drvdata(pdev);
> +
> +	pci402_finish_interrupt(pdev);
> +	pci402_finish_cores(pdev);
> +	pci402_finish_dma(pdev);
> +	pci_iounmap(pdev, card->addr);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +	kfree(card);
> +}
> +
> +static const struct pci_device_id pci402_tbl[] =3D {
> +	{ PCI_VENDOR_ID_ESDGMBH, ESD_PCI_DEVICE_ID_PCIE402,
> +			PCI_ANY_ID, PCI_ANY_ID, },
> +	{ 0, }
> +};
> +
> +static struct pci_driver pci402_driver =3D {
> +	.name =3D DRV_NAME,
> +	.id_table =3D pci402_tbl,
> +	.probe =3D pci402_probe,
> +	.remove =3D pci402_remove,
> +};
> +
> +module_pci_driver(pci402_driver);
> +
> +MODULE_DESCRIPTION("linux-can driver for esd CAN PCIe/402 cards");
> +MODULE_AUTHOR("Thomas K=C3=B6rper <thomas.koerper@esd.eu>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.=
c
> new file mode 100644
> index 0000000..46feae6
> --- /dev/null
> +++ b/drivers/net/can/esd/esdacc.c
> @@ -0,0 +1,600 @@
> +/* Copyright (C) 2015 esd electronic system design gmbh
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#include <linux/ktime.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include "esdacc.h"
> +
> +static void acc_resetmode_enter(struct acc_core *core)
> +{
> +	int i;
> +
> +	acc_set_bits(core, ACC_CORE_OF_CTRL_MODE,
> +		     ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> +
> +	for (i =3D 0; i < 10; ++i) {
> +		if (acc_resetmode_entered(core))
> +			return;
> +
> +		udelay(5);
> +	}
> +
> +	netdev_warn(core->net_dev, "Entering reset mode timed out\n");
> +}
> +
> +static void acc_resetmode_leave(struct acc_core *core)
> +{
> +	int i;
> +
> +	acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> +		       ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> +
> +	for (i =3D 0; i < 10; ++i) {
> +		if (!acc_resetmode_entered(core))
> +			return;
> +
> +		udelay(5);
> +	}
> +
> +	netdev_warn(core->net_dev, "Leaving reset mode timed out\n");
> +}
> +
> +static int acc_txq_isready(struct acc_core *core)
> +{
> +	u8 fifo_level =3D (u8)(acc_read32(core, ACC_CORE_OF_TXFIFO_STATUS) >>=
 16);
> +
> +	return (fifo_level < core->tx_fifo_size - 1);
> +}
> +
> +static void acc_txq_put(struct acc_core *core, u32 esd_id, u8 esd_len,=

> +			const void *data)
> +{
> +	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
> +			   *((const u32 *)data));
> +	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
> +			   *((const u32 *)(data + 4)));
> +	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, esd_len);
> +	/* CAN id must be written at last: */
> +	acc_write32(core, ACC_CORE_OF_TXFIFO_ID, esd_id);
> +}
> +
> +static ktime_t acc_ts_to_ktime(struct acc_ov *ov, u64 ts)
> +{
> +	unsigned long long ns;
> +	unsigned int rem;
> +
> +	rem =3D do_div(ts, ov->timestamp_frequency);
> +	ns =3D ts * NSEC_PER_SEC;
> +
> +	ts =3D (unsigned long long)rem * NSEC_PER_SEC;
> +	do_div(ts, ov->timestamp_frequency);
> +	ns +=3D ts;
> +
> +	return ns_to_ktime(ns);
> +}
> +
> +void acc_init_ov(struct acc_ov *ov, struct device *dev)
> +{
> +	u32 temp;
> +
> +	temp =3D acc_ov_read32(ov, ACC_OV_OF_VERSION);
> +	ov->features =3D (u16)(temp >> 16);
> +	ov->version =3D (u16)temp;
> +
> +	temp =3D acc_ov_read32(ov, ACC_OV_OF_INFO);
> +	ov->active_cores =3D (u8)(temp >> 8);
> +	ov->total_cores =3D (u8)temp;
> +
> +	ov->core_frequency =3D acc_ov_read32(ov, ACC_OV_OF_CANCORE_FREQ);
> +	ov->timestamp_frequency =3D acc_ov_read32(ov, ACC_OV_OF_TS_FREQ_LO);
> +
> +	dev_info(dev,
> +		 "FPGA v%u, freq: %u/%u, feat/strap: 0x%x/0x%x, cores: %u/%u\n",
> +		 ov->version, ov->core_frequency, ov->timestamp_frequency,
> +		 ov->features, acc_ov_read32(ov, ACC_OV_OF_INFO) >> 16,
> +		 ov->active_cores, ov->total_cores);
> +}
> +
> +void acc_init_bm_ptr(struct acc_ov *ov, struct acc_core *cores, const =
void *mem)
> +{
> +	int i;
> +
> +	/* DMA buffer layout:
> +	 * +-----------------------+
> +	 * | FIFO Card/Overview    |
> +	 * |                       |
> +	 * +-----------------------+
> +	 * | FIFO Core0            |
> +	 * |                       |
> +	 * +-----------------------+
> +	 * | FIFO Core1            |
> +	 * |                       |
> +	 * +-----------------------+
> +	 * | ...                   |
> +	 * |                       |
> +	 * +-----------------------+
> +	 * | irq_cnt Card/Overview |
> +	 * +-----------------------+
> +	 * | irq_cnt Core0         |
> +	 * +-----------------------+
> +	 * | irq_cnt Core1         |
> +	 * +-----------------------+
> +	 * | ...                   |
> +	 * +-----------------------+
> +	 */
> +	ov->bmfifo.messages =3D mem;
> +	ov->bmfifo.irq_cnt =3D mem + (ov->total_cores + 1) * ACC_CORE_DMABUF_=
SIZE;
> +
> +	for (i =3D 0; i < ov->active_cores; ++i) {
> +		struct acc_core *core =3D &cores[i];
> +
> +		core->bmfifo.messages =3D mem + (i + 1) * ACC_CORE_DMABUF_SIZE;
> +		core->bmfifo.irq_cnt =3D ov->bmfifo.irq_cnt + 1 + i;
> +	}
> +}
> +
> +int acc_open(struct net_device *netdev)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +	u32 ctrl_mode;
> +	int err;
> +
> +	err =3D open_candev(netdev);
> +	if (err)
> +		return err;
> +
> +	ctrl_mode =3D ACC_REG_CONTROL_MASK_IE_RXTX |
> +			ACC_REG_CONTROL_MASK_IE_TXERROR |
> +			ACC_REG_CONTROL_MASK_IE_ERRPASS |
> +			ACC_REG_CONTROL_MASK_IE_OVERRUN |
> +			ACC_REG_CONTROL_MASK_IE_ERROR;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		ctrl_mode |=3D ACC_REG_CONTROL_MASK_IE_BUSERR;
> +
> +	acc_set_bits(priv->core, ACC_CORE_OF_CTRL_MODE, ctrl_mode);
> +
> +	netif_start_queue(netdev);
> +	return 0;
> +}
> +
> +int acc_close(struct net_device *netdev)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +
> +	acc_clear_bits(priv->core, ACC_CORE_OF_CTRL_MODE,
> +		       ACC_REG_CONTROL_MASK_IE_RXTX |
> +		       ACC_REG_CONTROL_MASK_IE_TXERROR |
> +		       ACC_REG_CONTROL_MASK_IE_OVERRUN);
> +
> +	netif_stop_queue(netdev);
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	close_candev(netdev);
> +	return 0;
> +}
> +
> +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *net=
dev)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +	struct acc_core *core =3D priv->core;
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u8 new_fifo_head =3D (core->tx_fifo_head + 1) % core->tx_fifo_size;
> +	u32 esd_id;
> +	u8 esd_len;
> +
> +	if ((new_fifo_head =3D=3D core->tx_fifo_tail) || !acc_txq_isready(cor=
e)) {
> +		netif_stop_queue(netdev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	esd_len =3D can_dlc2len(cf->can_dlc);
> +	if (cf->can_id & CAN_RTR_FLAG)
> +		esd_len |=3D ACC_CAN_RTR_FLAG;
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		esd_id =3D cf->can_id & CAN_EFF_MASK;
> +		esd_id |=3D ACC_CAN_EFF_FLAG;
> +	} else {
> +		esd_id =3D cf->can_id & CAN_SFF_MASK;
> +	}
> +
> +	can_put_echo_skb(skb, netdev, core->tx_fifo_head);
> +	core->tx_fifo_head =3D new_fifo_head;
> +
> +	acc_txq_put(core, esd_id, esd_len, cf->data);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +int acc_get_berr_counter(const struct net_device *netdev,
> +			 struct can_berr_counter *bec)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +	u32 core_status =3D acc_read32(priv->core, ACC_CORE_OF_STATUS);
> +
> +	bec->txerr =3D (u8)(core_status >> 8);
> +	bec->rxerr =3D (u8)core_status;
> +
> +	return 0;
> +}
> +
> +int acc_set_mode(struct net_device *netdev, enum can_mode mode)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		acc_resetmode_leave(priv->core);
> +		netif_wake_queue(netdev);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +int acc_set_bittiming(struct net_device *netdev)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(netdev);
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	u32 btr;
> +	u8 brp;
> +
> +	brp =3D (u8)(bt->brp - 1);
> +	acc_resetmode_enter(priv->core);
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		acc_set_bits(priv->core, ACC_CORE_OF_CTRL_MODE,
> +			     ACC_REG_CONTROL_MASK_MODE_LOM);
> +	else
> +		acc_clear_bits(priv->core, ACC_CORE_OF_CTRL_MODE,
> +			       ACC_REG_CONTROL_MASK_MODE_LOM);
> +
> +	if (priv->ov->deprecated_btr) {
> +		btr =3D brp;
> +
> +		/* TSEG1: Bit12..15 */
> +		btr |=3D ((bt->phase_seg1 + bt->prop_seg - 1) & 0xf) << 12;
> +		/* TSEG2: Bit20..22 */
> +		btr |=3D ((bt->phase_seg2 - 1) & 0x7) << 20;
> +		/* SJW: Bit25..26 */
> +		btr |=3D ((bt->sjw - 1) & 0x3) << 25;
> +
> +		acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
> +	} else {
> +		/* TSEG1: Bit0..7 */
> +		btr =3D (bt->phase_seg1 + bt->prop_seg - 1) & 0xff;
> +		/* TSEG2: Bit16..22 */
> +		btr |=3D ((bt->phase_seg2 - 1) & 0x7f) << 16;
> +		/* SJW: Bit24..30 */
> +		btr |=3D ((bt->sjw - 1) & 0x7f) << 24;
> +
> +		acc_write32(priv->core, ACC_CORE_OF_BTR, brp);
> +		acc_write32(priv->core, ACC_CORE_OF_BTR_FD, btr);
> +	}
> +
> +	acc_resetmode_leave(priv->core);
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static void handle_core_msg_rxtxdone(struct acc_core *core,
> +				     const struct acc_bmmsg_rxtxdone *msg)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +
> +	if (msg->dlc.rxtx.len & ACC_BM_LENFLAG_TX) {
> +		if (core->tx_fifo_head =3D=3D core->tx_fifo_tail) {
> +			netdev_warn(core->net_dev,
> +				    "TX interrupt, but queue is empty!?\n");
> +			return;
> +		}
> +		stats->tx_packets++;
> +		stats->tx_bytes +=3D
> +				get_can_dlc(msg->dlc.tx.len & ACC_CAN_DLC_MASK);
> +
> +		can_get_echo_skb(core->net_dev, core->tx_fifo_tail);
> +		core->tx_fifo_tail++;
> +		if (core->tx_fifo_tail >=3D core->tx_fifo_size)
> +			core->tx_fifo_tail =3D 0;
> +		netif_wake_queue(core->net_dev);
> +
> +	} else {
> +		struct skb_shared_hwtstamps *skb_ts;
> +		struct can_frame *cf;
> +		struct sk_buff *skb;
> +
> +		skb =3D alloc_can_skb(core->net_dev, &cf);
> +		if (!skb) {
> +			stats->rx_dropped++;
> +			return;
> +		}
> +
> +		cf->can_id =3D msg->id & CAN_EFF_MASK;
> +		if (msg->id & ACC_CAN_EFF_FLAG)
> +			cf->can_id |=3D CAN_EFF_FLAG;
> +
> +		cf->can_dlc =3D get_can_dlc(msg->dlc.rx.len);
> +		if (msg->dlc.rx.len & ACC_CAN_RTR_FLAG)
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		else
> +			memcpy(cf->data, msg->data, cf->can_dlc);
> +
> +		skb_ts =3D skb_hwtstamps(skb);
> +		skb_ts->hwtstamp =3D acc_ts_to_ktime(priv->ov, msg->timestamp);
> +		netif_rx(skb);
> +
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
> +	}
> +}
> +
> +static void handle_core_msg_txabort(struct acc_core *core,
> +				    const struct acc_bmmsg_txabort *msg)
> +{
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +	int i;
> +
> +	/* abort_mask signals which frames were aborted in card's fifo */
> +	for (i =3D 0; i < sizeof(msg->abort_mask) * BITS_PER_BYTE; ++i) {
> +		if (!(msg->abort_mask & (1 << i)))
> +			continue;
> +
> +		if (core->tx_fifo_head =3D=3D core->tx_fifo_tail) {
> +			netdev_warn(core->net_dev,
> +				    "TX Err interrupt, but queue is empty!?\n");
> +			break;
> +		}
> +		stats->tx_errors++;
> +
> +		can_free_echo_skb(core->net_dev, core->tx_fifo_tail);
> +		core->tx_fifo_tail++;
> +		if (core->tx_fifo_tail >=3D core->tx_fifo_size)
> +			core->tx_fifo_tail =3D 0;
> +	}
> +
> +	if (!acc_resetmode_entered(core))
> +		netif_wake_queue(core->net_dev);
> +}
> +
> +static void handle_core_msg_overrun(struct acc_core *core,
> +				    const struct acc_bmmsg_overrun *msg)
> +{
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	skb =3D alloc_can_err_skb(core->net_dev, &cf);
> +	if (!skb)
> +		return;
> +
> +	/* lost_cnt may be 0 if not supported by FPGA version */
> +	if (msg->lost_cnt) {
> +		stats->rx_dropped +=3D msg->lost_cnt;
> +		stats->rx_over_errors +=3D msg->lost_cnt;
> +	} else {
> +		stats->rx_dropped++;
> +		stats->rx_over_errors++;
> +	}
> +
> +	cf->can_id |=3D CAN_ERR_CRTL;
> +	cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +	netif_rx(skb);
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +}
> +
> +static void handle_core_msg_buserr(struct acc_core *core,
> +				   const struct acc_bmmsg_buserr *msg)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	priv->can.can_stats.bus_error++;
> +	stats->rx_errors++;
> +
> +	skb =3D alloc_can_err_skb(core->net_dev, &cf);
> +	if (!skb)
> +		return;
> +
> +	cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +	/* msg->ecc acts like SJA1000's ECC register */
> +	switch (msg->ecc & ACC_ECC_MASK) {
> +	case ACC_ECC_BIT:
> +		cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +		break;
> +	case ACC_ECC_FORM:
> +		cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +		break;
> +	case ACC_ECC_STUFF:
> +		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +		break;
> +	default:
> +		cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
> +		cf->data[3] =3D msg->ecc & ACC_ECC_SEG;
> +		break;
> +	}
> +
> +	if ((msg->ecc & ACC_ECC_DIR) =3D=3D 0)
> +		cf->data[2] |=3D CAN_ERR_PROT_TX;
> +
> +	netif_rx(skb);
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;

the skb is't valid anymore after netif_rx()
> +}
> +
> +static void
> +handle_core_msg_errstatechange(struct acc_core *core,
> +			       const struct acc_bmmsg_errstatechange *msg)
> +{
> +	struct acc_net_priv *priv =3D netdev_priv(core->net_dev);
> +	struct net_device_stats *stats =3D &core->net_dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	int is_busoff;
> +	int is_passive;
> +	int is_warning;
> +	u8 txerr;
> +	u8 rxerr;
> +
> +	txerr =3D (u8)(msg->reg_status >> 8);
> +	rxerr =3D (u8)msg->reg_status;
> +	is_warning =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_ES) !=3D=
 0;
> +	is_passive =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_EP) !=3D=
 0;
> +	is_busoff =3D (msg->reg_status & ACC_REG_STATUS_MASK_STATUS_BS) !=3D =
0;
> +
> +	skb =3D alloc_can_err_skb(core->net_dev, &cf);
> +	if (skb) {
> +		if (is_busoff) {
> +			priv->can.state =3D CAN_STATE_BUS_OFF;
> +			/* bus-offs counted by can_bus_off() */
> +			cf->can_id |=3D CAN_ERR_BUSOFF;
> +		} else if (is_passive) {
> +			priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
> +			priv->can.can_stats.error_passive++;
> +			cf->data[1] =3D (txerr > rxerr) ?
> +					CAN_ERR_CRTL_TX_PASSIVE :
> +					CAN_ERR_CRTL_RX_PASSIVE;
> +			cf->can_id |=3D CAN_ERR_CRTL;
> +			cf->data[6] =3D txerr;
> +			cf->data[7] =3D rxerr;
> +		} else if (is_warning) {
> +			priv->can.state =3D CAN_STATE_ERROR_WARNING;
> +			priv->can.can_stats.error_warning++;
> +			cf->data[1] =3D (txerr > rxerr) ?
> +					CAN_ERR_CRTL_TX_WARNING :
> +					CAN_ERR_CRTL_RX_WARNING;
> +			cf->can_id |=3D CAN_ERR_CRTL;
> +			cf->data[6] =3D txerr;
> +			cf->data[7] =3D rxerr;
> +		} else {
> +			priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +			/* restarts counted in dev.c */
> +		}
> +
> +		netif_rx(skb);
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
same here
> +	}
> +
> +	if (is_busoff) {
> +		acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> +		can_bus_off(core->net_dev);
> +	}
> +}
> +
> +static void handle_core_interrupt(struct acc_core *core)
> +{
> +	u32 msg_fifo_head =3D core->bmfifo.local_irq_cnt & 0xff;
> +
> +	while (core->bmfifo.msg_fifo_tail !=3D msg_fifo_head) {
> +		const struct acc_bmmsg *msg =3D
> +			&core->bmfifo.messages[core->bmfifo.msg_fifo_tail];
> +
> +		switch (msg->u.msg_id) {
> +		case BM_MSG_ID_RXTXDONE:
> +			handle_core_msg_rxtxdone(core, &msg->u.rxtxdone);
> +			break;
> +
> +		case BM_MSG_ID_TXABORT:
> +			handle_core_msg_txabort(core, &msg->u.txabort);
> +			break;
> +
> +		case BM_MSG_ID_OVERRUN:
> +			handle_core_msg_overrun(core, &msg->u.overrun);
> +			break;
> +
> +		case BM_MSG_ID_BUSERR:
> +			handle_core_msg_buserr(core, &msg->u.buserr);
> +			break;
> +
> +		case BM_MSG_ID_ERRPASSIVE:
> +		case BM_MSG_ID_ERRWARN:
> +			handle_core_msg_errstatechange(core,
> +						       &msg->u.errstatechange);
> +			break;
> +
> +		default:
> +			break;
> +		}
> +
> +		core->bmfifo.msg_fifo_tail =3D
> +				(core->bmfifo.msg_fifo_tail + 1) & 0xff;
> +	}
> +}
> +
> +irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *cor=
es)
> +{
> +	u32 irqmask;
> +	int i;
> +
> +	/* First we look for whom interrupts are pending, card/overview
> +	 * or any of the cores. Two bits in irqmask are used for each;
> +	 * set to BM_IRQ_MASK then:
> +	 */
> +	irqmask =3D 0;
> +	if (*ov->bmfifo.irq_cnt !=3D ov->bmfifo.local_irq_cnt) {
> +		irqmask |=3D ACC_BM_IRQ_MASK;
> +		ov->bmfifo.local_irq_cnt =3D *ov->bmfifo.irq_cnt;
> +	}
> +
> +	for (i =3D 0; i < ov->active_cores; ++i) {
> +		struct acc_core *core =3D &cores[i];
> +
> +		if (*core->bmfifo.irq_cnt !=3D core->bmfifo.local_irq_cnt) {
> +			irqmask |=3D (ACC_BM_IRQ_MASK << (2 * (i + 1)));
> +			core->bmfifo.local_irq_cnt =3D *core->bmfifo.irq_cnt;
> +		}
> +	}
> +
> +	if (!irqmask)
> +		return IRQ_NONE;
> +
> +	/* At second we tell the card we're working on them by writing irqmas=
k,
> +	 * call handle_{ov|core}_interrupt and then acknowledge the
> +	 * interrupts by writing irq_cnt:
> +	 */
> +	acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, irqmask);
> +
> +	if (irqmask & ACC_BM_IRQ_MASK) {
> +		/* handle_ov_interrupt(); - no use yet. */
> +		acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_COUNTER,
> +			       ov->bmfifo.local_irq_cnt);
> +	}
> +
> +	for (i =3D 0; i < ov->active_cores; ++i) {
> +		struct acc_core *core =3D &cores[i];
> +
> +		if (irqmask & (ACC_BM_IRQ_MASK << (2 * (i + 1)))) {
> +			handle_core_interrupt(core);
> +			acc_write32(core, ACC_OV_OF_BM_IRQ_COUNTER,
> +				    core->bmfifo.local_irq_cnt);
> +		}
> +	}
> +
> +	acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, ACC_BM_IRQ_UNMASK_ALL);
> +
> +	return IRQ_HANDLED;
> +}
> diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.=
h
> new file mode 100644
> index 0000000..97d0d3b
> --- /dev/null
> +++ b/drivers/net/can/esd/esdacc.h
> @@ -0,0 +1,428 @@
> +/* Copyright (C) 2015 esd electronic system design gmbh
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/can/dev.h>
> +
> +#define ACC_CAN_EFF_FLAG			0x20000000
> +#define ACC_CAN_RTR_FLAG			0x10
> +#define ACC_CAN_DLC_MASK			0x0f
> +
> +#define ACC_OV_OF_PROBE				0x0000
> +#define ACC_OV_OF_VERSION			0x0004
> +#define ACC_OV_OF_INFO				0x0008
> +#define ACC_OV_OF_CANCORE_FREQ			0x000c
> +#define ACC_OV_OF_TS_FREQ_LO			0x0010
> +#define ACC_OV_OF_TS_FREQ_HI			0x0014
> +#define ACC_OV_OF_IRQ_STATUS_CORES		0x0018
> +#define ACC_OV_OF_TS_CURR_LO			0x001c
> +#define ACC_OV_OF_TS_CURR_HI			0x0020
> +#define ACC_OV_OF_IRQ_STATUS			0x0028
> +#define ACC_OV_OF_MODE				0x002c
> +#define ACC_OV_OF_BM_IRQ_COUNTER		0x0070
> +#define ACC_OV_OF_BM_IRQ_MASK			0x0074
> +#define ACC_OV_OF_MSI_DATA			0x0080
> +#define ACC_OV_OF_MSI_ADDRESSOFFSET		0x0084
> +
> +#define ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE	0x00000001
> +#define ACC_OV_REG_MODE_MASK_BM_ENABLE		0x00000002
> +#define ACC_OV_REG_MODE_MASK_MODE_LED		0x00000004
> +#define ACC_OV_REG_MODE_MASK_TIMER		0x00000070
> +#define ACC_OV_REG_MODE_MASK_TIMER_ENABLE	0x00000010
> +#define ACC_OV_REG_MODE_MASK_TIMER_ONE_SHOT	0x00000020
> +#define ACC_OV_REG_MODE_MASK_TIMER_ABSOLUTE	0x00000040
> +#define ACC_OV_REG_MODE_MASK_TS_SRC		0x00000180
> +#define ACC_OV_REG_MODE_MASK_I2C_ENABLE		0x00000800
> +#define ACC_OV_REG_MODE_MASK_MSI_ENABLE		0x00004000
> +#define ACC_OV_REG_MODE_MASK_FPGA_RESET		0x80000000
> +
> +#define ACC_BM_IRQ_UNMASK_ALL			0x55555555
> +#define ACC_BM_IRQ_MASK_ALL			0xaaaaaaaa
> +#define ACC_BM_IRQ_MASK				0x2
> +#define ACC_BM_IRQ_UNMASK			0x1
> +#define ACC_BM_LENFLAG_TX			0x20
> +
> +#define ACC_CORE_OF_CTRL_MODE			0x0000
> +#define ACC_CORE_OF_STATUS_IRQ			0x0008
> +#define ACC_CORE_OF_BTR				0x000c
> +#define ACC_CORE_OF_BTR_FD			0x0010
> +#define ACC_CORE_OF_BTR_FDF			0x0014
> +#define ACC_CORE_OF_STATUS			0x0030
> +#define ACC_CORE_OF_TXFIFO_CONFIG		0x0048
> +#define ACC_CORE_OF_TXFIFO_STATUS		0x004c
> +#define ACC_CORE_OF_TX_STATUS_IRQ		0x0050
> +#define ACC_CORE_OF_TX_ABORT_MASK		0x0054
> +#define ACC_CORE_OF_BM_IRQ_COUNTER		0x0070
> +#define ACC_CORE_OF_TXFIFO_ID			0x00c0
> +#define ACC_CORE_OF_TXFIFO_DLC			0x00c4
> +#define ACC_CORE_OF_TXFIFO_DATA_0		0x00c8
> +#define ACC_CORE_OF_TXFIFO_DATA_1		0x00cc
> +
> +/* ecc value of esdACC equals SJA1000's ECC register */
> +#define ACC_ECC_SEG				0x1f
> +#define ACC_ECC_DIR				0x20
> +#define ACC_ECC_BIT				0x00
> +#define ACC_ECC_FORM				0x40
> +#define ACC_ECC_STUFF				0x80
> +#define ACC_ECC_MASK				0xc0
> +
> +#define ACC_REG_CONTROL_IDX_MODE_RESETMODE	0
> +#define ACC_REG_CONTROL_IDX_MODE_LOM		1
> +#define ACC_REG_CONTROL_IDX_MODE_STM		2
> +#define ACC_REG_CONTROL_IDX_MODE_TRANSEN	5
> +#define ACC_REG_CONTROL_IDX_MODE_TS		6
> +#define ACC_REG_CONTROL_IDX_MODE_SCHEDULE	7
> +#define ACC_REG_CONTROL_MASK_MODE_RESETMODE	\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_RESETMODE)
> +#define ACC_REG_CONTROL_MASK_MODE_LOM		\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_LOM)
> +#define ACC_REG_CONTROL_MASK_MODE_STM		\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_STM)
> +#define ACC_REG_CONTROL_MASK_MODE_TRANSEN	\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_TRANSEN)
> +#define ACC_REG_CONTROL_MASK_MODE_TS		\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_TS)
> +#define ACC_REG_CONTROL_MASK_MODE_SCHEDULE	\
> +				BIT(ACC_REG_CONTROL_IDX_MODE_SCHEDULE)
> +
> +#define ACC_REG_CONTROL_IDX_IE_RXTX	8
> +#define ACC_REG_CONTROL_IDX_IE_TXERROR	9
> +#define ACC_REG_CONTROL_IDX_IE_ERROR	10
> +#define ACC_REG_CONTROL_IDX_IE_OVERRUN	11
> +#define ACC_REG_CONTROL_IDX_IE_TSI	12
> +#define ACC_REG_CONTROL_IDX_IE_ERRPASS	13
> +#define ACC_REG_CONTROL_IDX_IE_BUSERR	15
> +#define ACC_REG_CONTROL_MASK_IE_RXTX	BIT(ACC_REG_CONTROL_IDX_IE_RXTX)
> +#define ACC_REG_CONTROL_MASK_IE_TXERROR	BIT(ACC_REG_CONTROL_IDX_IE_TXE=
RROR)
> +#define ACC_REG_CONTROL_MASK_IE_ERROR	BIT(ACC_REG_CONTROL_IDX_IE_ERROR=
)
> +#define ACC_REG_CONTROL_MASK_IE_OVERRUN	BIT(ACC_REG_CONTROL_IDX_IE_OVE=
RRUN)
> +#define ACC_REG_CONTROL_MASK_IE_TSI	BIT(ACC_REG_CONTROL_IDX_IE_TSI)
> +#define ACC_REG_CONTROL_MASK_IE_ERRPASS	BIT(ACC_REG_CONTROL_IDX_IE_ERR=
PASS)
> +#define ACC_REG_CONTROL_MASK_IE_BUSERR	BIT(ACC_REG_CONTROL_IDX_IE_BUSE=
RR)
> +
> +#define ACC_REG_STATUS_IDX_STATUS_DOS	16
> +#define ACC_REG_STATUS_IDX_STATUS_ES	17
> +#define ACC_REG_STATUS_IDX_STATUS_EP	18
> +#define ACC_REG_STATUS_IDX_STATUS_BS	19
> +#define ACC_REG_STATUS_IDX_STATUS_RBS	20
> +#define ACC_REG_STATUS_IDX_STATUS_RS	21
> +#define ACC_REG_STATUS_MASK_STATUS_DOS	BIT(ACC_REG_STATUS_IDX_STATUS_D=
OS)
> +#define ACC_REG_STATUS_MASK_STATUS_ES	BIT(ACC_REG_STATUS_IDX_STATUS_ES=
)
> +#define ACC_REG_STATUS_MASK_STATUS_EP	BIT(ACC_REG_STATUS_IDX_STATUS_EP=
)
> +#define ACC_REG_STATUS_MASK_STATUS_BS	BIT(ACC_REG_STATUS_IDX_STATUS_BS=
)
> +#define ACC_REG_STATUS_MASK_STATUS_RBS	BIT(ACC_REG_STATUS_IDX_STATUS_R=
BS)
> +#define ACC_REG_STATUS_MASK_STATUS_RS	BIT(ACC_REG_STATUS_IDX_STATUS_RS=
)
> +
> +#define ACC_CORE_DMABUF_SIZE		(256 * 32) /* 256 messages */
> +
> +enum acc_bmmsg_id {
> +	BM_MSG_ID_RXTXDONE =3D 0x01,
> +	BM_MSG_ID_TXABORT =3D 0x02,
> +	BM_MSG_ID_OVERRUN =3D 0x03,
> +	BM_MSG_ID_BUSERR =3D 0x04,
> +	BM_MSG_ID_ERRPASSIVE =3D 0x05,
> +	BM_MSG_ID_ERRWARN =3D 0x06,
> +	BM_MSG_ID_TIMESLICE =3D 0x07,
> +	BM_MSG_ID_HWTIMER =3D 0x08,
> +	BM_MSG_ID_HOTPLUG =3D 0x09,
> +	BM_MSG_ID_CANFDDATA0 =3D 0x0a,
> +	BM_MSG_ID_CANFDDATA1 =3D 0x0b
> +};
> +
> +struct acc_bmmsg_rxtxdone {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u8 reserved1[2];
> +	u8 txtsfifo_level;
> +	u8 reserved2[3];
> +	u32 id;
> +	union {
> +		struct {
> +			u8 len;
> +			u8 reserved0;
> +			u8 bits;
> +			u8 state;
> +		} rxtx;
> +		struct {
> +			u8 len;
> +			u8 msg_lost;
> +			u8 bits;
> +			u8 state;
> +		} rx;
> +		struct {
> +			u8 len;
> +			u8 txfifo_idx;
> +			u8 bits;
> +			u8 state;
> +		} tx;
> +	} dlc;
> +	u8 data[8];
> +	u64 timestamp;
> +} __packed;
> +
> +struct acc_bmmsg_txabort {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u16 abort_mask;
> +	u8 txtsfifo_level;
> +	u8 reserved2[1];
> +	u16 abort_mask_txts;
> +	u64 ts;
> +	u32 reserved3[4];
> +} __packed;
> +
> +struct acc_bmmsg_overrun {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u8 lost_cnt;
> +	u8 reserved1;
> +	u8 txtsfifo_level;
> +	u8 reserved2[3];
> +	u64 ts;
> +	u32 reserved3[4];
> +} __packed;
> +
> +struct acc_bmmsg_buserr {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u8 ecc;
> +	u8 reserved1;
> +	u8 txtsfifo_level;
> +	u8 reserved2[3];
> +	u64 ts;
> +	u32 reg_status;
> +	u32 reg_btr;
> +	u32 reserved3[2];
> +} __packed;
> +
> +struct acc_bmmsg_errstatechange {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u8 reserved1[2];
> +	u8 txtsfifo_level;
> +	u8 reserved2[3];
> +	u64 ts;
> +	u32 reg_status;
> +	u32 reserved3[3];
> +} __packed;
> +
> +struct acc_bmmsg_timeslice {
> +	u8 msg_id;
> +	u8 txfifo_level;
> +	u8 reserved1[2];
> +	u8 txtsfifo_level;
> +	u8 reserved2[3];
> +	u64 ts;
> +	u32 reserved3[4];
> +} __packed;
> +
> +struct acc_bmmsg_hwtimer {
> +	u8 msg_id;
> +	u8 reserved1[3];
> +	u32 reserved2[1];
> +	u64 timer;
> +	u32 reserved3[4];
> +} __packed;
> +
> +struct acc_bmmsg_hotplug {
> +	u8 msg_id;
> +	u8 reserved1[3];
> +	u32 reserved2[7];
> +} __packed;
> +
> +struct acc_bmmsg_canfddata {
> +	u8 msg_id;
> +	u8 reserved1[3];
> +	union {
> +		u8 ui8[28];
> +		u32 ui32[7];
> +	} d;
> +} __packed;
> +
> +struct acc_bmmsg {
> +	union {
> +		u8 msg_id;
> +		struct acc_bmmsg_rxtxdone rxtxdone;
> +		struct acc_bmmsg_canfddata canfddata;
> +		struct acc_bmmsg_txabort txabort;
> +		struct acc_bmmsg_overrun overrun;
> +		struct acc_bmmsg_buserr buserr;
> +		struct acc_bmmsg_errstatechange errstatechange;
> +		struct acc_bmmsg_timeslice timeslice;
> +		struct acc_bmmsg_hwtimer hwtimer;
> +	} u;
> +};
> +
> +struct acc_bmfifo {
> +	const struct acc_bmmsg *messages;
> +	/* Bits0..7: bm_fifo head index */
> +	const u32 *irq_cnt;
> +	u32 local_irq_cnt;
> +	u32 msg_fifo_tail;
> +};
> +
> +struct acc_core {
> +	void __iomem *addr;
> +	struct net_device *net_dev;
> +	struct acc_bmfifo bmfifo;
> +	u8 tx_fifo_size;
> +	u8 tx_fifo_head;
> +	u8 tx_fifo_tail;
> +};
> +
> +struct acc_ov {
> +	void __iomem *addr;
> +	struct acc_bmfifo bmfifo;
> +	u32 timestamp_frequency;
> +	u32 core_frequency;
> +	u16 version;
> +	u16 features;
> +	u8 total_cores;
> +	u8 active_cores;
> +	bool deprecated_btr;
> +};
> +
> +struct acc_net_priv {
> +	struct can_priv can; /* must be the first member! */
> +	struct acc_core *core;
> +	struct acc_ov *ov;
> +};
> +
> +static inline u32 acc_read32(struct acc_core *core, unsigned short off=
s)
> +{
> +	return ioread32be(core->addr + offs);
> +}
> +
> +static inline void acc_write32(struct acc_core *core,
> +			       unsigned short offs, u32 v)
> +{
> +	iowrite32be(v, core->addr + offs);
> +}
> +
> +static inline void acc_write32_noswap(struct acc_core *core,
> +				      unsigned short offs, u32 v)
> +{
> +	iowrite32(v, core->addr + offs);
> +}
> +
> +static inline void acc_set_bits(struct acc_core *core,
> +				unsigned short offs, u32 mask)
> +{
> +	u32 v =3D acc_read32(core, offs);
> +
> +	v |=3D mask;
> +	acc_write32(core, offs, v);
> +}
> +
> +static inline void acc_clear_bits(struct acc_core *core,
> +				  unsigned short offs, u32 mask)
> +{
> +	u32 v =3D acc_read32(core, offs);
> +
> +	v &=3D ~mask;
> +	acc_write32(core, offs, v);
> +}
> +
> +static inline int acc_resetmode_entered(struct acc_core *core)
> +{
> +	u32 ctrl =3D acc_read32(core, ACC_CORE_OF_CTRL_MODE);
> +
> +	return (ctrl & ACC_REG_CONTROL_MASK_MODE_RESETMODE) !=3D 0;
> +}
> +
> +static inline u32 acc_ov_read32(struct acc_ov *ov, unsigned short offs=
)
> +{
> +	return ioread32be(ov->addr + offs);
> +}
> +
> +static inline void acc_ov_write32(struct acc_ov *ov,
> +				  unsigned short offs, u32 v)
> +{
> +	iowrite32be(v, ov->addr + offs);
> +}
> +
> +static inline void acc_ov_set_bits(struct acc_ov *ov,
> +				   unsigned short offs, u32 b)
> +{
> +	u32 v =3D acc_ov_read32(ov, offs);
> +
> +	v |=3D b;
> +	acc_ov_write32(ov, offs, v);
> +}
> +
> +static inline void acc_ov_clear_bits(struct acc_ov *ov,
> +				     unsigned short offs, u32 b)
> +{
> +	u32 v =3D acc_ov_read32(ov, offs);
> +
> +	v &=3D ~b;
> +	acc_ov_write32(ov, offs, v);
> +}
> +
> +static inline void acc_reset_fpga(struct acc_ov *ov)
> +{
> +	acc_ov_write32(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_FPGA_RESET);
> +
> +	/* Also reset I=C2=B2C, to re-detect card addons at every driver star=
t: */
> +	acc_ov_clear_bits(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_I2C_ENABLE=
);
> +	mdelay(2);
> +	acc_ov_set_bits(ov, ACC_OV_OF_MODE, ACC_OV_REG_MODE_MASK_I2C_ENABLE);=

> +	mdelay(10);
> +}
> +
> +void acc_init_ov(struct acc_ov *ov, struct device *dev);
> +void acc_init_bm_ptr(struct acc_ov *ov, struct acc_core *cores,
> +		     const void *mem);
> +int acc_open(struct net_device *netdev);
> +int acc_close(struct net_device *netdev);
> +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *net=
dev);
> +int acc_get_berr_counter(const struct net_device *netdev,
> +			 struct can_berr_counter *bec);
> +int acc_set_mode(struct net_device *netdev, enum can_mode mode);
> +int acc_set_bittiming(struct net_device *netdev);
> +irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *cor=
es);
> +
> +/* Used in PCIe/402 cards with FPGA Version < 0x0032 */
> +static const struct can_bittiming_const acc_bittiming_const_pci402_old=
 =3D {
> +	.name =3D "pci402_old",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 1,
> +	.brp_max =3D 256,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const acc_bittiming_const_pci402 =3D=
 {
> +	.name =3D "pci402",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 256,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct net_device_ops acc_netdev_ops =3D {
> +	.ndo_open =3D acc_open,
> +	.ndo_stop =3D acc_close,
> +	.ndo_start_xmit =3D acc_start_xmit,
> +	.ndo_change_mtu =3D can_change_mtu
> +};
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--oaCra4jLQiBUIS4h54tEpaTiFgAcBTMNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVCJxjAAoJECte4hHFiupUkw8P/249zoHR3dmCDewrVrhB1Z0Z
hwNwiL2YWcKHJ5hT/qIVP/CuCnfeU+80oxOVz3UdSnQmhGQxrJkx3CUk4Mk0YcVA
EHRvRC+r9H4B4iovd9vlHizsWETizGXJ7rdBIL7bgShtgWe5+UHNO5cl3TOOlNUN
rCSP2yr+K5BDSRbZBPzJjvmM92S8mkbZs6b0QjC6cUV9yL+tp6mm3t7AdFhhTlnE
cAmVkDg8Bz93489zwAnj51HbiKENvy9kYLxlP9sO+5fJqXyRf6kq/OvkgJ8Zp/lg
NACOCZQFdcmOVf+b4gxiRjfTpn7ABD2fTrP/fNZx+OerGgoq8jwfcRQxIIRHacbH
a9IcY93gw15S7dKcWC+jdtrQKDrqj0V883Comqr2Cin5RC5VN2qAQRWvFQDbMfUg
7Kw59G01tfZcJfKg3x4rGaSfanYQbj3KCDpoM8u5AKhToWd0/PYMTp8ECr3WBOXG
jBT1L2Nb906uY+1s/d1SLxf/Zq+NJCkJZ2pzIrtEKv3kNZHDeGJuFML0oKYVFxYE
f4cYV9UEU7oyRzxAWue6kVcioNNXt2p0HTS+LIn5Ohiffyon1vKulkFfKHuJk2XQ
xhQBOXkUHoZlj7tKG1h7ynVB48V2hgOmdaT/PE9DMf4GhNb/rAKmf6XOu4t3tNC4
6RROBTeuyEujVQ1a1hrC
=/aXC
-----END PGP SIGNATURE-----

--oaCra4jLQiBUIS4h54tEpaTiFgAcBTMNP--

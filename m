From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Allwinner SoC CAN controller Support
Date: Tue, 8 Sep 2015 12:51:48 +0200
Message-ID: <55EEBDC4.8050800@pengutronix.de>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fRbxIn1CVb3x6j0wgeS9rnEbkmmpVKHOi"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59825 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbbIHKv5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 06:51:57 -0400
In-Reply-To: <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fRbxIn1CVb3x6j0wgeS9rnEbkmmpVKHOi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 12:09 PM, Gerhard Bertelsmann wrote:
> Second try:
>  Allwinner A10/A20 CAN Controller support
>=20
>=20
> Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
> Tested-by; Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
>=20
>=20
>  drivers/net/can/Kconfig                            |  10 +
>  drivers/net/can/Makefile                           |   1 +
>  drivers/net/can/sunxi_can.c                        | 832 +++++++++++++=
++++++++
>  3 files changed, 843 insertions(+)
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index e8c96b8..29b62e6 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -129,6 +129,16 @@ config CAN_RCAR
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called rcar_can.
> =20
> +config CAN_SUNXI
> +	tristate "Allwinner SUNXI CAN controller"
> +	depends on MACH_SUN4I || MACH_SUN7I
> +	---help---
> +	  Say Y here if you want to use CAN controller found on Allwinner
> +	  A10/A20 SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called sunxi_can.
> +
>  config CAN_XILINXCAN
>  	tristate "Xilinx CAN"
>  	depends on ARCH_ZYNQ || ARM64 || MICROBLAZE || COMPILE_TEST
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index c533c62..b3e825c 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_CAN_FLEXCAN)	+=3D flexcan.o
>  obj-$(CONFIG_PCH_CAN)		+=3D pch_can.o
>  obj-$(CONFIG_CAN_GRCAN)		+=3D grcan.o
>  obj-$(CONFIG_CAN_RCAR)		+=3D rcar_can.o
> +obj-$(CONFIG_CAN_SUNXI)		+=3D sunxi_can.o
>  obj-$(CONFIG_CAN_XILINXCAN)	+=3D xilinx_can.o
> =20
>  subdir-ccflags-y +=3D -D__CHECK_ENDIAN__
> diff --git a/drivers/net/can/sunxi_can.c b/drivers/net/can/sunxi_can.c
> new file mode 100644
> index 0000000..6e3a5e5
> --- /dev/null
> +++ b/drivers/net/can/sunxi_can.c
> @@ -0,0 +1,832 @@
> +/*
> + * sunxi_can.c - CAN bus controller driver for Allwinner SUN4I&SUN7I b=
ased SoCs
> + *
> + * Copyright (C) 2013 Peter Chen
> + * Copyright (C) 2015 Gerhard Bertelsmann
> + *
> + * Parts of this software are based on (derived from) the SJA1000 code=
 by:
> + *   Copyright (C) 2014 Oliver Hartkopp <oliver.hartkopp@volkswagen.de=
>
> + *   Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
> + *   Copyright (C) 2002-2007 Volkswagen Group Electronic Research
> + *   Copyright (C) 2003 Matthias Brukner, Trajet Gmbh, Rebenring 33,
> + *   38106 Braunschweig, GERMANY
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
> + *
> + */
> +
> +#include <linux/netdevice.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/can/led.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define DRV_NAME "sunxi_can"
> +#define DRV_MODULE_VERSION "0.94"

Where does the version come from? Are you planing to make use of this?

> +
> +/* Registers address */

Please prefix _all_ your defines with a common prefix, e.g. SUNXI_

> +#define CAN_BASE0		0x01C2BC00

Please remove that define, the base address comes from the DT now.

> +#define CAN_MSEL_ADDR		0x0000	/* CAN Mode Select */
> +#define CAN_CMD_ADDR            0x0004	/* CAN Command */
> +#define CAN_STA_ADDR		0x0008	/* CAN Status */
> +#define CAN_INT_ADDR		0x000c	/* CAN Interrupt Flag */
> +#define CAN_INTEN_ADDR		0x0010	/* CAN Interrupt Enable */
> +#define CAN_BTIME_ADDR		0x0014	/* CAN Bus Timing 0 */
> +#define CAN_TEWL_ADDR		0x0018	/* CAN Tx Error Warning Limit */
> +#define CAN_ERRC_ADDR		0x001c	/* CAN Error Counter */
> +#define CAN_RMCNT_ADDR		0x0020	/* CAN Receive Message Counter */
> +#define CAN_RBUFSA_ADDR		0x0024	/* CAN Receive Buffer Start Address */=

> +#define CAN_BUF0_ADDR		0x0040	/* CAN Tx/Rx Buffer 0 */
> +#define CAN_BUF1_ADDR		0x0044	/* CAN Tx/Rx Buffer 1 */
> +#define CAN_BUF2_ADDR		0x0048	/* CAN Tx/Rx Buffer 2 */
> +#define CAN_BUF3_ADDR		0x004c	/* CAN Tx/Rx Buffer 3 */
> +#define CAN_BUF4_ADDR		0x0050	/* CAN Tx/Rx Buffer 4 */
> +#define CAN_BUF5_ADDR		0x0054	/* CAN Tx/Rx Buffer 5 */
> +#define CAN_BUF6_ADDR		0x0058	/* CAN Tx/Rx Buffer 6 */
> +#define CAN_BUF7_ADDR		0x005c	/* CAN Tx/Rx Buffer 7 */
> +#define CAN_BUF8_ADDR		0x0060	/* CAN Tx/Rx Buffer 8 */
> +#define CAN_BUF9_ADDR		0x0064	/* CAN Tx/Rx Buffer 9 */
> +#define CAN_BUF10_ADDR		0x0068	/* CAN Tx/Rx Buffer 10 */
> +#define CAN_BUF11_ADDR		0x006c	/* CAN Tx/Rx Buffer 11 */
> +#define CAN_BUF12_ADDR		0x0070	/* CAN Tx/Rx Buffer 12 */
> +#define CAN_ACPC_ADDR		0x0040	/* CAN Acceptance Code 0 */
> +#define CAN_ACPM_ADDR		0x0044	/* CAN Acceptance Mask 0 */
> +#define CAN_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer start =
*/
> +#define CAN_RBUF_RBACK_END_ADDR		0x01b0	/* CAN transmit buffer end */

Please rename the defines like this:
SUNXI_REG_ACPC, SUNXI_REG_ACPM

> +
> +/* Controller Register Description */
> +
> +/* mode select register (r/w)
> + * offset:0x0000 default:0x0000_0001
> + */
> +#define SLEEP_MODE		(0x01 << 4)	/* write in reset mode */
> +#define WAKE_UP			(0x00 << 4)
> +#define SINGLE_FILTER		(0x01 << 3)	/* write in reset mode */
> +#define DUAL_FILTERS		(0x00 << 3)
> +#define LOOPBACK_MODE		BIT(2)
> +#define LISTEN_ONLY_MODE	BIT(1)
> +#define RESET_MODE		BIT(0)

For these something like: SUNXI_MSEL_SLEEP_MODE, SUNXI_MSEL_WAKE_UP
makes sense.

> +
> +/* command register (w)
> + * offset:0x0004 default:0x0000_0000
> + */
> +#define BUS_OFF_REQ		BIT(5)
> +#define SELF_RCV_REQ		BIT(4)
> +#define CLEAR_OR_FLAG		BIT(3)
> +#define RELEASE_RBUF		BIT(2)
> +#define ABORT_REQ		BIT(1)
> +#define TRANS_REQ		BIT(0)

use here SUNXI_CMD_ as prefix

> +
> +/* status register (r)
> + * offset:0x0008 default:0x0000_003c
> + */
> +#define BIT_ERR			(0x00 << 22)
> +#define FORM_ERR		(0x01 << 22)
> +#define STUFF_ERR		(0x02 << 22)
> +#define OTHER_ERR		(0x03 << 22)
> +#define ERR_DIR			BIT(21)
> +#define ERR_SEG_CODE		(0x1f << 16)
> +#define START			(0x03 << 16)
> +#define ID28_21			(0x02 << 16)
> +#define ID20_18			(0x06 << 16)
> +#define SRTR			(0x04 << 16)
> +#define IDE			(0x05 << 16)
> +#define ID17_13			(0x07 << 16)
> +#define ID12_5			(0x0f << 16)
> +#define ID4_0			(0x0e << 16)
> +#define RTR			(0x0c << 16)
> +#define RB1			(0x0d << 16)
> +#define RB0			(0x09 << 16)
> +#define DLEN			(0x0b << 16)
> +#define DATA_FIELD		(0x0a << 16)
> +#define CRC_SEQUENCE		(0x08 << 16)
> +#define CRC_DELIMITER		(0x18 << 16)
> +#define ACK			(0x19 << 16)
> +#define ACK_DELIMITER		(0x1b << 16)
> +#define END			(0x1a << 16)
> +#define INTERMISSION		(0x12 << 16)
> +#define ACTIVE_ERROR		(0x11 << 16)
> +#define PASSIVE_ERROR		(0x16 << 16)
> +#define TOLERATE_DOMINANT_BITS	(0x13 << 16)
> +#define ERROR_DELIMITER		(0x17 << 16)
> +#define OVERLOAD		(0x1c << 16)
> +#define BUS_OFF			BIT(7)
> +#define ERR_STA			BIT(6)
> +#define TRANS_BUSY		BIT(5)
> +#define RCV_BUSY		BIT(4)
> +#define TRANS_OVER		BIT(3)
> +#define TBUF_RDY		BIT(2)
> +#define DATA_ORUN		BIT(1)
> +#define RBUF_RDY		BIT(0)

SUNXI_STA_
> +
> +/* interrupt register (r)
> + * offset:0x000c default:0x0000_0000
> + */
> +#define BUS_ERR			BIT(7)
> +#define ARB_LOST		BIT(6)
> +#define ERR_PASSIVE		BIT(5)
> +#define WAKEUP			BIT(4)
> +#define DATA_OR			BIT(3)
> +#define ERR_WRN			BIT(2)
> +#define TBUF_VLD		BIT(1)
> +#define RBUF_VLD		BIT(0)

SUNXI_INT_
> +
> +/* interrupt enable register (r/w)
> + * offset:0x0010 default:0x0000_0000
> + */
> +#define BERR_IRQ_EN		BIT(7)
> +#define ARB_LOST_IRQ_EN		BIT(6)
> +#define ERR_PASSIVE_IRQ_EN	BIT(5)
> +#define WAKEUP_IRQ_EN		BIT(4)
> +#define OR_IRQ_EN		BIT(3)
> +#define ERR_WRN_IRQ_EN		BIT(2)
> +#define TX_IRQ_EN		BIT(1)
> +#define RX_IRQ_EN		BIT(0)

SUNXI_INTENT_
> +
> +/* error code */
> +#define ERR_INRCV		(0x1 << 5)
> +#define ERR_INTRANS		(0x0 << 5)
> +
> +/* filter mode */
> +#define FILTER_CLOSE		0
> +#define SINGLE_FLTER_MODE	1
> +#define DUAL_FILTER_MODE	2
> +
> +/* max. number of interrupts handled in ISR */
> +#define SUNXI_CAN_MAX_IRQ	20
> +
> +struct sunxican_priv {
> +	struct can_priv can;
> +	struct sk_buff *echo_skb;

not used

> +	void __iomem *base;
> +	struct clk *clk;
> +	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */=

> +};
> +
> +static const struct can_bittiming_const sunxican_bittiming_const =3D {=

> +	.name =3D DRV_NAME,
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 1,
> +	.brp_max =3D 64,
> +	.brp_inc =3D 1,
> +};
> +
> +static void sunxi_can_write_cmdreg(struct sunxican_priv *priv, u8 val)=

> +{
> +	unsigned long flags;
> +
> +	 /* The command register needs some locking and time to settle
> +	  * the write_reg() operation - especially on SMP systems.
> +	  */

Is this needed with your SJA1000 alike IP core?

> +	spin_lock_irqsave(&priv->cmdreg_lock, flags);
> +	writel(val, priv->base + CAN_CMD_ADDR);
> +	readl(priv->base + CAN_STA_ADDR);
> +	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
> +}
> +
> +static void set_normal_mode(struct net_device *dev)

What about making this function an int and return an error value in case
of an error?

> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	u8 status =3D readl(priv->base + CAN_MSEL_ADDR);
> +	int i;
> +
> +	for (i =3D 0; i < 100; i++) {
> +		/* check reset bit */
> +		if ((status & RESET_MODE) =3D=3D 0) {
> +			priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +			/* enable interrupts */
> +			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
> +				writel(0xFFFF, priv->base + CAN_INTEN_ADDR);
> +			} else {
> +				writel(0xFFFF & ~BERR_IRQ_EN,
> +				       priv->base + CAN_INTEN_ADDR);
> +			}
> +
> +			if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +				/* Put device into loopback mode */

That's not loopback mode according to socketcan, that's
CAN_CTRLMODE_PRESUME_ACK.

> +				writel(readl(priv->base + CAN_MSEL_ADDR) |
> +				       LOOPBACK_MODE,
> +				       priv->base + CAN_MSEL_ADDR);
> +			} else if
> +				(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
> +				/* Put device into listen-only mode */
> +				writel(readl(priv->base + CAN_MSEL_ADDR) |
> +				       LISTEN_ONLY_MODE,
> +				       priv->base + CAN_MSEL_ADDR);
> +			}
> +			return;
> +		}
> +		/* set chip to normal mode */
> +		writel(readl(priv->base + CAN_MSEL_ADDR) & (~RESET_MODE),
> +		       priv->base + CAN_MSEL_ADDR);
> +		status =3D readl(priv->base + CAN_MSEL_ADDR);
> +	}

This loop looks not straight forward. What about:

	while (timeout -- &&
		(readl(priv->base + CAN_MSEL_ADDR) & RESET_MODE)) {
			writel(readl(priv->base)....);
	}

	if (readl(priv->base + CAN_MSEL_ADDR) & RESET_MODE)
		return -ETIMEDOUT;

	/* do the rest */
	return 0;=09

> +	netdev_err(dev, "setting controller into normal mode failed!\n");
> +}
> +
> +static void set_reset_mode(struct net_device *dev)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	u8 status =3D readl(priv->base + CAN_MSEL_ADDR);
> +	int i;
> +
> +	for (i =3D 0; i < 100; i++) {
> +		/* check reset bit */
> +		if (status & RESET_MODE) {
> +			priv->can.state =3D CAN_STATE_STOPPED;
> +			return;
> +		}
> +		/* select reset mode */
> +		writel(readl(priv->base + CAN_MSEL_ADDR) |
> +			RESET_MODE, priv->base + CAN_MSEL_ADDR);
> +		status =3D readl(priv->base + CAN_MSEL_ADDR);
> +	}
> +	netdev_err(dev, "setting controller into reset mode failed!\n");
> +}

same here. move the action out of the loop and return an error.

> +
> +static int sunxican_set_bittiming(struct net_device *dev)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	u32 cfg;
> +
> +	cfg =3D ((bt->brp - 1) & 0x3FF) |
> +	    (((bt->sjw - 1) & 0x3) << 14) |
> +	    (((bt->prop_seg + bt->phase_seg1 - 1) & 0xf) << 16) |
> +	    (((bt->phase_seg2 - 1) & 0x7) << 20);
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
> +		cfg |=3D 0x800000;
> +
> +	netdev_info(dev, "setting BITTIMING=3D0x%08x\n", cfg);
> +
> +	/* CAN_BTIME_ADDR only writable in reset mode */
> +	set_reset_mode(dev);
> +	writel(cfg, priv->base + CAN_BTIME_ADDR);
> +	set_normal_mode(dev);

check the return values of set_.._mode() here
> +
> +	return 0;
> +}
> +
> +static int sunxican_get_berr_counter(const struct net_device *dev,
> +				     struct can_berr_counter *bec)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	u32 errors;
> +
> +	errors =3D readl(priv->base + CAN_ERRC_ADDR);
> +	bec->txerr =3D errors & 0x000F;
> +	bec->rxerr =3D (errors >> 16) & 0x000F;
> +	return 0;
> +}
> +
> +static void sunxi_can_start(struct net_device *dev)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +
> +	/* leave reset mode */
> +	if (priv->can.state !=3D CAN_STATE_STOPPED)
> +		set_reset_mode(dev);
> +
> +	/* set filters - we accept all */
> +	writel(0x00000000, priv->base + CAN_ACPC_ADDR);
> +	writel(0xffffffff, priv->base + CAN_ACPM_ADDR);
> +
> +	/* Clear error counters and error code capture */
> +	writel(0x0, priv->base + CAN_ERRC_ADDR);
> +
> +	/* leave reset mode */
> +	set_normal_mode(dev);
> +}
> +
> +static int sunxican_set_mode(struct net_device *dev, enum can_mode mod=
e)
> +{
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		sunxi_can_start(dev);
> +		if (netif_queue_stopped(dev))
> +			netif_wake_queue(dev);
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +/* transmit a CAN message
> + * message layout in the sk_buff should be like this:
> + * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
> + * [ can_id ] [flags] [len] [can data (up to 8 bytes]
> + */
> +static int sunxican_start_xmit(struct sk_buff *skb, struct net_device =
*dev)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u8 dlc;
> +	canid_t id;
> +	u32 temp =3D 0;
> +	int i;
> +
> +	/* wait buffer ready */
> +	while (!(readl(priv->base + CAN_STA_ADDR) & TBUF_RDY))
> +		usleep_range(10, 100);

Can you explain why you need this sleep here?

> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	netif_stop_queue(dev);
> +
> +	dlc =3D cf->can_dlc;
> +	id =3D cf->can_id;
> +
> +	temp =3D ((id >> 30) << 6) | dlc;

Please don't reply on the fact that the upper two bits of id match the
upper two bits for temp. Please use an explizid conversion via:
	if (id & ..)
		temp |=3D BIT_FOO;

> +	writel(temp, priv->base + CAN_BUF0_ADDR);
> +	if (id & CAN_EFF_FLAG) {
> +		/* extended frame */
> +		writel((id >> 21) & 0xFF, priv->base + CAN_BUF1_ADDR);
> +		writel((id >> 13) & 0xFF, priv->base + CAN_BUF2_ADDR);
> +		writel((id >> 5)  & 0xFF, priv->base + CAN_BUF3_ADDR);
> +		writel((id & 0x1F) << 3,  priv->base + CAN_BUF4_ADDR);

Can you make it always first shift then mask or the other way round. see
the original sja1000 xmit() functio, that look pretty neat.

> +
> +		for (i =3D 0; i < dlc; i++) {
> +			writel(cf->data[i],
> +			       priv->base + (CAN_BUF5_ADDR + i * 4));
> +		}
> +	} else {
> +		/* standard frame */
> +		writel((id >> 3) & 0xFF, priv->base + CAN_BUF1_ADDR);
> +		writel((id & 0x7) << 5, priv->base + CAN_BUF2_ADDR);
> +
> +		for (i =3D 0; i < dlc; i++)
> +			writel(cf->data[i], priv->base + CAN_BUF3_ADDR + i * 4);
> +	}
> +	can_put_echo_skb(skb, dev, 0);

Do you have support for one_shot or loopback mode here, too. Like the
sja1000?

> +	sunxi_can_write_cmdreg(priv, TRANS_REQ);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void sunxi_can_rx(struct net_device *dev)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u8 fi;
> +	canid_t id;
> +	int i;
> +
> +	/* create zero'ed CAN frame buffer */
> +	skb =3D alloc_can_skb(dev, &cf);
> +	if (!skb)
> +		return;
> +
> +	fi =3D readl(priv->base + CAN_BUF0_ADDR);
> +	cf->can_dlc =3D get_can_dlc(fi & 0x0F);
> +	if (fi >> 7) {
> +		/* extended frame format (EFF) */
> +		id =3D (readl(priv->base + CAN_BUF1_ADDR) << 21) |
> +		     (readl(priv->base + CAN_BUF2_ADDR) << 13) |
> +		     (readl(priv->base + CAN_BUF3_ADDR) << 5)  |
> +		    ((readl(priv->base + CAN_BUF4_ADDR) >> 3) & 0x1f);
> +		id |=3D CAN_EFF_FLAG;
> +
> +		/* remote transmission request ? */
> +		if ((fi >> 6) & 0x1) {
> +			id |=3D CAN_RTR_FLAG;
> +		} else {
> +			for (i =3D 0; i < cf->can_dlc; i++)
> +				cf->data[i] =3D
> +				    readl(priv->base + CAN_BUF5_ADDR + i * 4);
> +		}
> +	} else {
> +		/* standard frame format (SFF) */
> +		id =3D (readl(priv->base + CAN_BUF1_ADDR) << 3) |
> +		    ((readl(priv->base + CAN_BUF2_ADDR) >> 5) & 0x7);
> +
> +		/* remote transmission request ? */
> +		if ((fi >> 6) & 0x1) {
> +			id |=3D CAN_RTR_FLAG;
> +		} else {
> +			for (i =3D 0; i < cf->can_dlc; i++)
> +				cf->data[i] =3D
> +				    readl(priv->base + CAN_BUF3_ADDR + i * 4);
> +		}
> +	}
> +	cf->can_id =3D id;
> +
> +	/* release receive buffer */
> +	sunxi_can_write_cmdreg(priv, RELEASE_RBUF);
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_rx(skb);
> +
> +	can_led_event(dev, CAN_LED_EVENT_RX);
> +}
> +
> +static int sunxi_can_err(struct net_device *dev, u8 isrc, u8 status)
> +{
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	enum can_state state =3D priv->can.state;
> +	u32 ecc, alc;
> +
> +	skb =3D alloc_can_err_skb(dev, &cf);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (isrc & DATA_OR) {
> +		/* data overrun interrupt */
> +		netdev_dbg(dev, "data overrun interrupt\n");
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;
> +		sunxi_can_write_cmdreg(priv, CLEAR_OR_FLAG);	/* clear bit */
> +	}
> +	if (isrc & ERR_WRN) {
> +		/* error warning interrupt */
> +		netdev_dbg(dev, "error warning interrupt\n");
> +
> +		if (status & BUS_OFF) {
> +			state =3D CAN_STATE_BUS_OFF;
> +			cf->can_id |=3D CAN_ERR_BUSOFF;
> +			can_bus_off(dev);
> +		} else if (status & ERR_STA) {
> +			state =3D CAN_STATE_ERROR_WARNING;
> +		} else {
> +			state =3D CAN_STATE_ERROR_ACTIVE;
> +		}
> +	}
> +	if (isrc & BUS_ERR) {
> +		/* bus error interrupt */
> +		netdev_dbg(dev, "bus error interrupt\n");
> +		priv->can.can_stats.bus_error++;
> +		stats->rx_errors++;
> +
> +		ecc =3D readl(priv->base + CAN_STA_ADDR);
> +
> +		cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +
> +		if (ecc & BIT_ERR) {
> +			cf->data[2] |=3D CAN_ERR_PROT_BIT;
> +		} else if (ecc & FORM_ERR) {
> +			cf->data[2] |=3D CAN_ERR_PROT_FORM;
> +		} else if (ecc & STUFF_ERR) {
> +			cf->data[2] |=3D CAN_ERR_PROT_STUFF;
> +		} else {
> +			cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
> +			cf->data[3] =3D (ecc & ERR_SEG_CODE) >> 16;
> +		}
> +		/* error occurred during transmission? */
> +		if ((ecc & ERR_DIR) =3D=3D 0)
> +			cf->data[2] |=3D CAN_ERR_PROT_TX;
> +	}
> +	if (isrc & ERR_PASSIVE) {
> +		/* error passive interrupt */
> +		netdev_dbg(dev, "error passive interrupt\n");
> +		if (status & ERR_STA)
> +			state =3D CAN_STATE_ERROR_PASSIVE;
> +		else
> +			state =3D CAN_STATE_ERROR_ACTIVE;
> +	}
> +	if (isrc & ARB_LOST) {
> +		/* arbitration lost interrupt */
> +		netdev_dbg(dev, "arbitration lost interrupt\n");
> +		alc =3D readl(priv->base + CAN_STA_ADDR);
> +		priv->can.can_stats.arbitration_lost++;
> +		stats->tx_errors++;
> +		cf->can_id |=3D CAN_ERR_LOSTARB;
> +		cf->data[0] =3D (alc & 0x1f) >> 8;
> +	}
> +	if (state !=3D priv->can.state && (state =3D=3D CAN_STATE_ERROR_WARNI=
NG ||
> +					 state =3D=3D CAN_STATE_ERROR_PASSIVE)) {
> +		u32 errc =3D readl(priv->base + CAN_ERRC_ADDR);
> +		u8 rxerr =3D (errc >> 16) & 0xFF;
> +		u8 txerr =3D errc & 0xFF;
> +
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		if (state =3D=3D CAN_STATE_ERROR_WARNING) {
> +			priv->can.can_stats.error_warning++;
> +			cf->data[1] =3D (txerr > rxerr) ?
> +			    CAN_ERR_CRTL_TX_WARNING : CAN_ERR_CRTL_RX_WARNING;
> +		} else {
> +			priv->can.can_stats.error_passive++;
> +			cf->data[1] =3D (txerr > rxerr) ?
> +			    CAN_ERR_CRTL_TX_PASSIVE : CAN_ERR_CRTL_RX_PASSIVE;
> +		}
> +		cf->data[6] =3D txerr;
> +		cf->data[7] =3D rxerr;
> +	}
> +	priv->can.state =3D state;
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_rx(skb);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t sunxi_can_interrupt(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D (struct net_device *)dev_id;
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct net_device_stats *stats =3D &dev->stats;
> +	u8 isrc, status;
> +	int n =3D 0;
> +
> +	while ((isrc =3D readl(priv->base + CAN_INT_ADDR))
> +	       && (n < SUNXI_CAN_MAX_IRQ)) {
> +		n++;
> +		status =3D readl(priv->base + CAN_STA_ADDR);
> +
> +		if (isrc & WAKEUP)
> +			netdev_warn(dev, "wakeup interrupt\n");
> +
> +		if (isrc & TBUF_VLD) {
> +			/* transmission complete interrupt */
> +			stats->tx_bytes +=3D
> +			    readl(priv->base + CAN_RBUF_RBACK_START_ADDR) & 0xf;
> +			stats->tx_packets++;
> +			can_get_echo_skb(dev, 0);
> +			netif_wake_queue(dev);
> +			can_led_event(dev, CAN_LED_EVENT_TX);
> +		}
> +		if (isrc & RBUF_VLD) {
> +			/* receive interrupt */
> +			while (status & RBUF_RDY) {
> +			/* RX buffer is not empty */
> +				sunxi_can_rx(dev);
> +				status =3D readl(priv->base + CAN_STA_ADDR);
> +			}
> +		}
> +		if (isrc &
> +		    (DATA_OR | ERR_WRN | BUS_ERR | ERR_PASSIVE | ARB_LOST)) {
> +			/* error interrupt */
> +			if (sunxi_can_err(dev, isrc, status))
> +				break;
> +		}
> +		/* clear the interrupt */
> +		writel(isrc, priv->base + CAN_INT_ADDR);
> +	}
> +	if (n >=3D SUNXI_CAN_MAX_IRQ)
> +		netdev_dbg(dev, "%d messages handled in ISR", n);
> +
> +	return (n) ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static int sunxican_open(struct net_device *dev)
> +{
> +	int err;
> +
> +	/* set chip into reset mode */
> +	set_reset_mode(dev);
> +
> +	/* common open */
> +	err =3D open_candev(dev);
> +	if (err)
> +		return err;
> +
> +	/* register interrupt handler */

please make it:
	err =3D request_irq();
	if (err) {
	}
> +	if (request_irq
> +	    (dev->irq, sunxi_can_interrupt, IRQF_TRIGGER_NONE, dev->name,
                                            ^^^^^^^^^^^^^^^^^
Please make it a IRQF_SHARED.


> +	     (void *)dev)) {
             ^^^^^^^^
cast not needed
> +		netdev_err(dev, "request_irq err: %d\n", err);
close_candev() missing
> +		return -EAGAIN;

> +	}
> +	sunxican_set_bittiming(dev);
> +	sunxi_can_start(dev);
> +
> +	can_led_event(dev, CAN_LED_EVENT_OPEN);
> +
> +	netif_start_queue(dev);
> +
> +	return 0;
> +}
> +
> +static int sunxican_close(struct net_device *dev)
> +{
> +	netif_stop_queue(dev);
> +	set_reset_mode(dev);
> +
> +	free_irq(dev->irq, (void *)dev);
> +
> +	close_candev(dev);
> +
> +	can_led_event(dev, CAN_LED_EVENT_STOP);
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops sunxican_netdev_ops =3D {
> +	.ndo_open =3D sunxican_open,
> +	.ndo_stop =3D sunxican_close,
> +	.ndo_start_xmit =3D sunxican_start_xmit,
> +};
> +
> +static const struct of_device_id sunxican_of_match[] =3D {
> +	{.compatible =3D "allwinner,sunxican"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, sunxican_of_match);
> +
> +static const struct platform_device_id sunxican_id_table[] =3D {
> +	{.name =3D "sunxican"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(platform, sunxican_id_table);
> +
> +static int sunxican_remove(struct platform_device *pdev)
> +{
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +	struct resource *res;
> +
> +	set_reset_mode(dev);
> +	unregister_netdev(dev);
> +	iounmap(priv->base);
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, resource_size(res));
> +
> +	free_candev(dev);
> +
> +	return 0;
> +}
> +
> +static int sunxican_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	struct clk *clk;
> +	void __iomem *addr;
> +	int err, irq;
> +	u32 temp_irqen;
> +	struct net_device *dev;
> +	struct sunxican_priv *priv;
> +
> +	clk =3D clk_get(&pdev->dev, "apb1_can");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "no clock defined\n");
> +		err =3D -ENODEV;
> +		goto exit;
> +	}
> +	/* turn on clocking for CAN peripheral block */
> +	err =3D clk_prepare_enable(clk);

Please move the clock handling into the open() function. Or better think
about implementing runtimepm.

> +	if (err) {
> +		dev_err(&pdev->dev, "could not enable clocking (apb1_can)\n");
> +		goto exit;
> +	}
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq =3D platform_get_irq(pdev, 0);
> +
> +	if (!res || irq <=3D 0) {
> +		dev_err(&pdev->dev, "could not get a valid irq\n");
> +		err =3D -ENODEV;
> +		goto exit_put;
> +	}
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) =
{
> +		dev_err(&pdev->dev, "could not get io memory resource\n");
> +		err =3D -EBUSY;
> +		goto exit_put;
> +	}
> +	addr =3D ioremap_nocache(res->start, resource_size(res));
> +	if (!addr) {
> +		dev_err(&pdev->dev, "could not map io memory\n");
> +		err =3D -ENOMEM;
> +		goto exit_release;
> +	}
> +	dev =3D alloc_candev(sizeof(struct sunxican_priv), 1);
> +
> +	if (!dev) {
> +		dev_err(&pdev->dev,
> +			"could not allocate memory for CAN device\n");
> +		err =3D -ENOMEM;
> +		goto exit_iounmap;
> +	}
> +
> +	dev->netdev_ops =3D &sunxican_netdev_ops;
> +	dev->irq =3D irq;
> +	dev->flags |=3D IFF_ECHO;
> +
> +	priv =3D netdev_priv(dev);
> +	priv->can.clock.freq =3D clk_get_rate(clk);
> +	priv->can.bittiming_const =3D &sunxican_bittiming_const;
> +	priv->can.do_set_mode =3D sunxican_set_mode;
> +	priv->can.do_get_berr_counter =3D sunxican_get_berr_counter;
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_BERR_REPORTING |
> +	    CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_LOOPBACK |
> +	    CAN_CTRLMODE_3_SAMPLES;
> +	priv->base =3D addr;
> +	priv->clk =3D clk;
> +	spin_lock_init(&priv->cmdreg_lock);
> +
> +	/* enable CAN specific interrupts */
> +	set_reset_mode(dev);
> +	temp_irqen =3D BERR_IRQ_EN | ERR_PASSIVE_IRQ_EN | OR_IRQ_EN | RX_IRQ_=
EN;
> +	writel(readl(priv->base + CAN_INTEN_ADDR) | temp_irqen,
> +	       priv->base + CAN_INTEN_ADDR);
> +
> +	platform_set_drvdata(pdev, dev);
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +
> +	err =3D register_candev(dev);
> +	if (err) {
> +		dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
> +			DRV_NAME, err);
> +		goto exit_free;
> +	}
> +	devm_can_led_init(dev);
> +
> +	dev_info(&pdev->dev, "device registered (base=3D%p, irq=3D%d)\n",
> +		 priv->base, dev->irq);
> +
> +	return 0;
> +
> +exit_free:
> +	free_candev(dev);
> +exit_iounmap:
> +	iounmap(addr);
> +exit_release:
> +	release_mem_region(res->start, resource_size(res));
> +exit_put:
> +	clk_put(clk);
> +exit:
> +	return err;
> +}
> +
> +static int __maybe_unused sunxi_can_suspend(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev)) {
> +		netif_stop_queue(dev);
> +		netif_device_detach(dev);
> +	}
> +	priv->can.state =3D CAN_STATE_SLEEPING;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused sunxi_can_resume(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct sunxican_priv *priv =3D netdev_priv(dev);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	if (netif_running(dev)) {
> +		netif_device_attach(dev);
> +		netif_start_queue(dev);
> +	}
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(sunxi_can_pm_ops, sunxi_can_suspend, sunxi_ca=
n_resume);
> +
> +static struct platform_driver sunxi_can_driver =3D {
> +	.driver =3D {
> +		   .name =3D DRV_NAME,

Please remove the .name.

> +		   .owner =3D THIS_MODULE,

Please indent with just two tabs here.

> +		   .pm =3D &sunxi_can_pm_ops,
> +		   .of_match_table =3D sunxican_of_match,
> +		   },
> +	.probe =3D sunxican_probe,
> +	.remove =3D sunxican_remove,
> +	.id_table =3D sunxican_id_table,
> +};
> +
> +module_platform_driver(sunxi_can_driver);
> +
> +MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
> +MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");

Oh nice, I didn't know that you can use two MODULE_AUTHOR lines.

> +MODULE_LICENSE("Dual BSD/GPL");
                   ^^^^^^^^^^^^
The header does only state GPL
> +MODULE_DESCRIPTION(DRV_NAME "CAN driver for Allwinner SoCs (A10/A20)")=
;
> +MODULE_VERSION(DRV_MODULE_VERSION);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--fRbxIn1CVb3x6j0wgeS9rnEbkmmpVKHOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7r3EAAoJEP5prqPJtc/HVd4H/RM1Aa4FmH6RJvpKbvYvpgUi
9R1tGjZryRWn873oEvj54626BV19l6pnpYLwRHXTidOH+XOlSkbU8bM72dKa2AuO
1XdV1QAGU6DOvqASELATfmYwWoclXf2lACTNvkB0oDtSMeRjjgpDnKhLngO59e4x
b/4Efw+CU0Z69V9fgemg8g175PPHhOUeRzQ4C1WsdISHD3ZjOvvqm0DXOhAuv9+W
thzmObsT9D62Kdagps3twi9y9TkrydpHPJDff4+dm7uj02Y1BpfANZfVTVCKOzom
Yb+WNXERUSEGE1unRo/Q2Eej8s2WUSjiW1s6cKlQnB1jln3mAwXH7kIPsh0c+xc=
=51hA
-----END PGP SIGNATURE-----

--fRbxIn1CVb3x6j0wgeS9rnEbkmmpVKHOi--

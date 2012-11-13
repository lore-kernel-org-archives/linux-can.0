From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Tue, 13 Nov 2012 22:15:54 +0100
Message-ID: <50A2B88A.3040609@pengutronix.de>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B400DDAA624B95D5122E5DD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40346 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab2KMVQM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Nov 2012 16:16:12 -0500
In-Reply-To: <1352732256-12712-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B400DDAA624B95D5122E5DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/2012 03:57 PM, Andreas Larsson wrote:
> This driver supports GRCAN and CRHCAN CAN controllers available in the =
GRLIB
> VHDL IP core library.
>=20
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> Acked-by: Wolfgang Grandegger <wg@grandegger.com>

looks almost ready, nitpicks inline.

Marc
> ---
> Changes since v7:
> - Enable napi before turning on interrupts
> - Remove unneeded casts, unneded checks and improper devm_ usages
> - Fix, downgrade or remove some printouts
> - Rewrite poll function so that tx gets its own budget and so that undo=
ne work
>   does not fall between the cracks when enabling interrupts
> - Don't check irq number against NO_IRQ that does not exist on all OF e=
nabled
>   platforms
> - Document kernel parameters with MODULE_PARM_DESC
>=20
>  Documentation/ABI/testing/sysfs-class-net-grcan    |   35 +
>  .../devicetree/bindings/net/can/grcan.txt          |   28 +
>  Documentation/kernel-parameters.txt                |   18 +
>  drivers/net/can/Kconfig                            |    9 +
>  drivers/net/can/Makefile                           |    1 +
>  drivers/net/can/grcan.c                            | 1768 ++++++++++++=
++++++++
>  6 files changed, 1859 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-net-grcan
>  create mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt=

>  create mode 100644 drivers/net/can/grcan.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-net-grcan b/Document=
ation/ABI/testing/sysfs-class-net-grcan
> new file mode 100644
> index 0000000..f418c92
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-net-grcan
> @@ -0,0 +1,35 @@
> +
> +What:		/sys/class/net/<iface>/grcan/enable0
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Hardware configuration of physical interface 0. This file reads
> +		and writes the "Enable 0" bit of the configuration register.
> +		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
> +		core library documentation for details. The default value is 0
> +		or set by the module parameter grcan.enable0 and can be read at
> +		/sys/module/grcan/parameters/enable0.
> +
> +What:		/sys/class/net/<iface>/grcan/enable1
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Hardware configuration of physical interface 1. This file reads
> +		and writes the "Enable 1" bit of the configuration register.
> +		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
> +		core library documentation for details. The default value is 0
> +		or set by the module parameter grcan.enable1 and can be read at
> +		/sys/module/grcan/parameters/enable1.
> +
> +What:		/sys/class/net/<iface>/grcan/select
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configuration of which physical interface to be used. Possible
> +		values: 0 or 1. See the GRCAN chapter of the GRLIB IP core
> +		library documentation for details. The default value is 0 or is
> +		set by the module parameter grcan.select and can be read at
> +		/sys/module/grcan/parameters/select.
> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Docu=
mentation/devicetree/bindings/net/can/grcan.txt
> new file mode 100644
> index 0000000..34ef349
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/grcan.txt
> @@ -0,0 +1,28 @@
> +Aeroflex Gaisler GRCAN and GRHCAN CAN controllers.
> +
> +The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL I=
P core
> +library.
> +
> +Note: These properties are built from the AMBA plug&play in a Leon SPA=
RC system
> +(the ordinary environment for GRCAN and GRHCAN). There are no dts file=
s for
> +sparc.
> +
> +Required properties:
> +
> +- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_=
034"
> +
> +- reg : Address and length of the register set for the device
> +
> +- freq : Frequency of the external oscillator clock in Hz (the frequen=
cy of
> +	the amba bus in the ordinary case)
> +
> +- interrupts : Interrupt number for this device
> +
> +Optional properties:
> +
> +- systemid : If not present or if the value of the least significant 1=
6 bits
> +	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSIO=
N
> +	a bug workaround is activated.
> +
> +For further information look in the documentation for the GLIB IP core=
 library:
> +http://www.gaisler.com/products/grlib/grip.pdf
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel=
-parameters.txt
> index 9776f06..3da4f96 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -905,6 +905,24 @@ bytes respectively. Such letter suffixes can also =
be entirely omitted.
>  	gpt		[EFI] Forces disk with valid GPT signature but
>  			invalid Protective MBR to be treated as GPT.
> =20
> +	grcan.enable0=3D	[HW] Configuration of physical interface 0. Determin=
es
> +			the "Enable 0" bit of the configuration register.
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.enable1=3D	[HW] Configuration of physical interface 1. Determin=
es
> +			the "Enable 0" bit of the configuration register.
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.select=3D	[HW] Select which physical interface to use.
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.txsize=3D	[HW] Sets the size of the tx buffer.
> +			Format: <unsigned int> such that (txsize & ~0x1fffc0) =3D=3D 0.
> +			Default: 1024
> +	grcan.rxsize=3D	[HW] Sets the size of the rx buffer.
> +			Format: <unsigned int> such that (rxsize & ~0x1fffc0) =3D=3D 0.
> +			Default: 1024
> +
>  	hashdist=3D	[KNL,NUMA] Large hashes allocated during boot
>  			are distributed across NUMA nodes.  Defaults on
>  			for 64-bit NUMA, off otherwise.
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index bb709fd..b56bd9e 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -110,6 +110,15 @@ config PCH_CAN
>  	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
>  	  This driver can access CAN bus.
> =20
> +config CAN_GRCAN
> +	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
> +	depends on CAN_DEV && OF
> +	---help---
> +	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
> +	  Note that the driver supports little endian, even though little
> +	  endian syntheses of the cores would need some modifications on
> +	  the hardware level to work.
> +
>  source "drivers/net/can/mscan/Kconfig"
> =20
>  source "drivers/net/can/sja1000/Kconfig"
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 938be37..7de5986 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_CAN_BFIN)		+=3D bfin_can.o
>  obj-$(CONFIG_CAN_JANZ_ICAN3)	+=3D janz-ican3.o
>  obj-$(CONFIG_CAN_FLEXCAN)	+=3D flexcan.o
>  obj-$(CONFIG_PCH_CAN)		+=3D pch_can.o
> +obj-$(CONFIG_CAN_GRCAN)		+=3D grcan.o
> =20
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
> new file mode 100644
> index 0000000..2eafe74
> --- /dev/null
> +++ b/drivers/net/can/grcan.c
> @@ -0,0 +1,1768 @@
> +/*
> + * Socket CAN driver for Aeroflex Gaisler GRCAN and GRHCAN.
> + *
> + * 2012 (c) Aeroflex Gaisler AB
> + *
> + * This driver supports GRCAN and GRHCAN CAN controllers available in =
the GRLIB
> + * VHDL IP core library.
> + *
> + * Full documentation of the GRCAN core can be found here:
> + * http://www.gaisler.com/products/grlib/grip.pdf
> + *
> + * See "Documentation/devicetree/bindings/net/can/grcan.txt" for infor=
mation on
> + * open firmware properties.
> + *
> + * See "Documentation/ABI/testing/sysfs-class-net-grcan" for informati=
on on the
> + * sysfs interface.
> + *
> + * See "Documentation/kernel-parameters.txt" for information on the mo=
dule
> + * parameters.
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published by t=
he
> + * Free Software Foundation; either version 2 of the License, or (at y=
our
> + * option) any later version.
> + *
> + * Contributors: Andreas Larsson <andreas@gaisler.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/netdevice.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/can/dev.h>
> +#include <linux/spinlock.h>
> +
> +#include <linux/of_platform.h>
> +#include <asm/prom.h>
> +
> +#include <linux/of_irq.h>
> +
> +#include <linux/dma-mapping.h>
> +
> +#define DRV_NAME	"grcan"
> +
> +#define GRCAN_TX_BUDGET		16
> +#define GRCAN_NAPI_WEIGHT	16
> +
> +#define GRCAN_RESERVE_SIZE(slot1, slot2) (((slot2) - (slot1)) / 4 - 1)=

> +
> +struct grcan_registers {
> +	u32 conf;	/* 0x00 */
> +	u32 stat;	/* 0x04 */
> +	u32 ctrl;	/* 0x08 */
> +	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
> +	u32 smask;	/* 0x18 - CanMASK */
> +	u32 scode;	/* 0x1c - CanCODE */
> +	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
> +	u32 pimsr;	/* 0x100 */
> +	u32 pimr;	/* 0x104 */
> +	u32 pisr;	/* 0x108 */
> +	u32 pir;	/* 0x10C */
> +	u32 imr;	/* 0x110 */
> +	u32 picr;	/* 0x114 */
> +	u32 __reserved3[GRCAN_RESERVE_SIZE(0x114, 0x200)];
> +	u32 txctrl;	/* 0x200 */
> +	u32 txaddr;	/* 0x204 */
> +	u32 txsize;	/* 0x208 */
> +	u32 txwr;	/* 0x20C */
> +	u32 txrd;	/* 0x210 */
> +	u32 txirq;	/* 0x214 */
> +	u32 __reserved4[GRCAN_RESERVE_SIZE(0x214, 0x300)];
> +	u32 rxctrl;	/* 0x300 */
> +	u32 rxaddr;	/* 0x304 */
> +	u32 rxsize;	/* 0x308 */
> +	u32 rxwr;	/* 0x30C */
> +	u32 rxrd;	/* 0x310 */
> +	u32 rxirq;	/* 0x314 */
> +	u32 rxmask;	/* 0x318 */
> +	u32 rxcode;	/* 0x31C */
> +};
> +
> +#define GRCAN_CONF_ABORT	0x00000001
> +#define GRCAN_CONF_ENABLE0	0x00000002
> +#define GRCAN_CONF_ENABLE1	0x00000004
> +#define GRCAN_CONF_SELECT	0x00000008
> +#define GRCAN_CONF_SILENT	0x00000010
> +#define GRCAN_CONF_SAM		0x00000020 /* Available in some hardware */
> +#define GRCAN_CONF_BPR		0x00000300 /* Note: not BRP */
> +#define GRCAN_CONF_RSJ		0x00007000
> +#define GRCAN_CONF_PS1		0x00f00000
> +#define GRCAN_CONF_PS2		0x000f0000
> +#define GRCAN_CONF_SCALER	0xff000000
> +#define GRCAN_CONF_OPERATION						\
> +	(GRCAN_CONF_ABORT | GRCAN_CONF_ENABLE0 | GRCAN_CONF_ENABLE1	\
> +	 | GRCAN_CONF_SELECT | GRCAN_CONF_SILENT | GRCAN_CONF_SAM)
> +#define GRCAN_CONF_TIMING						\
> +	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
> +	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)
> +
> +#define GRCAN_CONF_RSJ_MIN	1
> +#define GRCAN_CONF_RSJ_MAX	4
> +#define GRCAN_CONF_PS1_MIN	1
> +#define GRCAN_CONF_PS1_MAX	15
> +#define GRCAN_CONF_PS2_MIN	2
> +#define GRCAN_CONF_PS2_MAX	8
> +#define GRCAN_CONF_SCALER_MIN	0
> +#define GRCAN_CONF_SCALER_MAX	255
> +#define GRCAN_CONF_SCALER_INC	1
> +
> +#define GRCAN_CONF_BPR_BIT	8
> +#define GRCAN_CONF_RSJ_BIT	12
> +#define GRCAN_CONF_PS1_BIT	20
> +#define GRCAN_CONF_PS2_BIT	16
> +#define GRCAN_CONF_SCALER_BIT	24
> +
> +#define GRCAN_STAT_PASS		0x000001
> +#define GRCAN_STAT_OFF		0x000002
> +#define GRCAN_STAT_OR		0x000004
> +#define GRCAN_STAT_AHBERR	0x000008
> +#define GRCAN_STAT_ACTIVE	0x000010
> +#define GRCAN_STAT_RXERRCNT	0x00ff00
> +#define GRCAN_STAT_TXERRCNT	0xff0000
> +
> +#define GRCAN_STAT_ERRCTR_RELATED	(GRCAN_STAT_PASS | GRCAN_STAT_OFF)
> +
> +#define GRCAN_STAT_RXERRCNT_BIT	8
> +#define GRCAN_STAT_TXERRCNT_BIT	16
> +
> +#define GRCAN_STAT_ERRCNT_WARNING_LIMIT	96
> +#define GRCAN_STAT_ERRCNT_PASSIVE_LIMIT	127
> +
> +#define GRCAN_CTRL_RESET	0x2
> +#define GRCAN_CTRL_ENABLE	0x1
> +
> +#define GRCAN_TXCTRL_ENABLE	0x1
> +#define GRCAN_TXCTRL_ONGOING	0x2
> +#define GRCAN_TXCTRL_SINGLE	0x4
> +
> +#define GRCAN_RXCTRL_ENABLE	0x1
> +#define GRCAN_RXCTRL_ONGOING	0x2
> +
> +/* Relative offset of IRQ sources to AMBA Plug&Play */
> +#define GRCAN_IRQIX_IRQ		0
> +#define GRCAN_IRQIX_TXSYNC	1
> +#define GRCAN_IRQIX_RXSYNC	2
> +
> +#define GRCAN_IRQ_PASS		0x00001
> +#define GRCAN_IRQ_OFF		0x00002
> +#define GRCAN_IRQ_OR		0x00004
> +#define GRCAN_IRQ_RXAHBERR	0x00008
> +#define GRCAN_IRQ_TXAHBERR	0x00010
> +#define GRCAN_IRQ_RXIRQ		0x00020
> +#define GRCAN_IRQ_TXIRQ		0x00040
> +#define GRCAN_IRQ_RXFULL	0x00080
> +#define GRCAN_IRQ_TXEMPTY	0x00100
> +#define GRCAN_IRQ_RX		0x00200
> +#define GRCAN_IRQ_TX		0x00400
> +#define GRCAN_IRQ_RXSYNC	0x00800
> +#define GRCAN_IRQ_TXSYNC	0x01000
> +#define GRCAN_IRQ_RXERRCTR	0x02000
> +#define GRCAN_IRQ_TXERRCTR	0x04000
> +#define GRCAN_IRQ_RXMISS	0x08000
> +#define GRCAN_IRQ_TXLOSS	0x10000
> +
> +#define GRCAN_IRQ_NONE	0
> +#define GRCAN_IRQ_ALL							\
> +	(GRCAN_IRQ_PASS | GRCAN_IRQ_OFF | GRCAN_IRQ_OR			\
> +	 | GRCAN_IRQ_RXAHBERR | GRCAN_IRQ_TXAHBERR			\
> +	 | GRCAN_IRQ_RXIRQ | GRCAN_IRQ_TXIRQ				\
> +	 | GRCAN_IRQ_RXFULL | GRCAN_IRQ_TXEMPTY				\
> +	 | GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_RXSYNC		\
> +	 | GRCAN_IRQ_TXSYNC | GRCAN_IRQ_RXERRCTR			\
> +	 | GRCAN_IRQ_TXERRCTR | GRCAN_IRQ_RXMISS			\
> +	 | GRCAN_IRQ_TXLOSS)
> +
> +#define GRCAN_IRQ_ERRCTR_RELATED (GRCAN_IRQ_RXERRCTR | GRCAN_IRQ_TXERR=
CTR \
> +				  | GRCAN_IRQ_PASS | GRCAN_IRQ_OFF)
> +#define GRCAN_IRQ_ERRORS (GRCAN_IRQ_ERRCTR_RELATED | GRCAN_IRQ_OR	\
> +			  | GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR	\
> +			  | GRCAN_IRQ_TXLOSS)
> +#define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERR=
ORS)
> +
> +#define GRCAN_MSG_SIZE		16
> +
> +#define GRCAN_MSG_IDE		0x80000000
> +#define GRCAN_MSG_RTR		0x40000000
> +#define GRCAN_MSG_BID		0x1ffc0000
> +#define GRCAN_MSG_EID		0x1fffffff
> +#define GRCAN_MSG_IDE_BIT	31
> +#define GRCAN_MSG_RTR_BIT	30
> +#define GRCAN_MSG_BID_BIT	18
> +#define GRCAN_MSG_EID_BIT	0
> +
> +#define GRCAN_MSG_DLC		0xf0000000
> +#define GRCAN_MSG_TXERRC	0x00ff0000
> +#define GRCAN_MSG_RXERRC	0x0000ff00
> +#define GRCAN_MSG_DLC_BIT	28
> +#define GRCAN_MSG_TXERRC_BIT	16
> +#define GRCAN_MSG_RXERRC_BIT	8
> +#define GRCAN_MSG_AHBERR	0x00000008
> +#define GRCAN_MSG_OR		0x00000004
> +#define GRCAN_MSG_OFF		0x00000002
> +#define GRCAN_MSG_PASS		0x00000001
> +
> +#define GRCAN_MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
> +#define GRCAN_MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
> +
> +#define GRCAN_BUFFER_ALIGNMENT		1024
> +#define GRCAN_DEFAULT_BUFFER_SIZE	1024
> +#define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
> +
> +#define GRCAN_INVALID_BUFFER_SIZE(s)			\
> +	((s) =3D=3D 0 || ((s) & ~GRCAN_VALID_TR_SIZE_MASK))
> +
> +#if GRCAN_INVALID_BUFFER_SIZE(GRCAN_DEFAULT_BUFFER_SIZE)
> +#error "Invalid default buffer size"
> +#endif
> +
> +struct grcan_dma_buffer {
> +	size_t size;
> +	void *buf;
> +	dma_addr_t handle;
> +};
> +
> +struct grcan_dma {
> +	size_t base_size;
> +	void *base_buf;
> +	dma_addr_t base_handle;
> +	struct grcan_dma_buffer tx;
> +	struct grcan_dma_buffer rx;
> +};
> +
> +/* GRCAN configuration parameters */
> +struct grcan_device_config {
> +	unsigned short enable0;
> +	unsigned short enable1;
> +	unsigned short select;
> +	unsigned int txsize;
> +	unsigned int rxsize;
> +};
> +
> +#define GRCAN_DEFAULT_DEVICE_CONFIG {				\
> +		.enable0	=3D 0,				\
> +		.enable1	=3D 0,				\
> +		.select		=3D 0,				\
> +		.txsize		=3D GRCAN_DEFAULT_BUFFER_SIZE,	\
> +		.rxsize		=3D GRCAN_DEFAULT_BUFFER_SIZE,	\
> +		}
> +
> +#define GRCAN_TXBUG_SAFE_GRLIB_VERSION	0x4100
> +#define GRLIB_VERSION_MASK		0xffff
> +
> +/* GRCAN private data structure */
> +struct grcan_priv {
> +	struct can_priv can;	/* must be the first member */
> +	struct net_device *dev;
> +	struct napi_struct napi;
> +
> +	struct grcan_registers __iomem *regs;	/* ioremap'ed registers */
> +	struct grcan_device_config config;
> +	struct grcan_dma dma;
> +
> +	struct sk_buff **echo_skb;	/* We allocate this on our own */
> +	u8 *txdlc;			/* Length of queued frames */
> +
> +	/* The echo skb pointer, pointing into echo_skb and indicating which
> +	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
> +	 * handling"-comment for grcan_start_xmit for more details.
> +	 */
> +	u32 eskbp;
> +
> +	/* Lock for controlling changes to the netif tx queue state, accesses=
 to
> +	 * the echo_skb pointer eskbp and for making sure that a running rese=
t
> +	 * and/or a close of the interface is done without interference from
> +	 * other parts of the code.
> +	 *
> +	 * The echo_skb pointer, eskbp, should only be accessed under this lo=
ck
> +	 * as it can be changed in several places and together with decisions=
 on
> +	 * whether to wake up the tx queue.
> +	 *
> +	 * The tx queue must never be woken up if there is a running reset or=

> +	 * close in progress.
> +	 *
> +	 * A running reset (see below on need_txbug_workaround) should never =
be
> +	 * done if the interface is closing down and several running resets
> +	 * should never be scheduled simultaneously.
> +	 */
> +	spinlock_t lock;
> +
> +	/* Whether a workaround is needed due to a bug in older hardware. In
> +	 * this case, the driver both tries to prevent the bug from being
> +	 * triggered and recovers, if the bug nevertheless happens, by doing =
a
> +	 * running reset. A running reset, resets the device and continues fr=
om
> +	 * where it were without being noticeable from outside the driver (ap=
art
> +	 * from slight delays).
> +	 */
> +	bool need_txbug_workaround;
> +
> +	/* To trigger initization of running reset and to trigger running res=
et
> +	 * respectively in the case of a hanged device due to a txbug.
> +	 */
> +	struct timer_list hang_timer;
> +	struct timer_list rr_timer;
> +
> +	/* To avoid waking up the netif queue and restarting timers
> +	 * when a reset is scheduled or when closing of the device is
> +	 * undergoing
> +	 */
> +	bool resetting;
> +	bool closing;
> +};
> +
> +/* Wait time for a short wait for ongoing to clear */
> +#define GRCAN_SHORTWAIT_USECS	10
> +
> +/* Limit on the number of transmitted bits of an eff frame according t=
o the CAN
> + * specification: 1 bit start of frame, 32 bits arbitration field, 6 b=
its
> + * control field, 8 bytes data field, 16 bits crc field, 2 bits ACK fi=
eld and 7
> + * bits end of frame
> + */
> +#define GRCAN_EFF_FRAME_MAX_BITS	(1+32+6+8*8+16+2+7)
> +
> +#if defined(__BIG_ENDIAN)
> +static inline u32 grcan_read_reg(u32 __iomem *reg)
> +{
> +	return ioread32be(reg);
> +}
> +
> +static inline void grcan_write_reg(u32 __iomem *reg, u32 val)
> +{
> +	iowrite32be(val, reg);
> +}
> +#else
> +static inline u32 grcan_read_reg(u32 __iomem *reg)
> +{
> +	return ioread32(reg);
> +}
> +
> +static inline void grcan_write_reg(u32 __iomem *reg, u32 val)
> +{
> +	iowrite32(val, reg);
> +}
> +#endif
> +
> +static inline void grcan_clear_bits(u32 __iomem *reg, u32 mask)
> +{
> +	grcan_write_reg(reg, grcan_read_reg(reg) & ~mask);
> +}
> +
> +static inline void grcan_set_bits(u32 __iomem *reg, u32 mask)
> +{
> +	grcan_write_reg(reg, grcan_read_reg(reg) | mask);
> +}
> +
> +static inline u32 grcan_read_bits(u32 __iomem *reg, u32 mask)
> +{
> +	return grcan_read_reg(reg) & mask;
> +}
> +
> +static inline void grcan_write_bits(u32 __iomem *reg, u32 value, u32 m=
ask)
> +{
> +	u32 old =3D grcan_read_reg(reg);
> +
> +	grcan_write_reg(reg, (old & ~mask) | (value & mask));
> +}
> +
> +/* a and b should both be in [0,size] and a =3D=3D b =3D=3D size shoul=
d not hold */
> +static inline u32 grcan_ring_add(u32 a, u32 b, u32 size)
> +{
> +	u32 sum =3D a + b;
> +
> +	if (sum < size)
> +		return sum;
> +	else
> +		return sum - size;
> +}
> +
> +/* a and b should both be in [0,size) */
> +static inline u32 grcan_ring_sub(u32 a, u32 b, u32 size)
> +{
> +	return grcan_ring_add(a, size - b, size);
> +}
> +
> +/* Available slots for new transmissions */
> +static inline u32 grcan_txspace(size_t txsize, u32 txwr, u32 eskbp)
> +{
> +	u32 slots =3D txsize / GRCAN_MSG_SIZE - 1;
> +	u32 used =3D grcan_ring_sub(txwr, eskbp, txsize) / GRCAN_MSG_SIZE;
> +
> +	return slots - used;
> +}
> +
> +/* Configuration parameters that can be set via module parameters */
> +static struct grcan_device_config grcan_module_config =3D
> +	GRCAN_DEFAULT_DEVICE_CONFIG;
> +
> +static struct can_bittiming_const grcan_bittiming_const =3D {

make it const

> +	.name		=3D DRV_NAME,
> +	.tseg1_min	=3D GRCAN_CONF_PS1_MIN + 1,
> +	.tseg1_max	=3D GRCAN_CONF_PS1_MAX + 1,
> +	.tseg2_min	=3D GRCAN_CONF_PS2_MIN,
> +	.tseg2_max	=3D GRCAN_CONF_PS2_MAX,
> +	.sjw_max	=3D GRCAN_CONF_RSJ_MAX,
> +	.brp_min	=3D GRCAN_CONF_SCALER_MIN + 1,
> +	.brp_max	=3D GRCAN_CONF_SCALER_MAX + 1,
> +	.brp_inc	=3D GRCAN_CONF_SCALER_INC,
> +};
> +
> +static int grcan_set_bittiming(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	u32 timing =3D 0;
> +	int bpr, rsj, ps1, ps2, scaler;
> +
> +	/* Should never happen - function will not be called when
> +	 * device is up
> +	 */
> +	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
> +		return -EBUSY;
> +
> +	bpr =3D 0; /* Note bpr and brp are different concepts */
> +	rsj =3D bt->sjw;
> +	ps1 =3D (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
> +	ps2 =3D bt->phase_seg2;
> +	scaler =3D (bt->brp - 1);
> +	timing |=3D (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
> +	timing |=3D (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
> +	timing |=3D (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
> +	timing |=3D (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
> +	timing |=3D (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
> +
> +	netdev_info(dev, "setting timing=3D0x%x\n", timing);

what about moving the sanity check before putting together the "timing"
variable and doing the netdev_info()?

> +	if (!(ps1 > ps2)) {
> +		netdev_err(dev, "PS1 > PS2 must hold: PS1=3D%d, PS2=3D%d\n",
> +			   ps1, ps2);
> +		return -EINVAL;
> +	}
> +	if (!(ps2 >=3D rsj)) {
> +		netdev_err(dev, "PS2 >=3D RSJ must hold: PS2=3D%d, RSJ=3D%d\n",
> +			   ps2, rsj);
> +		return -EINVAL;
> +	}
> +
> +	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
> +	return 0;
> +}
> +
> +static int grcan_get_berr_counter(const struct net_device *dev,
> +				  struct can_berr_counter *bec)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	u32 status =3D grcan_read_reg(&regs->stat);
> +
> +	bec->txerr =3D (status & GRCAN_STAT_TXERRCNT) >> GRCAN_STAT_TXERRCNT_=
BIT;
> +	bec->rxerr =3D (status & GRCAN_STAT_RXERRCNT) >> GRCAN_STAT_RXERRCNT_=
BIT;
> +	return 0;
> +}
> +
> +static int grcan_poll(struct napi_struct *napi, int budget);
> +
> +/* Reset device, but keep configuration information */
> +static void grcan_reset(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	u32 config =3D grcan_read_reg(&regs->conf);
> +
> +	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
> +	grcan_write_reg(&regs->conf, config);
> +
> +	priv->eskbp =3D grcan_read_reg(&regs->txrd);
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
> +	grcan_write_reg(&regs->rxmask, 0);
> +}
> +
> +/* stop device without changing any configurations */
> +static void grcan_stop_hardware(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +
> +	grcan_write_reg(&regs->imr, GRCAN_IRQ_NONE);
> +	grcan_clear_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
> +	grcan_clear_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
> +	grcan_clear_bits(&regs->ctrl, GRCAN_CTRL_ENABLE);
> +}
> +
> +/* Let priv->eskbp catch up to regs->txrd and echo back the skbs if ec=
ho
> + * is true and free them otherwise.
> + *
> + * If budget is >=3D 0, stop after handling at most budget skbs. Other=
wise,
> + * continue until priv->eskbp catches up to regs->txrd.
> + *
> + * priv->lock *must* be held when calling this function
> + */
> +static int catch_up_echo_skb(struct net_device *dev, int budget, bool =
echo)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	struct net_device_stats *stats =3D &dev->stats;
> +	int i, work_done;
> +
> +	/* Updates to priv->eskbp and wake-ups of the queue needs to
> +	 * be atomic towards the reads of priv->eskbp and shut-downs
> +	 * of the queue in grcan_start_xmit.
> +	 */
> +	u32 txrd =3D grcan_read_reg(&regs->txrd);
> +
> +	for (work_done =3D 0; work_done < budget || budget < 0; work_done++) =
{
> +		if (priv->eskbp =3D=3D txrd)
> +			break;
> +		i =3D priv->eskbp / GRCAN_MSG_SIZE;
> +		if (echo) {
> +			/* Normal echo of messages */
> +			stats->tx_packets++;
> +			stats->tx_bytes +=3D priv->txdlc[i];
> +			priv->txdlc[i] =3D 0;
> +			can_get_echo_skb(dev, i);
> +		} else {
> +			/* For cleanup of untransmitted messages */
> +			can_free_echo_skb(dev, i);
> +		}
> +
> +		priv->eskbp =3D grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
> +					     dma->tx.size);
> +		txrd =3D grcan_read_reg(&regs->txrd);
> +	}
> +	return work_done;
> +}
> +
> +static void grcan_lost_one_shot_frame(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	u32 txrd;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	catch_up_echo_skb(dev, -1, true);
> +
> +	if (unlikely(grcan_read_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE))) {
> +		/* Should never happen */
> +		netdev_err(dev, "TXCTRL enabled at TXLOSS in one shot mode\n");
> +	} else {
> +		/* By the time an GRCAN_IRQ_TXLOSS is generated in
> +		 * one-shot mode there is no problem in writing
> +		 * to TXRD even in versions of the hardware in
> +		 * which GRCAN_TXCTRL_ONGOING is not cleared properly
> +		 * in one-shot mode.
> +		 */
> +
> +		/* Skip message and discard echo-skb */
> +		txrd =3D grcan_read_reg(&regs->txrd);
> +		txrd =3D grcan_ring_add(txrd, GRCAN_MSG_SIZE, dma->tx.size);
> +		grcan_write_reg(&regs->txrd, txrd);
> +		catch_up_echo_skb(dev, -1, false);
> +
> +		if (!priv->resetting && !priv->closing &&
> +		    !(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)) {
> +			netif_wake_queue(dev);
> +			grcan_set_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static void grcan_err(struct net_device *dev, u32 sources, u32 status)=

> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct can_frame cf;
> +
> +	/* Zero potential error_frame */
> +	memset(&cf, 0, sizeof(cf));
> +
> +	/* Message lost interrupt. This might be due to arbitration error, bu=
t
> +	 * is also triggered when there is no one else on the can bus or when=

> +	 * there is a problem with the hardware interface or the bus itself. =
As
> +	 * arbitration errors can not be singled out, no error frames are
> +	 * generated reporting this event as an arbitration error.
> +	 */
> +	if (sources & GRCAN_IRQ_TXLOSS) {
> +		/* Take care of failed one-shot transmit */
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
> +			grcan_lost_one_shot_frame(dev);
> +
> +		/* Stop printing as soon as error passive or bus off is in
> +		 * effect to limit the amount of txloss debug printouts.
> +		 */
> +		if (!(status & GRCAN_STAT_ERRCTR_RELATED)) {
> +			netdev_dbg(dev, "tx message lost\n");
> +			stats->tx_errors++;
> +		}
> +	}
> +
> +	/* Conditions dealing with the error counters. There is no interrupt =
for
> +	 * error warning, but there are interrupts for increases of the error=

> +	 * counters.
> +	 */
> +	if ((sources & GRCAN_IRQ_ERRCTR_RELATED) ||
> +	    (status & GRCAN_STAT_ERRCTR_RELATED)) {
> +		enum can_state state =3D priv->can.state;
> +		enum can_state oldstate =3D state;
> +		u32 txerr =3D (status & GRCAN_STAT_TXERRCNT)
> +			>> GRCAN_STAT_TXERRCNT_BIT;
> +		u32 rxerr =3D (status & GRCAN_STAT_RXERRCNT)
> +			>> GRCAN_STAT_RXERRCNT_BIT;
> +
> +		/* Figure out current state */
> +		if (status & GRCAN_STAT_OFF) {
> +			state =3D CAN_STATE_BUS_OFF;
> +		} else if (status & GRCAN_STAT_PASS) {
> +			state =3D CAN_STATE_ERROR_PASSIVE;
> +		} else if (txerr >=3D GRCAN_STAT_ERRCNT_WARNING_LIMIT ||
> +			   rxerr >=3D GRCAN_STAT_ERRCNT_WARNING_LIMIT) {
> +			state =3D CAN_STATE_ERROR_WARNING;
> +		} else {
> +			state =3D CAN_STATE_ERROR_ACTIVE;
> +		}
> +
> +		/* Handle and report state changes */
> +		if (state !=3D oldstate) {
> +			switch (state) {
> +			case CAN_STATE_BUS_OFF:
> +				netdev_dbg(dev, "bus-off\n");
> +				netif_carrier_off(dev);
> +				priv->can.can_stats.bus_off++;
> +
> +				/* Prevent the hardware from recovering from bus
> +				 * off on its own if restart is disabled.
> +				 */
> +				if (!priv->can.restart_ms)
> +					grcan_stop_hardware(dev);
> +
> +				cf.can_id |=3D CAN_ERR_BUSOFF;
> +				break;
> +
> +			case CAN_STATE_ERROR_PASSIVE:
> +				netdev_dbg(dev, "Error passive condition\n");
> +				priv->can.can_stats.error_passive++;
> +
> +				cf.can_id |=3D CAN_ERR_CRTL;
> +				if (txerr >=3D GRCAN_STAT_ERRCNT_PASSIVE_LIMIT)
> +					cf.data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
> +				if (rxerr >=3D GRCAN_STAT_ERRCNT_PASSIVE_LIMIT)
> +					cf.data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
> +				break;
> +
> +			case CAN_STATE_ERROR_WARNING:
> +				netdev_dbg(dev, "Error warning condition\n");
> +				priv->can.can_stats.error_warning++;
> +
> +				cf.can_id |=3D CAN_ERR_CRTL;
> +				if (txerr >=3D GRCAN_STAT_ERRCNT_WARNING_LIMIT)
> +					cf.data[1] |=3D CAN_ERR_CRTL_TX_WARNING;
> +				if (rxerr >=3D GRCAN_STAT_ERRCNT_WARNING_LIMIT)
> +					cf.data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
> +				break;
> +
> +			case CAN_STATE_ERROR_ACTIVE:
> +				netdev_dbg(dev, "Error active condition\n");
> +				cf.can_id |=3D CAN_ERR_CRTL;
> +				break;
> +
> +			default:
> +				/* There are no others at this point */
> +				break;
> +			}
> +			cf.data[6] =3D txerr;
> +			cf.data[7] =3D rxerr;
> +			priv->can.state =3D state;
> +		}
> +
> +		/* Report automatic restarts */
> +		if (priv->can.restart_ms && oldstate =3D=3D CAN_STATE_BUS_OFF) {
> +			unsigned long flags;
> +
> +			cf.can_id |=3D CAN_ERR_RESTARTED;
> +			netdev_dbg(dev, "restarted\n");
> +			priv->can.can_stats.restarts++;
> +			netif_carrier_on(dev);
> +
> +			spin_lock_irqsave(&priv->lock, flags);
> +
> +			if (!priv->resetting && !priv->closing) {
> +				u32 txwr =3D grcan_read_reg(&regs->txwr);
> +
> +				if (grcan_txspace(dma->tx.size, txwr,
> +						  priv->eskbp))
> +					netif_wake_queue(dev);
> +			}
> +
> +			spin_unlock_irqrestore(&priv->lock, flags);
> +		}
> +	}
> +
> +	/* Data overrun interrupt */
> +	if ((sources & GRCAN_IRQ_OR) || (status & GRCAN_STAT_OR)) {
> +		netdev_dbg(dev, "got data overrun interrupt\n");
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;
> +
> +		cf.can_id |=3D CAN_ERR_CRTL;
> +		cf.data[1] |=3D CAN_ERR_CRTL_RX_OVERFLOW;
> +	}
> +
> +	/* AHB bus error interrupts (not CAN bus errors) - shut down the
> +	 * device.
> +	 */
> +	if (sources & (GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR) ||
> +	    (status & GRCAN_STAT_AHBERR)) {
> +		char *txrx =3D "";
> +		unsigned long flags;
> +
> +		if (sources & GRCAN_IRQ_TXAHBERR) {
> +			txrx =3D "on tx ";
> +			stats->tx_errors++;
> +		} else if (sources & GRCAN_IRQ_RXAHBERR) {
> +			txrx =3D "on rx ";
> +			stats->rx_errors++;
> +		}
> +		netdev_err(dev, "Fatal AHB buss error %s- halting device\n",
> +			   txrx);
> +
> +		spin_lock_irqsave(&priv->lock, flags);
> +
> +		/* Prevent anything to be enabled again and halt device */
> +		priv->closing =3D true;
> +		netif_stop_queue(dev);
> +		grcan_stop_hardware(dev);
> +		priv->can.state =3D CAN_STATE_STOPPED;
> +
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +	}
> +
> +	/* Pass on error frame if something to report,
> +	 * i.e. id contains some information
> +	 */
> +	if (cf.can_id) {
> +		struct can_frame *skb_cf;
> +		struct sk_buff *skb =3D alloc_can_err_skb(dev, &skb_cf);
> +
> +		if (skb =3D=3D NULL) {
> +			netdev_dbg(dev, "could not allocate error frame\n");
> +			return;
> +		}
> +		skb_cf->can_id |=3D cf.can_id;
> +		memcpy(skb_cf->data, cf.data, sizeof(cf.data));
> +
> +		netif_rx(skb);
> +	}
> +}
> +
> +static irqreturn_t grcan_interrupt(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	u32 sources, status;
> +
> +	/* Find out the source */
> +	sources =3D grcan_read_reg(&regs->pimsr);
> +	if (!sources)
> +		return IRQ_NONE;
> +	grcan_write_reg(&regs->picr, sources);
> +	status =3D grcan_read_reg(&regs->stat);
> +
> +	/* If we got TX progress, the device has not hanged,
> +	 * so disable the hang timer
> +	 */
> +	if (priv->need_txbug_workaround &&
> +	    (sources & (GRCAN_IRQ_TX | GRCAN_IRQ_TXLOSS))) {
> +		del_timer(&priv->hang_timer);
> +	}
> +
> +	/* Frame(s) received or transmitted */
> +	if (sources & (GRCAN_IRQ_TX | GRCAN_IRQ_RX)) {
> +		/* Disable tx/rx interrupts and schedule poll() */
> +		grcan_clear_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
> +		napi_schedule(&priv->napi);
> +	}
> +
> +	/* (Potential) error conditions to take care of */
> +	if (sources & GRCAN_IRQ_ERRORS)
> +		grcan_err(dev, sources, status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Reset device and restart operations from where they were.
> + *
> + * This assumes that RXCTRL & RXCTRL is properly disabled and that RX
> + * is not ONGOING (TX might be stuck in ONGOING due to a harwrware bug=

> + * for single shot)
> + */
> +static void grcan_running_reset(unsigned long data)
> +{
> +	struct net_device *dev =3D (struct net_device *)data;
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	unsigned long flags;
> +
> +	/* This temporarily messes with eskbp, so we need to lock
> +	 * priv->lock
> +	 */
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	priv->resetting =3D false;
> +	del_timer(&priv->hang_timer);
> +	del_timer(&priv->rr_timer);
> +
> +	if (!priv->closing) {
> +		/* Save and reset - config register preserved by grcan_reset */
> +		u32 imr =3D grcan_read_reg(&regs->imr);
> +
> +		u32 txaddr =3D grcan_read_reg(&regs->txaddr);
> +		u32 txsize =3D grcan_read_reg(&regs->txsize);
> +		u32 txwr =3D grcan_read_reg(&regs->txwr);
> +		u32 txrd =3D grcan_read_reg(&regs->txrd);
> +		u32 eskbp =3D priv->eskbp;
> +
> +		u32 rxaddr =3D grcan_read_reg(&regs->rxaddr);
> +		u32 rxsize =3D grcan_read_reg(&regs->rxsize);
> +		u32 rxwr =3D grcan_read_reg(&regs->rxwr);
> +		u32 rxrd =3D grcan_read_reg(&regs->rxrd);
> +
> +		grcan_reset(dev);
> +
> +		/* Restore */
> +		grcan_write_reg(&regs->txaddr, txaddr);
> +		grcan_write_reg(&regs->txsize, txsize);
> +		grcan_write_reg(&regs->txwr, txwr);
> +		grcan_write_reg(&regs->txrd, txrd);
> +		priv->eskbp =3D eskbp;
> +
> +		grcan_write_reg(&regs->rxaddr, rxaddr);
> +		grcan_write_reg(&regs->rxsize, rxsize);
> +		grcan_write_reg(&regs->rxwr, rxwr);
> +		grcan_write_reg(&regs->rxrd, rxrd);
> +
> +		/* Turn on device again */
> +		grcan_write_reg(&regs->imr, imr);
> +		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +		grcan_write_reg(&regs->txctrl, GRCAN_TXCTRL_ENABLE
> +				| (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
> +				   ? GRCAN_TXCTRL_SINGLE : 0));
> +		grcan_write_reg(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
> +		grcan_write_reg(&regs->ctrl, GRCAN_CTRL_ENABLE);
> +
> +		/* Start queue if there is size and listen-onle mode is not
> +		 * enabled
> +		 */
> +		if (grcan_txspace(priv->dma.tx.size, txwr, priv->eskbp) &&
> +		    !(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
> +			netif_wake_queue(dev);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	netdev_err(dev, "Device reset and restored\n");
> +}
> +
> +/* Waiting time in usecs corresponding to the transmission of three ma=
ximum
> + * sized can frames in the given bitrate (in bits/sec). Waiting for th=
is amount
> + * of time makes sure that the can controller have time to finish send=
ing or
> + * receiving a frame with a good margin.
> + *
> + * usecs/sec * number of frames * bits/frame / bits/sec
> + */
> +static inline u32 grcan_ongoing_wait_usecs(__u32 bitrate)
> +{
> +	return 1000000 * 3 * GRCAN_EFF_FRAME_MAX_BITS / bitrate;
> +}
> +
> +/* Set timer so that it will not fire until after a period in which th=
e can
> + * controller have a good margin to finish transmitting a frame unless=
 it has
> + * hanged
> + */
> +static inline void grcan_reset_timer(struct timer_list *timer, __u32 b=
itrate)
> +{
> +	u32 wait_jiffies =3D usecs_to_jiffies(grcan_ongoing_wait_usecs(bitrat=
e));
> +
> +	mod_timer(timer, jiffies + wait_jiffies);
> +}
> +
> +/* Disable channels and schedule a running reset */
> +static void grcan_initiate_running_reset(unsigned long data)
> +{
> +	struct net_device *dev =3D (struct net_device *)data;
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	unsigned long flags;
> +
> +	netdev_err(dev, "Device seems hanged - reset scheduled\n");
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* The main body of this function must never be executed again
> +	 * until after an execution of grcan_running_reset
> +	 */
> +	if (!priv->resetting && !priv->closing) {
> +		priv->resetting =3D true;
> +		netif_stop_queue(dev);
> +		grcan_clear_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
> +		grcan_clear_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
> +		grcan_reset_timer(&priv->rr_timer, priv->can.bittiming.bitrate);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static void grcan_free_dma_buffers(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_dma *dma =3D &priv->dma;
> +
> +	dma_free_coherent(&dev->dev, dma->base_size, dma->base_buf,
> +			  dma->base_handle);
> +	memset(dma, 0, sizeof(*dma));
> +}
> +
> +static int grcan_allocate_dma_buffers(struct net_device *dev,
> +				      size_t tsize, size_t rsize)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_dma *dma =3D &priv->dma;
> +	struct grcan_dma_buffer *large =3D rsize > tsize ? &dma->rx : &dma->t=
x;
> +	struct grcan_dma_buffer *small =3D rsize > tsize ? &dma->tx : &dma->r=
x;
> +	size_t shift;
> +
> +	/* Need a whole number of GRCAN_BUFFER_ALIGNMENT for the large,
> +	 * i.e. first buffer
> +	 */
> +	size_t maxs =3D max(tsize, rsize);
> +	size_t lsize =3D ALIGN(maxs, GRCAN_BUFFER_ALIGNMENT);
> +
> +	/* Put the small buffer after that */
> +	size_t ssize =3D min(tsize, rsize);
> +
> +	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
> +	dma->base_size =3D lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
> +	dma->base_buf =3D dma_alloc_coherent(&dev->dev,
> +					   dma->base_size,
> +					   &dma->base_handle,
> +					   GFP_KERNEL);
> +
> +	if (!dma->base_buf)
> +		return -ENOMEM;
> +
> +	dma->tx.size =3D tsize;
> +	dma->rx.size =3D rsize;
> +
> +	large->handle =3D ALIGN(dma->base_handle, GRCAN_BUFFER_ALIGNMENT);
> +	small->handle =3D large->handle + lsize;
> +	shift =3D large->handle - dma->base_handle;
> +
> +	large->buf =3D dma->base_buf + shift;
> +	small->buf =3D large->buf + lsize;
> +
> +	return 0;
> +}
> +
> +/* priv->lock *must* be held when calling this function */
> +static int grcan_start(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	u32 confop, txctrl;
> +
> +	grcan_reset(dev);
> +
> +	grcan_write_reg(&regs->txaddr, priv->dma.tx.handle);
> +	grcan_write_reg(&regs->txsize, priv->dma.tx.size);
> +	/* regs->txwr, regs->txrd and priv->eskbp already set to 0 by reset *=
/
> +
> +	grcan_write_reg(&regs->rxaddr, priv->dma.rx.handle);
> +	grcan_write_reg(&regs->rxsize, priv->dma.rx.size);
> +	/* regs->rxwr and regs->rxrd already set to 0 by reset */
> +
> +	/* Enable interrupts */
> +	grcan_read_reg(&regs->pir);
> +	grcan_write_reg(&regs->imr, GRCAN_IRQ_DEFAULT);
> +
> +	/* Enable interfaces, channels and device */
> +	confop =3D GRCAN_CONF_ABORT
> +		| (priv->config.enable0 ? GRCAN_CONF_ENABLE0 : 0)
> +		| (priv->config.enable1 ? GRCAN_CONF_ENABLE1 : 0)
> +		| (priv->config.select ? GRCAN_CONF_SELECT : 0)
> +		| (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ?
> +		   GRCAN_CONF_SILENT : 0)
> +		| (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES ?
> +		   GRCAN_CONF_SAM : 0);
> +	grcan_write_bits(&regs->conf, confop, GRCAN_CONF_OPERATION);
> +	txctrl =3D GRCAN_TXCTRL_ENABLE
> +		| (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
> +		   ? GRCAN_TXCTRL_SINGLE : 0);
> +	grcan_write_reg(&regs->txctrl, txctrl);
> +	grcan_write_reg(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
> +	grcan_write_reg(&regs->ctrl, GRCAN_CTRL_ENABLE);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	unsigned long flags;
> +	int err =3D 0;
> +
> +	if (mode =3D=3D CAN_MODE_START) {
> +		/* This might be called to restart the device to recover from
> +		 * bus off errors
> +		 */
> +		spin_lock_irqsave(&priv->lock, flags);
> +		if (priv->closing || priv->resetting) {
> +			err =3D -EBUSY;
> +		} else {
> +			netdev_info(dev, "Restarting device\n");
> +			grcan_start(dev);
> +			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
> +				netif_wake_queue(dev);
> +		}
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		return err;
> +	}
> +	return -EOPNOTSUPP;
> +}
> +
> +static int grcan_open(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_dma *dma =3D &priv->dma;
> +	unsigned long flags;
> +	int err;
> +
> +	/* Allocate memory */
> +	err =3D grcan_allocate_dma_buffers(dev, priv->config.txsize,
> +					 priv->config.rxsize);
> +	if (err) {
> +		netdev_err(dev, "could not allocate DMA buffers\n");
> +		return err;
> +	}
> +
> +	priv->echo_skb =3D kzalloc(dma->tx.size * sizeof(*priv->echo_skb),
> +				 GFP_KERNEL);
> +	if (!priv->echo_skb) {
> +		err =3D -ENOMEM;
> +		goto exit_free_dma_buffers;
> +	}
> +	priv->can.echo_skb_max =3D dma->tx.size;
> +	priv->can.echo_skb =3D priv->echo_skb;
> +
> +	priv->txdlc =3D kzalloc(dma->tx.size * sizeof(*priv->txdlc), GFP_KERN=
EL);
> +	if (!priv->txdlc) {
> +		err =3D -ENOMEM;
> +		goto exit_free_echo_skb;
> +	}
> +
> +	/* Get can device up */
> +	err =3D open_candev(dev);
> +	if (err)
> +		goto exit_free_txdlc;
> +
> +	err =3D request_irq(dev->irq, grcan_interrupt, IRQF_SHARED,
> +			  dev->name, dev);
> +	if (err)
> +		goto exit_close_candev;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	napi_enable(&priv->napi);
> +	grcan_start(dev);
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
> +		netif_start_queue(dev);
> +	priv->resetting =3D false;
> +	priv->closing =3D false;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +
> +exit_close_candev:
> +	close_candev(dev);
> +exit_free_txdlc:
> +	kfree(priv->txdlc);
> +exit_free_echo_skb:
> +	kfree(priv->echo_skb);
> +exit_free_dma_buffers:
> +	grcan_free_dma_buffers(dev);
> +	return err;
> +}
> +
> +static int grcan_close(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	unsigned long flags;
> +
> +	napi_disable(&priv->napi);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	priv->closing =3D true;
> +	if (priv->need_txbug_workaround) {
> +		del_timer_sync(&priv->hang_timer);
> +		del_timer_sync(&priv->rr_timer);
> +	}
> +	netif_stop_queue(dev);
> +	grcan_stop_hardware(dev);
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	free_irq(dev->irq, dev);
> +	close_candev(dev);
> +
> +	grcan_free_dma_buffers(dev);
> +	priv->can.echo_skb_max =3D 0;
> +	priv->can.echo_skb =3D NULL;
> +	kfree(priv->echo_skb);
> +	kfree(priv->txdlc);
> +
> +	return 0;
> +}
> +
> +static void grcan_transmit_catch_up(struct net_device *dev, int budget=
)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	unsigned long flags;
> +	int work_done;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	work_done =3D catch_up_echo_skb(dev, budget, true);
> +	if (work_done) {
> +		if (!priv->resetting && !priv->closing &&
> +		    !(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
> +			netif_wake_queue(dev);
> +
> +		/* With napi we don't get TX interrupts for a while,
> +		 * so prevent a running reset while catching up
> +		 */
> +		if (priv->need_txbug_workaround)
> +			del_timer(&priv->hang_timer);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int grcan_receive(struct net_device *dev, int budget)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	struct net_device_stats *stats =3D &dev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u32 wr, rd, startrd;
> +	u32 *slot;
> +	u32 i, rtr, eff, j, shift;
> +	int work_done =3D 0;
> +
> +	rd =3D grcan_read_reg(&regs->rxrd);
> +	startrd =3D rd;
> +	for (work_done =3D 0; work_done < budget; work_done++) {
> +		/* Check for packet to receive */
> +		wr =3D grcan_read_reg(&regs->rxwr);
> +		if (rd =3D=3D wr)
> +			break;
> +
> +		/* Take care of packet */
> +		skb =3D alloc_can_skb(dev, &cf);
> +		if (skb =3D=3D NULL) {
> +			netdev_err(dev,
> +				   "dropping frame: skb allocation failed\n");
> +			stats->rx_dropped++;
> +			continue;
> +		}
> +
> +		slot =3D dma->rx.buf + rd;
> +		eff =3D slot[0] & GRCAN_MSG_IDE;
> +		rtr =3D slot[0] & GRCAN_MSG_RTR;
> +		if (eff) {
> +			cf->can_id =3D ((slot[0] & GRCAN_MSG_EID)
> +				      >> GRCAN_MSG_EID_BIT);
> +			cf->can_id |=3D CAN_EFF_FLAG;
> +		} else {
> +			cf->can_id =3D ((slot[0] & GRCAN_MSG_BID)
> +				      >> GRCAN_MSG_BID_BIT);
> +		}
> +		cf->can_dlc =3D get_can_dlc((slot[1] & GRCAN_MSG_DLC)
> +					  >> GRCAN_MSG_DLC_BIT);
> +		if (rtr) {
> +			cf->can_id |=3D CAN_RTR_FLAG;
> +		} else {
> +			for (i =3D 0; i < cf->can_dlc; i++) {
> +				j =3D GRCAN_MSG_DATA_SLOT_INDEX(i);
> +				shift =3D GRCAN_MSG_DATA_SHIFT(i);
> +				cf->data[i] =3D (u8)(slot[j] >> shift);
> +			}
> +		}
> +		netif_receive_skb(skb);
> +
> +		/* Update statistics and read pointer */
> +		stats->rx_packets++;
> +		stats->rx_bytes +=3D cf->can_dlc;
> +		rd =3D grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
> +	}
> +
> +	/* Make sure everything is read before allowing hardware to
> +	 * use the memory
> +	 */
> +	mb();
> +
> +	/* Update read pointer - no need to check for ongoing */
> +	if (likely(rd !=3D startrd))
> +		grcan_write_reg(&regs->rxrd, rd);
> +
> +	return work_done;
> +}
> +
> +/* priv->lock *must* be held when calling this function */
> +static inline int grcan_poll_all_done(struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	u32 txrd =3D grcan_read_reg(&regs->txrd);
> +	u32 rxwr =3D grcan_read_reg(&regs->rxwr);
> +	u32 rxrd =3D grcan_read_reg(&regs->rxrd);
> +
> +	return priv->eskbp =3D=3D txrd && rxwr =3D=3D rxrd;
> +}
> +
> +static int grcan_poll(struct napi_struct *napi, int rx_budget)
> +{
> +	struct grcan_priv *priv =3D container_of(napi, struct grcan_priv, nap=
i);
> +	struct net_device *dev =3D priv->dev;
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	int rx_work_done;
> +	unsigned long flags;
> +
> +	/* Receive according to given budget */
> +	rx_work_done =3D grcan_receive(dev, rx_budget);
> +
> +	/* Catch up echo skb according to separate budget to get the benefits=
 of
> +	 * napi for tx as well. The given rx_budget might not be appropriate =
for
> +	 * the tx side.
> +	 */
> +	grcan_transmit_catch_up(dev, GRCAN_TX_BUDGET);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	if (grcan_poll_all_done(dev)) {

Just make it:
	if (work_done < budget) {
		napi_complete();
		enable_interrupts();
	}

If there are CAN frames pending, an interrupt will kick in and
reschedule the NAPI.

> +		bool complete =3D true;
> +
> +		if (!priv->closing) {
> +			/* Enable tx and rx interrupts again */
> +			grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
> +
> +			/* If more work arrived between detecting completion and
> +			 * turning on interrupts, we need to keep napi running
> +			 */
> +			if (!grcan_poll_all_done(dev)) {
> +				complete =3D false;
> +				grcan_clear_bits(&regs->imr,
> +						 GRCAN_IRQ_TX | GRCAN_IRQ_RX);
> +			}
> +		}
> +		if (complete)
> +			napi_complete(napi);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return rx_work_done;
> +}
> +
> +/* Work tx bug by waiting while for the risky situation to clear. If t=
hat fails,
> + * drop a frame in one-shot mode or indicate a busy device otherwise.
> + *
> + * Returns 0 on successful wait. Otherwise it sets *netdev_tx_status t=
o the
> + * value that should be returned by grcan_start_xmit when aborting the=
 xmit.
> + */
> +static int grcan_txbug_workaround(struct net_device *dev, struct sk_bu=
ff *skb,
> +				  u32 txwr, u32 oneshotmode,
> +				  netdev_tx_t *netdev_tx_status)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	int i;
> +	unsigned long flags;
> +
> +	/* Wait a while for ongoing to be cleared or read pointer to catch up=
 to
> +	 * write pointer. The latter is needed due to a bug in older versions=
 of
> +	 * GRCAN in which ONGOING is not cleared properly one-shot mode when =
a
> +	 * transmission fails.
> +	 */
> +	for (i =3D 0; i < GRCAN_SHORTWAIT_USECS; i++) {
> +		udelay(1);
> +		if (!grcan_read_bits(&regs->txctrl, GRCAN_TXCTRL_ONGOING) ||
> +		    grcan_read_reg(&regs->txrd) =3D=3D txwr) {
> +			return 0;
> +		}
> +	}
> +
> +	/* Clean up, in case the situation was not resolved */
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (!priv->resetting && !priv->closing) {
> +		/* Queue might have been stopped earlier in grcan_start_xmit */
> +		if (grcan_txspace(dma->tx.size, txwr, priv->eskbp))
> +			netif_wake_queue(dev);
> +		/* Set a timer to resolve a hanged tx controller */
> +		if (!timer_pending(&priv->hang_timer))
> +			grcan_reset_timer(&priv->hang_timer,
> +					  priv->can.bittiming.bitrate);
> +	}
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	if (oneshotmode) {
> +		/* In one-shot mode we should never end up here because
> +		 * then the interrupt handler increases txrd on TXLOSS,
> +		 * but it is consistent with one-shot mode to drop the
> +		 * frame in this case.
> +		 */
> +		kfree_skb(skb);
> +		*netdev_tx_status =3D NETDEV_TX_OK;
> +	} else {
> +		/* In normal mode the socket-can transmission queue get
> +		 * to keep the frame so that it can be retransmitted
> +		 * later
> +		 */
> +		*netdev_tx_status =3D NETDEV_TX_BUSY;
> +	}
> +	return -EBUSY;
> +}
> +
> +/* Notes on the tx cyclic buffer handling:
> + *
> + * regs->txwr	- the next slot for the driver to put data to be sent
> + * regs->txrd	- the next slot for the device to read data
> + * priv->eskbp	- the next slot for the driver to call can_put_echo_skb=
 for
> + *
> + * grcan_start_xmit can enter more messages as long as regs->txwr does=

> + * not reach priv->eskbp (within 1 message gap)
> + *
> + * The device sends messages until regs->txrd reaches regs->txwr
> + *
> + * The interrupt calls handler calls can_put_echo_skb until
> + * priv->eskbp reaches regs->txrd
> + */
> +static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +	struct grcan_registers __iomem *regs =3D priv->regs;
> +	struct grcan_dma *dma =3D &priv->dma;
> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
> +	u32 id, txwr, txrd, space, txctrl;
> +	int slotindex;
> +	u32 *slot;
> +	u32 i, rtr, eff, dlc, tmp, err;
> +	int j, shift;
> +	unsigned long flags;
> +	u32 oneshotmode =3D priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	/* Trying to transmit in silent mode will generate error interrupts, =
but
> +	 * this should never happen - the queue should not have been started.=

> +	 */
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		return NETDEV_TX_BUSY;
> +
> +	/* Reads of priv->eskbp and shut-downs of the queue needs to
> +	 * be atomic towards the updates to priv->eskbp and wake-ups
> +	 * of the queue in the interrupt handler.
> +	 */
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	txwr =3D grcan_read_reg(&regs->txwr);
> +	space =3D grcan_txspace(dma->tx.size, txwr, priv->eskbp);
> +
> +	slotindex =3D txwr / GRCAN_MSG_SIZE;
> +	slot =3D dma->tx.buf + txwr;
> +
> +	if (unlikely(space =3D=3D 1))
> +		netif_stop_queue(dev);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +	/* End of critical section*/
> +
> +	/* This should never happen. If circular buffer is full, the
> +	 * netif_stop_queue should have been stopped already.
> +	 */
> +	if (unlikely(!space)) {
> +		netdev_err(dev, "No buffer space, but queue is non-stopped.\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	/* Convert and write CAN message to DMA buffer */
> +	eff =3D cf->can_id & CAN_EFF_FLAG;
> +	rtr =3D cf->can_id & CAN_RTR_FLAG;
> +	id =3D cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
> +	dlc =3D cf->can_dlc;
> +	if (eff)
> +		tmp =3D (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
> +	else
> +		tmp =3D (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
> +	slot[0] =3D (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | t=
mp;
> +
> +	slot[1] =3D ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
> +	slot[2] =3D 0;
> +	slot[3] =3D 0;
> +	for (i =3D 0; i < dlc; i++) {
> +		j =3D GRCAN_MSG_DATA_SLOT_INDEX(i);
> +		shift =3D GRCAN_MSG_DATA_SHIFT(i);
> +		slot[j] |=3D cf->data[i] << shift;
> +	}
> +
> +	/* Checking that channel has not been disabled. These cases
> +	 * should never happen
> +	 */
> +	txctrl =3D grcan_read_reg(&regs->txctrl);
> +	if (!(txctrl & GRCAN_TXCTRL_ENABLE))
> +		netdev_err(dev, "tx channel spuriously disabled\n");
> +
> +	if (oneshotmode && !(txctrl & GRCAN_TXCTRL_SINGLE))
> +		netdev_err(dev, "one-shot mode spuriously disabled\n");
> +
> +	/* Bug workaround for old version of grcan where updating txwr
> +	 * in the same clock cycle as the controller updates txrd to
> +	 * the current txwr could hang the can controller
> +	 */
> +	if (priv->need_txbug_workaround) {
> +		txrd =3D grcan_read_reg(&regs->txrd);
> +		if (unlikely(grcan_ring_sub(txwr, txrd, dma->tx.size) =3D=3D 1)) {
> +			netdev_tx_t txstatus;
> +
> +			err =3D grcan_txbug_workaround(dev, skb, txwr,
> +						     oneshotmode, &txstatus);
> +			if (err)
> +				return txstatus;
> +		}
> +	}
> +
> +	/* Prepare skb for echoing. This must be after the bug workaround abo=
ve
> +	 * as ownership of the skb is passed on by calling can_put_echo_skb.
> +	 * Returning NETDEV_TX_BUSY or accessing skb or cf after a call to
> +	 * can_put_echo_skb would be an error unless other measures are
> +	 * taken.
> +	 */
> +	priv->txdlc[slotindex] =3D cf->can_dlc; /* Store dlc for statistics *=
/
> +	can_put_echo_skb(skb, dev, slotindex);
> +
> +	/* Make sure everything is written before allowing hardware to
> +	 * read from the memory
> +	 */
> +	wmb();
> +
> +	/* Update write pointer to start transmission */
> +	grcan_write_reg(&regs->txwr,
> +			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Setting up sysfs interface and modul=
e parameters =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +
> +#define GRCAN_NOT_BOOL(unsigned_val) ((unsigned_val) > 1)
> +
> +#define GRCAN_MODULE_PARAM(name, mtype, valcheckf, desc)		\
> +	static void grcan_sanitize_##name(struct platform_device *pd)	\
> +	{								\
> +		struct grcan_device_config grcan_default_config		\
> +			=3D GRCAN_DEFAULT_DEVICE_CONFIG;			\
> +		if (valcheckf(grcan_module_config.name)) {		\
> +			dev_err(&pd->dev,				\
> +				"Invalid module parameter value for "	\
> +				#name " - setting default\n");		\
> +			grcan_module_config.name =3D			\
> +				grcan_default_config.name;		\
> +		}							\
> +	}								\
> +	module_param_named(name, grcan_module_config.name,		\
> +			   mtype, S_IRUGO);				\
> +	MODULE_PARM_DESC(name, desc)
> +
> +#define GRCAN_CONFIG_ATTR(name, desc)					\
> +	static ssize_t grcan_store_##name(struct device *sdev,		\
> +					  struct device_attribute *att,	\
> +					  const char *buf,		\
> +					  size_t count)			\
> +	{								\
> +		struct net_device *dev =3D to_net_dev(sdev);		\
> +		struct grcan_priv *priv =3D netdev_priv(dev);		\
> +		u8 val;							\
> +		int ret;						\
> +		if (dev->flags & IFF_UP)				\
> +			return -EBUSY;					\
> +		ret =3D kstrtou8(buf, 0, &val);				\
> +		if (ret < 0 || val > 1)					\
> +			return -EINVAL;					\
> +		priv->config.name =3D val;				\
> +		return count;						\
> +	}								\
> +	static ssize_t grcan_show_##name(struct device *sdev,		\
> +					 struct device_attribute *att,	\
> +					 char *buf)			\
> +	{								\
> +		struct net_device *dev =3D to_net_dev(sdev);		\
> +		struct grcan_priv *priv =3D netdev_priv(dev);		\
> +		return sprintf(buf, "%d\n", priv->config.name);		\
> +	}								\
> +	static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,			\
> +			   grcan_show_##name,				\
> +			   grcan_store_##name);				\
> +	GRCAN_MODULE_PARAM(name, ushort, GRCAN_NOT_BOOL, desc)
> +
> +/* The following configuration options are made available both via mod=
ule
> + * parameters and writable sysfs files. See the chapter about GRCAN in=
 the
> + * documentation for the GRLIB VHDL library for further details.
> + */
> +GRCAN_CONFIG_ATTR(enable0,
> +		  "Configuration of physical interface 0. Determines\n"	\
> +		  "the \"Enable 0\" bit of the configuration register.\n" \
> +		  "Format: 0 | 1\nDefault: 0\n");
> +
> +GRCAN_CONFIG_ATTR(enable1,
> +		  "Configuration of physical interface 1. Determines\n"	\
> +		  "the \"Enable 1\" bit of the configuration register.\n" \
> +		  "Format: 0 | 1\nDefault: 0\n");
> +
> +GRCAN_CONFIG_ATTR(select,
> +		  "Select which physical interface to use.\n"	\
> +		  "Format: 0 | 1\nDefault: 0\n");
> +
> +/* The tx and rx buffer size configuration options are only available =
via module
> + * parameters.
> + */
> +GRCAN_MODULE_PARAM(txsize, uint, GRCAN_INVALID_BUFFER_SIZE,
> +		   "Sets the size of the tx buffer.\n"			\
> +		   "Format: <unsigned int> where (txsize & ~0x1fffc0) =3D=3D 0\n" \
> +		   "Default: 1024\n");
> +GRCAN_MODULE_PARAM(rxsize, uint, GRCAN_INVALID_BUFFER_SIZE,
> +		   "Sets the size of the rx buffer.\n"			\
> +		   "Format: <unsigned int> where (size & ~0x1fffc0) =3D=3D 0\n" \
> +		   "Default: 1024\n");
> +
> +/* Function that makes sure that configuration done using
> + * module parameters are set to valid values
> + */
> +static void grcan_sanitize_module_config(struct platform_device *ofdev=
)
> +{
> +	grcan_sanitize_enable0(ofdev);
> +	grcan_sanitize_enable1(ofdev);
> +	grcan_sanitize_select(ofdev);
> +	grcan_sanitize_txsize(ofdev);
> +	grcan_sanitize_rxsize(ofdev);
> +}
> +
> +static const struct attribute *const sysfs_grcan_attrs[] =3D {
> +	/* Config attrs */
> +	&dev_attr_enable0.attr,
> +	&dev_attr_enable1.attr,
> +	&dev_attr_select.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group sysfs_grcan_group =3D {
> +	.name	=3D "grcan",
> +	.attrs	=3D (struct attribute **)sysfs_grcan_attrs,
> +};
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Setting up the driver =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
> +
> +static const struct net_device_ops grcan_netdev_ops =3D {
> +	.ndo_open	=3D grcan_open,
> +	.ndo_stop	=3D grcan_close,
> +	.ndo_start_xmit	=3D grcan_start_xmit,
> +};
> +
> +static int grcan_setup_netdev(struct platform_device *ofdev,
> +			      void __iomem *base,
> +			      int irq, u32 ambafreq, bool txbug)
> +{
> +	struct net_device *dev;
> +	struct grcan_priv *priv;
> +	struct grcan_registers __iomem *regs;
> +	int err;
> +
> +	dev =3D alloc_candev(sizeof(struct grcan_priv), 0);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->irq =3D irq;
> +	dev->flags |=3D IFF_ECHO;
> +	dev->netdev_ops =3D &grcan_netdev_ops;
> +	dev->sysfs_groups[0] =3D &sysfs_grcan_group;
> +
> +	priv =3D netdev_priv(dev);
> +	memcpy(&priv->config, &grcan_module_config,
> +	       sizeof(struct grcan_device_config));
> +	priv->dev =3D dev;
> +	priv->regs =3D base;
> +	priv->can.bittiming_const =3D &grcan_bittiming_const;
> +	priv->can.do_set_bittiming =3D grcan_set_bittiming;
> +	priv->can.do_set_mode =3D grcan_set_mode;
> +	priv->can.do_get_berr_counter =3D grcan_get_berr_counter;
> +	priv->can.clock.freq =3D ambafreq;
> +	priv->can.ctrlmode_supported =3D
> +		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
> +	priv->need_txbug_workaround =3D txbug;
> +
> +	/* Discover if triple sampling is supported by hardware */
> +	regs =3D priv->regs;
> +	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
> +	grcan_set_bits(&regs->conf, GRCAN_CONF_SAM);
> +	if (grcan_read_bits(&regs->conf, GRCAN_CONF_SAM)) {
> +		priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_3_SAMPLES;
> +		dev_dbg(&ofdev->dev, "Hardware supports triple-sampling\n");
> +	}
> +
> +	spin_lock_init(&priv->lock);
> +
> +	if (priv->need_txbug_workaround) {
> +		init_timer(&priv->rr_timer);
> +		priv->rr_timer.function =3D grcan_running_reset;
> +		priv->rr_timer.data =3D (unsigned long)dev;
> +
> +		init_timer(&priv->hang_timer);
> +		priv->hang_timer.function =3D grcan_initiate_running_reset;
> +		priv->hang_timer.data =3D (unsigned long)dev;
> +	}
> +
> +	netif_napi_add(dev, &priv->napi, grcan_poll, GRCAN_NAPI_WEIGHT);
> +
> +	SET_NETDEV_DEV(dev, &ofdev->dev);
> +	dev_info(&ofdev->dev, "regs=3D0x%p, irq=3D%d, clock=3D%d\n",
> +		 priv->regs, dev->irq, priv->can.clock.freq);
> +
> +	err =3D register_candev(dev);
> +	if (err)
> +		goto exit_free_candev;
> +
> +	dev_set_drvdata(&ofdev->dev, dev);
> +
> +	/* Reset device to allow bit-timing to be set. No need to call
> +	 * grcan_reset at this stage. That is done in grcan_open.
> +	 */
> +	grcan_write_reg(&regs->ctrl, GRCAN_CTRL_RESET);
> +
> +	return 0;
> +exit_free_candev:
> +	free_candev(dev);
> +	return err;
> +}
> +
> +static int __devinit grcan_probe(struct platform_device *ofdev)
> +{
> +	struct device_node *np =3D ofdev->dev.of_node;
> +	struct resource *res;
> +	u32 sysid, ambafreq;
> +	int irq, err;
> +	void __iomem *base;
> +	bool txbug =3D true;
> +
> +	/* Compare GRLIB version number with the first that does not
> +	 * have the tx bug (see start_xmit)
> +	 */
> +	err =3D of_property_read_u32(np, "systemid", &sysid);
> +	if (!err && ((sysid & GRLIB_VERSION_MASK)
> +		     >=3D GRCAN_TXBUG_SAFE_GRLIB_VERSION))
> +		txbug =3D false;
> +
> +	err =3D of_property_read_u32(np, "freq", &ambafreq);
> +	if (err) {
> +		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
> +		goto exit_error;
> +	}
> +
> +	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> +	base =3D devm_request_and_ioremap(&ofdev->dev, res);
> +	if (!base) {
> +		dev_err(&ofdev->dev, "couldn't map IO resource\n");
> +		err =3D -EADDRNOTAVAIL;
> +		goto exit_error;
> +	}
> +
> +	irq =3D irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
> +	if (!irq) {
> +		dev_err(&ofdev->dev, "no irq found\n");
> +		err =3D -ENODEV;
> +		goto exit_error;
> +	}
> +
> +	grcan_sanitize_module_config(ofdev);
> +
> +	err =3D grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
> +	if (err)
> +		goto exit_dispose_irq;
> +
> +	return 0;
> +
> +exit_dispose_irq:
> +	irq_dispose_mapping(irq);
> +exit_error:
> +	dev_err(&ofdev->dev,
> +		"%s socket CAN driver initialization failed with error %d\n",
> +		DRV_NAME, err);
> +	return err;
> +}
> +
> +static int __devexit grcan_remove(struct platform_device *ofdev)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(&ofdev->dev);
> +	struct grcan_priv *priv =3D netdev_priv(dev);
> +
> +	unregister_candev(dev); /* Will in turn call grcan_close */
> +
> +	irq_dispose_mapping(dev->irq);
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +	netif_napi_del(&priv->napi);
> +	free_candev(dev);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id grcan_match[] =3D {

static const struct of_device_id grcan_match[] __devinitconst =3D {

> +	{.name =3D "GAISLER_GRCAN"},
> +	{.name =3D "01_03d"},
> +	{.name =3D "GAISLER_GRHCAN"},
> +	{.name =3D "01_034"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, grcan_match);
> +
> +static struct platform_driver grcan_driver =3D {
> +	.driver =3D {
> +		.name =3D DRV_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D grcan_match,
> +	},
> +	.probe =3D grcan_probe,
> +	.remove =3D __devexit_p(grcan_remove),
> +};
> +
> +module_platform_driver(grcan_driver);
> +
> +MODULE_AUTHOR("Aeroflex Gaisler AB.");
> +MODULE_DESCRIPTION("Socket CAN driver for Aeroflex Gaisler GRCAN");
> +MODULE_LICENSE("GPL");
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1B400DDAA624B95D5122E5DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCiuIoACgkQjTAFq1RaXHNWqACfYIiXuuhIJ8wWQJosx8qUpneo
6aMAnA4ILiLNkfDIR+7gw1WdxRJwSHjQ
=0Ktp
-----END PGP SIGNATURE-----

--------------enig1B400DDAA624B95D5122E5DD--

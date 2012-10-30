From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Tue, 30 Oct 2012 10:06:57 +0100
Message-ID: <1351588017-14357-1-git-send-email-andreas@gaisler.com>
References: <5087EDBF.2040108@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:47581 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751394Ab2J3JHP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Oct 2012 05:07:15 -0400
In-Reply-To: <5087EDBF.2040108@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

This driver supports GRCAN and CRHCAN CAN controllers available in the GRLIB
VHDL IP core library.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 Documentation/ABI/testing/sysfs-class-net-grcan    |   35 +
 .../devicetree/bindings/net/can/grcan.txt          |   27 +
 Documentation/kernel-parameters.txt                |   25 +
 drivers/net/can/Kconfig                            |    9 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/grcan.c                            | 1616 ++++++++++++++++++++
 6 files changed, 1713 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-net-grcan
 create mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
 create mode 100644 drivers/net/can/grcan.c

diff --git a/Documentation/ABI/testing/sysfs-class-net-grcan b/Documentation/ABI/testing/sysfs-class-net-grcan
new file mode 100644
index 0000000..8fa2f90
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-net-grcan
@@ -0,0 +1,35 @@
+
+What:		/sys/class/net/<iface>/grcan/enable0
+Date:		October 2012
+KernelVersion:	3.8
+Contact:	Andreas Larsson <andreas@gaisler.com>
+Description:
+		Hardware configuration of physical interface 0. This file reads
+		and writes the "Enable 0" bit of the configuration register.
+		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
+		core library documentation for details.
+		The default value is set by the module parameter enable0 and can
+		be read at /sys/module/grcan/parameters/enable0.
+
+What:		/sys/class/net/<iface>/grcan/enable1
+Date:		October 2012
+KernelVersion:	3.8
+Contact:	Andreas Larsson <andreas@gaisler.com>
+Description:
+		Hardware configuration of physical interface 1. This file reads
+		and writes the "Enable 1" bit of the configuration register.
+		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
+		core library documentation for details.
+		The default value is set by the module parameter enable1 and can
+		be read at /sys/module/grcan/parameters/enable1.
+
+What:		/sys/class/net/<iface>/grcan/selection
+Date:		October 2012
+KernelVersion:	3.8
+Contact:	Andreas Larsson <andreas@gaisler.com>
+Description:
+		Configuration of which physical interface to be used. Possible
+		values: 0 or 1. See the GRCAN chapter of the GRLIB IP core
+		library documentation for details.
+		The default value is set by the module parameter selection and can
+		be read at /sys/module/grcan/parameters/selection.
diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
new file mode 100644
index 0000000..a7180f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/grcan.txt
@@ -0,0 +1,27 @@
+CAN controller for Aeroflex Gaisler GRCAN and GRHCAN.
+
+The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
+library.
+
+Note: These properties are built from the AMBA plug&play in a Leon SPARC
+system (the ordinary environment for GRCAN and GRHCAN). There are no bsp
+files for sparc.
+
+Required properties:
+
+- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"
+
+- reg : Address and length of the register set for the device
+
+- freq : Frequency of the external oscillator clock in Hz (the frequency of
+	the amba bus in the ordinary case)
+
+- interrupts : Interrupt number for this device
+
+Optional properties:
+
+- systemid : If not present or if the value of the least significant 16 bits
+	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
+	a bug workaround is activated.
+
+For further information look in the documentation for the GLIB IP core library.
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 9776f06..3a82433 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -905,6 +905,31 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	gpt		[EFI] Forces disk with valid GPT signature but
 			invalid Protective MBR to be treated as GPT.
 
+	grcan.enable0=	[HW] The "Enable 0" bit of the configuration
+			register. For more documentation, see
+			Documentation/ABI/testing/sysfs-class-net-grcan
+			Format: 0 | 1
+			Default: 0
+	grcan.enable1=	[HW] The "Enable 1" bit of the configuration
+			register. For more documentation, see
+			Documentation/ABI/testing/sysfs-class-net-grcan.
+			Format: 0 | 1
+			Default: 0
+	grcan.selection=
+			[HW] Selection of which physical interface to be
+			used. For more documentation, see
+			Documentation/ABI/testing/sysfs-class-net-grcan.
+			Format: 0 | 1
+			Default: 0
+	grcan.txsize=	[HW] The size of the tx buffer. For more documentation,
+			see Documentation/ABI/testing/sysfs-class-net-grcan.
+			Format: <value> such that (value & 0x1fffc0) == 0.
+			Default: 1024
+	grcan.rxsize=	[HW] The size of the rx buffer. For more documentation,
+			see Documentation/ABI/testing/sysfs-class-net-grcan.
+			Format: <value> such that (value & 0x1fffc0) == 0.
+			Default: 1024
+
 	hashdist=	[KNL,NUMA] Large hashes allocated during boot
 			are distributed across NUMA nodes.  Defaults on
 			for 64-bit NUMA, off otherwise.
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index bb709fd..b56bd9e 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -110,6 +110,15 @@ config PCH_CAN
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
 	  This driver can access CAN bus.
 
+config CAN_GRCAN
+	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
+	depends on CAN_DEV && OF
+	---help---
+	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
+	  Note that the driver supports little endian, even though little
+	  endian syntheses of the cores would need some modifications on
+	  the hardware level to work.
+
 source "drivers/net/can/mscan/Kconfig"
 
 source "drivers/net/can/sja1000/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 938be37..7de5986 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_CAN_BFIN)		+= bfin_can.o
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_FLEXCAN)	+= flexcan.o
 obj-$(CONFIG_PCH_CAN)		+= pch_can.o
+obj-$(CONFIG_CAN_GRCAN)		+= grcan.o
 
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
new file mode 100644
index 0000000..201914c
--- /dev/null
+++ b/drivers/net/can/grcan.c
@@ -0,0 +1,1616 @@
+/*
+ * Socket CAN driver for Aeroflex Gaisler GRCAN and GRHCAN.
+ *
+ * 2012 (c) Aeroflex Gaisler AB
+ *
+ * This driver supports GRCAN and CRHCAN CAN controllers available in the GRLIB
+ * VHDL IP core library.
+ *
+ * Full documentation of the GRCAN core can be found here:
+ * http://www.gaisler.com/products/grlib/grip.pdf
+ *
+ * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
+ * open firmware properties.
+ *
+ * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
+ * sysfs interface.
+ *
+ * See "Documentation/kernel-parameters.txt" for information on the module
+ * parameters.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * Contributors: Andreas Larsson <andreas@gaisler.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/can/dev.h>
+#include <linux/spinlock.h>
+
+#include <linux/of_platform.h>
+#include <asm/prom.h>
+
+#include <linux/of_irq.h>
+
+#include <linux/dma-mapping.h>
+
+#define DRV_NAME "grcan"
+
+#define GRCAN_NAPI_WEIGHT	16
+
+#define GRCAN_RESERVE_SIZE(slot1, slot2) (((slot2) - (slot1)) / 4 - 1)
+
+#define SPIN_LOCK(lock)						\
+	do { spin_lock(lock); priv->holder = __LINE__; } while (0)
+#define SPIN_LOCK_IRQSAVE(lock, flags)					\
+	do {spin_lock_irqsave(lock, flags); priv->holder = __LINE__; } while (0)
+#define SPIN_UNLOCK(lock)					\
+	do { priv->holder = 0; spin_unlock(lock); } while (0)
+#define SPIN_UNLOCK_IRQRESTORE(lock, flags)				\
+	do { priv->holder = 0; spin_unlock_irqrestore(lock, flags); } while (0)
+
+
+struct grcan_registers {
+	u32 conf;	/* 0x00 */
+	u32 stat;	/* 0x04 */
+	u32 ctrl;	/* 0x08 */
+	u32 __reserved1[GRCAN_RESERVE_SIZE(0x08, 0x18)];
+	u32 smask;	/* 0x18 - CanMASK */
+	u32 scode;	/* 0x1c - CanCODE */
+	u32 __reserved2[GRCAN_RESERVE_SIZE(0x1c, 0x100)];
+	u32 pimsr;	/* 0x100 */
+	u32 pimr;	/* 0x104 */
+	u32 pisr;	/* 0x108 */
+	u32 pir;	/* 0x10C */
+	u32 imr;	/* 0x110 */
+	u32 picr;	/* 0x114 */
+	u32 __reserved3[GRCAN_RESERVE_SIZE(0x114, 0x200)];
+	u32 txctrl;	/* 0x200 */
+	u32 txaddr;	/* 0x204 */
+	u32 txsize;	/* 0x208 */
+	u32 txwr;	/* 0x20C */
+	u32 txrd;	/* 0x210 */
+	u32 txirq;	/* 0x214 */
+	u32 __reserved4[GRCAN_RESERVE_SIZE(0x214, 0x300)];
+	u32 rxctrl;	/* 0x300 */
+	u32 rxaddr;	/* 0x304 */
+	u32 rxsize;	/* 0x308 */
+	u32 rxwr;	/* 0x30C */
+	u32 rxrd;	/* 0x310 */
+	u32 rxirq;	/* 0x314 */
+	u32 rxmask;	/* 0x318 */
+	u32 rxcode;	/* 0x31C */
+};
+
+#define GRCAN_CONF_ABORT      0x00000001
+#define GRCAN_CONF_ENABLE0    0x00000002
+#define GRCAN_CONF_ENABLE1    0x00000004
+#define GRCAN_CONF_SELECTION  0x00000008
+#define GRCAN_CONF_SILENT     0x00000010
+#define GRCAN_CONF_BPR        0x00000300  /* Note: not BRP */
+#define GRCAN_CONF_RSJ        0x00007000
+#define GRCAN_CONF_PS1        0x00f00000
+#define GRCAN_CONF_PS2        0x000f0000
+#define GRCAN_CONF_SCALER     0xff000000
+#define GRCAN_CONF_OPERATION						\
+	(GRCAN_CONF_ABORT | GRCAN_CONF_ENABLE0 | GRCAN_CONF_ENABLE1	\
+	 | GRCAN_CONF_SELECTION | GRCAN_CONF_SILENT)
+#define GRCAN_CONF_TIMING						\
+	(GRCAN_CONF_BPR | GRCAN_CONF_RSJ | GRCAN_CONF_PS1		\
+	 | GRCAN_CONF_PS2 | GRCAN_CONF_SCALER)
+
+#define GRCAN_CONF_RSJ_MIN    1
+#define GRCAN_CONF_RSJ_MAX    4
+#define GRCAN_CONF_PS1_MIN    1
+#define GRCAN_CONF_PS1_MAX    15
+#define GRCAN_CONF_PS2_MIN    2
+#define GRCAN_CONF_PS2_MAX    8
+#define GRCAN_CONF_SCALER_MIN 0
+#define GRCAN_CONF_SCALER_MAX 255
+#define GRCAN_CONF_SCALER_INC 1
+
+#define GRCAN_CONF_BPR_BIT    8
+#define GRCAN_CONF_RSJ_BIT    12
+#define GRCAN_CONF_PS1_BIT    20
+#define GRCAN_CONF_PS2_BIT    16
+#define GRCAN_CONF_SCALER_BIT 24
+
+#define GRCAN_STAT_PASS      0x000001
+#define GRCAN_STAT_OFF       0x000002
+#define GRCAN_STAT_OR        0x000004
+#define GRCAN_STAT_AHBERR    0x000008
+#define GRCAN_STAT_ACTIVE    0x000010
+#define GRCAN_STAT_RXERRCNT  0x00ff00
+#define GRCAN_STAT_TXERRCNT  0xff0000
+
+#define GRCAN_STAT_RXERRCNT_BIT  8
+#define GRCAN_STAT_TXERRCNT_BIT  16
+
+#define GRCAN_STAT_ERRCNT_WARNING_LIMIT 96
+#define GRCAN_STAT_ERRCNT_PASSIVE_LIMIT 127
+
+
+#define GRCAN_CTRL_RESET  0x2
+#define GRCAN_CTRL_ENABLE 0x1
+
+#define GRCAN_TXCTRL_ENABLE  0x1
+#define GRCAN_TXCTRL_ONGOING 0x2
+#define GRCAN_TXCTRL_SINGLE  0x4
+
+#define GRCAN_RXCTRL_ENABLE  0x1
+#define GRCAN_RXCTRL_ONGOING 0x2
+
+/* Relative offset of IRQ sources to AMBA Plug&Play */
+#define GRCAN_IRQIX_IRQ    0
+#define GRCAN_IRQIX_TXSYNC 1
+#define GRCAN_IRQIX_RXSYNC 2
+
+#define GRCAN_IRQ_PASS       0x00001
+#define GRCAN_IRQ_OFF        0x00002
+#define GRCAN_IRQ_OR         0x00004
+#define GRCAN_IRQ_RXAHBERR   0x00008
+#define GRCAN_IRQ_TXAHBERR   0x00010
+#define GRCAN_IRQ_RXIRQ      0x00020
+#define GRCAN_IRQ_TXIRQ      0x00040
+#define GRCAN_IRQ_RXFULL     0x00080
+#define GRCAN_IRQ_TXEMPTY    0x00100
+#define GRCAN_IRQ_RX         0x00200
+#define GRCAN_IRQ_TX         0x00400
+#define GRCAN_IRQ_RXSYNC     0x00800
+#define GRCAN_IRQ_TXSYNC     0x01000
+#define GRCAN_IRQ_RXERRCTR   0x02000
+#define GRCAN_IRQ_TXERRCTR   0x04000
+#define GRCAN_IRQ_RXMISS     0x08000
+#define GRCAN_IRQ_TXLOSS     0x10000
+
+#define GRCAN_IRQ_NONE 0
+#define GRCAN_IRQ_ALL \
+(GRCAN_IRQ_PASS | GRCAN_IRQ_OFF | GRCAN_IRQ_OR				\
+		       | GRCAN_IRQ_RXAHBERR | GRCAN_IRQ_TXAHBERR	\
+		       | GRCAN_IRQ_RXIRQ | GRCAN_IRQ_TXIRQ		\
+		       | GRCAN_IRQ_RXFULL | GRCAN_IRQ_TXEMPTY		\
+		       | GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_RXSYNC \
+		       | GRCAN_IRQ_TXSYNC | GRCAN_IRQ_RXERRCTR		\
+		       | GRCAN_IRQ_TXERRCTR | GRCAN_IRQ_RXMISS		\
+		       | GRCAN_IRQ_TXLOSS)
+
+#define GRCAN_IRQ_ERRCTR_RELATED (GRCAN_IRQ_RXERRCTR | GRCAN_IRQ_TXERRCTR \
+				  | GRCAN_IRQ_PASS | GRCAN_IRQ_OFF)
+#define GRCAN_IRQ_ERRORS (GRCAN_IRQ_ERRCTR_RELATED | GRCAN_IRQ_OR	\
+			  | GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR	\
+			  | GRCAN_IRQ_TXLOSS)
+#define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
+
+#define GRCAN_MSG_SIZE 16
+
+#define GRCAN_MSG_IDE 0x80000000
+#define GRCAN_MSG_RTR 0x40000000
+#define GRCAN_MSG_BID 0x1ffc0000
+#define GRCAN_MSG_EID 0x1fffffff
+#define GRCAN_MSG_IDE_BIT 31
+#define GRCAN_MSG_RTR_BIT 30
+#define GRCAN_MSG_BID_BIT 18
+#define GRCAN_MSG_EID_BIT 0
+
+#define GRCAN_MSG_DLC    0xf0000000
+#define GRCAN_MSG_TXERRC 0x00ff0000
+#define GRCAN_MSG_RXERRC 0x0000ff00
+#define GRCAN_MSG_DLC_BIT 28
+#define GRCAN_MSG_TXERRC_BIT 16
+#define GRCAN_MSG_RXERRC_BIT 8
+#define GRCAN_MSG_AHBERR 0x00000008
+#define GRCAN_MSG_OR     0x00000004
+#define GRCAN_MSG_OFF    0x00000002
+#define GRCAN_MSG_PASS   0x00000001
+
+#define GRCAN_MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
+#define GRCAN_MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
+
+#define GRCAN_BUFFER_ALIGNMENT 1024
+#define GRCAN_DEFAULT_BUFFER_SIZE 1024
+
+#define GRCAN_VALID_TR_SIZE_MASK 0x001fffc0
+#define GRCAN_INVALID_BUFFER_SIZE(s)		\
+	((s) == 0 || ((s) & ~GRCAN_VALID_TR_SIZE_MASK))
+
+#if GRCAN_INVALID_BUFFER_SIZE(GRCAN_DEFAULT_BUFFER_SIZE)
+#error "Invalid default buffer size"
+#endif
+
+struct grcan_dma_buffer {
+	size_t size;
+	void *buf;
+	dma_addr_t handle;
+};
+
+struct grcan_dma {
+	size_t base_size;
+	void *base_buf;
+	dma_addr_t base_handle;
+	struct grcan_dma_buffer tx;
+	struct grcan_dma_buffer rx;
+};
+
+/* GRCAN configuration parameters */
+struct grcan_device_config {
+	unsigned short enable0;
+	unsigned short enable1;
+	unsigned short selection;
+	unsigned int txsize;
+	unsigned int rxsize;
+};
+
+#define GRCAN_DEFAULT_DEVICE_CONFIG {			\
+		.enable0 = 0,				\
+		.enable1 = 0,				\
+		.selection = 0,				\
+		.txsize = GRCAN_DEFAULT_BUFFER_SIZE,	\
+		.rxsize = GRCAN_DEFAULT_BUFFER_SIZE,	\
+		}
+
+#define GRCAN_TXBUG_SAFE_GRLIB_VERSION 0x4100
+#define GRLIB_VERSION_MASK 0xffff
+
+
+/* GRCAN private data structure */
+struct grcan_priv {
+	struct can_priv can;	/* must be the first member */
+	struct net_device *dev;
+	struct napi_struct napi;
+
+	struct grcan_registers __iomem *regs; /* ioremap'ed registers */
+	struct grcan_device_config config;
+	struct grcan_dma dma;
+	struct sk_buff **echo_skb;	/* We allocate this on our own */
+	u32 eskbp;			/* Pointer into echo_skb */
+	u8 *txdlc;			/* Length of queued frames */
+	u32 ambafreq;
+
+	/* Lock for stopping and waking the netif tx queue and for
+	 * accesses to eskbp
+	 */
+	spinlock_t lock;
+	int holder;
+
+	/* Whether a workaround is needed due to a bug in older hardware. */
+	bool need_txbug_workaround;
+
+	/* To trigger initization of running reset and to trigger running reset
+	 * respectively in the case of a hanged device due to a txbug.
+	 */
+	struct timer_list hang_timer;
+	struct timer_list rr_timer;
+
+	/* To avoid waking up the netif queue and restarting timers
+	 * when a reset is scheduled or when closing of the device is
+	 * undergoing
+	 */
+	bool resetting;
+	bool closing;
+};
+
+/* Wait time for a short wait for ongoing to clear */
+#define GRCAN_SHORTWAIT_USECS 10
+
+/* Waiting for a time corresponding to transmission of three can frames */
+#define GRCAN_EFF_FRAME_MAX_BITS (1+32+6+8*8+16+2+7)
+
+#if defined(__BIG_ENDIAN)
+static inline u32 grcan_read_reg(u32 __iomem *reg)
+{
+	return ioread32be(reg);
+}
+
+static inline void grcan_write_reg(u32 __iomem *reg, u32 val)
+{
+	iowrite32be(val, reg);
+}
+#else
+static inline u32 grcan_read_reg(u32 __iomem *reg)
+{
+	return ioread32(reg);
+}
+
+static inline void grcan_write_reg(u32 __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+#endif
+
+static inline void grcan_clear_bits(u32 __iomem *reg, u32 mask)
+{
+	grcan_write_reg(reg, grcan_read_reg(reg) & ~mask);
+}
+
+static inline void grcan_set_bits(u32 __iomem *reg, u32 mask)
+{
+	grcan_write_reg(reg, grcan_read_reg(reg) | mask);
+}
+
+static inline u32 grcan_read_bits(u32 __iomem *reg, u32 mask)
+{
+	return grcan_read_reg(reg) & mask;
+}
+
+static inline void grcan_write_bits(u32 __iomem *reg, u32 value, u32 mask)
+{
+	u32 old = grcan_read_reg(reg);
+	grcan_write_reg(reg, (old & ~mask) | (value & mask));
+}
+
+static inline u32 grcan_ring_add(u32 a, u32 b, u32 size)
+{
+	u32 sum = a + b;
+	if (sum < size)
+		return sum;
+	else
+		return sum - size;
+}
+
+static inline u32 grcan_ring_sub(u32 a, u32 b, u32 size)
+{
+	u32 diff = a - b;
+	if (a < b)
+		return diff + size;
+	else
+		return diff;
+}
+
+static inline u32 grcan_txspace(size_t txsize, u32 txwr, u32 eskbp)
+{
+	u32 slots = txsize / GRCAN_MSG_SIZE - 1;
+	u32 used = grcan_ring_sub(txwr, eskbp, txsize);
+	return slots - used;
+}
+
+/* Configuration parameters that can be set via module parameters */
+static struct grcan_device_config grcan_module_config =
+	GRCAN_DEFAULT_DEVICE_CONFIG;
+
+static struct can_bittiming_const grcan_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = GRCAN_CONF_PS1_MIN + 1,
+	.tseg1_max = GRCAN_CONF_PS1_MAX + 1,
+	.tseg2_min = GRCAN_CONF_PS2_MIN,
+	.tseg2_max = GRCAN_CONF_PS2_MAX,
+	.sjw_max   = GRCAN_CONF_RSJ_MAX,
+	.brp_min   = GRCAN_CONF_SCALER_MIN + 1,
+	.brp_max   = GRCAN_CONF_SCALER_MAX + 1,
+	.brp_inc   = GRCAN_CONF_SCALER_INC,
+};
+
+static int grcan_set_bittiming(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct can_bittiming *bt = &priv->can.bittiming;
+	u32 timing = 0;
+	int bpr, rsj, ps1, ps2, scaler;
+
+	/* Should never happen - function will not be called when
+	 * device is up
+	 */
+	if (grcan_read_bits(&regs->ctrl, GRCAN_CTRL_ENABLE))
+		return -EBUSY;
+
+	bpr    = 0; /* Note bpr and brp are different concepts */
+	rsj    = bt->sjw;
+	ps1    = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1-1 */
+	ps2    = bt->phase_seg2;
+	scaler = (bt->brp - 1);
+	timing |= (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
+	timing |= (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
+	timing |= (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
+	timing |= (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
+	timing |= (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCALER;
+
+	dev_info(dev->dev.parent,
+		 "setting timing=0x%x\n", timing);
+	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
+	return 0;
+}
+
+static int grcan_get_berr_counter(const struct net_device *dev,
+				  struct can_berr_counter *bec)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	u32 status = grcan_read_reg(&regs->stat);
+	bec->txerr = (status & GRCAN_STAT_TXERRCNT) >> GRCAN_STAT_TXERRCNT_BIT;
+	bec->rxerr = (status & GRCAN_STAT_RXERRCNT) >> GRCAN_STAT_RXERRCNT_BIT;
+	return 0;
+}
+
+static int grcan_poll(struct napi_struct *napi, int budget);
+
+/* Reset device, but keep timing information */
+static void grcan_reset(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+
+	u32 timing = grcan_read_bits(&regs->conf, GRCAN_CONF_TIMING);
+	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_RESET);
+	grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
+
+	priv->eskbp = grcan_read_reg(&regs->txrd);
+	priv->can.state = CAN_STATE_STOPPED;
+
+	/* Turn off hardware filtering - regs->rxcode set to 0 by reset */
+	grcan_write_reg(&regs->rxmask, 0);
+}
+
+/* stop device without changing any configurations */
+static void grcan_stop(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	grcan_write_reg(&regs->imr, GRCAN_IRQ_NONE);
+	grcan_clear_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
+	grcan_clear_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
+	grcan_clear_bits(&regs->ctrl, GRCAN_CTRL_ENABLE);
+	priv->can.state = CAN_STATE_STOPPED;
+}
+
+/* Let priv->eskp catch up to regs->txrd and echo back the skbs if echo is true
+ * and free them otherwise.
+ *
+ * If budget is >= 0, stop after handling at most budget skbs. Otherwise,
+ * continue until priv->eskp catches up to regs->txrd.
+ *
+ * priv->lock *must* be held when calling this function
+ */
+static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_dma *dma = &priv->dma;
+	struct net_device_stats *stats = &dev->stats;
+	int i, work_done;
+
+	/* Updates to priv->eskbp and wake-ups of the queue needs to
+	 * be atomic towards the reads of priv->eskbp and shut-downs
+	 * of the queue in grcan_start_xmit.
+	 */
+	u32 txrd = grcan_read_reg(&regs->txrd);
+	for (work_done = 0; work_done < budget || budget < 0; work_done++) {
+		if (priv->eskbp == txrd)
+			break;
+		i = priv->eskbp / GRCAN_MSG_SIZE;
+		if (echo) {
+			/* Normal echo of messages */
+			stats->tx_packets++;
+			stats->tx_bytes += priv->txdlc[i];
+			priv->txdlc[i] = 0;
+			can_get_echo_skb(dev, i);
+		} else {
+			/* For cleanup of untransmitted messages */
+			can_free_echo_skb(dev, i);
+		}
+
+		priv->eskbp = grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
+					     dma->tx.size);
+		txrd = grcan_read_reg(&regs->txrd);
+	}
+	return work_done;
+}
+
+static void grcan_lost_one_shot_frame(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_dma *dma = &priv->dma;
+	u32 txrd;
+
+	SPIN_LOCK(&priv->lock);
+	priv->holder = 1;
+
+	catch_up_echo_skb(dev, -1, true);
+
+	if (unlikely(grcan_read_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE))) {
+		/* Should never happen */
+		netdev_err(dev, "TXCTRL enabled at TXLOSS in one shot mode\n");
+	} else {
+		/* By the time an GRCAN_IRQ_TXLOSS is generated in
+		 * one-shot mode there is no problem in writing
+		 * to TXRD even in versions of the hardware in
+		 * which GRCAN_TXCTRL_ONGOING is not cleared properly
+		 * in one-shot mode.
+		 */
+
+		/* Skip message and discard echo-skb */
+		txrd = grcan_read_reg(&regs->txrd);
+		txrd = grcan_ring_add(txrd, GRCAN_MSG_SIZE, dma->tx.size);
+		grcan_write_reg(&regs->txrd, txrd);
+		catch_up_echo_skb(dev, -1, false);
+
+		if (!priv->resetting && !priv->closing) {
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+			grcan_set_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
+		}
+	}
+
+	priv->holder = 0;
+	SPIN_UNLOCK(&priv->lock);
+}
+
+static void grcan_err(struct net_device *dev, u32 sources, u32 status)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	struct can_frame cf;
+
+	/* Zero potential error_frame */
+	memset(&cf, 0, sizeof(cf));
+
+	/* Arbitration lost interrupt */
+	if (sources & GRCAN_IRQ_TXLOSS) {
+		netdev_dbg(dev,
+			   "arbitration lost (or other comm failure)\n");
+		stats->tx_errors++;
+		priv->can.can_stats.arbitration_lost++;
+
+		/* Take care of failed one-shot transmit */
+		if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+			grcan_lost_one_shot_frame(dev);
+
+		cf.can_id |= CAN_ERR_LOSTARB;
+	}
+
+	/* Conditions dealing with the error counters */
+	if (sources & GRCAN_IRQ_ERRCTR_RELATED) {
+		enum can_state state = priv->can.state;
+		enum can_state oldstate = state;
+		u32 txerr = (status & GRCAN_STAT_TXERRCNT)
+			>> GRCAN_STAT_TXERRCNT_BIT;
+		u32 rxerr = (status & GRCAN_STAT_RXERRCNT)
+			>> GRCAN_STAT_RXERRCNT_BIT;
+
+		if (status & GRCAN_STAT_OFF) {
+			netdev_dbg(dev, "Bus off condition\n");
+			state = CAN_STATE_BUS_OFF;
+			can_bus_off(dev);
+
+			cf.can_id |= CAN_ERR_BUSOFF;
+		} else if (status & GRCAN_STAT_PASS) {
+			netdev_dbg(dev, "Error passive condition\n");
+			state = CAN_STATE_ERROR_PASSIVE;
+			priv->can.can_stats.error_passive++;
+
+			cf.can_id |= CAN_ERR_CRTL;
+			if (txerr >= GRCAN_STAT_ERRCNT_PASSIVE_LIMIT)
+				cf.data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+			if (rxerr >= GRCAN_STAT_ERRCNT_PASSIVE_LIMIT)
+				cf.data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+		} else if (txerr >= GRCAN_STAT_ERRCNT_WARNING_LIMIT ||
+			   rxerr >= GRCAN_STAT_ERRCNT_WARNING_LIMIT) {
+			state = CAN_STATE_ERROR_WARNING;
+			priv->can.can_stats.error_warning++;
+			if (oldstate != state)
+				netdev_dbg(dev, "Error warning condition\n");
+
+			cf.can_id |= CAN_ERR_CRTL;
+			if (txerr >= GRCAN_STAT_ERRCNT_WARNING_LIMIT)
+				cf.data[1] |= CAN_ERR_CRTL_TX_WARNING;
+			if (rxerr >= GRCAN_STAT_ERRCNT_WARNING_LIMIT)
+				cf.data[1] |= CAN_ERR_CRTL_RX_WARNING;
+		} else {
+			state = CAN_STATE_ERROR_ACTIVE;
+			if (oldstate != state)
+				netdev_dbg(dev, "Error active condition\n");
+		}
+		if (state != CAN_STATE_ERROR_ACTIVE) {
+			cf.data[6] = txerr;
+			cf.data[7] = rxerr;
+		}
+		priv->can.state = state;
+	}
+
+	/* Data overrun interrupt */
+	if (sources & GRCAN_IRQ_OR) {
+		netdev_dbg(dev, "got data overrun interrupt\n");
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+
+		cf.can_id  |= CAN_ERR_CRTL;
+		cf.data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+	}
+
+	/* AHB bus error interrupts (not CAN bus errors) - shut down the
+	 * device.
+	 */
+	if (sources & (GRCAN_IRQ_TXAHBERR | GRCAN_IRQ_RXAHBERR)) {
+		if (sources & GRCAN_IRQ_TXAHBERR) {
+			netdev_err(dev, "got AHB bus error on tx\n");
+			stats->tx_errors++;
+		} else {
+			netdev_err(dev, "got AHB bus error on rx\n");
+			stats->rx_errors++;
+		}
+		netdev_err(dev, "halting device\n");
+
+		/* Prevent anything to be enabled again and halt device */
+		SPIN_LOCK(&priv->lock);
+		priv->closing = true;
+		netif_stop_queue(dev);
+		grcan_stop(dev);
+		SPIN_UNLOCK(&priv->lock);
+	}
+
+	/* Pass on error frame if something to report,
+	 * i.e. id contains some information
+	 */
+	if (cf.can_id) {
+		struct can_frame *skb_cf;
+		struct sk_buff *skb = alloc_can_err_skb(dev, &skb_cf);
+		if (skb == NULL)
+			netdev_dbg(dev, "could not allocate error frame\n");
+		skb_cf->can_id |= cf.can_id;
+		memcpy(skb_cf->data, cf.data, sizeof(cf.data));
+
+		netif_rx(skb);
+	}
+}
+
+static irqreturn_t grcan_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	u32 sources, status;
+
+	/* Find out the source */
+	sources = grcan_read_reg(&regs->pimsr);
+	if (!sources)
+		return IRQ_NONE;
+	grcan_write_reg(&regs->picr, sources);
+	status = grcan_read_reg(&regs->stat);
+
+	/* If we got TX progress, the device has not hanged,
+	 * so disable the hang timer
+	 */
+	if (priv->need_txbug_workaround
+	    && (sources & (GRCAN_IRQ_TX | GRCAN_IRQ_TXLOSS))) {
+		SPIN_LOCK(&priv->lock);
+		if (timer_pending(&priv->hang_timer))
+			del_timer(&priv->hang_timer);
+		SPIN_UNLOCK(&priv->lock);
+	}
+
+	/* Frame(s) received or transmitted */
+	if (sources & (GRCAN_IRQ_TX | GRCAN_IRQ_RX)) {
+		/* Disable tx/rx interrupts and schedule poll() */
+		grcan_clear_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
+		napi_schedule(&priv->napi);
+	}
+
+	/* (Potential) error conditions to take care of */
+	if (sources & GRCAN_IRQ_ERRORS)
+		grcan_err(dev, sources, status);
+
+	return IRQ_HANDLED;
+}
+
+/* Reset device and restart operations from where they were.
+ *
+ * This assumes that RXCTRL & RXCTRL is properly disabled and that RX
+ * is not ONGOING (TX might be stuck in ONGOING due to a harwrware bug
+ * for single shot)
+ */
+static void grcan_running_reset(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *) data;
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	u32 txwr, txrd, rxwr, rxrd, eskbp;
+	unsigned long flags;
+
+	/* This temporarily messes with eskbp, so we need to lock
+	 * priv->lock
+	 */
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+	if (!priv->closing && priv->resetting) {
+		txwr = grcan_read_reg(&regs->txwr);
+		txrd = grcan_read_reg(&regs->txrd);
+		rxwr = grcan_read_reg(&regs->rxwr);
+		rxrd = grcan_read_reg(&regs->rxrd);
+		eskbp = priv->eskbp;
+
+		grcan_reset(dev);
+
+		grcan_write_reg(&regs->txwr, txwr);
+		grcan_write_reg(&regs->txrd, txrd);
+		grcan_write_reg(&regs->rxwr, rxwr);
+		grcan_write_reg(&regs->rxrd, rxrd);
+		priv->eskbp = eskbp;
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		grcan_set_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE
+			      | (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
+				 ? GRCAN_TXCTRL_SINGLE : 0));
+		grcan_set_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
+		/* Start queue if there is size */
+		if (grcan_txspace(priv->dma.tx.size, txwr, priv->eskbp))
+			netif_wake_queue(dev);
+
+		del_timer(&priv->hang_timer);
+		del_timer(&priv->rr_timer);
+
+		priv->resetting = false;
+	}
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+	netdev_err(dev, "Device reset and restored\n");
+
+}
+
+/* A time in usecs within which the can controller have time to finish sending
+ * or receiving a frame with a good margin
+ */
+static inline u32 grcan_ongoing_wait_usecs(__u32 bitrate)
+{
+	return 1000000 * 3 * GRCAN_EFF_FRAME_MAX_BITS / bitrate;
+}
+
+/* Set timer so that it will not fire until after a period in which the can
+ * controller have a good margin to finish transmitting a frame unless it has
+ * hanged
+ */
+static inline void grcan_reset_timer(struct timer_list *timer, __u32 bitrate)
+{
+	u32 wait_jiffies = usecs_to_jiffies(grcan_ongoing_wait_usecs(bitrate));
+	mod_timer(timer, jiffies + wait_jiffies);
+}
+
+/* Disable channels and schedule a running reset */
+static void grcan_initiate_running_reset(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	unsigned long flags;
+
+	netdev_err(dev, "Device seems hanged - reset scheduled\n");
+
+
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+
+	/* The main body of this function must never be executed again
+	 * until after an execution of grcan_running_reset
+	 */
+	if (!priv->resetting && !priv->closing) {
+		priv->resetting = true;
+		netif_stop_queue(dev);
+		grcan_clear_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE);
+		grcan_clear_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
+		grcan_reset_timer(&priv->rr_timer, priv->can.bittiming.bitrate);
+	}
+
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+}
+
+static void grcan_free_dma_buffers(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	dma_free_coherent(&dev->dev,
+			  dma->base_size,
+			  dma->base_buf,
+			  dma->base_handle);
+	dma->base_size = 0;
+	dma->base_buf = NULL;
+	dma->base_handle = 0;
+	dma->rx.size = 0;
+	dma->rx.buf = NULL;
+	dma->rx.handle = 0;
+	dma->tx.size = 0;
+	dma->tx.buf = NULL;
+	dma->tx.handle = 0;
+}
+
+static int grcan_allocate_dma_buffers(struct net_device *dev,
+				      size_t tsize, size_t rsize)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	struct grcan_dma_buffer *large = rsize > tsize ? &dma->rx : &dma->tx;
+	struct grcan_dma_buffer *small = rsize > tsize ? &dma->tx : &dma->rx;
+	size_t shift;
+
+	/* Need a whole number of GRCAN_BUFFER_ALIGNMENT for the large,
+	 * i.e. first buffer
+	 */
+	size_t maxs  = max(tsize, rsize);
+	size_t lsize = ALIGN(maxs, GRCAN_BUFFER_ALIGNMENT);
+
+	/* Put the small buffer after that */
+	size_t ssize = min(tsize, rsize);
+
+	/* Extra GRCAN_BUFFER_ALIGNMENT to allow for alignment */
+	dma->base_size = lsize + ssize + GRCAN_BUFFER_ALIGNMENT;
+	dma->base_buf = dma_alloc_coherent(&dev->dev,
+					   dma->base_size,
+					   &dma->base_handle,
+					   GFP_KERNEL);
+
+	if (!dma->base_buf)
+		return -ENOMEM;
+
+	dma->tx.size = tsize;
+	dma->rx.size = rsize;
+
+	large->handle = ALIGN(dma->base_handle, GRCAN_BUFFER_ALIGNMENT);
+	small->handle = large->handle + lsize;
+	shift = large->handle - dma->base_handle;
+
+	large->buf = dma->base_buf + shift;
+	small->buf = large->buf + lsize;
+
+	return 0;
+}
+
+
+/* priv->lock *must* be held when calling this function */
+static int grcan_start(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+
+	grcan_reset(dev);
+
+	grcan_write_reg(&regs->txaddr, priv->dma.tx.handle);
+	grcan_write_reg(&regs->txsize, priv->dma.tx.size);
+	/* regs->txwr and regs->txrd already set to 0 by reset */
+
+	grcan_write_reg(&regs->rxaddr, priv->dma.rx.handle);
+	grcan_write_reg(&regs->rxsize, priv->dma.rx.size);
+	/* regs->rxwr and regs->rxrd already set to 0 by reset */
+
+	/* Enable interrupts */
+	grcan_read_reg(&regs->pir);
+	grcan_write_reg(&regs->imr, GRCAN_IRQ_DEFAULT);
+
+	/* Enable interfaces, channels and device */
+	grcan_set_bits(&regs->conf,
+		      ((priv->config.enable0 ? GRCAN_CONF_ENABLE0 : 0)
+		       | (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ?
+			  GRCAN_CONF_SILENT : 0)
+		       | (priv->config.enable1 ? GRCAN_CONF_ENABLE1 : 0)
+		       | (priv->config.selection ? GRCAN_CONF_SELECTION : 0)
+		       | GRCAN_CONF_ABORT));
+	grcan_set_bits(&regs->txctrl, GRCAN_TXCTRL_ENABLE
+		      | (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
+			 ? GRCAN_TXCTRL_SINGLE : 0));
+	grcan_set_bits(&regs->rxctrl, GRCAN_RXCTRL_ENABLE);
+	grcan_set_bits(&regs->ctrl, GRCAN_CTRL_ENABLE);
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+}
+
+static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int err;
+
+	if (mode == CAN_MODE_START) {
+		/* This might be called to restart the device to recover from
+		 * bus off errors
+		 */
+		SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+		if (priv->closing || priv->resetting) {
+			err = -EBUSY;
+		} else {
+			netdev_info(dev, "Restarting device\n");
+			grcan_start(dev);
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+			err = 0;
+		}
+		SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int grcan_open(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	unsigned long flags;
+	int err;
+
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+
+	/* Allocate memory */
+	if (GRCAN_INVALID_BUFFER_SIZE(priv->config.txsize)
+	    || GRCAN_INVALID_BUFFER_SIZE(priv->config.rxsize)) {
+		/* Should never be able go this far with invalid sizes */
+		netdev_err(dev, "Invalid buffer size pair 0x%x 0x%x\n",
+			   priv->config.txsize, priv->config.rxsize);
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+	err = grcan_allocate_dma_buffers(dev, priv->config.txsize,
+					 priv->config.rxsize);
+	if (err) {
+		netdev_err(dev, "could not allocate DMA buffers\n");
+		goto exit_unlock;
+	}
+
+	priv->echo_skb = devm_kzalloc(&dev->dev,
+				      dma->tx.size * sizeof(*priv->echo_skb),
+				      GFP_KERNEL);
+	if (!priv->echo_skb) {
+		err = -ENOMEM;
+		goto exit_free_dma_buffers;
+	}
+	priv->can.echo_skb_max = dma->tx.size;
+	priv->can.echo_skb = priv->echo_skb;
+
+	priv->txdlc = devm_kzalloc(&dev->dev,
+				   dma->tx.size * sizeof(*priv->txdlc),
+				   GFP_KERNEL);
+	if (!priv->txdlc) {
+		err = -ENOMEM;
+		goto exit_free_echo_skb;
+	}
+
+	/* Get can device up */
+	err = open_candev(dev);
+	if (err)
+		goto exit_free_txdlc;
+
+	err = devm_request_irq(&dev->dev, dev->irq, grcan_interrupt,
+			       IRQF_SHARED, dev->name, (void *)dev);
+	if (err)
+		goto exit_close_candev;
+
+	grcan_start(dev);
+	napi_enable(&priv->napi);
+	netif_start_queue(dev);
+
+	priv->resetting = false;
+	priv->closing = false;
+
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+	return 0;
+
+exit_close_candev:
+	close_candev(dev);
+exit_free_txdlc:
+	devm_kfree(&dev->dev, priv->txdlc);
+exit_free_echo_skb:
+	devm_kfree(&dev->dev, priv->echo_skb);
+exit_free_dma_buffers:
+	grcan_free_dma_buffers(dev);
+exit_unlock:
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+	return err;
+}
+
+static int grcan_close(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	napi_disable(&priv->napi);
+
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+
+	priv->closing = true;
+	if (priv->need_txbug_workaround) {
+		del_timer_sync(&priv->hang_timer);
+		del_timer_sync(&priv->rr_timer);
+	}
+	netif_stop_queue(dev);
+	grcan_stop(dev);
+
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+
+	devm_free_irq(&dev->dev, dev->irq, (void *)dev);
+	close_candev(dev);
+
+	grcan_free_dma_buffers(dev);
+	priv->can.echo_skb_max = 0;
+	priv->can.echo_skb = NULL;
+	devm_kfree(&dev->dev, priv->echo_skb);
+	devm_kfree(&dev->dev, priv->txdlc);
+
+	return 0;
+}
+
+static int grcan_transmit_catch_up(struct net_device *dev, int budget)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int work_done;
+
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+
+	work_done = catch_up_echo_skb(dev, budget, true);
+	if (work_done) {
+		if (!priv->resetting && !priv->closing
+		    && netif_queue_stopped(dev))
+			netif_wake_queue(dev);
+
+		/* With napi we don't get TX interrupts for a while,
+		 * so prevent a running reset while catching up
+		 */
+		if (priv->need_txbug_workaround
+		    && timer_pending(&priv->hang_timer))
+			del_timer(&priv->hang_timer);
+	}
+
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+
+	return work_done;
+}
+
+static int grcan_receive(struct net_device *dev, int budget)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_dma *dma = &priv->dma;
+	struct net_device_stats *stats = &dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 wr, rd, startrd;
+	u32 *slot;
+	u32 i, rtr, eff, j, shift;
+	int work_done = 0;
+
+	rd = grcan_read_reg(&regs->rxrd);
+	startrd = rd;
+	for (work_done = 0; work_done < budget; work_done++) {
+		/* Check for packet to receive */
+		wr = grcan_read_reg(&regs->rxwr);
+		if (rd == wr)
+			break;
+
+		/* Take care of packet */
+		skb = alloc_can_skb(dev, &cf);
+		if (skb == NULL) {
+			netdev_dbg(dev,
+				   "dropping frame: skb allocation failed\n");
+			stats->rx_dropped++;
+			continue;
+		}
+
+		slot = dma->rx.buf + rd;
+		eff = slot[0] & GRCAN_MSG_IDE;
+		rtr = slot[0] & GRCAN_MSG_RTR;
+		if (eff) {
+			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
+				      >> GRCAN_MSG_EID_BIT);
+			cf->can_id |= CAN_EFF_FLAG;
+		} else {
+			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
+				      >> GRCAN_MSG_BID_BIT);
+		}
+		cf->can_dlc = get_can_dlc((slot[1] & GRCAN_MSG_DLC)
+					  >> GRCAN_MSG_DLC_BIT);
+		if (rtr) {
+			cf->can_id |= CAN_RTR_FLAG;
+		} else {
+			for (i = 0; i < cf->can_dlc; i++) {
+				j = GRCAN_MSG_DATA_SLOT_INDEX(i);
+				shift = GRCAN_MSG_DATA_SHIFT(i);
+				cf->data[i] = (u8)((slot[j] >> shift) & 0xff);
+			}
+		}
+		netif_receive_skb(skb);
+
+		/* Update statistics and read pointer */
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
+	}
+
+	/* Make sure everything is read before allowing hardware to
+	 * use the memory
+	 */
+	mb();
+
+	/* Update read pointer - no need to check for ongoing */
+	if (likely(rd != startrd))
+		grcan_write_reg(&regs->rxrd, rd);
+
+	return work_done;
+}
+
+static int grcan_poll(struct napi_struct *napi, int budget)
+{
+	struct grcan_priv *priv = container_of(napi, struct grcan_priv, napi);
+	struct net_device *dev = priv->dev;
+	struct grcan_registers __iomem *regs = priv->regs;
+	int rx_work_done = grcan_receive(dev, budget);
+	int tx_work_done = grcan_transmit_catch_up(dev, budget);
+	if (rx_work_done < budget && tx_work_done < budget) {
+		napi_complete(napi);
+		/* Enable tx and rx interrupts again */
+		if (!priv->closing)
+			grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
+	}
+	return rx_work_done;
+}
+
+/* Work tx bug by waiting while for the risky situation to clear. If that fails,
+ * drop a frame in one-shot mode or indicate a busy device otherwise.
+ *
+ * Returns 0 on successful wait. Otherwise it sets *netdev_tx_status to the
+ * value that should be returned by grcan_start_xmit when aborting the xmit.
+ */
+static int grcan_txbug_workaround(struct net_device *dev, struct sk_buff *skb,
+				  u32 txwr, u32 oneshotmode,
+				  netdev_tx_t *netdev_tx_status)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_dma *dma = &priv->dma;
+	int i;
+	unsigned long flags;
+
+	/* Wait a while for ongoing to be cleared or read pointer to catch up to
+	 * write pointer. The latter is needed due to a bug in older versions of
+	 * GRCAN in which ONGOING is not cleared properly one-shot mode when a
+	 * transmission fails.
+	 */
+	for (i = 0; i < GRCAN_SHORTWAIT_USECS; i++) {
+		udelay(1);
+		if (!grcan_read_bits(&regs->txctrl, GRCAN_TXCTRL_ONGOING)
+		    || grcan_read_reg(&regs->txrd) == txwr) {
+			return 0;
+		}
+	}
+
+	/* Clean up, in case the situation was not resolved */
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+	if (!priv->resetting && !priv->closing) {
+		/* Queue might have been stopped earlier in grcan_start_xmit */
+		if (grcan_txspace(dma->tx.size, txwr, priv->eskbp))
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+		/* Set a timer to resolve a hanged tx controller */
+		if (!timer_pending(&priv->hang_timer))
+			grcan_reset_timer(&priv->hang_timer,
+					  priv->can.bittiming.bitrate);
+	}
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+
+	if (oneshotmode) {
+		/* In one-shot mode we should never end up here because
+		 * then the interrupt handler increases txrd on TXLOSS,
+		 * but it is consistent with one-shot mode to drop the
+		 * frame in this case.
+		 */
+		kfree_skb(skb);
+		*netdev_tx_status = NETDEV_TX_OK;
+	} else {
+		/* In normal mode the socket-can transmission queue get
+		 * to keep the frame so that it can be retransmitted
+		 * later
+		 */
+		*netdev_tx_status = NETDEV_TX_BUSY;
+	}
+	return -EBUSY;
+}
+
+/* Notes on the tx cyclic buffer handling:
+ *
+ * regs->txwr	- the next slot for the driver to put data to be sent
+ * regs->txrd	- the next slot for the device to read data
+ * priv->eskbp	- the next slot for the driver to call can_put_echo_skb for
+ *
+ * grcan_start_xmit can enter more messages as long as regs->txwr does
+ * not reach priv->eskbp (within 1 message gap)
+ *
+ * The device sends messages until regs->txrd reaches regs->txwr
+ *
+ * The interrupt calls handler calls can_put_echo_skb until
+ * priv->eskbp reaches regs->txrd
+ */
+static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_dma *dma = &priv->dma;
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	u32 id, txwr, txrd, space, txctrl;
+	int slotindex;
+	u32 *slot;
+	u32 i, rtr, eff, dlc, tmp, err;
+	int j, shift;
+	unsigned long flags;
+	u32 oneshotmode = priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT;
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
+	/* Trying to transmit in silent mode will generate error interrupts */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		return NETDEV_TX_BUSY;
+
+	/* Reads of priv->eskbp and shut-downs of the queue needs to
+	 * be atomic towards the updates to priv->eskbp and wake-ups
+	 * of the queue in the interrupt handler.
+	 */
+	SPIN_LOCK_IRQSAVE(&priv->lock, flags);
+
+	txwr = grcan_read_reg(&regs->txwr);
+	space = grcan_txspace(dma->tx.size, txwr, priv->eskbp);
+
+	slotindex = txwr / GRCAN_MSG_SIZE;
+	slot = dma->tx.buf + txwr;
+
+	if (unlikely(space == 1))
+		netif_stop_queue(dev);
+
+	SPIN_UNLOCK_IRQRESTORE(&priv->lock, flags);
+	/* End of critical section*/
+
+	/* This should never happen. If circular buffer is full, the
+	 * netif_stop_queue should have been stopped already.
+	 */
+	if (unlikely(!space)) {
+		netdev_err(dev, "No buffer space, but queue is non-stopped.\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Convert and write CAN message to DMA buffer */
+	eff = cf->can_id & CAN_EFF_FLAG;
+	rtr = cf->can_id & CAN_RTR_FLAG;
+	id  = cf->can_id & (eff ? CAN_EFF_MASK : CAN_SFF_MASK);
+	dlc = cf->can_dlc;
+	if (eff)
+		tmp = (id << GRCAN_MSG_EID_BIT) & GRCAN_MSG_EID;
+	else
+		tmp = (id << GRCAN_MSG_BID_BIT) & GRCAN_MSG_BID;
+	slot[0] = (eff ? GRCAN_MSG_IDE : 0) | (rtr ? GRCAN_MSG_RTR : 0) | tmp;
+
+	slot[1] = ((dlc << GRCAN_MSG_DLC_BIT) & GRCAN_MSG_DLC);
+	slot[2] = 0;
+	slot[3] = 0;
+	for (i = 0; i < dlc; i++) {
+		j = GRCAN_MSG_DATA_SLOT_INDEX(i);
+		shift = GRCAN_MSG_DATA_SHIFT(i);
+		slot[j] |= cf->data[i] << shift;
+	}
+
+	/* Checking that channel has not been disabled. These cases
+	 * should never happen
+	 */
+	txctrl = grcan_read_reg(&regs->txctrl);
+	if (!(txctrl & GRCAN_TXCTRL_ENABLE))
+		netdev_err(dev, "tx channel spuriously disabled\n");
+
+	if (oneshotmode && !(txctrl & GRCAN_TXCTRL_SINGLE))
+		netdev_err(dev, "one-shot mode spuriously disabled\n");
+
+	/* Bug workaround for old version of grcan where updating txwr
+	 * in the same clock cycle as the controller updates txrd to
+	 * the current txwr could hang the can controller
+	 */
+	if (priv->need_txbug_workaround) {
+		txrd = grcan_read_reg(&regs->txrd) ;
+		if (unlikely(grcan_ring_sub(txwr, txrd, dma->tx.size) == 1)) {
+			netdev_tx_t txstatus;
+			err = grcan_txbug_workaround(dev, skb, txwr,
+						     oneshotmode, &txstatus);
+			if (err)
+				return txstatus;
+		}
+	}
+
+	/* Prepare skb for echoing. This must be after the bug workaround above
+	 * as ownership of the skb is passed on by calling can_put_echo_skb.
+	 * Returning NETDEV_TX_BUSY or accessing skb or cf after a call to
+	 * can_put_echo_skb would be an error unless other measures are
+	 * taken.
+	 */
+	priv->txdlc[slotindex] = cf->can_dlc; /* Store dlc for statistics */
+	can_put_echo_skb(skb, dev, slotindex);
+
+	/* Make sure everything is written before allowing hardware to
+	 * read from the memory
+	 */
+	wmb();
+
+	/* Update write pointer to start transmission */
+	grcan_write_reg(&regs->txwr,
+			grcan_ring_add(txwr, GRCAN_MSG_SIZE, dma->tx.size));
+
+	return NETDEV_TX_OK;
+}
+
+
+/* ========== Setting up sysfs interface and module parameters  ========== */
+
+
+#define GRCAN_NOT_BOOL(val) ((val) < 0 || (val) > 1)
+
+#define GRCAN_MODULE_PARAM(name, mtype, valcheckf)			\
+	static void grcan_sanitize_##name(struct platform_device *pd)	\
+	{								\
+		struct grcan_device_config grcan_default_config		\
+			= GRCAN_DEFAULT_DEVICE_CONFIG;			\
+		if (valcheckf(grcan_module_config.name)) {		\
+			dev_err(&pd->dev,				\
+				"Invalid module parameter value for "	\
+				#name " - setting default\n");		\
+			grcan_module_config.name =			\
+				grcan_default_config.name;		\
+		}							\
+	}								\
+	module_param_named(name, grcan_module_config.name,		\
+			   mtype, S_IRUGO)
+
+#define GRCAN_CONFIG_ATTR(name)						\
+	static ssize_t grcan_store_##name(struct device *sdev,		\
+					  struct device_attribute *att,	\
+					  const char *buf,		\
+					  size_t count)			\
+	{								\
+		struct net_device *dev = to_net_dev(sdev);		\
+		struct grcan_priv *priv = netdev_priv(dev);		\
+		u8 val;							\
+		int ret;						\
+		if (dev->flags & IFF_UP)				\
+			return -EBUSY;					\
+		ret = kstrtou8(buf, 0, &val);				\
+		if (ret < 0 || val < 0 || val > 1)			\
+			return -EINVAL;					\
+		priv->config.name = val;				\
+		return count;						\
+	}								\
+	static ssize_t grcan_show_##name(struct device *sdev,		\
+					 struct device_attribute *att,	\
+					 char *buf)			\
+	{								\
+		struct net_device *dev = to_net_dev(sdev);		\
+		struct grcan_priv *priv = netdev_priv(dev);		\
+		return sprintf(buf, "%d\n", priv->config.name);		\
+	}								\
+	static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,			\
+			   grcan_show_##name,				\
+			   grcan_store_##name);				\
+	GRCAN_MODULE_PARAM(name, ushort, GRCAN_NOT_BOOL)
+
+/* The following configuration options are made available both via module
+ * parameters and writable sysfs files. See the chapter about GRCAN in the
+ * documentation for the GRLIB VHDL library for further details.
+ */
+
+/* Configure enable0 - Configuration for interface 0. */
+GRCAN_CONFIG_ATTR(enable0);
+
+/* Configure enable1 - Configuration for interface 0  */
+GRCAN_CONFIG_ATTR(enable1);
+
+/* Configure selection - Selection on which interface to use */
+GRCAN_CONFIG_ATTR(selection);
+
+
+/* The following configuration options are only available via module
+ * parameters.
+ */
+
+/* Configure size of tx buffer */
+GRCAN_MODULE_PARAM(txsize, uint, GRCAN_INVALID_BUFFER_SIZE);
+
+/* Configure size of rx buffer */
+GRCAN_MODULE_PARAM(rxsize, uint, GRCAN_INVALID_BUFFER_SIZE);
+
+
+/* Function that makes sure that configuration done using
+ * module parameters are set to valid values
+ */
+static void grcan_sanitize_module_config(struct platform_device *ofdev)
+{
+	grcan_sanitize_enable0(ofdev);
+	grcan_sanitize_enable1(ofdev);
+	grcan_sanitize_selection(ofdev);
+	grcan_sanitize_txsize(ofdev);
+	grcan_sanitize_rxsize(ofdev);
+}
+
+static const struct attribute *const sysfs_grcan_attrs[] = {
+	/* Config attrs */
+	&dev_attr_enable0.attr,
+	&dev_attr_enable1.attr,
+	&dev_attr_selection.attr,
+	NULL,
+};
+
+static const struct attribute_group sysfs_grcan_group = {
+	.name = "grcan",
+	.attrs = (struct attribute **)sysfs_grcan_attrs,
+};
+
+
+/* ========== Setting up the driver ========== */
+
+static const struct net_device_ops grcan_netdev_ops = {
+	.ndo_open               = grcan_open,
+	.ndo_stop               = grcan_close,
+	.ndo_start_xmit         = grcan_start_xmit,
+};
+
+static int grcan_setup_netdev(struct platform_device *ofdev,
+			      void __iomem *base,
+			      int irq, u32 ambafreq, bool txbug)
+{
+	struct net_device *dev;
+	struct grcan_priv *priv;
+	struct grcan_registers __iomem *regs;
+	int err;
+
+	dev = alloc_candev(sizeof(struct grcan_priv), 0);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->irq = irq;
+	dev->flags |= IFF_ECHO;
+	dev->netdev_ops = &grcan_netdev_ops;
+	dev->sysfs_groups[0] = &sysfs_grcan_group;
+
+	priv = netdev_priv(dev);
+	memcpy(&priv->config, &grcan_module_config,
+	       sizeof(struct grcan_device_config));
+	priv->dev = dev;
+	priv->regs = (struct grcan_registers *) base;
+	priv->can.bittiming_const     = &grcan_bittiming_const;
+	priv->can.do_set_bittiming    = grcan_set_bittiming;
+	priv->can.do_set_mode         = grcan_set_mode;
+	priv->can.do_get_berr_counter = grcan_get_berr_counter;
+	priv->can.clock.freq          = ambafreq;
+	priv->can.ctrlmode_supported  =
+		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	priv->need_txbug_workaround = txbug;
+
+	spin_lock_init(&priv->lock);
+
+	if (priv->need_txbug_workaround) {
+		init_timer(&priv->rr_timer);
+		priv->rr_timer.function = grcan_running_reset;
+		priv->rr_timer.data = (unsigned long)dev;
+
+		init_timer(&priv->hang_timer);
+		priv->hang_timer.function = grcan_initiate_running_reset;
+		priv->hang_timer.data = (unsigned long)dev;
+	}
+
+	netif_napi_add(dev, &priv->napi, grcan_poll, GRCAN_NAPI_WEIGHT);
+
+	SET_NETDEV_DEV(dev, &ofdev->dev);
+	regs = priv->regs;
+	dev_info(&ofdev->dev,
+		 "regs=0x%p, irq=%d, clock=%d\n",
+		 priv->regs, dev->irq, priv->can.clock.freq);
+
+	err = register_candev(dev);
+	if (err) {
+		dev_err(&ofdev->dev, "registering %s failed (err=%d)\n",
+			DRV_NAME, err);
+		goto exit_free_candev;
+	}
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	/* Reset device to allow bit-timing to be set. No need to call
+	 * grcan_reset at this stage. That is done in grcan_open.
+	 */
+	grcan_write_reg(&regs->ctrl, GRCAN_CTRL_RESET);
+
+	return 0;
+exit_free_candev:
+	free_candev(dev);
+	return err;
+}
+
+static int __devinit grcan_probe(struct platform_device *ofdev)
+{
+	struct device_node *np = ofdev->dev.of_node;
+	struct resource *res;
+	u32 sysid, ambafreq;
+	int irq, err;
+	void __iomem *base;
+	bool txbug = true;
+
+	/* Compare GRLIB version number with the first that does not
+	 * have the tx bug (see start_xmit)
+	 */
+	err = of_property_read_u32(np, "systemid", &sysid);
+	if (!err && ((sysid & GRLIB_VERSION_MASK)
+		     >= GRCAN_TXBUG_SAFE_GRLIB_VERSION))
+		txbug = false;
+
+	err = of_property_read_u32(np, "freq", &ambafreq);
+	if (err) {
+		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
+		goto exit_error;
+	}
+
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
+	base = devm_request_and_ioremap(&ofdev->dev, res);
+	if (!base) {
+		dev_err(&ofdev->dev, "couldn't map IO resource\n");
+		err = -EADDRNOTAVAIL;
+		goto exit_error;
+	}
+
+	irq = irq_of_parse_and_map(np, GRCAN_IRQIX_IRQ);
+	if (irq == NO_IRQ) {
+		dev_err(&ofdev->dev, "no irq found\n");
+		err = -ENODEV;
+		goto exit_error;
+	}
+
+	grcan_sanitize_module_config(ofdev);
+
+	err = grcan_setup_netdev(ofdev, base, irq, ambafreq, txbug);
+	if (err)
+		goto exit_dispose_irq;
+
+	return 0;
+
+exit_dispose_irq:
+	irq_dispose_mapping(irq);
+exit_error:
+	dev_err(&ofdev->dev,
+		"%s socket CAN driver initialization failed with error %d\n",
+		DRV_NAME, err);
+	return err;
+}
+
+static  int __devexit grcan_remove(struct platform_device *ofdev)
+{
+	struct net_device *dev = dev_get_drvdata(&ofdev->dev);
+	struct grcan_priv *priv = netdev_priv(dev);
+
+	unregister_candev(dev); /* Will in turn call grcan_close */
+
+	irq_dispose_mapping(dev->irq);
+	dev_set_drvdata(&ofdev->dev, NULL);
+	netif_napi_del(&priv->napi);
+	free_candev(dev);
+
+	dev_info(&ofdev->dev, "%s socket CAN driver removed\n", DRV_NAME);
+	return 0;
+}
+
+static struct of_device_id grcan_match[] = {
+	{.name = "GAISLER_GRCAN"},
+	{.name = "01_03d"},
+	{.name = "GAISLER_GRHCAN"},
+	{.name = "01_034"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, grcan_match);
+
+static struct platform_driver grcan_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = grcan_match,
+	},
+	.probe = grcan_probe,
+	.remove = __devexit_p(grcan_remove),
+};
+
+module_platform_driver(grcan_driver);
+
+MODULE_AUTHOR("Aeroflex Gaisler AB.");
+MODULE_DESCRIPTION("Socket CAN driver for Aeroflex Gaisler GRCAN");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4


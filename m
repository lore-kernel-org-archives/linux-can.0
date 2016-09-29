From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: add ifi_nioscan driver
Date: Thu, 29 Sep 2016 09:09:19 +0200
Message-ID: <20160929070919.22382-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53671 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932382AbcI2HJZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Sep 2016 03:09:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: d.dusha@gmail.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Just for reference.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hey Damien,

the old driver just for reference, maybe this helps.

regards,
Marc

 drivers/net/can/ifi_nioscan.c | 1070 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1070 insertions(+)
 create mode 100644 drivers/net/can/ifi_nioscan.c

diff --git a/drivers/net/can/ifi_nioscan.c b/drivers/net/can/ifi_nioscan.c
new file mode 100644
index 000000000000..8bb04473c07d
--- /dev/null
+++ b/drivers/net/can/ifi_nioscan.c
@@ -0,0 +1,1070 @@
+/*
+ * drivers/can/nioscan.c
+ *
+ * Copyright (C) 2005, 2006, 2007
+ *
+ * - Sascha Hauer, Marc Kleine-Budde, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/* #define DEBUG	1 */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/can.h>
+#include <linux/version.h>
+#include <linux/fpbus.h>
+
+#include "can_driver_compat.h"
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#define NIOS_VERSION_WORKING	0x0b053335
+
+/* Linux compatibility stuff */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,13)
+#define nios_show_version(_dev, _attr, _buf)	nios_show_version(_dev, _buf)
+#endif
+
+#define CARDNAME	"nioscan"
+
+#define TX_TIMEOUT 	(6*HZ)
+
+static int max_interrupt_work = 4;
+module_param(max_interrupt_work, int, 0400);
+MODULE_PARM_DESC(max_interrupt_work, "maximum events handled per interrupt");
+
+static int chip_clock = -1;
+module_param(chip_clock, int, 0400);
+MODULE_PARM_DESC(chip_clock, "Chip Clock Frequency in HZ, default use FPBUS value");
+
+enum nios_regs {
+	NIOS_LENGTH 		= 0x000,
+	NIOS_ID 		= 0x004,
+	NIOS_DATA_0_3 		= 0x008,
+	NIOS_DATA_4_7 		= 0x00C,
+	NIOS_TIMING 		= 0x010,
+	NIOS_INTMASK 		= 0x014,
+	NIOS_STATUS 		= 0x018,
+	NIOS_ERROR_COUNT 	= 0x01C,
+	NIOS_VERSION		= 0x020,
+	NIOS_FILTER_MASK 	= 0x200,
+	NIOS_FILTER_ID		= 0x204,
+};
+
+/*
+ * Bit definitionss of Data Lengh Code Reg
+ */
+#define NIOS_RTR 		(1<<4)
+
+/*
+ * Bit definitionss of Identifier Reg
+ */
+#define NIOS_EXTID 		(1<<29)
+
+/*
+ * Bit Definitions of Timing Reg
+ */
+#define NIOS_TIME_PRESCALE_OFFS (16)		/* offset of prescale value 	*/
+#define NIOS_TIME_PRESCALE_MASK (0xff << NIOS_TIME_PRESCALE_OFFS)
+#define NIOS_TIME_TIMEA_OFFS	(8)		/* offset of timeA value    	*/
+#define NIOS_TIME_TIMEA_MASK	(0x1f << NIOS_TIME_TIMEA_OFFS)
+#define NIOS_TIME_TIMEB_OFFS	(0)		/* offset of timeB value    	*/
+#define NIOS_TIME_TIMEB_MASK	(0x1f << NIOS_TIME_TIMEB_OFFS)
+#define NIOS_TIME_SET_PRESCALE	(1 << 31)	/* prescale value set  		*/
+#define NIOS_TIME_SET_TIMEA    	(1 << 15)	/* timea value set    	 	*/
+#define NIOS_TIME_SET_TIMEB    	(1 <<  7)	/* timeb value set     		*/
+#define NIOS_TIME_NORMAL_MODE	(1 << 24)	/* normal mode         		*/
+#define NIOS_TIME_SET_SILENT	(1 << 30)	/* set silent mode		*/
+#define NIOS_TIME_SILENT_MODE	(1 << 28)	/* silent mode			*/
+
+/*
+ * Bit Definitions of Interrupt Mask Reg
+ */
+#define NIOS_INTMASK_SET	(1 << 31)	/* set interrupt mask		*/
+#define NIOS_RX_FULL		(1 << 29)	/* receive buffer full		*/
+#define NIOS_RX_OVFL		(1 << 28)	/* receive buffer overflow	*/
+#define NIOS_RX_NEMPTY		(1 << 27)	/* receive buffer not empty	*/
+#define NIOS_TX_FULL		(1 << 26)	/* transmit buffer full		*/
+#define NIOS_TX_OVFL		(1 << 25)	/* transmit buffer overflow	*/
+#define NIOS_TX_EMPTY		(1 << 24)	/* transmit buffer empty	*/
+#define NIOS_ERRMASK_SET	(1 << 7)	/* set error mask		*/
+#define NIOS_ERR_WARN		(1 << 1)	/* error warning		*/
+#define NIOS_ERR_BUSOFF		(1 << 0)	/* error bus off		*/
+
+static const u32 nios_int_mask		= NIOS_RX_OVFL  | NIOS_TX_OVFL | NIOS_RX_FULL | NIOS_RX_NEMPTY | NIOS_TX_EMPTY;
+static const u32 nios_int_mask_abnormal	= NIOS_RX_OVFL  | NIOS_TX_OVFL | NIOS_RX_FULL;
+static const u32 nios_err_mask		= NIOS_ERR_WARN | NIOS_ERR_BUSOFF;
+static const u32 nios_all_mask		= NIOS_RX_OVFL  | NIOS_TX_OVFL | NIOS_RX_FULL |
+	NIOS_RX_NEMPTY | NIOS_TX_EMPTY | NIOS_ERR_WARN | NIOS_ERR_BUSOFF;
+
+/*
+ * Bit Definitions of Status Reg
+ */
+#define NIOS_RX_BUSY		(1 << 31)	/* receive busy			*/
+#define NIOS_TX_BUSY		(1 << 30)	/* transmit busy		*/
+#define NIOS_RX_BUFFER_FULL	(1 << 23)	/* receive buffer full		*/
+#define NIOS_TX_BUFFER_FULL	(1 << 22)	/* transmit buffer full		*/
+#define NIOS_RX_POINTER_RESET	(1 << 23)	/* reset receive pointer	*/
+#define NIOS_TX_POINTER_RESET	(1 << 15)	/* reset transmit pointer	*/
+#define NIOS_RX_NEXT_VALUE	(1 <<  7)	/* receive fifo next value	*/
+#define NIOS_ERR_PASSIVE	(1 <<  3)	/* error passive mode		*/
+#define NIOS_ERR_ACTIVE		(1 <<  2)	/* error active mode		*/
+#define NIOS_RX_PTR_MASK 	(0x003F0000)	/* receive buffer pointer mask	*/
+#define NIOS_RX_PTR_OFFS 	(16)		/* receive buffer pointer offset*/
+#define NIOS_TX_PTR_MASK 	(0x00003F00)	/* transmit buffer pointer mask	*/
+#define NIOS_TX_PTR_OFFS 	(8)		/* transmit buf. pointer offset	*/
+
+/*
+ * Bit Definitions of Error Counter Reg
+ */
+#define NIOS_RX_ERR_CNT_MASK	(0x00ff0000)
+#define NIOS_TX_ERR_CNT_MASK	(0x000001ff)
+#define NIOS_RX_ERR_CNT_OFFS	(16)
+#define NIOS_TX_ERR_CNT_OFFS	(0)
+
+/*
+ * Bit Definitions of Filter mask and Filter Id
+ */
+#define NIOS_FILTER_NR		(64)
+#define NIOS_FILTER_MASK_VALID	(1 << 31)
+#define NIOS_FILTER_ID_VALID	(1 << 31)
+
+#define NIOS_VERSION_MONTH(version)   ((version >> 24) & 0xff)
+#define NIOS_VERSION_YEAR(version)    ((version >> 16) & 0xff)
+#define NIOS_VERSION_QUARTUS(version) ((version >>  8) & 0xff)
+#define NIOS_VERSION_REV(version)     ((version >>  0) & 0xff)
+
+enum nios_chip_clock {
+	NIOS_CC_33 = 0,
+	NIOS_CC_48,
+	NIOS_CC_60,
+	NIOS_CC_MAX,
+};
+
+enum nios_priv_flags {
+	NIOS_PRIV_FLAGS_ERR_BUSOFF	= 1 << 0,
+	NIOS_PRIV_FLAGS_TX_FULL		= 1 << 1,
+};
+
+struct nioscan_private
+{
+	void __iomem		*base_addr;
+	struct net_device_stats	stats;
+	unsigned int 		baudrate;
+	enum nios_priv_flags	flags;
+	enum nios_chip_clock	chip_clock;
+	spinlock_t		lock;
+};
+
+static int do_set_baudrate(struct net_device *ndev, struct can_baudrate *br);
+
+static inline u32 nios_read_reg(const void __iomem *base, enum nios_regs reg)
+{
+	volatile u32 val;
+
+	val = readl(base + reg);
+
+	pr_debug("(%s) base 0x%p, reg 0x%x, val 0x%08x\n",
+		 __FUNCTION__, base, reg, val);
+
+	return val;
+}
+
+static inline void nios_write_reg(const void __iomem *base, enum nios_regs reg, u32 val)
+{
+	pr_debug("(%s) base 0x%08lx, reg 0x%x, val 0x%08x\n",
+		 __FUNCTION__, base, reg, val);
+
+	writel(val, base + reg);
+}
+
+static inline void nios_write_filter(const void __iomem *base, unsigned int nr,
+				     u32 mask, u32 id)
+{
+	nios_write_reg(base, NIOS_FILTER_MASK + (nr << 3), mask);
+	nios_write_reg(base, NIOS_FILTER_ID   + (nr << 3), id);
+}
+
+static inline u32 nios_id_can_to_reg(u32 can_id)
+{
+	if (can_id & CAN_FLAG_EXTENDED) {
+		return ((can_id & 0x1ffC0000) >> 18) |
+			((can_id & 0x0003ffff) << 11) |
+			NIOS_EXTID;
+	} else
+		return can_id & 0x7ff;
+}
+
+static inline u32 nios_id_reg_to_can(u32 reg_id)
+{
+	if (reg_id & NIOS_EXTID) {
+		return ((reg_id & 0x000007ff) << 18) |
+			((reg_id & 0x1ffff800) >> 11) |
+			CAN_FLAG_EXTENDED;
+	} else
+		return reg_id & 0x7ff;
+}
+
+static inline void nios_enable_txempty(struct nioscan_private *tp)
+{
+	/* ACK */
+	nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_TX_EMPTY);
+
+	/* activate int */
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, nios_int_mask | NIOS_INTMASK_SET);
+	tp->flags |= NIOS_PRIV_FLAGS_TX_FULL;
+}
+
+
+static inline void nios_disable_txempty(struct nioscan_private *tp)
+{
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, (nios_int_mask & ~NIOS_TX_EMPTY ) | NIOS_INTMASK_SET );
+	tp->flags &= ~NIOS_PRIV_FLAGS_TX_FULL;
+}
+
+static void nioscan_chip_reset(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	int i;
+
+	/* set filter */
+	nios_write_filter(tp->base_addr, 0,
+			  0x0 | NIOS_FILTER_MASK_VALID,
+			  0x0 | NIOS_FILTER_ID_VALID);
+	for (i = 1; i < 64; i++) {
+		nios_write_filter(tp->base_addr, i, 0x0, 0x0);
+	}
+
+	/* unmask interrupts and errors */
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, (nios_int_mask & ~NIOS_TX_EMPTY ) | NIOS_INTMASK_SET );
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, nios_err_mask | NIOS_ERRMASK_SET);
+	tp->flags &= ~NIOS_PRIV_FLAGS_TX_FULL;
+
+	/*
+	 * _NOTE_: DO NOT combine these 2 write statements into 1!
+	 *         The RX & TX buffer pointer reset has to be taken back.
+	 *         (which does the 2nd write)
+	 */
+	/* pointer reset */
+	nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_POINTER_RESET | NIOS_TX_POINTER_RESET);
+	nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_ERR_WARN | NIOS_ERR_BUSOFF);
+
+	/* status reset */
+	nios_write_reg(tp->base_addr, NIOS_STATUS,
+		         NIOS_RX_FULL
+		       | NIOS_RX_OVFL
+		       | NIOS_RX_NEMPTY
+		       | NIOS_TX_FULL
+		       | NIOS_TX_OVFL
+		       | NIOS_TX_EMPTY);
+
+	/* normal mode */
+	tp->flags &= ~NIOS_PRIV_FLAGS_ERR_BUSOFF;
+	nios_write_reg(tp->base_addr, NIOS_TIMING, NIOS_TIME_NORMAL_MODE);
+
+	return;
+}
+
+
+static struct net_device_stats *nioscan_get_stats (struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 reg_error_count;
+
+	reg_error_count = nios_read_reg(tp->base_addr, NIOS_ERROR_COUNT);
+
+	tp->stats.rx_errors = (reg_error_count & NIOS_RX_ERR_CNT_MASK) >> NIOS_RX_ERR_CNT_OFFS;
+	tp->stats.tx_errors = (reg_error_count & NIOS_TX_ERR_CNT_MASK) >> NIOS_TX_ERR_CNT_OFFS;
+
+	return &tp->stats;
+}
+
+
+static void nioscan_read_msg(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	struct sk_buff *skb;
+	struct can_frame *frame;
+	u32 reg_dlc, reg_id;
+
+	while (nios_read_reg(tp->base_addr, NIOS_STATUS) & NIOS_RX_PTR_MASK) {
+		skb = alloc_skb(sizeof(struct can_frame), GFP_ATOMIC);
+		if (unlikely(skb == NULL)) {
+			/* drop packet with this write */
+			nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_NEXT_VALUE);
+			tp->stats.rx_dropped++;
+			if (net_ratelimit())
+				dev_warn(ND2D(ndev), "Memory squeeze, dropping packet.\n");
+			continue;
+		}
+		skb->dev = ndev;
+
+		frame = (struct can_frame *)skb_put(skb, sizeof(struct can_frame));
+
+		reg_id = nios_read_reg(tp->base_addr, NIOS_ID);
+
+		/* process canid */
+		frame->can_id =	nios_id_reg_to_can(reg_id);
+
+		/* process data length code & rtr */
+		reg_dlc = nios_read_reg(tp->base_addr, NIOS_LENGTH);
+		frame->can_dlc = reg_dlc & 0xf;
+		if (reg_dlc & NIOS_RTR)
+			frame->can_id |= CAN_FLAG_RTR;
+
+		/* process payload */
+		frame->payload.data_u32[0] = nios_read_reg(tp->base_addr, NIOS_DATA_0_3);
+		frame->payload.data_u32[1] = nios_read_reg(tp->base_addr, NIOS_DATA_4_7);
+
+		wmb();
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_NEXT_VALUE);
+
+		skb->protocol = __constant_htons(ETH_P_CAN);
+
+		netif_rx(skb);
+
+		/* do stats */
+		ndev->last_rx = jiffies;
+		tp->stats.rx_packets++;
+		tp->stats.rx_bytes += frame->can_dlc;
+	}
+
+	return;
+}
+
+static int nioscan_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	struct can_frame *frame = (struct can_frame *)skb->data;
+	unsigned long flags;
+	u32 reg_dlc, reg_id;
+
+	reg_dlc = frame->can_dlc;
+	if (frame->can_id & CAN_FLAG_RTR)
+		reg_dlc |= NIOS_RTR;
+
+	reg_id = nios_id_can_to_reg(frame->can_id);
+	nios_write_reg(tp->base_addr, NIOS_DATA_0_3, frame->payload.data_u32[0]);
+	nios_write_reg(tp->base_addr, NIOS_DATA_4_7, frame->payload.data_u32[1]);
+	nios_write_reg(tp->base_addr, NIOS_ID, reg_id);
+	wmb();
+	nios_write_reg(tp->base_addr, NIOS_LENGTH, reg_dlc);		/* must be last, starts xmit in HW */
+
+	ndev->trans_start = jiffies;
+
+	kfree_skb(skb);
+
+	/* do stats */
+	ndev->last_rx = jiffies;
+	tp->stats.tx_packets++;
+	tp->stats.tx_bytes += frame->can_dlc;
+
+	if (unlikely(nios_read_reg(tp->base_addr, NIOS_STATUS) & NIOS_TX_BUFFER_FULL)) {
+		spin_lock_irqsave(&tp->lock, flags);
+		if (likely(nios_read_reg(tp->base_addr, NIOS_STATUS) & NIOS_TX_BUFFER_FULL)) {
+			nios_enable_txempty(tp);
+			netif_stop_queue(ndev);
+			spin_unlock_irqrestore(&tp->lock, flags);
+		} else
+			spin_unlock_irqrestore(&tp->lock, flags);
+	}
+
+	return 0;
+}
+
+
+static void nioscan_tx_timeout(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+
+	dev_err(ND2D(ndev), "%s status: 0x%08x, flags 0x%08x\n",
+		__FUNCTION__,
+		nios_read_reg(tp->base_addr, NIOS_STATUS),
+		tp->flags);
+}
+
+
+static const u32 baudrate2timing[NIOS_CC_MAX][CAN_BAUD_MAX] = {
+#if 0
+ 	[NIOS_CC_33][CAN_BAUD_10K]  =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_20K]  =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_50K]  =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_100K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_125K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_250K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_500K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_800K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_33][CAN_BAUD_1M]   =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+#endif
+ 	[NIOS_CC_48][CAN_BAUD_10K]  = 198 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_48][CAN_BAUD_20K]  =  98 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_48][CAN_BAUD_50K]  =  38 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_48][CAN_BAUD_100K] =  18 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+	[NIOS_CC_48][CAN_BAUD_125K] =  14 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+	[NIOS_CC_48][CAN_BAUD_250K] =   6 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+	[NIOS_CC_48][CAN_BAUD_500K] =   2 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+#if 0
+ 	[NIOS_CC_48][CAN_BAUD_800K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+#endif
+ 	[NIOS_CC_48][CAN_BAUD_1M]   =   0 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+
+ 	[NIOS_CC_60][CAN_BAUD_10K]  = 248 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_20K]  = 123 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_50K]  =  48 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_100K] =  23 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_125K] =  18 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_250K] =   8 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_500K] =   3 << NIOS_TIME_PRESCALE_OFFS | 15 << NIOS_TIME_TIMEA_OFFS |  5 << NIOS_TIME_TIMEB_OFFS,
+#if 0
+ 	[NIOS_CC_60][CAN_BAUD_800K] =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+ 	[NIOS_CC_60][CAN_BAUD_1M]   =     << NIOS_TIME_PRESCALE_OFFS |    << NIOS_TIME_TIMEA_OFFS |    << NIOS_TIME_TIMEB_OFFS,
+#endif
+};
+
+
+static const int freq2enum[] = {
+	[NIOS_CC_33] = 33300000,
+	[NIOS_CC_48] = 48700000,
+	[NIOS_CC_60] = 60000000,
+};
+
+
+static int do_set_baudrate(struct net_device *ndev, struct can_baudrate *br)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 reg_timing;
+	int err;
+
+	dev_dbg(ND2D(ndev), "%s baudrate: %d\n", __FUNCTION__, br->baudrate);
+
+	err = -EINVAL;
+	if (br->baudrate == CAN_BAUD_BTR_NIOS) {
+		struct can_baudrate_nios *br_nios = &br->btr.nios;
+
+		reg_timing = ((br_nios->prescale << NIOS_TIME_PRESCALE_OFFS) & NIOS_TIME_PRESCALE_MASK) |
+		             ((br_nios->timea << NIOS_TIME_TIMEA_OFFS) & NIOS_TIME_TIMEA_MASK) |
+		             ((br_nios->timeb << NIOS_TIME_TIMEB_OFFS) & NIOS_TIME_TIMEB_MASK);
+
+	} else if (br->baudrate >= 0 && br->baudrate < CAN_BAUD_MAX)
+		reg_timing = baudrate2timing[tp->chip_clock][br->baudrate];
+	else
+		goto exit;
+
+	err = 0;
+
+	reg_timing |= NIOS_TIME_SET_PRESCALE | NIOS_TIME_SET_TIMEA | NIOS_TIME_SET_TIMEB;
+	nios_write_reg(tp->base_addr, NIOS_TIMING, reg_timing);
+	tp->baudrate = br->baudrate;
+
+ exit:
+	return err;
+}
+
+
+static int do_get_baudrate(struct net_device *ndev, struct can_baudrate *br)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 reg_timing;
+
+	br->baudrate = tp->baudrate;
+	if(br->baudrate == CAN_BAUD_BTR_NIOS) {
+		struct can_baudrate_nios *br_nios = &br->btr.nios;
+
+		reg_timing = nios_read_reg(tp->base_addr, NIOS_TIMING);
+
+		br_nios->prescale = (reg_timing & NIOS_TIME_PRESCALE_MASK) >> NIOS_TIME_PRESCALE_OFFS;
+		br_nios->timea    = (reg_timing & NIOS_TIME_TIMEA_MASK)    >> NIOS_TIME_TIMEA_OFFS;
+		br_nios->timeb    = (reg_timing & NIOS_TIME_TIMEB_MASK)    >> NIOS_TIME_TIMEB_OFFS;
+	}
+
+	return 0;
+}
+
+
+static int do_set_mode(struct net_device *ndev, enum CAN_MODE mode)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	unsigned long flags;
+
+	switch (mode) {
+	case CAN_MODE_START:
+		spin_lock_irqsave(&tp->lock, flags);
+
+		tp->flags &= ~NIOS_PRIV_FLAGS_ERR_BUSOFF;
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_ERR_BUSOFF);		/* ack busoff int */
+		nios_write_reg(tp->base_addr, NIOS_TIMING, NIOS_TIME_NORMAL_MODE);	/* request normal mode */
+
+		if (!(tp->flags & NIOS_PRIV_FLAGS_TX_FULL))
+			netif_wake_queue(ndev);
+
+		spin_unlock_irqrestore(&tp->lock, flags);
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+
+static int do_get_state(struct net_device *ndev, enum CAN_STATE *state)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 reg_status;
+
+	*state = -1;
+
+	reg_status = nios_read_reg(tp->base_addr, NIOS_STATUS);
+	if      (reg_status & NIOS_ERR_PASSIVE)
+		*state = CAN_STATE_BUS_PASSIVE;
+	else if (reg_status & NIOS_ERR_ACTIVE)
+		*state = CAN_STATE_ACTIVE;
+	else if (tp->flags & NIOS_PRIV_FLAGS_ERR_BUSOFF)
+		*state = CAN_STATE_BUS_OFF;
+	else if ((reg_status & (NIOS_ERR_PASSIVE | NIOS_ERR_ACTIVE)) == 0) {
+		*state = CAN_STATE_BUS_OFF;
+		dev_err(ND2D(ndev), "Device is in Busoff, but we didn't get IRQ. (status: 0x%08x)\n", reg_status);
+	}
+	return 0;
+}
+
+
+static int do_set_hwfilt(struct net_device *ndev, struct can_hwfilt *hwfilt)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	struct can_hwfilt_accmask *accmask = &hwfilt->param.accmask;
+	unsigned long flags;
+	int i;
+
+	if (hwfilt->type != CAN_HWFILT_ACCMASK)
+		return -EOPNOTSUPP;
+	if (hwfilt->param.accmask.len > 64)
+		return -E2BIG;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	if (hwfilt->param.accmask.len == 0) {
+		nios_write_filter(tp->base_addr, 0,
+				  0x0 | NIOS_FILTER_MASK_VALID,
+				  0x0 | NIOS_FILTER_ID_VALID);
+		i = 1;	/* i is next filter to clear */
+	} else
+		for (i = 0; i < accmask->len; i++)
+			nios_write_filter(tp->base_addr, i,
+					  nios_id_can_to_reg(accmask->filter[i].can_mask) | NIOS_FILTER_MASK_VALID,
+					  nios_id_can_to_reg(accmask->filter[i].can_id)   | NIOS_FILTER_ID_VALID);
+
+	/* clean remaining filters */
+	for (/* nix */; i < NIOS_FILTER_NR; i++)
+		nios_write_filter(tp->base_addr, i, 0x0, 0x0);
+
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	return 0;
+}
+
+
+static int nioscan_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	struct can_baudrate *baudrate = (struct can_baudrate *)&ifr->ifr_ifru;
+	union can_settings *settings = (union can_settings *)&ifr->ifr_ifru;
+	struct can_hwfilt *hwfilt = (struct can_hwfilt *)&ifr->ifr_ifru;
+
+	dev_dbg(ND2D(ndev), "(%s) 0x%08x %p\n", __FUNCTION__, cmd);
+
+	switch (cmd) {
+	case SIOCSCANBAUDRATE:
+		return do_set_baudrate(ndev, baudrate);
+	case SIOCGCANBAUDRATE:
+		return do_get_baudrate(ndev, baudrate);
+	case SIOCSCANMODE:
+		return do_set_mode(ndev, settings->mode);
+	case SIOCGCANSTATE:
+		return do_get_state(ndev, &settings->state);
+	case SIOCSCANHWFILT: {
+		struct can_hwfilt my_hwfilt = {
+			.type	= CAN_HWFILT_ACCMASK,
+		};
+		int err;
+		size_t len;
+
+		if (hwfilt->type != CAN_HWFILT_ACCMASK)
+			return -EOPNOTSUPP;
+		if (hwfilt->param.accmask.len > 64)
+			return -E2BIG;
+		if (hwfilt->param.accmask.len == 0 &&
+		    hwfilt->param.accmask.filter != NULL)
+			return -EINVAL;
+
+		len = hwfilt->param.accmask.len * sizeof(struct can_filter);
+		if (len > 0) {
+			my_hwfilt.param.accmask.filter = kmalloc(len, GFP_KERNEL);
+			if (!my_hwfilt.param.accmask.filter)
+				return -ENOMEM;
+
+			err = copy_from_user(my_hwfilt.param.accmask.filter,
+					     hwfilt->param.accmask.filter,
+					     len);
+			if (err) {
+				err = -EACCES;
+				goto out_free;
+			}
+		}
+
+		err = do_set_hwfilt(ndev, &my_hwfilt);
+
+	out_free:
+		if (my_hwfilt.param.accmask.filter)
+			kfree(my_hwfilt.param.accmask.filter);
+
+		return err;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0; /* notreached */
+}
+
+
+static void do_weird_interrupt(struct net_device *ndev, u32 reg_status)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	int verbose = net_ratelimit();
+
+	if (verbose)
+		dev_err(ND2D(ndev), "Abnormal interrupt, status: 0x%08x, flags 0x%08x\n", reg_status, tp->flags);
+
+	if (reg_status & NIOS_ERR_WARN) {
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_ERR_WARN);
+		dev_err(ND2D(ndev), "Device triggered a warning INT\n");
+	}
+
+	if (reg_status & NIOS_ERR_BUSOFF) {
+		tp->flags |= NIOS_PRIV_FLAGS_ERR_BUSOFF;
+		netif_stop_queue(ndev);
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_ERR_BUSOFF);
+		dev_err(ND2D(ndev), "Device is in Bus Off Mode\n");
+	}
+
+
+	/* RX-Queue full? Ooops */
+	if (unlikely (reg_status & NIOS_RX_FULL)) {
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_FULL);
+		if (verbose)
+			dev_warn(ND2D(ndev), "RX-Buffer Full\n");
+	}
+
+	if (reg_status & NIOS_RX_OVFL) {
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_OVFL);
+		tp->stats.rx_fifo_errors++;
+		if (verbose)
+			dev_err(ND2D(ndev), "RX-Buffer Overflow\n");
+	}
+
+
+	/* This should not happen, the netif_queue should have been stopped before */
+	if (reg_status & NIOS_TX_OVFL) {
+		netif_stop_queue(ndev);
+		nios_enable_txempty(tp);
+		nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_TX_OVFL);
+
+		tp->stats.tx_fifo_errors++;
+		if (verbose)
+			dev_err(ND2D(ndev), "TX-Buffer Overflow\n");
+	}
+
+	return;
+}
+
+
+static irqreturn_t nioscan_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *ndev = (struct net_device *) dev_id;
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 reg_status;
+	u32 mask = nios_all_mask;
+	irqreturn_t handled = IRQ_NONE;
+	unsigned long flags;
+	int boguscnt = max_interrupt_work;
+
+	spin_lock_irqsave(&tp->lock, flags);
+	do {
+		if (unlikely(tp->flags & NIOS_PRIV_FLAGS_TX_FULL))
+			mask |= NIOS_TX_EMPTY;
+		else
+			mask &= ~NIOS_TX_EMPTY;
+
+		reg_status = nios_read_reg(tp->base_addr, NIOS_STATUS);
+
+		/* ready with work or shared IRQ-line? */
+		if (!(reg_status & mask))
+			goto exit;
+
+		handled = IRQ_HANDLED;
+
+		/* packet in the RX fifo? */
+		if (reg_status & NIOS_RX_BUSY)
+			nioscan_read_msg(ndev);
+
+		/* RX-Queue not empty INT? */
+		if (reg_status & NIOS_RX_NEMPTY)
+			nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_RX_NEMPTY);
+
+
+		/* space left in TX fifo? */
+		if ((tp->flags & NIOS_PRIV_FLAGS_TX_FULL) &&
+		    !(reg_status & NIOS_TX_BUFFER_FULL)) {
+			nios_disable_txempty(tp);
+			netif_wake_queue(ndev);
+		}
+
+		/* TX-Queue empty INT? */
+		if (reg_status & NIOS_TX_EMPTY)
+			nios_write_reg(tp->base_addr, NIOS_STATUS, NIOS_TX_EMPTY);
+
+		if (unlikely(reg_status & (nios_int_mask_abnormal | nios_err_mask)))
+			do_weird_interrupt(ndev, reg_status);
+	} while (--boguscnt > 0);
+
+ 	if (unlikely(boguscnt <= 0)) {
+		dev_warn(ND2D(ndev), "Too much work at interrupt, "
+			 "status (at enter): 0x%08x, now: 0x%08x\n",
+			 reg_status,
+			 nios_read_reg(tp->base_addr, NIOS_STATUS));
+
+		/* Clear all interrupt sources. */
+		nios_write_reg(tp->base_addr, NIOS_STATUS,
+			       nios_int_mask | nios_err_mask);
+	}
+
+ exit:
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	return handled;
+}
+
+
+static int nioscan_open(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	int ret;
+
+	if (tp->baudrate == CAN_BAUD_UNCONFIGURED) {
+		dev_err(ND2D(ndev), "Baudrate is unconfigured\n");
+		return -EINVAL;
+	}
+
+	/* Grab the IRQ */
+      	ret = request_irq(ndev->irq, &nioscan_interrupt, 0, ndev->name, ndev);
+      	if (ret) {
+		dev_err(ND2D(ndev), "Request of interrupt %d failed, err: %d\n", ndev->irq, ret);
+		ret = -ENODEV;
+      		goto err_out;
+	}
+
+	set_irq_type(ndev->irq, IRQT_FALLING);
+
+	/* reset chip, setup chip, unmask IRQs */
+	nioscan_chip_reset(ndev);
+
+	netif_wake_queue(ndev);
+
+	return 0;
+err_out:
+	return ret;
+}
+
+
+static int nioscan_stop(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	unsigned long flags;
+
+	netif_stop_queue(ndev);
+
+	/* mask all IRQs and errors */
+	spin_lock_irqsave(&tp->lock, flags);
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, 0x0 | NIOS_INTMASK_SET);
+	nios_write_reg(tp->base_addr, NIOS_INTMASK, 0x0 | NIOS_ERRMASK_SET);
+	spin_unlock_irqrestore(&tp->lock, flags);
+
+	free_irq(ndev->irq, ndev);
+
+	return 0;
+}
+
+
+static ssize_t nios_show_version(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct nioscan_private *tp = netdev_priv(ndev);
+	unsigned int version = nios_read_reg(tp->base_addr, NIOS_VERSION);
+
+	return sprintf (buf, "%d/20%02d (quartus %d, rev %d)\n",
+			NIOS_VERSION_MONTH(version),
+			NIOS_VERSION_YEAR(version),
+			NIOS_VERSION_QUARTUS(version),
+			NIOS_VERSION_REV(version));
+}
+
+static DEVICE_ATTR(version, S_IWUSR|S_IRUGO, nios_show_version, NULL);
+
+
+static int nioscan_get_clock(struct net_device *ndev)
+{
+	struct device *dev = ND2D(ndev);
+	struct nioscan_private *tp = netdev_priv(ndev);
+	struct fpbus_unit_info *info;
+	int i, clock;
+
+	if (chip_clock == -1) {	/* use fpbus */
+		if (!dev->platform_data) {
+			dev_err(dev, "no platform data found. please use module parameter so set chip_clock.\n");
+			return -ENODEV;
+		}
+		info = (struct fpbus_unit_info *)(dev->platform_data);
+		clock = info->fpga_clock;
+	} else 			/* use module param */
+		clock = chip_clock;
+
+	for (i = 0; i < NIOS_CC_MAX; i++) {
+		if (freq2enum[i] == clock) {
+			tp->chip_clock = (enum nios_chip_clock)i;
+			return 0;
+		}
+	}
+
+	dev_err(dev, "unknown chip clock %d, please send patches :)\n", clock);
+
+	return -ENODEV;
+}
+
+
+static int nioscan_probe_check_version(struct net_device *ndev, u32 version)
+{
+	const struct nioscan_private *tp = netdev_priv(ndev);
+
+	if (version == NIOS_VERSION_WORKING)
+		return 0;
+
+	if (version == 0x0604291e ||
+	    version == 0x0705322d ||
+	    version == 0x0705322e ||
+	    version == 0x0705322f ||
+	    version == 0x07053230) {
+		dev_err(ND2D(ndev),
+			"WARNING - buggy version 0x%08x found, please update your IP-Core\n",
+			version);
+
+	} else if (((NIOS_VERSION_YEAR(version) == NIOS_VERSION_YEAR(NIOS_VERSION_WORKING)) &&
+		    (NIOS_VERSION_MONTH(version) > NIOS_VERSION_MONTH(NIOS_VERSION_WORKING))) ||
+		   (NIOS_VERSION_YEAR(version) > NIOS_VERSION_YEAR(NIOS_VERSION_WORKING))) {
+
+		dev_warn(ND2D(ndev),
+			 "found nioscan core from %d/20%02d (quartus %d, rev %d). "
+			 "this core has not been tested, but it's newer than the latest tested version...\n",
+			 NIOS_VERSION_MONTH(version),
+			 NIOS_VERSION_YEAR(version),
+			 NIOS_VERSION_QUARTUS(version),
+			 NIOS_VERSION_REV(version));
+	} else
+		dev_err(ND2D(ndev), "no or old nios CAN chip found on address 0x%p, found 0x%08x instead\n",
+			tp->base_addr, version);
+
+	return -ENODEV;
+}
+
+static int nioscan_probe(struct net_device *ndev)
+{
+	struct nioscan_private *tp = netdev_priv(ndev);
+	u32 version = nios_read_reg(tp->base_addr, NIOS_VERSION);
+	int ret;
+
+	ret = nioscan_probe_check_version(ndev, version);
+	if (ret)
+		return ret;
+
+	dev_info(ND2D(ndev), "found nioscan core from %d/20%02d (quartus %d, rev %d)\n",
+		 NIOS_VERSION_MONTH(version),
+		 NIOS_VERSION_YEAR(version),
+		 NIOS_VERSION_QUARTUS(version),
+		 NIOS_VERSION_REV(version));
+
+	ret = nioscan_get_clock(ndev);
+	if (ret)
+		return ret;
+	tp->baudrate = CAN_BAUD_UNCONFIGURED;
+
+	ndev->open            = nioscan_open;
+	ndev->stop            = nioscan_stop;
+	ndev->hard_start_xmit = nioscan_hard_start_xmit;
+	ndev->do_ioctl        = nioscan_ioctl;
+	ndev->get_stats	      = nioscan_get_stats;
+	ndev->tx_timeout      = nioscan_tx_timeout;
+	ndev->watchdog_timeo  = TX_TIMEOUT;
+
+	spin_lock_init(&tp->lock);
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(ND2D(ndev), "register_netdev failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+
+static int nioscan_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct nioscan_private *tp;
+	struct resource *res;
+	struct net_device *ndev;
+	void __iomem *addr;
+	int irq, err;
+
+	err = -ENODEV;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!res || !irq) {
+		goto exit;
+	}
+
+	err = -ENOMEM;
+	ndev = alloc_candev(sizeof(struct nioscan_private));
+	if (!ndev) {
+		dev_err(dev, "could not allocate device\n");
+		goto exit;
+	}
+
+	tp = netdev_priv(ndev);
+
+	/*
+	 * Request the regions.
+	 */
+	err = -EBUSY;
+	if (!request_mem_region(res->start, res->end - res->start + 1, CARDNAME)) {
+		goto exit_free_netdev;
+	}
+
+	SET_MODULE_OWNER(ndev);
+	SET_NETDEV_DEV(ndev, dev);
+
+	err = -ENOMEM;
+	addr = ioremap_nocache(res->start, res->end - res->start + 1);
+	if (!addr) {
+		goto exit_release;
+	}
+
+	ndev->irq = irq;
+	tp->base_addr = addr;
+
+	dev_set_drvdata(dev, ndev);
+
+	err = nioscan_probe(ndev);
+	if (err) {
+		dev_err(dev, "Device not found (%d).\n", err);
+		goto exit_unmap;
+	}
+
+	err = device_create_file(dev, &dev_attr_version);
+        if (err)
+                goto exit_unregister;
+
+	err = 0;
+
+ exit:
+	return err;
+
+ exit_unregister:
+	unregister_netdev(ndev);
+ exit_unmap:
+	iounmap(addr);
+ exit_release:
+	release_mem_region(res->start, res->end - res->start + 1);
+ exit_free_netdev:
+	dev_set_drvdata(dev, NULL);
+	free_netdev(ndev);
+	goto exit;
+}
+
+
+static int nioscan_drv_remove(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct nioscan_private *tp = netdev_priv(ndev);
+	struct resource *res;
+
+	dev_set_drvdata(dev, NULL);
+
+        device_remove_file(dev, &dev_attr_version);
+
+	unregister_netdev(ndev);
+
+	iounmap(tp->base_addr);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+
+	free_netdev(ndev);
+
+	return 0;
+}
+
+static int nioscan_drv_suspend(struct device *dev, u32 state, u32 level)
+{
+	dev_err(dev, "suspend not implemented\n");
+	return 0;
+}
+
+static int nioscan_drv_resume(struct device *dev, u32 level)
+{
+	dev_err(dev, "resume not implemented\n");
+	return 0;
+}
+
+static struct device_driver nioscan_driver = {
+	.name		= CARDNAME,
+	.bus		= &platform_bus_type,
+	.probe		= nioscan_drv_probe,
+	.remove		= __devexit_p(nioscan_drv_remove),
+	.suspend	= nioscan_drv_suspend,
+	.resume		= nioscan_drv_resume,
+};
+
+static int __init nioscan_init(void)
+{
+	return driver_register(&nioscan_driver);
+}
+
+static void __exit nioscan_cleanup(void)
+{
+	driver_unregister(&nioscan_driver);
+}
+
+module_init(nioscan_init);
+module_exit(nioscan_cleanup);
+
+MODULE_LICENSE("GPL v2");
-- 
2.9.3


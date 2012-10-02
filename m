From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] can: grcan: Add device driver for GRCAN and GRHCAN cores
Date: Tue,  2 Oct 2012 16:38:50 +0200
Message-ID: <1349188730-11434-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:12215 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751645Ab2JBOjl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Oct 2012 10:39:41 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: software@gaisler.com

This driver supports GRCAN and CRHCAN CAN controllers available in the GRLIB
VHDL IP core library.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/net/can/Kconfig  |    6 +
 drivers/net/can/Makefile |    1 +
 drivers/net/can/grcan.c  | 1283 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/can/grcan.h  |  273 ++++++++++
 4 files changed, 1563 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/grcan.c
 create mode 100644 drivers/net/can/grcan.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index bb709fd..e039f2b 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -110,6 +110,12 @@ config PCH_CAN
 	  is an IOH for x86 embedded processor (Intel Atom E6xx series).
 	  This driver can access CAN bus.
 
+config CAN_GRCAN
+	tristate "Aeroflex Gaisler GRCAN and GRHCAN CAN devices"
+	depends on CAN_DEV && OF
+	---help---
+	  Say Y here if you want to use Aeroflex Gaisler GRCAN or GRHCAN.
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
index 0000000..854b469
--- /dev/null
+++ b/drivers/net/can/grcan.c
@@ -0,0 +1,1283 @@
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
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <linux/dma-mapping.h>
+
+#include "grcan.h"
+
+#define DRV_NAME "grcan"
+
+static inline u32 grcan_read_reg(const struct grcan_priv *priv, int reg)
+{
+	return ioread32be(priv->reg_base + reg);
+}
+
+static inline void grcan_write_reg(const struct grcan_priv *priv,
+				  int reg, u32 val)
+{
+	iowrite32be(val, priv->reg_base + reg);
+}
+
+static inline void grcan_clearbits(const struct grcan_priv *priv,
+				   int reg, u32 mask)
+{
+	grcan_write_reg(priv, reg, grcan_read_reg(priv, reg) & ~mask);
+}
+
+static inline void grcan_setbits(const struct grcan_priv *priv,
+				 int reg, u32 mask)
+{
+	grcan_write_reg(priv, reg, grcan_read_reg(priv, reg) | mask);
+}
+
+static inline u32 grcan_readbits(const struct grcan_priv *priv,
+				 int reg, u32 mask)
+{
+	return grcan_read_reg(priv, reg) & mask;
+}
+
+static inline void grcan_writebits(const struct grcan_priv *priv,
+				   int reg, u32 value, u32 mask)
+{
+	u32 old = grcan_read_reg(priv, reg);
+	grcan_write_reg(priv, reg, (old & ~mask) | (value & mask));
+}
+
+
+/* Configuration parameters that can be set via module parameters */
+static struct grcan_device_config grcan_module_config = DEFAULT_DEVICE_CONFIG;
+
+static struct can_bittiming_const grcan_bittiming_const = {
+	.name = DRV_NAME,
+	.tseg1_min = CONF_PS1_MIN + 1,
+	.tseg1_max = CONF_PS1_MAX + 1,
+	.tseg2_min = CONF_PS2_MIN,
+	.tseg2_max = CONF_PS2_MAX,
+	.sjw_max   = CONF_RSJ_MAX,
+	.brp_min   = CONF_SCALER_MIN + 1,
+	.brp_max   = CONF_SCALER_MAX + 1,
+	.brp_inc   = CONF_SCALER_INC,
+};
+
+static int grcan_set_bittiming(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct can_bittiming *bt = &priv->can.bittiming;
+	u32 timing = 0;
+	int bpr, rsj, ps1, ps2, scaler;
+
+	/* Should never happen - function will not be called when
+	 * device is up */
+	if (grcan_readbits(priv, REG_CTRL, CTRL_ENABLE))
+		return -EBUSY;
+
+	/* Note bpr and brp are different concepts */
+	bpr    = priv->config.bpr;
+	rsj    = bt->sjw;
+	ps1    = (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1-1 */
+	ps2    = bt->phase_seg2;
+	scaler = (bt->brp - 1);
+	timing |= (bpr << CONF_BPR_BIT) & CONF_BPR;
+	timing |= (rsj << CONF_RSJ_BIT) & CONF_RSJ;
+	timing |= (ps1 << CONF_PS1_BIT) & CONF_PS1;
+	timing |= (ps2 << CONF_PS2_BIT) & CONF_PS2;
+	timing |= (scaler << CONF_SCALER_BIT) & CONF_SCALER;
+
+	dev_info(dev->dev.parent,
+		 "setting timing=0x%x\n", timing);
+	grcan_writebits(priv, REG_CONF, timing, CONF_TIMING);
+	return 0;
+}
+
+
+static int grcan_get_berr_counter(const struct net_device *dev,
+				    struct can_berr_counter *bec)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	u32 status = grcan_read_reg(priv, REG_STAT);
+	bec->txerr = (status & STAT_TXERRCNT) >> STAT_TXERRCNT_BIT;
+	bec->rxerr = (status & STAT_RXERRCNT) >> STAT_RXERRCNT_BIT;
+	return 0;
+}
+
+
+static void grcan_receive(struct net_device *dev);
+
+/* Reset device, but keep timing information */
+static void grcan_reset(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	u32 timing = grcan_readbits(priv, REG_CONF, CONF_TIMING);
+	grcan_setbits(priv, REG_CTRL, CTRL_RESET);
+	grcan_writebits(priv, REG_CONF, timing, CONF_TIMING);
+	priv->eskbp = grcan_read_reg(priv, REG_TXRD);
+	priv->can.state = CAN_STATE_STOPPED;
+}
+
+/*
+ * priv->lock *must* be held when calling this function
+ */
+static void catch_up_echo_skb(struct net_device *dev, bool echo)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	struct net_device_stats *stats = &dev->stats;
+	int i;
+
+	/* Updates to priv->eskbp and wake-ups of the queue needs to
+	 * be atomic towards the reads of priv->eskbp and shut-downs
+	 * of the queue in grcan_start_xmit. */
+	u32 txrd = grcan_read_reg(priv, REG_TXRD);
+	while (priv->eskbp != txrd) {
+		i = priv->eskbp / MSG_SIZE;
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
+		priv->eskbp = (priv->eskbp + MSG_SIZE)
+			% dma->tx.size;
+		txrd = grcan_read_reg(priv, REG_TXRD);
+	}
+}
+
+static void grcan_lost_one_shot_frame(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	u32 txrd;
+
+	spin_lock(&priv->lock);
+
+	catch_up_echo_skb(dev, true);
+
+	if (unlikely(grcan_readbits(priv, REG_TXCTRL, TXCTRL_ENABLE))) {
+		/* Should never happen */
+		netdev_err(dev, "TXCTRL enabled at TXLOSS in one shot mode\n");
+	} else {
+		/* By the time an IRQ_TXLOSS is generated in
+		 * one-shot mode there is no problem in writing
+		 * to TXRD even in versions of the hardware in
+		 * which TXCTRL_ONGOING is not cleared properly
+		 * in one-shot mode. */
+
+		/* Skip message and discard echo-skb */
+		txrd = grcan_read_reg(priv, REG_TXRD);
+		grcan_write_reg(priv, REG_TXRD,
+				(txrd + MSG_SIZE) % dma->tx.size);
+		catch_up_echo_skb(dev, false);
+
+		if (!priv->resetting && !priv->closing) {
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+			grcan_setbits(priv, REG_TXCTRL, TXCTRL_ENABLE);
+		}
+	}
+
+	spin_unlock(&priv->lock);
+}
+
+static void grcan_err(struct net_device *dev, u32 sources, u32 status)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+
+	/* Allocate zeroed error buffer */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (skb == NULL)
+		netdev_dbg(dev, "could not allocate error frame\n");
+
+	/* Arbitration lost interrupt */
+	if (sources & IRQ_TXLOSS) {
+		netdev_dbg(dev,
+			   "arbitration lost (or other comm failure)\n");
+		stats->tx_errors++;
+		priv->can.can_stats.arbitration_lost++;
+
+		/* Take care of failed one-shot transmit */
+		if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+			grcan_lost_one_shot_frame(dev);
+
+		if (skb)
+			cf->can_id |= CAN_ERR_LOSTARB;
+	}
+
+	/* Conditions dealing with the error counters */
+	if (sources & IRQ_ERRCTR_RELATED) {
+		enum can_state state = priv->can.state;
+		enum can_state oldstate = state;
+		u32 txerr = (status & STAT_TXERRCNT) >> STAT_TXERRCNT_BIT;
+		u32 rxerr = (status & STAT_RXERRCNT) >> STAT_RXERRCNT_BIT;
+
+		if (status & STAT_OFF) {
+			netdev_dbg(dev, "Bus off condition\n");
+			state = CAN_STATE_BUS_OFF;
+			can_bus_off(dev);
+			if (skb)
+				cf->can_id |= CAN_ERR_BUSOFF;
+		} else if (status & STAT_PASS) {
+			netdev_dbg(dev, "Error passive condition\n");
+			state = CAN_STATE_ERROR_PASSIVE;
+			priv->can.can_stats.error_passive++;
+			if (skb) {
+				cf->can_id |= CAN_ERR_CRTL;
+				if (txerr >= STAT_ERRCNT_PASSIVE_LIMIT)
+					cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
+				if (rxerr >= STAT_ERRCNT_PASSIVE_LIMIT)
+					cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
+			}
+		} else if (txerr >= STAT_ERRCNT_WARNING_LIMIT ||
+			   rxerr >= STAT_ERRCNT_WARNING_LIMIT) {
+			state = CAN_STATE_ERROR_WARNING;
+			priv->can.can_stats.error_warning++;
+			if (oldstate != state)
+				netdev_dbg(dev, "Error warning condition\n");
+			if (skb) {
+				cf->can_id |= CAN_ERR_CRTL;
+				if (txerr >= STAT_ERRCNT_WARNING_LIMIT)
+					cf->data[1] |= CAN_ERR_CRTL_TX_WARNING;
+				if (rxerr >= STAT_ERRCNT_WARNING_LIMIT)
+					cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
+			}
+		} else {
+			state = CAN_STATE_ERROR_ACTIVE;
+			if (oldstate != state)
+				netdev_dbg(dev, "Error active condition\n");
+		}
+		if (state != CAN_STATE_ERROR_ACTIVE) {
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
+		}
+		priv->can.state = state;
+	}
+
+	/* Data overrun interrupt */
+	if (sources & IRQ_OR) {
+		netdev_dbg(dev, "got data overrun interrupt\n");
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+		if (skb) {
+			cf->can_id  |= CAN_ERR_CRTL;
+			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
+		}
+	}
+
+	/* AHB bus error interrupts (not CAN bus errors) - shut down the
+	 * device. */
+	if (sources & (IRQ_TXAHBERR | IRQ_RXAHBERR)) {
+		if (sources & IRQ_TXAHBERR) {
+			netdev_err(dev, "got AHB bus error on tx\n");
+			stats->tx_errors++;
+			if (priv->trackgstats)
+				priv->gstats.tx_ahberr++;
+		} else {
+			netdev_err(dev, "got AHB bus error on rx\n");
+			stats->rx_errors++;
+			if (priv->trackgstats)
+				priv->gstats.rx_ahberr++;
+		}
+		netdev_err(dev, "halting device\n");
+
+		/* Prevent anything to be enabled again and halt device */
+		spin_lock(&priv->lock);
+		priv->closing = true;
+		netif_stop_queue(dev);
+		grcan_reset(dev);
+		spin_unlock(&priv->lock);
+	}
+
+	/* Message filtered interrupt */
+	if (sources & IRQ_RXMISS) {
+		if (priv->trackgstats)
+			priv->gstats.rx_hwfiltered++;
+	}
+
+
+	/* Pass on error frame if something to report, i.e. id
+	 * contains more than just CAN_ERR_FLAG */
+	if (skb) {
+		if (cf->can_id != CAN_ERR_FLAG)
+			netif_rx(skb);
+		else
+			kfree_skb(skb);
+	}
+}
+
+static irqreturn_t grcan_interrupt(int irq, void *dev_id)
+{
+	struct net_device *dev = (struct net_device *)dev_id;
+	struct grcan_priv *priv = netdev_priv(dev);
+	u32 sources, status;
+	int n = 0;
+	bool handled = false; /* Whether any interrupt was handled */
+
+	while (true) {
+		sources = grcan_read_reg(priv, REG_PIMSR); /* PIMSR? */
+
+		if (!sources)
+			return handled ? IRQ_HANDLED : IRQ_NONE;
+
+		/* No locking needed for disabling the hang_timer */
+		if (sources & (IRQ_TX | IRQ_TXLOSS)
+		   && timer_pending(&priv->hang_timer))
+			del_timer(&priv->hang_timer);
+
+		if (n >= GRCAN_MAX_IRQ)
+			netdev_dbg(dev,
+				   "%d interrupt loops handled in a row\n", n);
+		grcan_write_reg(priv, REG_PICR, sources);
+		status = grcan_read_reg(priv, REG_STAT);
+		handled = true;
+
+		/* Frame(s) received */
+		if (sources & IRQ_RX)
+			grcan_receive(dev);
+
+		/* Frame(s) transmitted */
+		if (sources & IRQ_TX) {
+			spin_lock(&priv->lock);
+			catch_up_echo_skb(dev, true);
+			if (!priv->resetting && !priv->closing)
+				if (netif_queue_stopped(dev))
+					netif_wake_queue(dev);
+			spin_unlock(&priv->lock);
+
+		}
+
+		/* (Potential) error conditions to take care of */
+		if (sources & IRQ_ERRORS)
+			grcan_err(dev, sources, status);
+
+		n++;
+	}
+}
+
+/* Reset device and restart operations from where they were.
+ *
+ * This assumes that RXCTRL & RXCTRL is properly disabled and that RX
+ * is not ONGOING (TX might be stuck in ONGOING due to a harwrware bug
+ * for single shot) */
+static void grcan_running_reset(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *) data;
+	struct grcan_priv *priv = netdev_priv(dev);
+	u32 txwr, txrd, rxwr, rxrd, eskbp;
+	unsigned long flags;
+
+	/* This temporarily messes with eskbp, so we need to lock
+	 * priv->lock */
+	spin_lock_irqsave(&priv->lock, flags);
+	if (!priv->closing && priv->resetting) {
+		txwr = grcan_read_reg(priv, REG_TXWR);
+		txrd = grcan_read_reg(priv, REG_TXRD);
+		rxwr = grcan_read_reg(priv, REG_RXWR);
+		rxrd = grcan_read_reg(priv, REG_RXRD);
+		eskbp = priv->eskbp;
+
+		grcan_reset(dev);
+
+		grcan_write_reg(priv, REG_TXWR, txwr);
+		grcan_write_reg(priv, REG_TXRD, txrd);
+		grcan_write_reg(priv, REG_RXWR, rxwr);
+		grcan_write_reg(priv, REG_RXRD, rxrd);
+		priv->eskbp = eskbp;
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
+		grcan_setbits(priv, REG_TXCTRL, TXCTRL_ENABLE
+			      | (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
+				 ? TXCTRL_SINGLE : 0));
+		grcan_setbits(priv, REG_RXCTRL, RXCTRL_ENABLE);
+		/* Start queue if there is size */
+		if (TXSPACE(priv->dma.tx.size, txwr, priv->eskbp))
+			netif_wake_queue(dev);
+
+		del_timer(&priv->hang_timer);
+		del_timer(&priv->rr_timer);
+
+		priv->resetting = false;
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+	netdev_err(dev, "Device reset and restored\n");
+
+}
+
+static void grcan_initiate_running_reset(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct grcan_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+
+	netdev_err(dev, "Device seems hanged - reset scheduled\n");
+
+	spin_lock_irqsave(&priv->lock, flags);
+	/* The main body of this function must never be executed again
+	 * until after an execution of grcan_running_reset */
+	if (!priv->resetting && !priv->closing) {
+
+		priv->resetting = true;
+		netif_stop_queue(dev);
+		grcan_clearbits(priv, REG_TXCTRL, TXCTRL_ENABLE);
+		grcan_clearbits(priv, REG_RXCTRL, RXCTRL_ENABLE);
+		RESET_TIMER(&priv->rr_timer, priv->can.bittiming.bitrate);
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
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
+	/* Need a whole number of BUFFER_ALIGNMENT for the large,
+	 * i.e. first buffer */
+	size_t maxs  = max(tsize, rsize);
+	size_t lsize = ALIGN(maxs, BUFFER_ALIGNMENT);
+
+	/* Put the small buffer after that */
+	size_t ssize = min(tsize, rsize);
+
+	/* Extra BUFFER_ALIGNMENT to allow for alignment  */
+	dma->base_size = lsize + ssize + BUFFER_ALIGNMENT;
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
+	large->handle = ALIGN(dma->base_handle, BUFFER_ALIGNMENT);
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
+/*
+ * priv->lock *must* be held when calling this function
+ */
+static int grcan_start(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+
+	grcan_reset(dev);
+
+	grcan_write_reg(priv, REG_TXADDR, priv->dma.tx.handle);
+	grcan_write_reg(priv, REG_TXSIZE, priv->dma.tx.size);
+	/* REG_TXWR and REG_TXRD already set to 0 by reset*/
+
+	grcan_write_reg(priv, REG_RXADDR, priv->dma.rx.handle);
+	grcan_write_reg(priv, REG_RXSIZE, priv->dma.rx.size);
+	/* REG_RXWR and REG_RXRD already set to 0 by reset*/
+
+	/* Set up hardware message filtering */
+	grcan_write_reg(priv, REG_RXCODE, priv->config.rxcode);
+	grcan_write_reg(priv, REG_RXMASK, priv->config.rxmask);
+
+	/* Enable interrupts */
+	grcan_read_reg(priv, REG_PIR);
+	grcan_write_reg(priv, REG_IMR, IRQ_DEFAULT);
+
+	/* Enable interfaces, channels and device */
+	grcan_setbits(priv, REG_CONF,
+		      ((priv->config.output0 ? CONF_ENABLE0 : 0)
+		       | (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY ?
+			  CONF_SILENT : 0)
+		       | (priv->config.output1 ? CONF_ENABLE1 : 0)
+		       | (priv->config.selection ? CONF_SELECTION : 0)
+		       | CONF_ABORT));
+	grcan_setbits(priv, REG_TXCTRL, TXCTRL_ENABLE
+		      | (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT
+			 ? TXCTRL_SINGLE : 0));
+	grcan_setbits(priv, REG_RXCTRL, RXCTRL_ENABLE);
+	grcan_setbits(priv, REG_CTRL, CTRL_ENABLE);
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
+		/* This is called to restarts the device to recover from bus off
+		 * errors */
+		spin_lock_irqsave(&priv->lock, flags);
+		if (priv->closing || priv->resetting) {
+			err = -EBUSY;
+		} else {
+			netdev_info(dev, "Restarting device\n");
+			grcan_start(dev);
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+			err = 0;
+		}
+		spin_unlock_irqrestore(&priv->lock, flags);
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
+	spin_lock_irqsave(&priv->lock, flags);
+
+	err = open_candev(dev);
+	if (err)
+		goto exit_unlock;
+
+	err = request_irq(dev->irq, grcan_interrupt, IRQF_SHARED,
+			  dev->name, (void *)dev);
+	if (err)
+		goto exit_close_candev;
+
+	if (INVALID_BUFFER_SIZE(priv->config.txsize)
+	    || INVALID_BUFFER_SIZE(priv->config.rxsize)) {
+		/* Should never be able go this far with invalid sizes */
+		netdev_err(dev, "Invalid buffer size pair 0x%x 0x%x\n",
+			   priv->config.txsize, priv->config.rxsize);
+		err = -EINVAL;
+		goto exit_free_irq;
+	}
+	err = grcan_allocate_dma_buffers(dev, priv->config.txsize,
+					 priv->config.rxsize);
+	if (err) {
+		netdev_err(dev, "could not allocate DMA buffers\n");
+		goto exit_free_irq;
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
+	grcan_start(dev);
+
+	netif_start_queue(dev);
+	priv->resetting = false;
+	priv->closing = false;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return 0;
+
+exit_free_echo_skb:
+	devm_kfree(&dev->dev, priv->echo_skb);
+exit_free_dma_buffers:
+	grcan_free_dma_buffers(dev);
+exit_free_irq:
+	free_irq(dev->irq, (void *)dev);
+exit_close_candev:
+	close_candev(dev);
+exit_unlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return err;
+}
+
+static int grcan_close(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	unsigned long flags;
+	int i;
+	unsigned long waitusecs;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	priv->closing = true;
+	del_timer_sync(&priv->hang_timer);
+	del_timer_sync(&priv->rr_timer);
+
+	netif_stop_queue(dev);
+	grcan_clearbits(priv, REG_TXCTRL, TXCTRL_ENABLE);
+	grcan_clearbits(priv, REG_RXCTRL, RXCTRL_ENABLE);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	waitusecs = ONGOING_WAIT_USECS(priv->can.bittiming.bitrate);
+	for (i = 0; i < waitusecs; i += 10) {
+		udelay(10);
+		if (!grcan_readbits(priv, REG_RXCTRL, RXCTRL_ONGOING)
+		    && (!grcan_readbits(priv, REG_TXCTRL, TXCTRL_ONGOING)
+			|| (grcan_read_reg(priv, REG_TXWR)
+			    == grcan_read_reg(priv, REG_TXRD))))
+			break;
+	}
+	free_irq(dev->irq, (void *)dev);
+	grcan_reset(dev);
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
+static void grcan_receive(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	struct grcan_dma *dma = &priv->dma;
+	struct net_device_stats *stats = &dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 wr, rd, startrd;
+	u32 *slot;
+	u32 i, rtr, eff, j, shift;
+
+	startrd = grcan_read_reg(priv, REG_RXRD);
+	for (rd = startrd ; rd != (wr = grcan_read_reg(priv, REG_RXWR));
+	     rd = (rd + MSG_SIZE) % dma->rx.size) {
+		skb = alloc_can_skb(dev, &cf);
+		if (skb == NULL) {
+			netdev_dbg(dev,
+				   "dropping frame: skb allocation failed\n");
+			stats->rx_dropped++;
+			continue;
+		}
+		slot = dma->rx.buf + rd;
+		eff = slot[0] & MSG_IDE;
+		rtr = slot[0] & MSG_RTR;
+		if (eff) {
+			cf->can_id = ((slot[0] & MSG_EID) >> MSG_EID_BIT);
+			cf->can_id |= CAN_EFF_FLAG;
+		} else {
+			cf->can_id = (slot[0] & MSG_BID) >> MSG_BID_BIT;
+		}
+		cf->can_dlc = get_can_dlc((slot[1] & MSG_DLC) >> MSG_DLC_BIT);
+		if (rtr) {
+			cf->can_id |= CAN_RTR_FLAG;
+		} else {
+			for (i = 0; i < cf->can_dlc; i++) {
+				j = MSG_DATA_SLOT_INDEX(i);
+				shift = MSG_DATA_SHIFT(i);
+				cf->data[i] = (u8)((slot[j] >> shift) & 0xff);
+			}
+		}
+
+		netif_rx(skb);
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+	}
+
+	/* Update read pointer - no need to check for ongoing */
+	if (likely(rd != startrd))
+		grcan_write_reg(priv, REG_RXRD, rd);
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
+	struct grcan_dma *dma = &priv->dma;
+	int i;
+	unsigned long flags;
+
+	/* Wait a while for ongoing to be cleared or read pointer to catch up to
+	 * write pointer. The latter is needed due to a bug in older versions of
+	 * GRCAN in which ONGOING is not cleared properly one-shot mode when a
+	 * transmission fails. */
+	for (i = 0; i < ONGOING_SHORTWAIT_USECS; i++) {
+		udelay(1);
+		if (!grcan_readbits(priv, REG_TXCTRL, TXCTRL_ONGOING)
+		    || grcan_read_reg(priv, REG_TXRD) == txwr) {
+			return 0;
+		}
+	}
+
+	/* Clean up, in case the situation was not resolved */
+	spin_lock_irqsave(&priv->lock, flags);
+	if (!priv->resetting && !priv->closing) {
+		/* Queue might have been stopped earlier in grcan_start_xmit */
+		if (TXSPACE(dma->tx.size, txwr, priv->eskbp))
+			if (netif_queue_stopped(dev))
+				netif_wake_queue(dev);
+		/* Set a timer to resolve a hanged tx controller */
+		if (!timer_pending(&priv->hang_timer))
+			RESET_TIMER(&priv->hang_timer,
+				    priv->can.bittiming.bitrate);
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if (oneshotmode) {
+		/* In one-shot mode we should never end up here because
+		 * then the interrupt handler increases txrd on TXLOSS,
+		 * but it is consistent with one-shot mode to drop the
+		 * frame in this case.  */
+		kfree_skb(skb);
+		*netdev_tx_status = NETDEV_TX_OK;
+	} else {
+		/* In normal mode the socket-can transmission queue get
+		 * to keep the frame so that it can be retransmitted
+		 * later */
+		*netdev_tx_status = NETDEV_TX_BUSY;
+	}
+	return -EBUSY;
+}
+
+/*
+ * Notes on the tx cyclic buffer handling:
+ *
+ * REG_TXWR	- the next slot for the driver to put data to be sent
+ * REG_TXRD	- the next slot for the device to read data
+ * priv->eskbp	- the next slot for the driver to call can_put_echo_skb for
+ *
+ * grcan_start_xmit can enter more messages as long as REG_TXWR does
+ * not reach priv->eskbp (within 1 message gap)
+ *
+ * The device sends messages until REG_TXRD reaches REG_TXWR
+ *
+ * The interrupt calls handler calls can_put_echo_skb until
+ * priv->eskbp reaces REG_TXRD
+ */
+static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
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
+	 * of the queue in the interrupt handler. */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	txwr = grcan_read_reg(priv, REG_TXWR);
+	space = TXSPACE(dma->tx.size, txwr, priv->eskbp);
+
+	slotindex = txwr / MSG_SIZE;
+	slot = dma->tx.buf + txwr;
+
+	if (unlikely(space == 1))
+		netif_stop_queue(dev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	/* End of critical section*/
+
+	/* This should never happen. If circular buffer is full, the
+	 * netif_stop_queue should have been stopped already. */
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
+		tmp = (id << MSG_EID_BIT) & MSG_EID;
+	else
+		tmp = (id << MSG_BID_BIT) & MSG_BID;
+	slot[0] = (eff ? MSG_IDE : 0) | (rtr ? MSG_RTR : 0) | tmp;
+
+	slot[1] = ((dlc << MSG_DLC_BIT) & MSG_DLC);
+	slot[2] = 0;
+	slot[3] = 0;
+	for (i = 0; i < dlc; i++) {
+		j = MSG_DATA_SLOT_INDEX(i);
+		shift = MSG_DATA_SHIFT(i);
+		slot[j] |= cf->data[i] << shift;
+	}
+
+	/* Checking that channel has not been disabled. These cases
+	 * should never happen */
+	txctrl = grcan_read_reg(priv, REG_TXCTRL);
+	if (!(txctrl & TXCTRL_ENABLE))
+		netdev_err(dev, "tx channel spuriously disabled\n");
+
+	if (oneshotmode && !(txctrl & TXCTRL_SINGLE))
+		netdev_err(dev, "one-shot mode spuriously disabled\n");
+
+	/* Bug workaround for old version of grcan where updating txwr
+	 * in the same clock cycle as the controller updates txrd to
+	 * the current txwr could hang the can controller */
+	if (priv->need_txbug_workaround) {
+		txrd = grcan_read_reg(priv, REG_TXRD) ;
+		if (unlikely((txwr - txrd) % dma->tx.size == 1)) {
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
+	 * taken. */
+	priv->txdlc[slotindex] = cf->can_dlc; /* Store dlc for statistics */
+	can_put_echo_skb(skb, dev, slotindex);
+
+	/* Update write pointer to start transmission */
+	grcan_write_reg(priv, REG_TXWR, (txwr + MSG_SIZE) % dma->tx.size);
+
+	return NETDEV_TX_OK;
+}
+
+
+/* ========== Setting up the sysfs interface ========== */
+
+#define DECF "%d"
+#define HEXF "0x%08x"
+
+#define RANGECHECK(val, minval, maxval)		\
+	((val) < (minval) || (val) > (maxval))
+
+#define NOVALCHECK(val, minval, maxval) 0
+
+#define NOPOSTSETF(dev)
+#define NOMANIP(x) (x)
+
+#define SYSFS_WRITE_ATTR(name, type, lval, manip,			\
+			 minval, maxval, valcheckf, postsetf)		\
+	static ssize_t grcan_store_##name(struct device *sdev,		\
+					  struct device_attribute *att,	\
+					  const char *buf,		\
+					  size_t count)			\
+	{								\
+		struct net_device *dev = to_net_dev(sdev);		\
+		struct grcan_priv *priv = netdev_priv(dev);		\
+		type val;						\
+		int ret;						\
+		if (dev->flags & IFF_UP)				\
+			return -EBUSY;					\
+		ret = kstrto##type(buf, 0, &val);			\
+		if (ret < 0 || valcheckf(val, (minval), (maxval)))	\
+			return -EINVAL;					\
+		lval = manip(val);					\
+		postsetf(dev);						\
+		return count;						\
+	}
+
+#define SYSFS_RESET_ATTR(name, lval, val)				\
+	static ssize_t grcan_reset_##name(struct device *sdev,		\
+					  struct device_attribute *att,	\
+					  const char *buf,		\
+					  size_t count)			\
+	{								\
+		struct net_device *dev = to_net_dev(sdev);		\
+		struct grcan_priv *priv = netdev_priv(dev);		\
+		lval = val;						\
+		return count;						\
+	}
+
+#define SYSFS_READ_ATTR(name, rval, format)				\
+	static ssize_t grcan_show_##name(struct device *sdev,		\
+					 struct device_attribute *att,	\
+					 char *buf)			\
+	{								\
+		struct net_device *dev = to_net_dev(sdev);		\
+		struct grcan_priv *priv = netdev_priv(dev);		\
+		return sprintf(buf, format "\n", rval);			\
+	}
+
+/* Configuration */
+
+#define CONFIG_ATTR(name, type, mtype, format,				\
+		    minval, maxval, valcheckf, postsetf)		\
+	SYSFS_READ_ATTR(name, priv->config.name, format)		\
+	SYSFS_WRITE_ATTR(name, type, priv->config.name, NOMANIP,	\
+			 minval, maxval, valcheckf, postsetf)		\
+	static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,			\
+				 grcan_show_##name,			\
+				 grcan_store_##name);			\
+	static void grcan_sanitize_##name(struct platform_device *pd)	\
+	{								\
+		struct grcan_device_config grcan_default_config		\
+			= DEFAULT_DEVICE_CONFIG;			\
+		type val = grcan_module_config.name;			\
+		if (valcheckf(val, (minval), (maxval)))	{		\
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
+CONFIG_ATTR(output0,   u8, ushort, DECF, 0, 1, RANGECHECK, NOPOSTSETF);
+CONFIG_ATTR(output1,   u8, ushort, DECF, 0, 1, RANGECHECK, NOPOSTSETF);
+CONFIG_ATTR(selection, u8, ushort, DECF, 0, 1, RANGECHECK, NOPOSTSETF);
+
+static void grcan_postset_bpr(struct net_device *dev)
+{
+	struct grcan_priv *priv = netdev_priv(dev);
+	priv->can.clock.freq = priv->ambafreq >> priv->config.bpr;
+	netdev_info(dev, "bpr will be set to %d when bitrate is set\n",
+		    priv->config.bpr);
+}
+CONFIG_ATTR(bpr, u8, ushort, DECF, 0, 3, RANGECHECK, grcan_postset_bpr);
+
+static int dma_buf_check(u32 val, u32 minval, u32 maxval)
+{
+	return INVALID_BUFFER_SIZE(val);
+}
+
+CONFIG_ATTR(txsize, u32, uint, DECF, 0, 0, dma_buf_check, NOPOSTSETF);
+CONFIG_ATTR(rxsize, u32, uint, DECF, 0, 0, dma_buf_check, NOPOSTSETF);
+CONFIG_ATTR(rxcode, u32, uint, HEXF, 0, MSG_EID, RANGECHECK, NOPOSTSETF);
+CONFIG_ATTR(rxmask, u32, uint, HEXF, 0, MSG_EID, RANGECHECK, NOPOSTSETF);
+
+
+#define BASIC_ID_SHIFT(x) (((x) << MSG_BID_BIT) & MSG_BID)
+
+#define CONFIG_ATTR_BASIC_ID(name, lval)				\
+	SYSFS_WRITE_ATTR(name, u32, lval, BASIC_ID_SHIFT,		\
+			 0, MSG_BID >> MSG_BID_BIT, RANGECHECK,		\
+			 NOPOSTSETF)					\
+	static DEVICE_ATTR(name, S_IWUSR,				\
+				 NULL, grcan_store_##name)
+
+CONFIG_ATTR_BASIC_ID(rxcode_basic, priv->config.rxcode);
+CONFIG_ATTR_BASIC_ID(rxmask_basic, priv->config.rxmask);
+
+static const struct attribute *const sysfs_config_attrs[] = {
+	&dev_attr_output0.attr,
+	&dev_attr_output1.attr,
+	&dev_attr_selection.attr,
+	&dev_attr_bpr.attr,
+	&dev_attr_txsize.attr,
+	&dev_attr_rxsize.attr,
+	&dev_attr_rxcode.attr,
+	&dev_attr_rxmask.attr,
+	&dev_attr_rxcode_basic.attr,
+	&dev_attr_rxmask_basic.attr,
+	NULL,
+};
+
+static void grcan_sanitize_module_config(struct platform_device *ofdev)
+{
+	grcan_sanitize_output0(ofdev);
+	grcan_sanitize_output1(ofdev);
+	grcan_sanitize_selection(ofdev);
+	grcan_sanitize_bpr(ofdev);
+	grcan_sanitize_txsize(ofdev);
+	grcan_sanitize_rxsize(ofdev);
+	grcan_sanitize_rxcode(ofdev);
+	grcan_sanitize_rxmask(ofdev);
+}
+
+static const struct attribute_group sysfs_config_group = {
+	.name = "config",
+	.attrs = (struct attribute **)sysfs_config_attrs,
+};
+
+/* More statistics */
+
+#define GSTATS_ATTR(name)						\
+	SYSFS_READ_ATTR(name, priv->gstats.name, DECF)			\
+	SYSFS_RESET_ATTR(name, priv->gstats.name, 0)			\
+	static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,			\
+				 grcan_show_##name, grcan_reset_##name)
+
+GSTATS_ATTR(tx_ahberr);
+GSTATS_ATTR(rx_ahberr);
+GSTATS_ATTR(rx_hwfiltered);
+
+static const struct attribute *const sysfs_stats_attrs[] = {
+	&dev_attr_tx_ahberr.attr,
+	&dev_attr_rx_ahberr.attr,
+	&dev_attr_rx_hwfiltered.attr,
+	NULL,
+};
+
+static const struct attribute_group sysfs_stats_group = {
+	.name = "grcan_statistics",
+	.attrs = (struct attribute **)sysfs_stats_attrs,
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
+	int err;
+
+	/* One skb buffer per slot in the circular tx buffer */
+	dev = alloc_candev(sizeof(struct grcan_priv), 0);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->irq = irq;
+	dev->flags |= IFF_ECHO;	/* We support local echo */
+	dev->netdev_ops = &grcan_netdev_ops;
+	dev->sysfs_groups[0] = &sysfs_config_group;
+
+	priv = netdev_priv(dev);
+	memcpy(&priv->config, &grcan_module_config,
+	       sizeof(struct grcan_device_config));
+	priv->dev = dev;
+	priv->reg_base = base;
+	priv->can.bittiming_const     = &grcan_bittiming_const;
+	priv->can.do_set_bittiming    = grcan_set_bittiming;
+	priv->can.do_set_mode         = grcan_set_mode;
+	priv->can.do_get_berr_counter = grcan_get_berr_counter;
+	priv->ambafreq                = ambafreq;
+	priv->can.clock.freq          = ambafreq >> priv->config.bpr;
+	priv->can.ctrlmode_supported  =
+		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_ONE_SHOT;
+	priv->gstats.tx_ahberr = 0;
+	priv->gstats.rx_ahberr = 0;
+	priv->gstats.rx_hwfiltered = 0;
+	priv->need_txbug_workaround = txbug;
+
+	spin_lock_init(&priv->lock);
+
+	init_timer(&priv->rr_timer);
+	priv->rr_timer.function = grcan_running_reset;
+	priv->rr_timer.data = (unsigned long)dev;
+
+	init_timer(&priv->hang_timer);
+	priv->hang_timer.function = grcan_initiate_running_reset;
+	priv->hang_timer.data = (unsigned long)dev;
+
+	SET_NETDEV_DEV(dev, &ofdev->dev);
+	dev_info(&ofdev->dev,
+		 "reg_base=0x%p irq=%d clock=%d\n",
+		 priv->reg_base, dev->irq, priv->can.clock.freq);
+
+	err = register_candev(dev);
+	if (err) {
+		dev_err(&ofdev->dev, "registering %s failed (err=%d)\n",
+			DRV_NAME, err);
+		goto exit_free_candev;
+	}
+	dev_set_drvdata(&ofdev->dev, dev);
+
+	priv->trackgstats = !sysfs_create_group(&dev->dev.kobj,
+						&sysfs_stats_group);
+
+	/* Reset device to allow bit-timing to be set. No need to call
+	 * grcan_reset at this stage. That is done in grcan_open. */
+	grcan_write_reg(priv, REG_CTRL, CTRL_RESET);
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
+	 * have the tx bug (see start_xmit) */
+	err = of_property_read_u32(np, "systemid", &sysid);
+	if (!err && ((sysid & GRLIB_VERSION_MASK) >= TXBUG_SAFE_GRLIB_VERSION))
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
+	irq = irq_of_parse_and_map(np, 0);
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
+	if (priv->trackgstats)
+		sysfs_remove_group(&dev->dev.kobj, &sysfs_stats_group);
+
+	unregister_candev(dev); /* Will in turn call grcan_close */
+
+	irq_dispose_mapping(dev->irq);
+	dev_set_drvdata(&ofdev->dev, NULL);
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
+		.name = "grlib-" DRV_NAME,
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
diff --git a/drivers/net/can/grcan.h b/drivers/net/can/grcan.h
new file mode 100644
index 0000000..1b69c59
--- /dev/null
+++ b/drivers/net/can/grcan.h
@@ -0,0 +1,273 @@
+
+#ifndef GRCAN_H
+#define GRCAN_H
+
+#include <linux/spinlock.h>
+
+#define REG_CONF 0x00
+#define REG_STAT 0x04
+#define REG_CTRL 0x08
+
+#define REG_SMASK 0x18 /* CanMASK */
+#define REG_SCODE 0x1C /* CanCODE */
+
+#define REG_PIMSR 0x100
+#define REG_PIMR  0x104
+#define REG_PISR  0x108
+#define REG_PIR   0x10C
+#define REG_IMR   0x110
+#define REG_PICR  0x114
+
+#define REG_TXCTRL 0x200
+#define REG_TXADDR 0x204
+#define REG_TXSIZE 0x208
+#define REG_TXWR   0x20C
+#define REG_TXRD   0x210
+#define REG_TXIRQ  0x214
+
+#define REG_RXCTRL 0x300
+#define REG_RXADDR 0x304
+#define REG_RXSIZE 0x308
+#define REG_RXWR   0x30C
+#define REG_RXRD   0x310
+#define REG_RXIRQ  0x314
+#define REG_RXMASK 0x318
+#define REG_RXCODE 0x31C
+
+#define TR_ADDR 0xfffffc00
+#define TR_SIZE 0x001fffc0
+#define TR_RDWR 0x000ffff0
+
+#define CONF_ABORT      0x00000001
+#define CONF_ENABLE0    0x00000002
+#define CONF_ENABLE1    0x00000004
+#define CONF_SELECTION  0x00000008
+#define CONF_SILENT     0x00000010
+#define CONF_BPR        0x00000300  /* Note: not BRP */
+#define CONF_RSJ        0x00007000
+#define CONF_PS1        0x00f00000
+#define CONF_PS2        0x000f0000
+#define CONF_SCALER     0xff000000
+#define CONF_OPERATION  (CONF_ABORT | CONF_ENABLE0 | CONF_ENABLE1 | \
+			 CONF_SELECTION | CONF_SILENT)
+#define CONF_TIMING     (CONF_BPR | CONF_RSJ | CONF_PS1 | \
+			 CONF_PS2 | CONF_SCALER)
+
+#define CONF_RSJ_MIN    1
+#define CONF_RSJ_MAX    4
+#define CONF_PS1_MIN    1
+#define CONF_PS1_MAX    15
+#define CONF_PS2_MIN    2
+#define CONF_PS2_MAX    8
+#define CONF_SCALER_MIN 0
+#define CONF_SCALER_MAX 255
+#define CONF_SCALER_INC 1
+
+#define CONF_BPR_BIT    8
+#define CONF_RSJ_BIT    12
+#define CONF_PS1_BIT    20
+#define CONF_PS2_BIT    16
+#define CONF_SCALER_BIT 24
+
+#define STAT_PASS      0x000001
+#define STAT_OFF       0x000002
+#define STAT_OR        0x000004
+#define STAT_AHBERR    0x000008
+#define STAT_ACTIVE    0x000010
+#define STAT_RXERRCNT  0x00ff00
+#define STAT_TXERRCNT  0xff0000
+
+#define STAT_RXERRCNT_BIT  8
+#define STAT_TXERRCNT_BIT  16
+
+#define STAT_ERRCNT_WARNING_LIMIT 96
+#define STAT_ERRCNT_PASSIVE_LIMIT 127
+
+
+#define CTRL_RESET  0x2
+#define CTRL_ENABLE 0x1
+
+#define TXCTRL_ENABLE  0x1
+#define TXCTRL_ONGOING 0x2
+#define TXCTRL_SINGLE  0x4
+
+#define RXCTRL_ENABLE  0x1
+#define RXCTRL_ONGOING 0x2
+
+/* Relative offset of IRQ sources to AMBA Plug&Play */
+#define IRQIX_IRQ    0
+#define IRQIX_TXSYNC 1
+#define IRQIX_RXSYNC 2
+
+#define IRQ_PASS       0x00001
+#define IRQ_OFF        0x00002
+#define IRQ_OR         0x00004
+#define IRQ_RXAHBERR   0x00008
+#define IRQ_TXAHBERR   0x00010
+#define IRQ_RXIRQ      0x00020
+#define IRQ_TXIRQ      0x00040
+#define IRQ_RXFULL     0x00080
+#define IRQ_TXEMPTY    0x00100
+#define IRQ_RX         0x00200
+#define IRQ_TX         0x00400
+#define IRQ_RXSYNC     0x00800
+#define IRQ_TXSYNC     0x01000
+#define IRQ_RXERRCTR   0x02000
+#define IRQ_TXERRCTR   0x04000
+#define IRQ_RXMISS     0x08000
+#define IRQ_TXLOSS     0x10000
+
+#define IRQ_NONE 0
+#define IRQ_ALL (IRQ_PASS | IRQ_OFF | IRQ_OR | IRQ_RXAHBERR		\
+		 | IRQ_TXAHBERR | IRQ_RXIRQ | IRQ_TXIRQ | IRQ_RXFULL	\
+		 | IRQ_TXEMPTY | IRQ_RX | IRQ_TX | IRQ_RXSYNC		\
+		 | IRQ_TXSYNC | IRQ_RXERRCTR | IRQ_TXERRCTR		\
+		 | IRQ_RXMISS | IRQ_TXLOSS)
+
+#define IRQ_ERRCTR_RELATED (IRQ_RXERRCTR | IRQ_TXERRCTR | IRQ_PASS | IRQ_OFF)
+#define IRQ_ERRORS (IRQ_ERRCTR_RELATED | IRQ_OR | IRQ_TXAHBERR |	\
+		    IRQ_RXAHBERR | IRQ_RXMISS | IRQ_TXLOSS)
+#define IRQ_DEFAULT (IRQ_RX | IRQ_TX | IRQ_ERRORS)
+
+#define MSG_SIZE 16
+
+#define MSG_IDE 0x80000000
+#define MSG_RTR 0x40000000
+#define MSG_BID 0x1ffc0000
+#define MSG_EID 0x1fffffff
+#define MSG_IDE_BIT 31
+#define MSG_RTR_BIT 30
+#define MSG_BID_BIT 18
+#define MSG_EID_BIT 0
+
+#define MSG_DLC    0xf0000000
+#define MSG_TXERRC 0x00ff0000
+#define MSG_RXERRC 0x0000ff00
+#define MSG_DLC_BIT    28
+#define MSG_TXERRC_BIT 16
+#define MSG_RXERRC_BIT 8
+#define MSG_AHBERR 0x00000008
+#define MSG_OR     0x00000004
+#define MSG_OFF    0x00000002
+#define MSG_PASS   0x00000001
+
+#define MSG_DATA_SLOT_INDEX(i) (2 + (i) / 4)
+#define MSG_DATA_SHIFT(i) ((3 - (i) % 4) * 8)
+
+#define BUFFER_ALIGNMENT 1024
+#define DEFAULT_BUFFER_SIZE 1024
+
+#define INVALID_BUFFER_SIZE(s) ((s) == 0 || ((s) & ~TR_SIZE))
+
+#if INVALID_BUFFER_SIZE(DEFAULT_BUFFER_SIZE)
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
+/*
+ * GRCAN configuration parameters
+ */
+struct grcan_device_config {
+	unsigned short output0;
+	unsigned short output1;
+	unsigned short selection;
+	unsigned short bpr;
+	unsigned int txsize;
+	unsigned int rxsize;
+	unsigned int rxcode;
+	unsigned int rxmask;
+};
+
+#define DEFAULT_DEVICE_CONFIG {			\
+		.output0 = 0,			\
+		.output1 = 0,			\
+		.selection = 0,			\
+		.bpr = 0,			\
+		.txsize = DEFAULT_BUFFER_SIZE,	\
+		.rxsize = DEFAULT_BUFFER_SIZE,	\
+		.rxcode = 0,			\
+		.rxmask = 0,			\
+		}
+
+struct grcan_stats {
+	u32 tx_ahberr;
+	u32 rx_ahberr;
+	u32 rx_hwfiltered;
+};
+
+#define TXBUG_SAFE_GRLIB_VERSION 0x4100
+#define GRLIB_VERSION_MASK 0xffff
+
+
+/*
+ * GRCAN private data structure
+ */
+struct grcan_priv {
+	struct can_priv can;	/* must be the first member */
+	struct net_device *dev;
+	void __iomem *reg_base;	 /* ioremap'ed address to registers */
+	u32 ambafreq;
+	struct grcan_device_config config;
+	struct grcan_dma dma;
+	struct sk_buff **echo_skb;	/* We allocate this on our own */
+	u32 eskbp;			/* Pointer into echo_skb */
+	u8 *txdlc;			/* Length of queued frames */
+
+	/* Lock for stopping and waking the netif tx queue and for
+	 * acesses to eskbp  */
+	spinlock_t lock;
+
+	/* Whether a workaround is needed due to a bug in older hardware. */
+	bool need_txbug_workaround;
+
+	/* To trigger initization of running reset and to trigger running reset
+	 * respectively in the case of a hanged device due to a txbug. */
+	struct timer_list hang_timer;
+	struct timer_list rr_timer;
+
+	/* To avoid waking up the netif queue and restarting timers
+	 * when a reset is scheduled or when closing of the device is
+	 * undergoing */
+	bool resetting;
+	bool closing;
+
+	bool trackgstats;
+	struct grcan_stats gstats;
+};
+
+/* Max # lopps in interrupt handler before reporting it  */
+#define GRCAN_MAX_IRQ          20
+
+/* Wait time for a short wait for ongoing to clear */
+#define ONGOING_SHORTWAIT_USECS 10
+
+/* Waiting for a time corresponding to transmission of three can frames */
+#define EFF_FRAME_MAX_BITS (1+32+6+8*8+16+2+7)
+#define ONGOING_WAIT_USECS(bitrate)			\
+	(1000000 * 3 * EFF_FRAME_MAX_BITS / (bitrate))
+#define ONGOING_WAIT_JIFFIES(bitrate)			\
+	usecs_to_jiffies(ONGOING_WAIT_USECS((bitrate)))
+
+#define RESET_TIMER(timer, bitrate)					\
+	mod_timer((timer), jiffies + ONGOING_WAIT_JIFFIES((bitrate)))
+
+
+#define TXSPACE(txsize, txwr, eskbp)					\
+	(((txsize) / MSG_SIZE - 1)					\
+	 - ((((txwr) - (eskbp)) % (txsize)) / MSG_SIZE))
+
+
+#endif /* GRCAN_H */
-- 
1.7.0.4


From: =?UTF-8?q?Thomas=20K=C3=B6rper?= <Thomas.Koerper@esd.eu>
Subject: [PATCH 1/1] can: Add support for esd CAN PCIe/402 card
Date: Mon, 13 Oct 2014 13:23:30 +0200
Message-ID: <1413199410-42938-1-git-send-email-Thomas.Koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu02.htp-tel.de ([81.14.242.9]:58526 "EHLO mxuout02.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbaJMLXi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 13 Oct 2014 07:23:38 -0400
Received: from mxuin01.htp-tel.de (a81-14-242-29.net-htp.de [81.14.242.29])
        by mxuout02.htp-tel.de with ESMTP id s9DBNYDT027451
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-can@vger.kernel.org>; Mon, 13 Oct 2014 13:23:34 +0200 (CEST)
Received: from esd-s3.esd.eu (a81-14-225-174.net-htp.de [81.14.225.174])
        by mxuin01.htp-tel.de with ESMTP id s9DBNXEt000584
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-can@vger.kernel.org>; Mon, 13 Oct 2014 13:23:34 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20K=C3=B6rper?= <Thomas.Koerper@esd.eu>

Some infos: Hardware: Card based on our own CAN controller ("esdACC"). =
Bus master DMA and MSI / Different configurations with up to 4 can core=
s / CAN termination jumpers on board.
Driver: "core" refers to a net/controller specific part, overview ("ov"=
) to the general card. DMA transfer (Rx direction) is done via bus mast=
er messages ("bm_" prefix)

Signed-off-by: Thomas K=C3=B6rper <Thomas.Koerper@esd.eu>
---
 drivers/net/can/Kconfig      |    2 +
 drivers/net/can/Makefile     |    1 +
 drivers/net/can/esd/Kconfig  |    6 +
 drivers/net/can/esd/Makefile |    4 +
 drivers/net/can/esd/esd402.c | 1115 ++++++++++++++++++++++++++++++++++=
++++++++
 drivers/net/can/esd/esd402.h |  332 +++++++++++++
 6 files changed, 1460 insertions(+)
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd402.c
 create mode 100644 drivers/net/can/esd/esd402.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 4168822..077ee72 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -151,6 +151,8 @@ source "drivers/net/can/usb/Kconfig"
=20
 source "drivers/net/can/softing/Kconfig"
=20
+source "drivers/net/can/esd/Kconfig"
+
 endif
=20
 config CAN_DEBUG_DEVICES
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 1697f22..5b8681e 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -13,6 +13,7 @@ can-dev-$(CONFIG_CAN_LEDS)	+=3D led.o
 obj-y				+=3D spi/
 obj-y				+=3D usb/
 obj-y				+=3D softing/
+obj-y				+=3D esd/
=20
 obj-$(CONFIG_CAN_SJA1000)	+=3D sja1000/
 obj-$(CONFIG_CAN_MSCAN)		+=3D mscan/
diff --git a/drivers/net/can/esd/Kconfig b/drivers/net/can/esd/Kconfig
new file mode 100644
index 0000000..faefced
--- /dev/null
+++ b/drivers/net/can/esd/Kconfig
@@ -0,0 +1,6 @@
+config CAN_ESD_402
+	tristate "esd gmbh CAN PCIe/402 support"
+	default y
+	depends on PCI && HAS_DMA
+	---help---
+	  Support for CAN PCIe/402 cards from esd electronic system design gm=
bh
diff --git a/drivers/net/can/esd/Makefile b/drivers/net/can/esd/Makefil=
e
new file mode 100644
index 0000000..211b64d
--- /dev/null
+++ b/drivers/net/can/esd/Makefile
@@ -0,0 +1,4 @@
+
+obj-m +=3D esd402.o
+
+ccflags-$(CONFIG_CAN_DEBUG_DEVICES) :=3D -DDEBUG
diff --git a/drivers/net/can/esd/esd402.c b/drivers/net/can/esd/esd402.=
c
new file mode 100644
index 0000000..54e55d1
--- /dev/null
+++ b/drivers/net/can/esd/esd402.c
@@ -0,0 +1,1115 @@
+=EF=BB=BF/* Copyright (C) 2014 esd electronic system design gmbh
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the version 2 of the GNU General Public Licen=
se
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/dma-mapping.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+
+#include "esd402.h"
+
+#define DRV_NAME			"esd402_driver"
+
+#define ESD_CAN_EFF_FLAG		0x20000000
+#define ESD_CAN_RTR_FLAG		0x10
+#define ESD_CAN_DLC_MASK		0x0f
+
+static inline u32 ov_read32(struct esd_pci402_card *card, unsigned sho=
rt offs)
+{
+	return ioread32be(card->addr_overview + offs);
+}
+
+static inline void ov_write32(struct esd_pci402_card *card,
+			      unsigned short offs, u32 v)
+{
+	iowrite32be(v, card->addr_overview + offs);
+}
+
+static void ov_set_bits(struct esd_pci402_card *card,
+			unsigned short offs, u32 b)
+{
+	u32 v =3D ov_read32(card, offs);
+
+	v |=3D b;
+	ov_write32(card, offs, v);
+}
+
+static void ov_clear_bits(struct esd_pci402_card *card,
+			  unsigned short offs, u32 b)
+{
+	u32 v =3D ov_read32(card, offs);
+
+	v &=3D ~b;
+	ov_write32(card, offs, v);
+}
+
+static ktime_t ov_ts_to_ktime(struct esd_pci402_card *card, u64 ts)
+{
+	unsigned long long ns;
+	unsigned int rem;
+
+	rem =3D do_div(ts, card->timestamp_frequency);
+	ns =3D ts * NSEC_PER_SEC;
+
+	ts =3D (unsigned long long)rem * NSEC_PER_SEC;
+	do_div(ts, card->timestamp_frequency);
+	ns +=3D ts;
+
+	return ns_to_ktime(ns);
+}
+
+static inline u32 core_read32(struct esd_pci402_cancore *core,
+			      unsigned short offs)
+{
+	return ioread32be(core->addr + offs);
+}
+
+static inline void core_write32(struct esd_pci402_cancore *core,
+				unsigned short offs, u32 v)
+{
+	iowrite32be(v, core->addr + offs);
+}
+
+static inline void core_write32_noswap(struct esd_pci402_cancore *core=
,
+				       unsigned short offs, u32 v)
+{
+	iowrite32(v, core->addr + offs);
+}
+
+static void core_set_bits(struct esd_pci402_cancore *core,
+			  unsigned short offs, u32 mask)
+{
+	u32 v =3D core_read32(core, offs);
+
+	v |=3D mask;
+	core_write32(core, offs, v);
+}
+
+static void core_clear_bits(struct esd_pci402_cancore *core,
+			    unsigned short offs, u32 mask)
+{
+	u32 v =3D core_read32(core, offs);
+
+	v &=3D ~mask;
+	core_write32(core, offs, v);
+}
+
+static int core_resetmode_entered(struct esd_pci402_cancore *core)
+{
+	u32 ctrl =3D core_read32(core, OFFS_CORE_CTRL_MODE);
+
+	return (ctrl & REG_CONTROL_MASK_MODE_RESETMODE) !=3D 0;
+}
+
+static void core_resetmode_enter(struct esd_pci402_cancore *core)
+{
+	int i;
+
+	core_set_bits(core, OFFS_CORE_CTRL_MODE,
+		      REG_CONTROL_MASK_MODE_RESETMODE);
+
+	for (i =3D 0; i < 10; ++i) {
+		if (core_resetmode_entered(core))
+			return;
+
+		udelay(5);
+	}
+
+	netdev_warn(core->net_dev, "Entering reset mode timed out\n");
+}
+
+static void core_resetmode_leave(struct esd_pci402_cancore *core)
+{
+	int i;
+
+	core_clear_bits(core, OFFS_CORE_CTRL_MODE,
+			REG_CONTROL_MASK_MODE_RESETMODE);
+
+	for (i =3D 0; i < 10; ++i) {
+		if (!core_resetmode_entered(core))
+			return;
+
+		udelay(5);
+	}
+
+	netdev_warn(core->net_dev, "Leaving reset mode timed out\n");
+}
+
+static int core_txq_isready(struct esd_pci402_cancore *core)
+{
+	u8 fifo_level =3D (u8)(core_read32(core, OFFS_CORE_TXFIFO_STATUS) >> =
16);
+
+	return (fifo_level < core->tx_fifo_size - 1);
+}
+
+static void core_txq_put(struct esd_pci402_cancore *core, u32 esd_id,
+			 u8 esd_len, const void *data)
+{
+	core_write32_noswap(core, OFFS_CORE_TXFIFO_DATA_0,
+			    *((const u32 *)data));
+	core_write32_noswap(core, OFFS_CORE_TXFIFO_DATA_1,
+			    *((const u32 *)(data + 4)));
+	core_write32(core, OFFS_CORE_TXFIFO_DLC, esd_len);
+	/* CAN id must be written at last: */
+	core_write32(core, OFFS_CORE_TXFIFO_ID, esd_id);
+}
+
+static void core_handlemsg_rxtxdone(struct esd_pci402_cancore *core,
+				    const struct bm_msg_rxtxdone *msg)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(core->net_dev);
+	struct net_device_stats *stats =3D &core->net_dev->stats;
+
+	if (msg->dlc.rxtx.len & ESD_PCI402_BM_LENFLAG_TX) {
+		if (core->tx_fifo_head =3D=3D core->tx_fifo_tail) {
+			netdev_warn(core->net_dev,
+				    "TX interrupt, but queue is empty!?\n");
+			return;
+		}
+		stats->tx_packets++;
+		stats->tx_bytes +=3D
+				get_can_dlc(msg->dlc.tx.len & ESD_CAN_DLC_MASK);
+
+		can_get_echo_skb(core->net_dev, core->tx_fifo_tail);
+		core->tx_fifo_tail++;
+		if (core->tx_fifo_tail >=3D core->tx_fifo_size)
+			core->tx_fifo_tail =3D 0;
+		netif_wake_queue(core->net_dev);
+
+	} else {
+		struct skb_shared_hwtstamps *skb_ts;
+		struct can_frame *cf;
+		struct sk_buff *skb;
+
+		skb =3D alloc_can_skb(core->net_dev, &cf);
+		if (skb =3D=3D NULL) {
+			stats->rx_dropped++;
+			return;
+		}
+
+		cf->can_id =3D msg->id & CAN_EFF_MASK;
+		if (msg->id & ESD_CAN_EFF_FLAG)
+			cf->can_id |=3D CAN_EFF_FLAG;
+
+		cf->can_dlc =3D get_can_dlc(msg->dlc.rx.len);
+		if (msg->dlc.rx.len & ESD_CAN_RTR_FLAG)
+			cf->can_id |=3D CAN_RTR_FLAG;
+		else
+			memcpy(cf->data, msg->data, cf->can_dlc);
+
+		skb_ts =3D skb_hwtstamps(skb);
+		skb_ts->hwtstamp =3D ov_ts_to_ktime(priv->card, msg->timestamp);
+		netif_rx(skb);
+
+		stats->rx_packets++;
+		stats->rx_bytes +=3D cf->can_dlc;
+	}
+}
+
+static void core_handlemsg_txabort(struct esd_pci402_cancore *core,
+				   const struct bm_msg_txabort *msg)
+{
+	struct net_device_stats *stats =3D &core->net_dev->stats;
+	int i;
+
+	/* abort_mask signals which frames were aborted in card's fifo */
+	for (i =3D 0; i < sizeof(msg->abort_mask) * BITS_PER_BYTE; ++i) {
+		if (!(msg->abort_mask & (1 << i)))
+			continue;
+
+		if (core->tx_fifo_head =3D=3D core->tx_fifo_tail) {
+			netdev_warn(core->net_dev,
+				    "TX Err interrupt, but queue is empty!?\n");
+			break;
+		}
+		stats->tx_errors++;
+
+		can_free_echo_skb(core->net_dev, core->tx_fifo_tail);
+		core->tx_fifo_tail++;
+		if (core->tx_fifo_tail >=3D core->tx_fifo_size)
+			core->tx_fifo_tail =3D 0;
+	}
+
+	if (!core_resetmode_entered(core))
+		netif_wake_queue(core->net_dev);
+}
+
+static void core_handlemsg_overrun(struct esd_pci402_cancore *core,
+				   const struct bm_msg_overrun *msg)
+{
+	struct net_device_stats *stats =3D &core->net_dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	skb =3D alloc_can_err_skb(core->net_dev, &cf);
+	if (skb =3D=3D NULL)
+		return;
+
+	/* lost_cnt may be 0 if not supported by FPGA version */
+	if (msg->lost_cnt) {
+		stats->rx_dropped +=3D msg->lost_cnt;
+		stats->rx_over_errors +=3D  msg->lost_cnt;
+	} else {
+		stats->rx_dropped++;
+		stats->rx_over_errors++;
+	}
+
+	cf->can_id |=3D CAN_ERR_CRTL;
+	cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
+
+	netif_rx(skb);
+	stats->rx_packets++;
+	stats->rx_bytes +=3D cf->can_dlc;
+}
+
+static void core_handlemsg_buserr(struct esd_pci402_cancore *core,
+				  const struct bm_msg_buserr *msg)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(core->net_dev);
+	struct net_device_stats *stats =3D &core->net_dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	priv->can.can_stats.bus_error++;
+	stats->rx_errors++;
+
+	skb =3D alloc_can_err_skb(core->net_dev, &cf);
+	if (skb =3D=3D NULL)
+		return;
+
+	cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+	/* msg->ecc acts like SJA1000's ECC register */
+	switch (msg->ecc & ESD_PCI402_ECC_MASK) {
+	case ESD_PCI402_ECC_BIT:
+		cf->data[2] |=3D CAN_ERR_PROT_BIT;
+		break;
+	case ESD_PCI402_ECC_FORM:
+		cf->data[2] |=3D CAN_ERR_PROT_FORM;
+		break;
+	case ESD_PCI402_ECC_STUFF:
+		cf->data[2] |=3D CAN_ERR_PROT_STUFF;
+		break;
+	default:
+		cf->data[2] |=3D CAN_ERR_PROT_UNSPEC;
+		cf->data[3] =3D msg->ecc & ESD_PCI402_ECC_SEG;
+		break;
+	}
+
+	if ((msg->ecc & ESD_PCI402_ECC_DIR) =3D=3D 0)
+		cf->data[2] |=3D CAN_ERR_PROT_TX;
+
+	netif_rx(skb);
+	stats->rx_packets++;
+	stats->rx_bytes +=3D cf->can_dlc;
+}
+
+static void
+core_handlemsg_errstatechange(struct esd_pci402_cancore *core,
+			      const struct bm_msg_errstatechange *msg)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(core->net_dev);
+	struct net_device_stats *stats =3D &core->net_dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	int is_busoff;
+	int is_passive;
+	int is_warning;
+	u8 txerr;
+	u8 rxerr;
+
+	txerr =3D (u8)(msg->reg_status >> 8);
+	rxerr =3D (u8)msg->reg_status;
+	is_warning =3D (msg->reg_status & REG_STATUS_MASK_STATUS_ES) !=3D 0;
+	is_passive =3D (msg->reg_status & REG_STATUS_MASK_STATUS_EP) !=3D 0;
+	is_busoff =3D (msg->reg_status & REG_STATUS_MASK_STATUS_BS) !=3D 0;
+
+	skb =3D alloc_can_err_skb(core->net_dev, &cf);
+	if (skb) {
+		if (is_busoff) {
+			priv->can.state =3D CAN_STATE_BUS_OFF;
+			/* bus-offs counted by can_bus_off() */
+			cf->can_id |=3D CAN_ERR_BUSOFF;
+		} else if (is_passive) {
+			priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
+			priv->can.can_stats.error_passive++;
+			cf->data[1] =3D (txerr > rxerr) ? CAN_ERR_CRTL_TX_PASSIVE
+					: CAN_ERR_CRTL_RX_PASSIVE;
+			cf->can_id |=3D CAN_ERR_CRTL;
+			cf->data[6] =3D txerr;
+			cf->data[7] =3D rxerr;
+		} else if (is_warning) {
+			priv->can.state =3D CAN_STATE_ERROR_WARNING;
+			priv->can.can_stats.error_warning++;
+			cf->data[1] =3D (txerr > rxerr) ? CAN_ERR_CRTL_TX_WARNING
+					: CAN_ERR_CRTL_RX_WARNING;
+			cf->can_id |=3D CAN_ERR_CRTL;
+			cf->data[6] =3D txerr;
+			cf->data[7] =3D rxerr;
+		} else {
+			priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+			/* restarts counted in dev.c */
+		}
+
+		netif_rx(skb);
+		stats->rx_packets++;
+		stats->rx_bytes +=3D cf->can_dlc;
+	}
+
+	if (is_busoff) {
+		core_write32(core, OFFS_CORE_TX_ABORT_MASK, 0xffff);
+		can_bus_off(core->net_dev);
+	}
+}
+
+static void core_handle_interrupt(struct esd_pci402_cancore *core)
+{
+	u32 msg_fifo_head =3D core->irq_cnt & 0xff;
+
+	while (core->msg_fifo_tail !=3D msg_fifo_head) {
+		const struct bm_msg *msg =3D &core->bm_fifo[core->msg_fifo_tail];
+
+		switch (msg->u.msg_id) {
+		case BM_MSG_ID_RXTXDONE:
+			core_handlemsg_rxtxdone(core, &msg->u.rxtxdone);
+			break;
+
+		case BM_MSG_ID_TXABORT:
+			core_handlemsg_txabort(core, &msg->u.txabort);
+			break;
+
+		case BM_MSG_ID_OVERRUN:
+			core_handlemsg_overrun(core, &msg->u.overrun);
+			break;
+
+		case BM_MSG_ID_BUSERR:
+			core_handlemsg_buserr(core, &msg->u.buserr);
+			break;
+
+		case BM_MSG_ID_ERRPASSIVE:
+		case BM_MSG_ID_ERRWARN:
+			core_handlemsg_errstatechange(core,
+						      &msg->u.errstatechange);
+			break;
+
+		default:
+			break;
+		}
+
+		core->msg_fifo_tail++;
+		if (core->msg_fifo_tail >=3D ESD_PCI402_DMA_FIFO_ITEMCOUNT)
+			core->msg_fifo_tail =3D 0;
+	}
+}
+
+static irqreturn_t esd_pci402_interrupt(int irq, void *dev_id)
+{
+	struct esd_pci402_card *card;
+	u32 irqmask;
+	int i;
+
+	card =3D pci_get_drvdata((struct pci_dev *)dev_id);
+
+	/* First we look for whom interrupts are pending, card/overview
+	 * or any of the cores. Two bits in irqmask are used for each;
+	 * set to BM_IRQ_MASK then:
+	 */
+	irqmask =3D 0;
+	if (*card->bm_irq_cnt !=3D card->irq_cnt) {
+		irqmask |=3D BM_IRQ_MASK;
+		card->irq_cnt =3D *card->bm_irq_cnt;
+	}
+
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		if (*core->bm_irq_cnt !=3D core->irq_cnt) {
+			irqmask |=3D (BM_IRQ_MASK << (2 * (i + 1)));
+			core->irq_cnt =3D *core->bm_irq_cnt;
+		}
+	}
+
+	if (!irqmask)
+		return IRQ_NONE;
+
+	/* At second we tell the card we're working on them by writing irqmas=
k,
+	 * call esd_pci402_interrupt_{ov|core} and then acknowledge the
+	 * interrupts by writing irq_cnt:
+	 */
+	ov_write32(card, OFFS_OV_BM_IRQ_MASK, irqmask);
+
+	if (irqmask & BM_IRQ_MASK) {
+		/* ov_handle_interrupt(card); - no use yet. */
+		ov_write32(card, OFFS_OV_BM_IRQ_COUNTER, card->irq_cnt);
+	}
+
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		if (irqmask & (BM_IRQ_MASK << (2 * (i + 1)))) {
+			core_handle_interrupt(core);
+			core_write32(core, OFFS_OV_BM_IRQ_COUNTER,
+				     core->irq_cnt);
+		}
+	}
+
+	ov_write32(card, OFFS_OV_BM_IRQ_MASK, BM_IRQ_UNMASK_ALL);
+
+	return IRQ_HANDLED;
+}
+
+static int esd_pci402_open(struct net_device *netdev)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+	u32 ctrl_mode;
+	int err;
+
+	err =3D open_candev(netdev);
+	if (err)
+		return err;
+
+	ctrl_mode =3D REG_CONTROL_MASK_IE_RXTX |
+			REG_CONTROL_MASK_IE_TXERROR |
+			REG_CONTROL_MASK_IE_ERRPASS |
+			REG_CONTROL_MASK_IE_OVERRUN |
+			REG_CONTROL_MASK_IE_ERROR;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		ctrl_mode |=3D REG_CONTROL_MASK_IE_BUSERR;
+
+	core_set_bits(priv->core, OFFS_CORE_CTRL_MODE, ctrl_mode);
+
+	netif_start_queue(netdev);
+	return 0;
+}
+
+static int esd_pci402_close(struct net_device *netdev)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+
+	core_clear_bits(priv->core, OFFS_CORE_CTRL_MODE,
+			REG_CONTROL_MASK_IE_RXTX |
+			REG_CONTROL_MASK_IE_TXERROR |
+			REG_CONTROL_MASK_IE_OVERRUN);
+
+	netif_stop_queue(netdev);
+	priv->can.state =3D CAN_STATE_STOPPED;
+
+	close_candev(netdev);
+	return 0;
+}
+
+static netdev_tx_t esd_pci402_start_xmit(struct sk_buff *skb,
+					 struct net_device *netdev)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+	struct can_frame *cf =3D (struct can_frame *)skb->data;
+	struct esd_pci402_cancore *core =3D priv->core;
+	u8 new_fifo_head =3D (core->tx_fifo_head + 1) % core->tx_fifo_size;
+	u32 esd_id;
+	u8 esd_len;
+
+	if ((new_fifo_head =3D=3D core->tx_fifo_tail) || !core_txq_isready(co=
re)) {
+		netif_stop_queue(netdev);
+		return NETDEV_TX_BUSY;
+	}
+
+	esd_len =3D can_dlc2len(cf->can_dlc);
+	if (cf->can_id & CAN_RTR_FLAG)
+		esd_len |=3D ESD_CAN_RTR_FLAG;
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		esd_id =3D cf->can_id & CAN_EFF_MASK;
+		esd_id |=3D ESD_CAN_EFF_FLAG;
+	} else {
+		esd_id =3D cf->can_id & CAN_SFF_MASK;
+	}
+
+	can_put_echo_skb(skb, netdev, core->tx_fifo_head);
+	core->tx_fifo_head =3D new_fifo_head;
+
+	core_txq_put(core, esd_id, esd_len, cf->data);
+
+	return NETDEV_TX_OK;
+}
+
+static int esd_pci402_set_bittiming(struct net_device *netdev)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+	struct can_bittiming *bt =3D &priv->can.bittiming;
+	u32 btr;
+	u8 brp;
+
+	brp =3D (u8)(bt->brp - 1);
+	core_resetmode_enter(priv->core);
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		core_set_bits(priv->core, OFFS_CORE_CTRL_MODE,
+			      REG_CONTROL_MASK_MODE_LOM);
+	else
+		core_clear_bits(priv->core, OFFS_CORE_CTRL_MODE,
+				REG_CONTROL_MASK_MODE_LOM);
+
+	if (priv->card->version < ESD_PCI402_VERSION_NEWBTR) {
+		btr =3D brp;
+
+		/* TSEG1: Bit12..15 */
+		btr |=3D ((bt->phase_seg1 + bt->prop_seg - 1) & 0xf) << 12;
+		/* TSEG2: Bit20..22 */
+		btr |=3D ((bt->phase_seg2 - 1) & 0x7) << 20;
+		/* SJW: Bit25..26 */
+		btr |=3D ((bt->sjw - 1) & 0x3) << 25;
+
+		core_write32(priv->core, OFFS_CORE_BTR, btr);
+	} else {
+		/* TSEG1: Bit0..7 */
+		btr =3D (bt->phase_seg1 + bt->prop_seg - 1) & 0xff;
+		/* TSEG2: Bit16..22 */
+		btr |=3D ((bt->phase_seg2 - 1) & 0x7f) << 16;
+		/* SJW: Bit24..30 */
+		btr |=3D ((bt->sjw - 1) & 0x7f) << 24;
+
+		core_write32(priv->core, OFFS_CORE_BTR, brp);
+		core_write32(priv->core, OFFS_CORE_BTR_FD, btr);
+	}
+
+	core_resetmode_leave(priv->core);
+	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
+
+	return 0;
+}
+
+static int esd_pci402_get_berr_counter(const struct net_device *netdev=
,
+				       struct can_berr_counter *bec)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+	u32 core_status =3D core_read32(priv->core, OFFS_CORE_STATUS);
+
+	bec->txerr =3D (u8)(core_status >> 8);
+	bec->rxerr =3D (u8)core_status;
+
+	return 0;
+}
+
+static int esd_pci402_set_mode(struct net_device *netdev, enum can_mod=
e mode)
+{
+	struct esd_pci402_net_priv *priv =3D netdev_priv(netdev);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		core_resetmode_leave(priv->core);
+		netif_wake_queue(netdev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/* For cards with FPGA Version < ESD_PCI402_VERSION_NEWBTR */
+static const struct can_bittiming_const esd_pci402_bittiming_const_old=
 =3D {
+	.name =3D "esd_pci402_old",
+	.tseg1_min =3D 1,
+	.tseg1_max =3D 16,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 8,
+	.sjw_max =3D 4,
+	.brp_min =3D 1,
+	.brp_max =3D 256,
+	.brp_inc =3D 1,
+};
+
+static const struct can_bittiming_const esd_pci402_bittiming_const =3D=
 {
+	.name =3D "esd_pci402",
+	.tseg1_min =3D 1,
+	.tseg1_max =3D 256,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 128,
+	.sjw_max =3D 128,
+	.brp_min =3D 1,
+	.brp_max =3D 256,
+	.brp_inc =3D 1,
+};
+
+static const struct net_device_ops esd_pci402_netdev_ops =3D {
+	.ndo_open =3D esd_pci402_open,
+	.ndo_stop =3D esd_pci402_close,
+	.ndo_start_xmit =3D esd_pci402_start_xmit,
+	.ndo_change_mtu =3D can_change_mtu
+};
+
+static int dump_infos;
+module_param(dump_infos, int, S_IRUGO);
+MODULE_PARM_DESC(dump_infos, "Dump card infos while probing. Default: =
0 (Off)");
+
+static void esd_pci402_reset_fpga(struct esd_pci402_card *card)
+{
+	ov_write32(card, OFFS_OV_MODE, REG_OV_MODE_MASK_FPGA_RESET);
+
+	/* Also reset I=C2=B2C, to re-detect card addons at every driver star=
t: */
+	ov_clear_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_I2C_ENABLE);
+	mdelay(2);
+	ov_set_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_I2C_ENABLE);
+	mdelay(10);
+}
+
+static int esd_pci402_set_msiconfig(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	u32 addr_lo_offs =3D 0;
+	u32 addr_lo =3D 0;
+	u32 addr_hi =3D 0;
+	u32 data =3D 0;
+	u16 csr =3D 0;
+	int err;
+
+	err =3D pci_read_config_word(pdev, ESD_PCI402_PCICFG_MSICAP_CSR, &csr=
);
+	if (err)
+		goto failed;
+
+	err =3D pci_read_config_dword(pdev, ESD_PCI402_PCICFG_MSICAP_ADDR,
+				    &addr_lo);
+	if (err)
+		goto failed;
+
+	err =3D pci_read_config_dword(pdev, ESD_PCI402_PCICFG_MSICAP_ADDR + 4=
,
+				    &addr_hi);
+	if (err)
+		goto failed;
+
+	err =3D pci_read_config_dword(pdev, ESD_PCI402_PCICFG_MSICAP_DATA, &d=
ata);
+	if (err)
+		goto failed;
+
+	addr_lo_offs =3D addr_lo & 0x0000ffff;
+	addr_lo &=3D 0xffff0000;
+
+	if (addr_hi)
+		addr_lo |=3D 1; /* Enable 64-Bit addressing in address space */
+
+	if (!(csr & 0x0001)) /* Enable bit */
+		goto failed;
+
+	iowrite32(addr_lo, card->addr_pciep + OFFS_PCIEP_MSI_ADDR_LO);
+	iowrite32(addr_hi, card->addr_pciep + OFFS_PCIEP_MSI_ADDR_HI);
+	ov_write32(card, OFFS_OV_MSI_ADDRESSOFFSET, addr_lo_offs);
+	ov_write32(card, OFFS_OV_MSI_DATA, data);
+
+	return 0;
+
+failed:
+	dev_warn(&pdev->dev, "Error while setting MSI configuration:\n"
+		 "CSR: 0x%.4x, addr: 0x%.8x%.8x, data: 0x%.8x\n",
+		 csr, addr_hi, addr_lo, data);
+
+	return -1;
+}
+
+static int esd_pci402_init_card(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	u32 temp;
+
+	card->addr_overview =3D card->addr + ESD_PCI402_IO_OV_OFFS;
+	card->addr_pciep =3D card->addr + ESD_PCI402_IO_PCIEP_OFFS;
+
+	esd_pci402_reset_fpga(card);
+
+#ifdef __LITTLE_ENDIAN
+	ov_set_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_ENDIAN_LITTLE);
+	/* So card converts all busmastered data to LE for us */
+#endif
+
+	temp =3D ov_read32(card, OFFS_OV_VERSION);
+	card->features =3D (u16)(temp >> 16);
+	card->version =3D (u16)temp;
+
+	temp =3D ov_read32(card, OFFS_OV_INFO);
+	card->active_cores =3D (u8)(temp >> 8);
+	card->total_cores =3D (u8)temp;
+	if (card->active_cores > ESD_PCI402_MAX_CORES) {
+		dev_warn(&pdev->dev, "Card has more active cores than supported by d=
river, %u core(s) will be ignored\n",
+			 card->active_cores - ESD_PCI402_MAX_CORES);
+		card->active_cores =3D ESD_PCI402_MAX_CORES;
+	}
+
+	card->core_frequency =3D ov_read32(card, OFFS_OV_CANCORE_FREQ);
+	card->timestamp_frequency =3D ov_read32(card, OFFS_OV_TS_FREQ_LO);
+
+	if (dump_infos) {
+		dev_info(&pdev->dev, "\"dump_infos\" selected:");
+
+		temp =3D ov_read32(card, OFFS_OV_PROBE);
+		dev_info(&pdev->dev, "  Probe register: 0x%.8x\n", temp);
+		dev_info(&pdev->dev, "  Features: 0x%.4x\n", card->features);
+		dev_info(&pdev->dev, "  FPGA Version: 0x%.4x\n", card->version);
+		dev_info(&pdev->dev, "  Strappings: 0x%.4x\n",
+			 ov_read32(card, OFFS_OV_INFO) >> 16);
+		dev_info(&pdev->dev, "  Active cores: %u\n",
+			 card->active_cores);
+		dev_info(&pdev->dev, "  Total cores: %u\n",
+			 card->total_cores);
+		dev_info(&pdev->dev, "  Core frequency: %u\n",
+			 card->core_frequency);
+		dev_info(&pdev->dev, "  Timestamp frequency: %u\n",
+			 card->timestamp_frequency);
+	}
+
+	if (card->version < ESD_PCI402_VERSION_MIN) {
+		dev_err(&pdev->dev,
+			"FPGA version (0x%.4x) outdated, please update\n",
+			card->version);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int esd_pci402_init_interrupt(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	int err;
+
+	err =3D pci_enable_msi(pdev);
+	if (!err) {
+		err =3D esd_pci402_set_msiconfig(pdev);
+		if (!err) {
+			card->msi_enabled =3D 1;
+			ov_set_bits(card, OFFS_OV_MODE,
+				    REG_OV_MODE_MASK_MSI_ENABLE);
+			dev_info(&pdev->dev, "MSI enabled\n");
+		}
+	}
+
+	err =3D request_irq(pdev->irq, esd_pci402_interrupt,
+			  IRQF_SHARED, DRV_NAME, pdev);
+	if (err)
+		goto failure_msidis;
+
+	iowrite32(1, card->addr_pciep + OFFS_PCIEP_INT_ENABLE);
+
+	return 0;
+
+failure_msidis:
+	if (card->msi_enabled) {
+		ov_clear_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_MSI_ENABLE);
+		pci_disable_msi(pdev);
+		card->msi_enabled =3D 0;
+	}
+
+	return err;
+}
+
+static void esd_pci402_finish_interrupt(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+
+	iowrite32(0, card->addr_pciep + OFFS_PCIEP_INT_ENABLE);
+	free_irq(pdev->irq, pdev);
+
+	if (card->msi_enabled) {
+		ov_clear_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_MSI_ENABLE);
+		pci_disable_msi(pdev);
+		card->msi_enabled =3D 0;
+	}
+}
+
+static int esd_pci402_init_dma(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	int err;
+	int i;
+
+	err =3D pci_set_consistent_dma_mask(pdev, ESD_PCI402_DMA_MASK);
+	if (err) {
+		dev_err(&pdev->dev, "dma set mask failed!");
+		return err;
+	}
+
+	card->dma_buf =3D pci_alloc_consistent(pdev, ESD_PCI402_DMA_SIZE,
+					     &card->dma_hnd);
+	if (!card->dma_buf) {
+		dev_err(&pdev->dev, "dma alloc failed!");
+		return -ENOMEM;
+	}
+
+	/* Setting card/core "bm_" pointers according to this DMA buffer layo=
ut:
+	 * +-----------------------+
+	 * | FIFO Card/Overview    |
+	 * +-----------------------+
+	 * | FIFO Core0            |
+	 * +-----------------------+
+	 * | FIFO Core1            |
+	 * +-----------------------+
+	 * | ...                   |
+	 * +-----------------------+
+	 * | irq_cnt Card/Overview |
+	 * +-----------------------+
+	 * | irq_cnt Core0         |
+	 * +-----------------------+
+	 * | irq_cnt Core1         |
+	 * +-----------------------+
+	 * | ...                   |
+	 * +-----------------------+
+	 */
+	card->bm_fifo =3D card->dma_buf;
+	card->bm_irq_cnt =3D card->dma_buf + (card->total_cores + 1)
+						* ESD_PCI402_DMA_FIFOSIZE;
+
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		core->bm_fifo =3D card->dma_buf + (i + 1)
+						* ESD_PCI402_DMA_FIFOSIZE;
+		core->bm_irq_cnt =3D card->bm_irq_cnt + 1 + i;
+	}
+
+	iowrite32((u32)card->dma_hnd,
+		  card->addr_pciep + OFFS_PCIEP_BM_ADDR_LO);
+	iowrite32((u32)(card->dma_hnd >> 32),
+		  card->addr_pciep + OFFS_PCIEP_BM_ADDR_HI);
+
+	ov_set_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_BM_ENABLE);
+
+	return 0;
+}
+
+static void esd_pci402_finish_dma(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	int i;
+
+	ov_clear_bits(card, OFFS_OV_MODE, REG_OV_MODE_MASK_BM_ENABLE);
+
+	iowrite32(0, card->addr_pciep + OFFS_PCIEP_BM_ADDR_LO);
+	iowrite32(0, card->addr_pciep + OFFS_PCIEP_BM_ADDR_HI);
+
+	card->bm_fifo =3D NULL;
+	card->bm_irq_cnt =3D NULL;
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		core->bm_fifo =3D NULL;
+		core->bm_irq_cnt =3D NULL;
+	}
+
+	pci_free_consistent(pdev, ESD_PCI402_DMA_SIZE, card->dma_buf,
+			    card->dma_hnd);
+	card->dma_buf =3D NULL;
+}
+
+static int esd_pci402_init_cores(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	const struct can_bittiming_const *bittiming_const;
+	int num_register_ok =3D 0;
+	int err;
+	int i;
+
+	if (card->version < ESD_PCI402_VERSION_NEWBTR)
+		bittiming_const =3D &esd_pci402_bittiming_const_old;
+	else
+		bittiming_const =3D &esd_pci402_bittiming_const;
+
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+		struct esd_pci402_net_priv *priv;
+		struct net_device *netdev;
+		u32 fifo_config;
+
+		core->addr =3D card->addr_overview +
+				(i + 1) * ESD_PCI402_IO_LEN_CORE;
+
+		fifo_config =3D core_read32(core, OFFS_CORE_TXFIFO_CONFIG);
+		core->tx_fifo_size =3D (u8)(fifo_config >> 24);
+		BUG_ON(core->tx_fifo_size <=3D 1);
+
+		netdev =3D alloc_candev(sizeof(*priv), core->tx_fifo_size);
+		if (!netdev) {
+			err =3D -ENOMEM;
+			goto failure;
+		}
+		core->net_dev =3D netdev;
+
+		netdev->flags |=3D IFF_ECHO;
+		netdev->netdev_ops =3D &esd_pci402_netdev_ops;
+		SET_NETDEV_DEV(netdev, &pdev->dev);
+
+		priv =3D netdev_priv(netdev);
+		priv->can.state =3D CAN_STATE_STOPPED;
+		priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LISTENONLY |
+						CAN_CTRLMODE_LOOPBACK |
+						CAN_CTRLMODE_BERR_REPORTING;
+		priv->can.clock.freq =3D card->core_frequency / 2;
+		priv->can.bittiming_const =3D bittiming_const;
+		priv->can.do_set_bittiming =3D esd_pci402_set_bittiming;
+		priv->can.do_set_mode =3D esd_pci402_set_mode;
+		priv->can.do_get_berr_counter =3D esd_pci402_get_berr_counter;
+
+		priv->card =3D card;
+		priv->core =3D core;
+
+		err =3D register_candev(netdev);
+		if (err)
+			goto failure;
+
+		netdev_info(netdev, "registered\n");
+		num_register_ok++;
+	}
+
+	return 0;
+
+failure:
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		if (!core->net_dev)
+			continue;
+
+		if (i < num_register_ok) {
+			netdev_info(core->net_dev, "unregistering...\n");
+			unregister_candev(core->net_dev);
+		}
+
+		free_candev(core->net_dev);
+		core->net_dev =3D NULL;
+	}
+
+	return err;
+}
+
+static void esd_pci402_finish_cores(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+	int i;
+
+	for (i =3D 0; i < card->active_cores; ++i) {
+		struct esd_pci402_cancore *core =3D &card->core[i];
+
+		unregister_candev(core->net_dev);
+		free_candev(core->net_dev);
+		core->net_dev =3D NULL;
+	}
+}
+
+static int esd_pci402_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	struct esd_pci402_card *card =3D NULL;
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct bm_msg) !=3D ESD_PCI402_DMA_FIFO_ITEMSIZE)=
;
+
+	err =3D pci_enable_device(pdev);
+	if (err)
+		goto failure;
+
+	pci_set_master(pdev);
+
+	card =3D kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card)
+		goto failure;
+
+	pci_set_drvdata(pdev, card);
+
+	err =3D pci_request_regions(pdev, DRV_NAME);
+	if (err)
+		goto failure_disable_pci;
+
+	card->addr =3D pci_iomap(pdev, ESD_PCI402_BAR, ESD_PCI402_IO_LEN_TOTA=
L);
+	if (!card->addr) {
+		err =3D -ENOMEM;
+		goto failure_release_regions;
+	}
+
+	err =3D esd_pci402_init_card(pdev);
+	if (err)
+		goto failure_unmap;
+
+	err =3D esd_pci402_init_dma(pdev);
+	if (err)
+		goto failure_unmap;
+
+	err =3D esd_pci402_init_interrupt(pdev);
+	if (err)
+		goto failure_finish_dma;
+
+	err =3D esd_pci402_init_cores(pdev);
+	if (err)
+		goto failure_finish_interrupt;
+
+	return 0;
+
+failure_finish_interrupt:
+	esd_pci402_finish_interrupt(pdev);
+
+failure_finish_dma:
+	esd_pci402_finish_dma(pdev);
+
+failure_unmap:
+	pci_iounmap(pdev, card->addr);
+
+failure_release_regions:
+	pci_release_regions(pdev);
+
+failure_disable_pci:
+	pci_disable_device(pdev);
+
+failure:
+	kfree(card);
+
+	return err;
+}
+
+static void esd_pci402_remove(struct pci_dev *pdev)
+{
+	struct esd_pci402_card *card =3D pci_get_drvdata(pdev);
+
+	esd_pci402_finish_interrupt(pdev);
+	esd_pci402_finish_cores(pdev);
+	esd_pci402_finish_dma(pdev);
+	pci_iounmap(pdev, card->addr);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	kfree(card);
+}
+
+static const struct pci_device_id esd_pci402_tbl[] =3D {
+	{ PCI_VENDOR_ID_ESDGMBH, ESD_PCI_DEVICE_ID_PCI402,
+			PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, }
+};
+
+static struct pci_driver esd_pci402_driver =3D {
+	.name =3D DRV_NAME,
+	.id_table =3D esd_pci402_tbl,
+	.probe =3D esd_pci402_probe,
+	.remove =3D esd_pci402_remove,
+};
+
+module_pci_driver(esd_pci402_driver);
+
+MODULE_DESCRIPTION("linux-can driver for esd CAN PCIe/402 card");
+MODULE_AUTHOR("Thomas K=C3=B6rper <Thomas.Koerper@esd.eu>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/can/esd/esd402.h b/drivers/net/can/esd/esd402.=
h
new file mode 100644
index 0000000..509afd4
--- /dev/null
+++ b/drivers/net/can/esd/esd402.h
@@ -0,0 +1,332 @@
+/* Copyright (C) 2014 esd electronic system design gmbh
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the version 2 of the GNU General Public Licen=
se
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>=
=2E
+ */
+
+#include <linux/kernel.h>
+
+#define ESD_PCI_DEVICE_ID_PCI402	0x0402
+
+#define ESD_PCI402_VERSION_MIN		0x0025
+#define ESD_PCI402_VERSION_NEWBTR	0x0032
+
+#define ESD_PCI402_MAX_CORES		4
+#define ESD_PCI402_BAR			0
+#define ESD_PCI402_IO_OV_OFFS		0
+#define ESD_PCI402_IO_PCIEP_OFFS	0x10000
+#define ESD_PCI402_IO_LEN_TOTAL		0x20000
+#define ESD_PCI402_IO_LEN_CORE		0x2000
+#define ESD_PCI402_PCICFG_MSICAP_CSR	0x52
+#define ESD_PCI402_PCICFG_MSICAP_ADDR	0x54
+#define ESD_PCI402_PCICFG_MSICAP_DATA	0x5c
+
+#define ESD_PCI402_DMA_MASK		(DMA_BIT_MASK(32) & 0xffff0000)
+#define ESD_PCI402_DMA_SIZE		ALIGN(0x10000, PAGE_SIZE)
+#define ESD_PCI402_DMA_FIFO_ITEMCOUNT	256
+#define ESD_PCI402_DMA_FIFO_ITEMSIZE	32
+#define ESD_PCI402_DMA_FIFOSIZE		\
+		(ESD_PCI402_DMA_FIFO_ITEMCOUNT * ESD_PCI402_DMA_FIFO_ITEMSIZE)
+
+enum bm_msg_id {
+	BM_MSG_ID_RXTXDONE =3D 0x01,
+	BM_MSG_ID_TXABORT =3D 0x02,
+	BM_MSG_ID_OVERRUN =3D 0x03,
+	BM_MSG_ID_BUSERR =3D 0x04,
+	BM_MSG_ID_ERRPASSIVE =3D 0x05,
+	BM_MSG_ID_ERRWARN =3D 0x06,
+	BM_MSG_ID_TIMESLICE =3D 0x07,
+	BM_MSG_ID_HWTIMER =3D 0x08,
+	BM_MSG_ID_HOTPLUG =3D 0x09,
+	BM_MSG_ID_CANFDDATA0 =3D 0x0a,
+	BM_MSG_ID_CANFDDATA1 =3D 0x0b
+};
+
+struct bm_msg_rxtxdone {
+	u8 msg_id;
+	u8 txfifo_level;
+	u8 reserved1[2];
+	u8 txtsfifo_level;
+	u8 reserved2[3];
+	u32 id;
+	union {
+		struct {
+			u8 len;
+			u8 reserved0;
+			u8 bits;
+			u8 state;
+		} rxtx;
+		struct {
+			u8 len;
+			u8 msg_lost;
+			u8 bits;
+			u8 state;
+		} rx;
+		struct {
+			u8 len;
+			u8 txfifo_idx;
+			u8 bits;
+			u8 state;
+		} tx;
+	} dlc;
+	u8 data[8];
+	u64 timestamp;
+} __packed;
+
+struct bm_msg_txabort {
+	u8 msg_id;
+	u8 txfifo_level;
+	u16 abort_mask;
+	u8 txtsfifo_level;
+	u8 reserved2[1];
+	u16 abort_mask_txts;
+	u64 ts;
+	u32 reserved3[4];
+} __packed;
+
+struct bm_msg_overrun {
+	u8 msg_id;
+	u8 txfifo_level;
+	u8 lost_cnt;
+	u8 reserved1;
+	u8 txtsfifo_level;
+	u8 reserved2[3];
+	u64 ts;
+	u32 reserved3[4];
+} __packed;
+
+struct bm_msg_buserr {
+	u8 msg_id;
+	u8 txfifo_level;
+	u8 ecc;
+	u8 reserved1;
+	u8 txtsfifo_level;
+	u8 reserved2[3];
+	u64 ts;
+	u32 reg_status;
+	u32 reg_btr;
+	u32 reserved3[2];
+} __packed;
+
+struct bm_msg_errstatechange {
+	u8 msg_id;
+	u8 txfifo_level;
+	u8 reserved1[2];
+	u8 txtsfifo_level;
+	u8 reserved2[3];
+	u64 ts;
+	u32 reg_status;
+	u32 reserved3[3];
+} __packed;
+
+struct bm_msg_timeslice {
+	u8 msg_id;
+	u8 txfifo_level;
+	u8 reserved1[2];
+	u8 txtsfifo_level;
+	u8 reserved2[3];
+	u64 ts;
+	u32 reserved3[4];
+} __packed;
+
+struct bm_msg_hwtimer {
+	u8 msg_id;
+	u8 reserved1[3];
+	u32 reserved2[1];
+	u64 timer;
+	u32 reserved3[4];
+} __packed;
+
+struct bm_msg_hotplug {
+	u8 msg_id;
+	u8 reserved1[3];
+	u32 reserved2[7];
+} __packed;
+
+struct bm_msg_canfddata {
+	u8 msg_id;
+	u8 reserved1[3];
+	union {
+		u8 ui8[28];
+		u32 ui32[7];
+	} d;
+} __packed;
+
+struct bm_msg {
+	union {
+		u8 msg_id;
+		struct bm_msg_rxtxdone rxtxdone;
+		struct bm_msg_canfddata canfddata;
+		struct bm_msg_txabort txabort;
+		struct bm_msg_overrun overrun;
+		struct bm_msg_buserr buserr;
+		struct bm_msg_errstatechange errstatechange;
+		struct bm_msg_timeslice timeslice;
+		struct bm_msg_hwtimer hwtimer;
+	} u;
+};
+
+struct esd_pci402_cancore {
+	void __iomem *addr;
+	struct net_device *net_dev;
+
+	const struct bm_msg *bm_fifo;
+	/* Bits0..7: bm_fifo head index */
+	const u32 *bm_irq_cnt;
+	/* Local copy of bm_irq_cnt */
+	u32 irq_cnt;
+	u32 msg_fifo_tail;
+
+	u8 tx_fifo_size;
+	u8 tx_fifo_head;
+	u8 tx_fifo_tail;
+};
+
+struct esd_pci402_card {
+	/* Actually mapped io space, all other iomem derived from this */
+	void __iomem *addr;
+
+	void __iomem *addr_pciep;
+	void __iomem *addr_overview;
+
+	void *dma_buf;
+	dma_addr_t dma_hnd;
+
+	const struct bm_msg *bm_fifo;
+	/* Bits0..7: bm_fifo head index */
+	const u32 *bm_irq_cnt;
+	/* Local copy of bm_irq_cnt */
+	u32 irq_cnt;
+
+	struct esd_pci402_cancore core[ESD_PCI402_MAX_CORES];
+
+	u32 timestamp_frequency;
+	u32 core_frequency;
+	u16 version;
+	u16 features;
+	u8 total_cores;
+	u8 active_cores;
+
+	int msi_enabled;
+};
+
+struct esd_pci402_net_priv {
+	struct can_priv can; /* must be the first member! */
+	struct esd_pci402_card *card;
+	struct esd_pci402_cancore *core;
+};
+
+#define OFFS_CORE_CTRL_MODE		0x0000
+#define OFFS_CORE_STATUS_IRQ		0x0008
+#define OFFS_CORE_BTR			0x000c
+#define OFFS_CORE_BTR_FD		0x0010
+#define OFFS_CORE_BTR_FDF		0x0014
+#define OFFS_CORE_STATUS		0x0030
+#define OFFS_CORE_TXFIFO_CONFIG		0x0048
+#define OFFS_CORE_TXFIFO_STATUS		0x004c
+#define OFFS_CORE_TX_STATUS_IRQ		0x0050
+#define OFFS_CORE_TX_ABORT_MASK		0x0054
+#define OFFS_CORE_BM_IRQ_COUNTER	0x0070
+#define OFFS_CORE_TXFIFO_ID		0x00c0
+#define OFFS_CORE_TXFIFO_DLC		0x00c4
+#define OFFS_CORE_TXFIFO_DATA_0		0x00c8
+#define OFFS_CORE_TXFIFO_DATA_1		0x00cc
+
+#define OFFS_OV_PROBE			0x0000
+#define OFFS_OV_VERSION			0x0004
+#define OFFS_OV_INFO			0x0008
+#define OFFS_OV_CANCORE_FREQ		0x000c
+#define OFFS_OV_TS_FREQ_LO		0x0010
+#define OFFS_OV_TS_FREQ_HI		0x0014
+#define OFFS_OV_IRQ_STATUS_CORES	0x0018
+#define OFFS_OV_TS_CURR_LO		0x001c
+#define OFFS_OV_TS_CURR_HI		0x0020
+#define OFFS_OV_IRQ_STATUS		0x0028
+#define OFFS_OV_MODE			0x002c
+#define OFFS_OV_BM_IRQ_COUNTER		0x0070
+#define OFFS_OV_BM_IRQ_MASK		0x0074
+#define OFFS_OV_MSI_DATA		0x0080
+#define OFFS_OV_MSI_ADDRESSOFFSET	0x0084
+
+#define OFFS_PCIEP_INT_ENABLE		0x0050
+#define OFFS_PCIEP_BM_ADDR_LO		0x1000
+#define OFFS_PCIEP_BM_ADDR_HI		0x1004
+#define OFFS_PCIEP_MSI_ADDR_LO		0x1008
+#define OFFS_PCIEP_MSI_ADDR_HI		0x100c
+
+#define REG_OV_MODE_MASK_ENDIAN_LITTLE  0x00000001
+#define REG_OV_MODE_MASK_BM_ENABLE      0x00000002
+#define REG_OV_MODE_MASK_MODE_LED       0x00000004
+#define REG_OV_MODE_MASK_TIMER          0x00000070
+#define REG_OV_MODE_MASK_TIMER_ENABLE   0x00000010
+#define REG_OV_MODE_MASK_TIMER_ONE_SHOT 0x00000020
+#define REG_OV_MODE_MASK_TIMER_ABSOLUTE 0x00000040
+#define REG_OV_MODE_MASK_TS_SRC         0x00000180
+#define REG_OV_MODE_MASK_I2C_ENABLE     0x00000800
+#define REG_OV_MODE_MASK_MSI_ENABLE     0x00004000
+#define REG_OV_MODE_MASK_FPGA_RESET     0x80000000
+
+#define BM_IRQ_UNMASK_ALL               0x55555555
+#define BM_IRQ_MASK_ALL                 0xaaaaaaaa
+#define BM_IRQ_MASK                     0x00000002
+#define BM_IRQ_UNMASK                   0x00000001
+
+#define REG_CONTROL_IDX_MODE_RESETMODE  0
+#define REG_CONTROL_IDX_MODE_LOM        1
+#define REG_CONTROL_IDX_MODE_STM        2
+#define REG_CONTROL_IDX_MODE_TRANSEN    5
+#define REG_CONTROL_IDX_MODE_TS         6
+#define REG_CONTROL_IDX_MODE_SCHEDULE   7
+#define REG_CONTROL_MASK_MODE_RESETMODE BIT(REG_CONTROL_IDX_MODE_RESET=
MODE)
+#define REG_CONTROL_MASK_MODE_LOM       BIT(REG_CONTROL_IDX_MODE_LOM)
+#define REG_CONTROL_MASK_MODE_STM       BIT(REG_CONTROL_IDX_MODE_STM)
+#define REG_CONTROL_MASK_MODE_TRANSEN   BIT(REG_CONTROL_IDX_MODE_TRANS=
EN)
+#define REG_CONTROL_MASK_MODE_TS        BIT(REG_CONTROL_IDX_MODE_TS)
+#define REG_CONTROL_MASK_MODE_SCHEDULE  BIT(REG_CONTROL_IDX_MODE_SCHED=
ULE)
+
+#define REG_CONTROL_IDX_IE_RXTX         8
+#define REG_CONTROL_IDX_IE_TXERROR      9
+#define REG_CONTROL_IDX_IE_ERROR        10
+#define REG_CONTROL_IDX_IE_OVERRUN      11
+#define REG_CONTROL_IDX_IE_TSI          12
+#define REG_CONTROL_IDX_IE_ERRPASS      13
+#define REG_CONTROL_IDX_IE_BUSERR       15
+#define REG_CONTROL_MASK_IE_RXTX        BIT(REG_CONTROL_IDX_IE_RXTX)
+#define REG_CONTROL_MASK_IE_TXERROR     BIT(REG_CONTROL_IDX_IE_TXERROR=
)
+#define REG_CONTROL_MASK_IE_ERROR       BIT(REG_CONTROL_IDX_IE_ERROR)
+#define REG_CONTROL_MASK_IE_OVERRUN     BIT(REG_CONTROL_IDX_IE_OVERRUN=
)
+#define REG_CONTROL_MASK_IE_TSI         BIT(REG_CONTROL_IDX_IE_TSI)
+#define REG_CONTROL_MASK_IE_ERRPASS     BIT(REG_CONTROL_IDX_IE_ERRPASS=
)
+#define REG_CONTROL_MASK_IE_BUSERR      BIT(REG_CONTROL_IDX_IE_BUSERR)
+
+#define REG_STATUS_IDX_STATUS_DOS       16
+#define REG_STATUS_IDX_STATUS_ES        17
+#define REG_STATUS_IDX_STATUS_EP        18
+#define REG_STATUS_IDX_STATUS_BS        19
+#define REG_STATUS_IDX_STATUS_RBS       20
+#define REG_STATUS_IDX_STATUS_RS        21
+#define REG_STATUS_MASK_STATUS_DOS      BIT(REG_STATUS_IDX_STATUS_DOS)
+#define REG_STATUS_MASK_STATUS_ES       BIT(REG_STATUS_IDX_STATUS_ES)
+#define REG_STATUS_MASK_STATUS_EP       BIT(REG_STATUS_IDX_STATUS_EP)
+#define REG_STATUS_MASK_STATUS_BS       BIT(REG_STATUS_IDX_STATUS_BS)
+#define REG_STATUS_MASK_STATUS_RBS      BIT(REG_STATUS_IDX_STATUS_RBS)
+#define REG_STATUS_MASK_STATUS_RS       BIT(REG_STATUS_IDX_STATUS_RS)
+
+#define ESD_PCI402_BM_LENFLAG_TX	0x20
+
+/* ecc value of PCI402 equals SJA1000's ECC register */
+#define ESD_PCI402_ECC_SEG		0x1f
+#define ESD_PCI402_ECC_DIR		0x20
+#define ESD_PCI402_ECC_BIT		0x00
+#define ESD_PCI402_ECC_FORM		0x40
+#define ESD_PCI402_ECC_STUFF		0x80
+#define ESD_PCI402_ECC_MASK		0xc0
--=20
1.7.9.5


From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD boards
Date: Thu,  8 Dec 2016 15:38:44 +0100
Message-ID: <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:19880 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752110AbcLHOjK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2016 09:39:10 -0500
In-Reply-To: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch adds the support of the PCAN-PCI Express FD boards made
by PEAK-System, for computers using the PCI Express slot.

The PCAN-PCI Express FD has one or two CAN FD channels, depending
on the model. A galvanic isolation of the CAN ports protects
the electronics of the card and the respective computer against
disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operated
with ambient temperatures in a range of -40 to +85 °C.

Such boards run an extented version of the CAN-FD IP running into USB
CAN-FD interfaces from PEAK-System, so this patch adds several new commands
and their corresponding data types to the PEAK CAN-FD common definitions
header file too.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/Kconfig                       |   1 +
 drivers/net/can/Makefile                      |   1 +
 drivers/net/can/peak_canfd/Kconfig            |  13 +
 drivers/net/can/peak_canfd/Makefile           |   5 +
 drivers/net/can/peak_canfd/peak_canfd.c       | 673 +++++++++++++++++++++
 drivers/net/can/peak_canfd/peak_canfd_user.h  |  47 ++
 drivers/net/can/peak_canfd/peak_pciefd_main.c | 820 ++++++++++++++++++++++++++
 include/linux/can/dev/peak_canfd.h            |  50 ++
 8 files changed, 1610 insertions(+)
 create mode 100644 drivers/net/can/peak_canfd/Kconfig
 create mode 100644 drivers/net/can/peak_canfd/Makefile
 create mode 100644 drivers/net/can/peak_canfd/peak_canfd.c
 create mode 100644 drivers/net/can/peak_canfd/peak_canfd_user.h
 create mode 100644 drivers/net/can/peak_canfd/peak_pciefd_main.c

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index 22570ea..aa20b69 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -142,6 +142,7 @@ source "drivers/net/can/cc770/Kconfig"
 source "drivers/net/can/ifi_canfd/Kconfig"
 source "drivers/net/can/m_can/Kconfig"
 source "drivers/net/can/mscan/Kconfig"
+source "drivers/net/can/peak_canfd/Kconfig"
 source "drivers/net/can/rcar/Kconfig"
 source "drivers/net/can/sja1000/Kconfig"
 source "drivers/net/can/softing/Kconfig"
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 26ba4b7..fa0678f 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_CAN_IFI_CANFD)	+= ifi_canfd/
 obj-$(CONFIG_CAN_JANZ_ICAN3)	+= janz-ican3.o
 obj-$(CONFIG_CAN_MSCAN)		+= mscan/
 obj-$(CONFIG_CAN_M_CAN)		+= m_can/
+obj-$(CONFIG_CAN_PEAK_PCIEFD)	+= peak_canfd/
 obj-$(CONFIG_CAN_SJA1000)	+= sja1000/
 obj-$(CONFIG_CAN_SUN4I)		+= sun4i_can.o
 obj-$(CONFIG_CAN_TI_HECC)	+= ti_hecc.o
diff --git a/drivers/net/can/peak_canfd/Kconfig b/drivers/net/can/peak_canfd/Kconfig
new file mode 100644
index 0000000..84b3097
--- /dev/null
+++ b/drivers/net/can/peak_canfd/Kconfig
@@ -0,0 +1,13 @@
+config CAN_PEAK_PCIEFD
+	depends on PCI
+	tristate "PEAK-System PCAN-PCIe FD cards"
+	---help---
+	  This driver adds support for the PEAK-System PCI Express FD
+	  CAN-FD cards family.
+	  These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
+	  CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
+	  1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
+	  up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the
+	  electronics of the card and the respective computer against
+	  disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
+	  operated with ambient temperatures in a range of -40 to +85 °C.
diff --git a/drivers/net/can/peak_canfd/Makefile b/drivers/net/can/peak_canfd/Makefile
new file mode 100644
index 0000000..3dc7a6a
--- /dev/null
+++ b/drivers/net/can/peak_canfd/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the PEAK-System CAN-FD IP module drivers
+#
+obj-$(CONFIG_CAN_PEAK_PCIEFD) += peak_pciefd.o
+peak_pciefd-y := peak_pciefd_main.o peak_canfd.o
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
new file mode 100644
index 0000000..6f6e370
--- /dev/null
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -0,0 +1,673 @@
+/*
+ * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ *
+ * Copyright (C) 2016  PEAK System-Technik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+
+#include "peak_canfd_user.h"
+
+/* bittiming ranges of the PEAK-System PC CAN-FD interfaces */
+static const struct can_bittiming_const peak_canfd_nominal_const = {
+	.name = "peak_canfd",
+	.tseg1_min = 1,
+	.tseg1_max = (1 << PUCAN_TSLOW_TSGEG1_BITS),
+	.tseg2_min = 1,
+	.tseg2_max = (1 << PUCAN_TSLOW_TSGEG2_BITS),
+	.sjw_max = (1 << PUCAN_TSLOW_SJW_BITS),
+	.brp_min = 1,
+	.brp_max = (1 << PUCAN_TSLOW_BRP_BITS),
+	.brp_inc = 1,
+};
+
+static const struct can_bittiming_const peak_canfd_data_const = {
+	.name = "peak_canfd",
+	.tseg1_min = 1,
+	.tseg1_max = (1 << PUCAN_TFAST_TSGEG1_BITS),
+	.tseg2_min = 1,
+	.tseg2_max = (1 << PUCAN_TFAST_TSGEG2_BITS),
+	.sjw_max = (1 << PUCAN_TFAST_SJW_BITS),
+	.brp_min = 1,
+	.brp_max = (1 << PUCAN_TFAST_BRP_BITS),
+	.brp_inc = 1,
+};
+
+static struct peak_canfd_priv *pucan_init_cmd(struct peak_canfd_priv *priv)
+{
+	priv->cmd_len = 0;
+	return priv;
+}
+
+static void *pucan_add_cmd(struct peak_canfd_priv *priv, int cmd_op)
+{
+	struct pucan_command *cmd;
+
+	if (priv->cmd_len + sizeof(*cmd) > priv->cmd_maxlen)
+		return NULL;
+
+	cmd = priv->cmd_buffer + priv->cmd_len;
+	cmd->opcode_channel = pucan_cmd_opcode_channel(priv->index, cmd_op);
+	priv->cmd_len += sizeof(*cmd);
+
+	return cmd;
+}
+
+/* uCAN commands interface functions */
+static int pucan_set_reset_mode(struct peak_canfd_priv *priv)
+{
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RESET_MODE);
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_normal_mode(struct peak_canfd_priv *priv)
+{
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_NORMAL_MODE);
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_listen_only_mode(struct peak_canfd_priv *priv)
+{
+	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_LISTEN_ONLY_MODE);
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_timing_slow(struct peak_canfd_priv *priv,
+				 const struct can_bittiming *pbt)
+{
+	struct pucan_timing_slow *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TIMING_SLOW);
+
+	cmd->sjw_t = PUCAN_TSLOW_SJW_T(pbt->sjw - 1,
+				priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
+	cmd->tseg1 = PUCAN_TSLOW_TSEG1(pbt->prop_seg + pbt->phase_seg1 - 1);
+	cmd->tseg2 = PUCAN_TSLOW_TSEG2(pbt->phase_seg2 - 1);
+	cmd->brp = cpu_to_le16(PUCAN_TSLOW_BRP(pbt->brp - 1));
+
+	cmd->ewl = 96;	/* default */
+
+	netdev_dbg(priv->ndev,
+		   "nominal: brp=%u tseg1=%u tseg2=%u sjw=%u\n",
+		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw_t);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_timing_fast(struct peak_canfd_priv *priv,
+				 const struct can_bittiming *pbt)
+{
+	struct pucan_timing_fast *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TIMING_FAST);
+
+	cmd->sjw = PUCAN_TFAST_SJW(pbt->sjw - 1);
+	cmd->tseg1 = PUCAN_TFAST_TSEG1(pbt->prop_seg + pbt->phase_seg1 - 1);
+	cmd->tseg2 = PUCAN_TFAST_TSEG2(pbt->phase_seg2 - 1);
+	cmd->brp = cpu_to_le16(PUCAN_TFAST_BRP(pbt->brp - 1));
+
+	netdev_dbg(priv->ndev,
+		   "data: brp=%u tseg1=%u tseg2=%u sjw=%u\n",
+		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_std_filter(struct peak_canfd_priv *priv, u8 row, u32 mask)
+{
+	struct pucan_std_filter *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_STD_FILTER);
+
+	/* all the 11-bits CAN ID values are represented by one bit in a
+	 * 64 rows array of 32 bits: the upper 6 bits of the CAN ID select the
+	 * row while the lowest 5 bits select the bit in that row.
+	 *
+	 * bit	filter
+	 * 1	passed
+	 * 0	discarded
+	 */
+
+	/* select the row */
+	cmd->idx = row;
+
+	/* set/unset bits in the row */
+	cmd->mask = cpu_to_le32(mask);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_tx_abort(struct peak_canfd_priv *priv, u16 flags)
+{
+	struct pucan_tx_abort *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TX_ABORT);
+
+	cmd->flags = cpu_to_le16(flags);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_clr_err_counters(struct peak_canfd_priv *priv)
+{
+	struct pucan_wr_err_cnt *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_WR_ERR_CNT);
+
+	cmd->sel_mask = cpu_to_le16(PUCAN_WRERRCNT_TE | PUCAN_WRERRCNT_RE);
+	cmd->tx_counter = 0;
+	cmd->rx_counter = 0;
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_set_options(struct peak_canfd_priv *priv, u16 opt_mask)
+{
+	struct pucan_options *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_EN_OPTION);
+
+	cmd->options = cpu_to_le16(opt_mask);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_clr_options(struct peak_canfd_priv *priv, u16 opt_mask)
+{
+	struct pucan_options *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_CLR_DIS_OPTION);
+
+	cmd->options = cpu_to_le16(opt_mask);
+
+	return priv->write_cmd(priv);
+}
+
+static int pucan_setup_rx_barrier(struct peak_canfd_priv *priv)
+{
+	struct pucan_options *cmd;
+
+	cmd = pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RX_BARRIER);
+
+	return priv->write_cmd(priv);
+}
+
+/* handle the reception of one CAN frame */
+static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
+			       struct pucan_rx_msg *msg)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct canfd_frame *cf;
+	struct sk_buff *skb;
+	const u16 rx_msg_flags = le16_to_cpu(msg->flags);
+
+	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
+		/* CANFD frame case */
+		skb = alloc_canfd_skb(priv->ndev, &cf);
+		if (!skb)
+			return -ENOMEM;
+
+		if (rx_msg_flags & PUCAN_MSG_BITRATE_SWITCH)
+			cf->flags |= CANFD_BRS;
+
+		if (rx_msg_flags & PUCAN_MSG_ERROR_STATE_IND)
+			cf->flags |= CANFD_ESI;
+
+		cf->len = can_dlc2len(get_canfd_dlc(pucan_msg_get_dlc(msg)));
+	} else {
+		/* CAN 2.0 frame case */
+		skb = alloc_can_skb(priv->ndev, (struct can_frame **)&cf);
+		if (!skb)
+			return -ENOMEM;
+
+		cf->len = get_can_dlc(pucan_msg_get_dlc(msg));
+	}
+
+	cf->can_id = le32_to_cpu(msg->can_id);
+
+	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
+		cf->can_id |= CAN_EFF_FLAG;
+
+	if (rx_msg_flags & PUCAN_MSG_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	else
+		memcpy(cf->data, msg->d, cf->len);
+
+	stats->rx_bytes += cf->len;
+	stats->rx_packets++;
+	netif_rx(skb);
+
+	return 0;
+}
+
+/* handle rx/tx error counters notification */
+static int pucan_handle_error(struct peak_canfd_priv *priv,
+			      struct pucan_error_msg *msg)
+{
+	priv->bec.txerr = msg->tx_err_cnt;
+	priv->bec.rxerr = msg->rx_err_cnt;
+
+	return 0;
+}
+
+/* handle status notification */
+static int pucan_handle_status(struct peak_canfd_priv *priv,
+			       struct pucan_status_msg *msg)
+{
+	struct net_device *ndev = priv->ndev;
+	struct net_device_stats *stats = &ndev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
+	if (PUCAN_STMSG_RB(msg)) {
+		if (priv->enable_tx_path) {
+			int err = priv->enable_tx_path(priv);
+
+			if (err)
+				return err;
+		}
+
+		netif_start_queue(ndev);
+		return 0;
+	}
+
+	skb = alloc_can_err_skb(ndev, &cf);
+	if (!skb) {
+		stats->rx_dropped++;
+		return -ENOMEM;
+	}
+
+	if (PUCAN_STMSG_WARNING(msg)) {
+		netdev_dbg(ndev, "Error warning status\n");
+		priv->can.state = CAN_STATE_ERROR_WARNING;
+		priv->can.can_stats.error_warning++;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
+						CAN_ERR_CRTL_TX_WARNING :
+						CAN_ERR_CRTL_RX_WARNING;
+		cf->data[6] = priv->bec.txerr;
+		cf->data[7] = priv->bec.rxerr;
+
+	} else if (PUCAN_STMSG_PASSIVE(msg)) {
+		netdev_dbg(ndev, "Error passive status\n");
+		priv->can.state = CAN_STATE_ERROR_PASSIVE;
+		priv->can.can_stats.error_passive++;
+		cf->can_id |= CAN_ERR_CRTL;
+		cf->data[1] = (priv->bec.txerr > priv->bec.rxerr) ?
+						CAN_ERR_CRTL_TX_PASSIVE :
+						CAN_ERR_CRTL_RX_PASSIVE;
+		cf->data[6] = priv->bec.txerr;
+		cf->data[7] = priv->bec.rxerr;
+
+	} else if (PUCAN_STMSG_BUSOFF(msg)) {
+		netdev_dbg(ndev, "Bus-off entry status\n");
+		priv->can.state = CAN_STATE_BUS_OFF;
+		priv->can.can_stats.bus_off++;
+		can_bus_off(ndev);
+		cf->can_id |= CAN_ERR_BUSOFF;
+
+	} else if (priv->can.state != CAN_STATE_ERROR_ACTIVE) {
+		/* back to ERROR_ACTIVE */
+		netdev_dbg(ndev, "Error active status\n");
+		can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
+				 CAN_STATE_ERROR_ACTIVE);
+	} else {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
+
+	return 0;
+}
+
+/* handle uCAN Rx overflow notification */
+static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	skb = alloc_can_err_skb(priv->ndev, &cf);
+	if (!skb)
+		return -ENOMEM;
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+
+	cf->data[6] = priv->bec.txerr;
+	cf->data[7] = priv->bec.rxerr;
+
+	stats->rx_over_errors++;
+	stats->rx_errors++;
+
+	stats->rx_bytes += cf->can_dlc;
+	stats->rx_packets++;
+	netif_rx(skb);
+
+	return 0;
+}
+
+/* handle a single uCAN message */
+int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
+			  struct pucan_rx_msg *msg)
+{
+	u16 msg_type = le16_to_cpu(msg->type);
+	int msg_size = le16_to_cpu(msg->size);
+	int err;
+
+	if (!msg_size || !msg_type) {
+		/* null packet found: end of list */
+		goto exit;
+	}
+
+	switch (msg_type) {
+	case PUCAN_MSG_CAN_RX:
+		err = pucan_handle_can_rx(priv, (struct pucan_rx_msg *)msg);
+		break;
+	case PUCAN_MSG_ERROR:
+		err = pucan_handle_error(priv, (struct pucan_error_msg *)msg);
+		break;
+	case PUCAN_MSG_STATUS:
+		err = pucan_handle_status(priv, (struct pucan_status_msg *)msg);
+		break;
+	case PUCAN_MSG_CACHE_CRITICAL:
+		err = pucan_handle_cache_critical(priv);
+		break;
+	default:
+		err = 0;
+	}
+
+	if (err < 0)
+		return err;
+
+exit:
+	return msg_size;
+}
+
+/* handle a list of rx_count messages from rx_msg memory address */
+int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
+				struct pucan_rx_msg *msg_list, int msg_count)
+{
+	void *msg_ptr = msg_list;
+	int i, msg_size;
+
+	for (i = 0; i < msg_count; i++) {
+		msg_size = peak_canfd_handle_msg(priv, msg_ptr);
+
+		/* a null packet can be found at the end of a list */
+		if (msg_size <= 0)
+			break;
+
+		msg_ptr += msg_size;
+	}
+
+	if (msg_size < 0)
+		return msg_size;
+
+	return i;
+}
+
+static int peak_canfd_start(struct peak_canfd_priv *priv)
+{
+	int i, err;
+
+	err = pucan_clr_err_counters(priv);
+	if (err)
+		goto err_exit;
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+			err = pucan_clr_options(priv, PUCAN_OPTION_CANDFDISO);
+		else
+			err = pucan_set_options(priv, PUCAN_OPTION_CANDFDISO);
+
+		if (err)
+			goto err_exit;
+	}
+
+	/* set option: get rx/tx error counters */
+	err = pucan_set_options(priv, PUCAN_OPTION_ERROR);
+	if (err)
+		goto err_exit;
+
+	/* accept all standard CAN ID */
+	for (i = 0; i <= PUCAN_FLTSTD_ROW_IDX_MAX; i++)
+		pucan_set_std_filter(priv, i, 0xffffffff);
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		err = pucan_set_listen_only_mode(priv);
+	else
+		err = pucan_set_normal_mode(priv);
+
+	if (err)
+		goto err_exit;
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	err = pucan_setup_rx_barrier(priv);
+
+err_exit:
+	return err;
+}
+
+static void peak_canfd_stop(struct peak_canfd_priv *priv)
+{
+	int err;
+
+	/* go back to RESET mode */
+	err = pucan_set_reset_mode(priv);
+	if (err) {
+		netdev_err(priv->ndev,
+			   "channel %u reset failed\n", priv->index);
+	} else {
+		/* abort last Tx */
+		pucan_tx_abort(priv, PUCAN_TX_ABORT_FLUSH);
+	}
+
+	priv->can.state = CAN_STATE_STOPPED;
+}
+
+static int peak_canfd_set_mode(struct net_device *ndev, enum can_mode mode)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+
+	switch (mode) {
+	case CAN_MODE_START:
+		peak_canfd_start(priv);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int peak_canfd_get_berr_counter(const struct net_device *ndev,
+				       struct can_berr_counter *bec)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+
+	*bec = priv->bec;
+	return 0;
+}
+
+static int peak_canfd_open(struct net_device *ndev)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+	int err = 0;
+
+	err = open_candev(ndev);
+	if (err) {
+		netdev_err(ndev, "open_candev() failed, error %d\n", err);
+		goto err_exit;
+	}
+
+	err = peak_canfd_start(priv);
+	if (err)
+		goto err_close;
+
+	return 0;
+
+err_close:
+	close_candev(ndev);
+err_exit:
+	return err;
+}
+
+static int peak_canfd_set_bittiming(struct net_device *ndev)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+
+	return pucan_set_timing_slow(priv, &priv->can.bittiming);
+}
+
+static int peak_canfd_set_data_bittiming(struct net_device *ndev)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+
+	return pucan_set_timing_fast(priv, &priv->can.data_bittiming);
+}
+
+static int peak_canfd_close(struct net_device *ndev)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+
+	netif_stop_queue(ndev);
+	peak_canfd_stop(priv);
+	close_candev(ndev);
+
+	return 0;
+}
+
+static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
+					 struct net_device *ndev)
+{
+	struct peak_canfd_priv *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+	struct pucan_tx_msg *msg;
+	u16 msg_size, msg_flags;
+	u8 can_dlc;
+
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
+	msg_size = ALIGN(sizeof(*msg) + cf->len, 4);
+	msg = priv->alloc_tx_msg(priv, msg_size);
+	if (!msg) {
+		netif_stop_queue(ndev);
+		return NETDEV_TX_OK;
+	}
+
+	msg->size = cpu_to_le16(msg_size);
+	msg->type = cpu_to_le16(PUCAN_MSG_CAN_TX);
+
+	if (cf->can_id & CAN_EFF_FLAG) {
+		msg_flags |= PUCAN_MSG_EXT_ID;
+		msg->can_id = cpu_to_le32(cf->can_id & CAN_EFF_MASK);
+	} else {
+		msg->can_id = cpu_to_le32(cf->can_id & CAN_SFF_MASK);
+	}
+
+	can_dlc = can_len2dlc(cf->len);
+	msg_flags = 0;
+
+	if (can_is_canfd_skb(skb)) {
+		/* CAN FD frame format */
+		can_dlc = can_len2dlc(cf->len);
+
+		msg_flags |= PUCAN_MSG_EXT_DATA_LEN;
+
+		if (cf->flags & CANFD_BRS)
+			msg_flags |= PUCAN_MSG_BITRATE_SWITCH;
+
+		if (cf->flags & CANFD_ESI)
+			msg_flags |= PUCAN_MSG_ERROR_STATE_IND;
+	} else {
+		/* CAN 2.0 frame format */
+		can_dlc = cf->len;
+
+		if (cf->can_id & CAN_RTR_FLAG)
+			msg_flags |= PUCAN_MSG_RTR;
+	}
+
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		msg_flags |= PUCAN_MSG_LOOPED_BACK;
+
+	msg->flags = cpu_to_le16(msg_flags);
+	msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
+	memcpy(msg->d, cf->data, cf->len);
+
+	priv->write_tx_msg(priv);
+
+	stats->tx_bytes += can_dlc;
+	stats->tx_packets++;
+
+	/* put skb in rx queue as echo */
+	netif_rx(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops peak_canfd_netdev_ops = {
+	.ndo_open = peak_canfd_open,
+	.ndo_stop = peak_canfd_close,
+	.ndo_start_xmit = peak_canfd_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int echo_skb_max,
+					int index)
+{
+	struct net_device *ndev;
+	struct peak_canfd_priv *priv;
+
+	/* allocate the candev object */
+	ndev = alloc_candev(sizeof_priv, echo_skb_max);
+	if (!ndev)
+		return NULL;
+
+	priv = netdev_priv(ndev);
+
+	/* complete now socket-can initialization side */
+	priv->can.state = CAN_STATE_STOPPED;
+	priv->can.bittiming_const = &peak_canfd_nominal_const;
+	priv->can.data_bittiming_const = &peak_canfd_data_const;
+
+	priv->can.do_set_mode = peak_canfd_set_mode;
+	priv->can.do_get_berr_counter = peak_canfd_get_berr_counter;
+	priv->can.do_set_bittiming = peak_canfd_set_bittiming;
+	priv->can.do_set_data_bittiming = peak_canfd_set_data_bittiming;
+
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
+				CAN_CTRLMODE_LISTENONLY |
+				CAN_CTRLMODE_3_SAMPLES |
+				CAN_CTRLMODE_FD |
+				CAN_CTRLMODE_FD_NON_ISO |
+				CAN_CTRLMODE_BERR_REPORTING;
+
+	priv->ndev = ndev;
+	priv->index = index;
+	priv->cmd_len = 0;
+
+	ndev->netdev_ops = &peak_canfd_netdev_ops;
+	ndev->flags |= IFF_ECHO;
+	ndev->dev_id = index;
+
+	return ndev;
+}
diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net/can/peak_canfd/peak_canfd_user.h
new file mode 100644
index 0000000..331be46
--- /dev/null
+++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
@@ -0,0 +1,47 @@
+/*
+ * CAN driver for PEAK System micro-CAN based adapters
+ *
+ * Copyright (C) 2003-2011 PEAK System-Technik GmbH
+ * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ */
+#ifndef PEAK_CANFD_USER_H
+#define PEAK_CANFD_USER_H
+
+#include <linux/can/dev/peak_canfd.h>
+
+/* data structure private to each uCAN interface */
+struct peak_canfd_priv {
+	struct can_priv can;		/* socket-can private data */
+	struct net_device *ndev;	/* network device */
+	int index;			/* channel index */
+
+	struct can_berr_counter bec;	/* rx/tx err counters */
+
+	int cmd_len;
+	void *cmd_buffer;
+	int cmd_maxlen;
+
+	int (*write_cmd)(struct peak_canfd_priv *priv);
+
+	int (*enable_tx_path)(struct peak_canfd_priv *priv);
+	void *(*alloc_tx_msg)(struct peak_canfd_priv *priv, u16 msg_size);
+	int (*write_tx_msg)(struct peak_canfd_priv *priv);
+};
+
+struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
+					int echo_skb_max);
+
+int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
+			  struct pucan_rx_msg *msg);
+int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
+				struct pucan_rx_msg *rx_msg, int rx_count);
+#endif
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
new file mode 100644
index 0000000..d0f83f9
--- /dev/null
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -0,0 +1,820 @@
+/*
+ * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
+ *
+ * Derived from the PCAN project file driver/src/pcan_pci.c:
+ *
+ * Copyright (C) 2001-2006  PEAK System-Technik GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/netdevice.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+
+#include "peak_canfd_user.h"
+
+MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
+MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe FD family cards");
+MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe FD CAN cards");
+MODULE_LICENSE("GPL v2");
+
+#define DRV_NAME		"peak_pciefd"
+
+#define Hz			(1)
+#define KHz			(1000 * Hz)
+#define MHz			(1000 * KHz)
+
+#define PEAK_PCI_VENDOR_ID	0x001c	/* The PCI device and vendor IDs */
+#define PEAK_PCIEFD_ID		0x0013	/* for PCIe slot cards */
+
+/* PEAK PCIe board access description */
+#define PCIEFD_BAR0_SIZE		(64 * 1024)
+#define PCIEFD_RX_DMA_SIZE		(4 * 1024)
+#define PCIEFD_TX_DMA_SIZE		(4 * 1024)
+
+#define PCIEFD_TX_PAGE_SIZE		(2 * 1024)
+
+/* System Control Registers */
+#define PCIEFD_REG_SYS_CTL_SET		0x0000	/* set bits */
+#define PCIEFD_REG_SYS_CTL_CLR		0x0004	/* clear bits */
+
+/* Version info registers */
+#define PCIEFD_REG_SYS_VER1		0x0040	/* version reg #1 */
+#define PCIEFD_REG_SYS_VER2		0x0044	/* version reg #2 */
+
+/* System Control Registers Bits */
+#define PCIEFD_SYS_CTL_TS_RST		0x00000001	/* timestamp clock */
+#define PCIEFD_SYS_CTL_CLK_EN		0x00000002	/* system clock */
+
+/* CAN-FD channel addresses */
+#define PCIEFD_CANX_OFF(c)		(((c) + 1) * 0x1000)
+
+#define CANFD_ECHO_SKB_MAX		0	/* no need of echo skb list */
+
+/* CAN-FD channel registers */
+#define PCIEFD_REG_CAN_MISC		0x0000	/* Misc. control */
+#define PCIEFD_REG_CAN_CLK_SEL		0x0008	/* Clock selector */
+#define PCIEFD_REG_CAN_CMD_PORT_L	0x0010	/* 64-bits command port */
+#define PCIEFD_REG_CAN_CMD_PORT_H	0x0014
+#define PCIEFD_REG_CAN_TX_REQ_ACC	0x0020	/* Tx request accumulator */
+#define PCIEFD_REG_CAN_TX_CTL_SET	0x0030	/* Tx control set register */
+#define PCIEFD_REG_CAN_TX_CTL_CLR	0x0038	/* Tx control clear register */
+#define PCIEFD_REG_CAN_TX_DMA_ADDR_L	0x0040	/* 64-bits addr for Tx DMA */
+#define PCIEFD_REG_CAN_TX_DMA_ADDR_H	0x0044
+#define PCIEFD_REG_CAN_RX_CTL_SET	0x0050	/* Rx control set register */
+#define PCIEFD_REG_CAN_RX_CTL_CLR	0x0058	/* Rx control clear register */
+#define PCIEFD_REG_CAN_RX_CTL_WRT	0x0060	/* Rx control write register */
+#define PCIEFD_REG_CAN_RX_CTL_ACK	0x0068	/* Rx control ACK register */
+#define PCIEFD_REG_CAN_RX_DMA_ADDR_L	0x0070	/* 64-bits addr for Rx DMA */
+#define PCIEFD_REG_CAN_RX_DMA_ADDR_H	0x0074
+
+/* CAN-FD channel misc register bits */
+#define CANFD_MISC_TS_RST		0x00000001	/* timestamp cnt rst */
+
+/* CAN-FD channel Clock SELector Source & DIVider */
+#define CANFD_CLK_SEL_DIV_MASK		0x00000007
+#define CANFD_CLK_SEL_DIV_60MHZ		0x00000000	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_40MHZ		0x00000001	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_30MHZ		0x00000002	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_24MHZ		0x00000003	/* SRC=240MHz only */
+#define CANFD_CLK_SEL_DIV_20MHZ		0x00000004	/* SRC=240MHz only */
+
+#define CANFD_CLK_SEL_SRC_MASK		0x00000008	/* 0=80MHz, 1=240MHz */
+#define CANFD_CLK_SEL_SRC_240MHZ	0x00000008
+#define CANFD_CLK_SEL_SRC_80MHZ		(~CANFD_CLK_SEL_SRC_240MHZ & \
+							CANFD_CLK_SEL_SRC_MASK)
+
+#define CANFD_CLK_SEL_20MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+						CANFD_CLK_SEL_DIV_20MHZ)
+#define CANFD_CLK_SEL_24MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+						CANFD_CLK_SEL_DIV_24MHZ)
+#define CANFD_CLK_SEL_30MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+						CANFD_CLK_SEL_DIV_30MHZ)
+#define CANFD_CLK_SEL_40MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+						CANFD_CLK_SEL_DIV_40MHZ)
+#define CANFD_CLK_SEL_60MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
+						CANFD_CLK_SEL_DIV_60MHZ)
+#define CANFD_CLK_SEL_80MHZ		(CANFD_CLK_SEL_SRC_80MHZ)
+
+/* CAN-FD channel Rx/Tx control register bits */
+#define CANFD_CTL_UNC_BIT		0x00010000	/* Uncached DMA mem */
+#define CANFD_CTL_RST_BIT		0x00020000	/* reset DMA action */
+#define CANFD_CTL_IEN_BIT		0x00040000	/* IRQ enable */
+
+/* Rx IRQ Count and Time Limits */
+#define CANFD_CTL_IRQ_CL_DEF	16	/* Rx msg max nb per IRQ in Rx DMA */
+#define CANFD_CTL_IRQ_TL_DEF	10	/* Time before IRQ if < CL (x100 µs) */
+
+#define CANFD_OPTIONS_SET	(CANFD_OPTION_ERROR | CANFD_OPTION_BUSLOAD)
+
+/* Tx anticipation window (link logical address should be aligned on 2K
+ * boundary)
+ */
+#define PCIEFD_TX_PAGE_COUNT	(PCIEFD_TX_DMA_SIZE / PCIEFD_TX_PAGE_SIZE)
+
+#define CANFD_MSG_LNK_TX	0x1001	/* Tx msgs link */
+
+/* 32-bits struct describing the content of the beginning of Rx DMA area */
+struct pciefd_irq_status {
+#ifdef __LITTLE_ENDIAN
+	uint irq_tag:4;
+	uint rx_cnt:7;
+	uint unused_1:5;
+	uint lnk:1;
+	uint unused_2:15;
+#else
+	uint unused_2:15;
+	uint lnk:1;
+	uint unused_1:5;
+	uint rx_cnt:7;
+	uint irq_tag:4;
+#endif
+};
+
+/* Rx record */
+struct pciefd_rx_dma {
+	struct pciefd_irq_status irq_status;	/* 32-bits */
+	__le32 sys_time_low;
+	__le32 sys_time_high;
+	struct pucan_rx_msg msg[0];
+} __packed __aligned(4);
+
+/* Tx Link record */
+struct pciefd_tx_link {
+	__le16 size;
+	__le16 type;
+	__le32 laddr_lo;
+	__le32 laddr_hi;
+} __packed __aligned(4);
+
+/* Tx page descriptor */
+struct pciefd_page {
+	void *vbase;			/* page virtual address */
+	dma_addr_t lbase;		/* page logical address */
+	u32 offset;
+	u32 size;
+};
+
+/* CAN-FD channel object */
+struct pciefd_board;
+struct pciefd_can {
+	struct peak_canfd_priv ucan;	/* must be the first member */
+	void __iomem *reg_base;		/* channel config base addr */
+	struct pciefd_board *board;	/* reverse link */
+
+	struct pucan_command pucan_cmd;	/* command buffer */
+
+	dma_addr_t rx_dma_laddr;	/* DMA virtual and logical addr */
+	void *rx_dma_vaddr;		/* for Rx and Tx areas */
+	dma_addr_t tx_dma_laddr;
+	void *tx_dma_vaddr;
+
+	struct pciefd_page tx_pages[PCIEFD_TX_PAGE_COUNT];
+	u16 tx_pages_free;		/* free Tx pages counter */
+	u16 tx_page_index;		/* current page used for Tx */
+
+	struct pciefd_irq_status irq_status;	/* current irq status */
+	u32 irq_tag;				/* next irq tag */
+};
+
+/* PEAK-PCIe FD board object */
+struct pciefd_board {
+	void __iomem *reg_base;
+	struct pci_dev *pci_dev;
+	u8 hw_ver_major;
+	u8 hw_ver_minor;
+	u8 hw_ver_sub;
+	int can_count;
+	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
+	struct pciefd_can *can[0];	/* array of network devices */
+};
+
+/* supported device ids. */
+static const struct pci_device_id peak_pciefd_tbl[] = {
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, peak_pciefd_tbl);
+
+/* read a 32 bits value from a SYS block register */
+static inline u32 pciefd_sys_readreg(const struct pciefd_board *priv, u16 reg)
+{
+	return readl(priv->reg_base + reg);
+}
+
+/* write a 32 bits value into a SYS block register */
+static inline void pciefd_sys_writereg(const struct pciefd_board *priv,
+				       u32 val, u16 reg)
+{
+	writel(val, priv->reg_base + reg);
+}
+
+/* read a 32 bits value from CAN-FD block register */
+static inline u32 pciefd_can_readreg(const struct pciefd_can *priv, u16 reg)
+{
+	return readl(priv->reg_base + reg);
+}
+
+/* write a 32 bits value into a CAN-FD block register */
+static inline void pciefd_can_writereg(const struct pciefd_can *priv,
+				       u32 val, u16 reg)
+{
+	writel(val, priv->reg_base + reg);
+}
+
+/* give a channel logical Rx DMA address to the board */
+static void pciefd_can_setup_rx_dma(struct pciefd_can *priv)
+{
+	/* (DMA must be reset for Rx) */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_RX_CTL_SET);
+
+	/* write the logical address of the Rx DMA area for this channel */
+	pciefd_can_writereg(priv, (u32)priv->rx_dma_laddr,
+			    PCIEFD_REG_CAN_RX_DMA_ADDR_L);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	pciefd_can_writereg(priv, (u32)(priv->rx_dma_laddr >> 32),
+			    PCIEFD_REG_CAN_RX_DMA_ADDR_H);
+#else
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
+#endif
+
+	/* also indicates that Rx DMA is cacheable */
+	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT, PCIEFD_REG_CAN_RX_CTL_CLR);
+}
+
+/* clear channel logical Rx DMA address from the board */
+static void pciefd_can_clear_rx_dma(struct pciefd_can *priv)
+{
+	/* DMA must be reset for Rx */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_RX_CTL_SET);
+
+	/* clear the logical address of the Rx DMA area for this channel */
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_L);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
+#endif
+}
+
+/* give a channel logical Tx DMA address to the board */
+static void pciefd_can_setup_tx_dma(struct pciefd_can *priv)
+{
+	/* (DMA must be reset for Tx) */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_SET);
+
+	/* write the logical address of the Tx DMA area for this channel */
+	pciefd_can_writereg(priv, (u32)priv->tx_dma_laddr,
+			    PCIEFD_REG_CAN_TX_DMA_ADDR_L);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	pciefd_can_writereg(priv, (u32)(priv->tx_dma_laddr >> 32),
+			    PCIEFD_REG_CAN_TX_DMA_ADDR_H);
+#else
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
+#endif
+
+	/* also indicates that Tx DMA is cacheable */
+	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT, PCIEFD_REG_CAN_TX_CTL_CLR);
+}
+
+/* clear channel logical Tx DMA address from the board */
+static void pciefd_can_clear_tx_dma(struct pciefd_can *priv)
+{
+	/* DMA must be reset for Tx */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_SET);
+
+	/* clear the logical address of the Tx DMA area for this channel */
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_L);
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
+#endif
+}
+
+static void pciefd_can_ack_rx_dma(struct pciefd_can *priv)
+{
+	/* read value of current IRQ tag and inc it for next one */
+	priv->irq_tag = le32_to_cpu(*(__le32 *)priv->rx_dma_vaddr);
+	priv->irq_tag++;
+	priv->irq_tag &= 0xf;
+
+	/* write the next IRQ tag for this CAN */
+	pciefd_can_writereg(priv, priv->irq_tag, PCIEFD_REG_CAN_RX_CTL_ACK);
+}
+
+/* IRQ handler */
+static irqreturn_t pciefd_irq_handler(int irq, void *arg)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)arg;
+	struct pciefd_rx_dma *rx_dma = priv->rx_dma_vaddr;
+
+	/* INTA mode only to sync with PCIe transaction */
+	if (!pci_dev_msi_enabled(priv->board->pci_dev))
+		(void)pciefd_sys_readreg(priv->board, PCIEFD_REG_SYS_VER1);
+
+	/* read IRQ status from the first 32-bits of the Rx DMA area */
+	priv->irq_status = *(struct pciefd_irq_status *)rx_dma;
+
+	/* check if this (shared) IRQ is for this CAN */
+	if (priv->irq_status.irq_tag != priv->irq_tag)
+		return IRQ_NONE;
+
+	/* handle rx messages (if any) */
+	peak_canfd_handle_msgs_list(&priv->ucan,
+				    rx_dma->msg, priv->irq_status.rx_cnt);
+
+	/* handle tx link interrupt (if any) */
+	if (priv->irq_status.lnk) {
+		priv->tx_pages_free++;
+
+		/* wake producer up */
+		netif_wake_queue(priv->ucan.ndev);
+	}
+
+	/* re-enable Rx DMA transfer for this CAN */
+	pciefd_can_ack_rx_dma(priv);
+
+	return IRQ_HANDLED;
+}
+
+/* write a command */
+static int pciefd_write_cmd(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	u16 cmd = pucan_cmd_get_opcode(&priv->pucan_cmd);
+	int err = 0;
+
+	/* pre-process command */
+	switch (cmd) {
+	case PUCAN_CMD_NORMAL_MODE:
+	case PUCAN_CMD_LISTEN_ONLY_MODE:
+
+		/* going into operational mode: setup IRQ handler */
+		err = request_irq(priv->board->pci_dev->irq,
+				  pciefd_irq_handler,
+				  IRQF_SHARED,
+				  DRV_NAME,
+				  priv);
+		if (err)
+			return err;
+
+		/* setup max count of msgs per IRQ */
+		pciefd_can_writereg(priv, (CANFD_CTL_IRQ_TL_DEF) << 8 |
+				    CANFD_CTL_IRQ_CL_DEF,
+				    PCIEFD_REG_CAN_RX_CTL_WRT);
+
+		/* clear DMA RST for Rx (Rx start) */
+		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_CLR);
+
+		/* reset timestamps */
+		pciefd_can_writereg(priv, !CANFD_MISC_TS_RST,
+				    PCIEFD_REG_CAN_MISC);
+
+		/* do an initial ACK */
+		pciefd_can_ack_rx_dma(priv);
+
+		/* enable IRQ for this CAN after having set next irq_tag */
+		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_SET);
+
+		/* Tx path will be setup as soon as RX_BARRIER is received */
+		break;
+	default:
+		break;
+	}
+
+	if (!err) {
+		unsigned long flags;
+
+		/* 64-bits command is atomic */
+		spin_lock_irqsave(&priv->board->cmd_lock, flags);
+
+		pciefd_can_writereg(priv, *(u32 *)ucan->cmd_buffer,
+				    PCIEFD_REG_CAN_CMD_PORT_L);
+		pciefd_can_writereg(priv, *(u32 *)(ucan->cmd_buffer + 4),
+				    PCIEFD_REG_CAN_CMD_PORT_H);
+
+		spin_unlock_irqrestore(&priv->board->cmd_lock, flags);
+	}
+
+	/* post-process command */
+	switch (cmd) {
+	case PUCAN_CMD_RESET_MODE:
+
+		/* controller now in reset mode */
+
+		/* stop (TX_RST=1) DMA Tx engine */
+		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
+				    PCIEFD_REG_CAN_TX_CTL_SET);
+
+		/* disable IRQ for this CAN */
+		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
+				    PCIEFD_REG_CAN_RX_CTL_CLR);
+
+		free_irq(priv->board->pci_dev->irq, priv);
+
+		break;
+	}
+
+	return err;
+}
+
+static int pciefd_enable_tx_path(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	int i;
+
+	/* initialize the Tx pages descriptors */
+	priv->tx_pages_free = PCIEFD_TX_PAGE_COUNT - 1;
+	priv->tx_page_index = 0;
+
+	priv->tx_pages[0].vbase = priv->tx_dma_vaddr;
+	priv->tx_pages[0].lbase = priv->tx_dma_laddr;
+	for (i = 0; i < PCIEFD_TX_PAGE_COUNT; i++) {
+		priv->tx_pages[i].offset = 0;
+		priv->tx_pages[i].size = PCIEFD_TX_PAGE_SIZE -
+					 sizeof(struct pciefd_tx_link);
+		if (i) {
+			priv->tx_pages[i].vbase = priv->tx_pages[i - 1].vbase +
+						  PCIEFD_TX_PAGE_SIZE;
+			priv->tx_pages[i].lbase = priv->tx_pages[i - 1].lbase +
+						  PCIEFD_TX_PAGE_SIZE;
+		}
+	}
+
+	/* start (TX_RST=0) Tx Path */
+	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_CLR);
+
+	return 0;
+}
+
+static void *pciefd_alloc_tx_msg(struct peak_canfd_priv *ucan, u16 msg_size)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+	struct pciefd_page *page = priv->tx_pages + priv->tx_page_index;
+	void *msg;
+
+	if (page->offset + msg_size > page->size) {
+		struct pciefd_tx_link *lk;
+		/* not enough space in this page: try another one */
+		if (!priv->tx_pages_free) {
+			/* TODO: Tx overflow */
+			return NULL;
+		}
+
+		priv->tx_pages_free--;
+
+		/* keep address of the very last free slot of current page */
+		lk = page->vbase + page->offset;
+
+		/* next, move on a new free page */
+		priv->tx_page_index = (priv->tx_page_index + 1) %
+							PCIEFD_TX_PAGE_COUNT;
+		page = priv->tx_pages + priv->tx_page_index;
+
+		/* put link record to this new page at the end of prev one */
+		lk->size = cpu_to_le16(sizeof(*lk));
+		lk->type = cpu_to_le16(CANFD_MSG_LNK_TX);
+		lk->laddr_lo = cpu_to_le32(page->lbase);
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		lk->laddr_hi = cpu_to_le32(page->lbase >> 32);
+#else
+		lk->laddr_hi = 0;
+#endif
+
+		/* next msgs will be put from the begininng of this new page */
+		page->offset = 0;
+	}
+
+	msg = page->vbase + page->offset;
+
+	/* this slot is now reserved for writing next frame */
+	page->offset += msg_size;
+
+	return msg;
+}
+
+static int pciefd_write_tx_msg(struct peak_canfd_priv *ucan)
+{
+	struct pciefd_can *priv = (struct pciefd_can *)ucan;
+
+	/* tell the board a frame has been written in Tx DMA area */
+	pciefd_can_writereg(priv, 1, PCIEFD_REG_CAN_TX_REQ_ACC);
+
+	return 0;
+}
+
+/* probe for CAN-FD channel #pciefd_board->can_count */
+static int pciefd_can_probe(struct pciefd_board *pciefd)
+{
+	struct net_device *ndev;
+	struct pciefd_can *priv;
+	u32 clk;
+	int err;
+
+	/* allocate the candev object */
+	ndev = alloc_peak_canfd_dev(sizeof(*priv), CANFD_ECHO_SKB_MAX,
+				    pciefd->can_count);
+	if (!ndev) {
+		dev_err(&pciefd->pci_dev->dev,
+			"failed to alloc candev object\n");
+		goto failure;
+	}
+
+	priv = netdev_priv(ndev);
+
+	/* fill-in candev private object: */
+
+	/* setup PCIe-FD own callbacks */
+	priv->ucan.write_cmd = pciefd_write_cmd;
+	priv->ucan.enable_tx_path = pciefd_enable_tx_path;
+	priv->ucan.alloc_tx_msg = pciefd_alloc_tx_msg;
+	priv->ucan.write_tx_msg = pciefd_write_tx_msg;
+
+	/* setup PCIe-FD own command buffer */
+	priv->ucan.cmd_buffer = &priv->pucan_cmd;
+	priv->ucan.cmd_maxlen = sizeof(priv->pucan_cmd);
+
+	priv->board = pciefd;
+
+	/* CAN config regs block address */
+	priv->reg_base = pciefd->reg_base + PCIEFD_CANX_OFF(priv->ucan.index);
+
+	/* allocate non-cacheable DMA'able 4KB memory area for Rx */
+	priv->rx_dma_vaddr = dma_alloc_coherent(&pciefd->pci_dev->dev,
+						PCIEFD_RX_DMA_SIZE,
+						&priv->rx_dma_laddr,
+						GFP_KERNEL);
+	if (!priv->rx_dma_vaddr) {
+		dev_err(&pciefd->pci_dev->dev,
+			"Rx dma_alloc_coherent(%u) failure\n",
+			PCIEFD_RX_DMA_SIZE);
+		goto err_free_candev;
+	}
+
+	/* allocate non-cacheable DMA'able 4KB memory area for Tx */
+	priv->tx_dma_vaddr = dma_alloc_coherent(&pciefd->pci_dev->dev,
+						PCIEFD_TX_DMA_SIZE,
+						&priv->tx_dma_laddr,
+						GFP_KERNEL);
+	if (!priv->tx_dma_vaddr) {
+		dev_err(&pciefd->pci_dev->dev,
+			"Tx dma_alloc_coherent(%u) failure\n",
+			PCIEFD_TX_DMA_SIZE);
+		goto err_free_rx;
+	}
+
+	/* CAN clock in RST mode */
+	pciefd_can_writereg(priv, CANFD_MISC_TS_RST, PCIEFD_REG_CAN_MISC);
+
+	/* read current clock value */
+	clk = pciefd_can_readreg(priv, PCIEFD_REG_CAN_CLK_SEL);
+	switch (clk) {
+	case CANFD_CLK_SEL_20MHZ:
+		priv->ucan.can.clock.freq = 20 * MHz;
+		break;
+	case CANFD_CLK_SEL_24MHZ:
+		priv->ucan.can.clock.freq = 24 * MHz;
+		break;
+	case CANFD_CLK_SEL_30MHZ:
+		priv->ucan.can.clock.freq = 30 * MHz;
+		break;
+	case CANFD_CLK_SEL_40MHZ:
+		priv->ucan.can.clock.freq = 40 * MHz;
+		break;
+	case CANFD_CLK_SEL_60MHZ:
+		priv->ucan.can.clock.freq = 60 * MHz;
+		break;
+	default:
+		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
+				    PCIEFD_REG_CAN_CLK_SEL);
+
+	case CANFD_CLK_SEL_80MHZ:
+		priv->ucan.can.clock.freq = 80 * MHz;
+		break;
+	}
+
+	SET_NETDEV_DEV(ndev, &pciefd->pci_dev->dev);
+
+	err = register_candev(ndev);
+	if (err) {
+		dev_err(&pciefd->pci_dev->dev,
+			"couldn't register CAN device: %d\n", err);
+		goto err_free_tx;
+	}
+
+	/* everything is ok so setup DMA addresses */
+	pciefd_can_setup_rx_dma(priv);
+	pciefd_can_setup_tx_dma(priv);
+
+	/* save the object address in the board structure */
+	pciefd->can[pciefd->can_count] = priv;
+
+	dev_info(&pciefd->pci_dev->dev, "%s at reg_base=0x%p irq=%d\n",
+		 ndev->name, priv->reg_base, pciefd->pci_dev->irq);
+
+	return 0;
+
+err_free_tx:
+	dma_free_coherent(&pciefd->pci_dev->dev, PCIEFD_TX_DMA_SIZE,
+			  priv->tx_dma_vaddr, priv->tx_dma_laddr);
+err_free_rx:
+	dma_free_coherent(&pciefd->pci_dev->dev, PCIEFD_RX_DMA_SIZE,
+			  priv->rx_dma_vaddr, priv->rx_dma_laddr);
+err_free_candev:
+	free_candev(ndev);
+
+failure:
+	return -ENOMEM;
+}
+
+/* remove a CAN-FD channel by releasing all of its resources */
+static void pciefd_can_remove(struct pciefd_can *priv)
+{
+	/* unregister (close) the can device to go back to RST mode first */
+	unregister_candev(priv->ucan.ndev);
+
+	/* clear DMA logical addresses */
+	pciefd_can_clear_tx_dma(priv);
+	pciefd_can_clear_rx_dma(priv);
+
+	/* Tx DMA area can now be released */
+	dma_free_coherent(&priv->board->pci_dev->dev, PCIEFD_TX_DMA_SIZE,
+			  priv->tx_dma_vaddr, priv->tx_dma_laddr);
+
+	/* Rx DMA area can now be released */
+	dma_free_coherent(&priv->board->pci_dev->dev, PCIEFD_RX_DMA_SIZE,
+			  priv->rx_dma_vaddr, priv->rx_dma_laddr);
+
+	/* finally, free the candev object */
+	free_candev(priv->ucan.ndev);
+}
+
+/* remove all CAN-FD channels by releasing their own resources */
+static void pciefd_can_remove_all(struct pciefd_board *pciefd)
+{
+	while (pciefd->can_count > 0)
+		pciefd_can_remove(pciefd->can[--pciefd->can_count]);
+}
+
+/* probe for the entire device */
+static int peak_pciefd_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *ent)
+{
+	struct pciefd_board *pciefd;
+	int err, can_count;
+	u16 sub_sys_id;
+	u32 v2;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+	err = pci_request_regions(pdev, DRV_NAME);
+	if (err)
+		goto err_disable_pci;
+
+	/* the number of channels depends on sub-system id */
+	err = pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &sub_sys_id);
+	if (err)
+		goto err_release_regions;
+
+	dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
+		pdev->vendor, pdev->device, sub_sys_id);
+
+	if (sub_sys_id >= 0x0012)
+		can_count = 4;
+	else if (sub_sys_id >= 0x0010)
+		can_count = 3;
+	else if (sub_sys_id >= 0x0004)
+		can_count = 2;
+	else
+		can_count = 1;
+
+	/* allocate board structure object */
+	pciefd = kmalloc(sizeof(*pciefd) + sizeof(*pciefd->can) * can_count,
+			 GFP_KERNEL);
+	if (!pciefd) {
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
+
+	/* initialize the board structure */
+	pciefd->pci_dev = pdev;
+	spin_lock_init(&pciefd->cmd_lock);
+
+	/* save the PCI BAR0 virtual address for further system regs access */
+	pciefd->reg_base = pci_iomap(pdev, 0, PCIEFD_BAR0_SIZE);
+	if (!pciefd->reg_base) {
+		dev_err(&pdev->dev, "failed to map PCI resource #0\n");
+		err = -ENOMEM;
+		goto err_free_pciefd;
+	}
+
+	/* read the firmware version number */
+	v2 = pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER2);
+
+	pciefd->hw_ver_major = (v2 & 0x0000f000) >> 12;
+	pciefd->hw_ver_minor = (v2 & 0x00000f00) >> 8;
+	pciefd->hw_ver_sub = (v2 & 0x000000f0) >> 4;
+
+	dev_info(&pdev->dev,
+		 "%ux CAN-FD PCAN-PCIe FPGA v%u.%u.%u:\n", can_count,
+		 pciefd->hw_ver_major, pciefd->hw_ver_minor,
+		 pciefd->hw_ver_sub);
+
+	/* stop system clock */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
+			    PCIEFD_REG_SYS_CTL_CLR);
+
+	pci_set_master(pdev);
+
+	/* create now the corresponding channels objects */
+	for (pciefd->can_count = 0; pciefd->can_count < can_count;) {
+		err = pciefd_can_probe(pciefd);
+		if (err)
+			goto err_free_canfd;
+
+		pciefd->can_count++;
+	}
+
+	/* set system timestamps counter in RST mode */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
+			    PCIEFD_REG_SYS_CTL_SET);
+
+	/* wait a bit (read cycle) */
+	(void)pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER1);
+
+	/* free all clocks */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
+			    PCIEFD_REG_SYS_CTL_CLR);
+
+	/* start system clock */
+	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
+			    PCIEFD_REG_SYS_CTL_SET);
+
+	/* remember the board structure address in the device user data */
+	pci_set_drvdata(pdev, pciefd);
+
+	return 0;
+
+err_free_canfd:
+	pciefd_can_remove_all(pciefd);
+
+	pci_iounmap(pdev, pciefd->reg_base);
+
+err_free_pciefd:
+	kfree(pciefd);
+
+err_release_regions:
+	pci_release_regions(pdev);
+
+err_disable_pci:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void peak_pciefd_remove(struct pci_dev *pdev)
+{
+	struct pciefd_board *pciefd  = pci_get_drvdata(pdev);
+
+	/* get and free the board structure object, as well as its resources */
+	if (pciefd) {
+		/* release CAN-FD channels resources */
+		pciefd_can_remove_all(pciefd);
+
+		pci_iounmap(pdev, pciefd->reg_base);
+
+		kfree(pciefd);
+
+		pci_set_drvdata(pdev, NULL);
+	}
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver peak_pciefd_driver = {
+	.name = DRV_NAME,
+	.id_table = peak_pciefd_tbl,
+	.probe = peak_pciefd_probe,
+	.remove = peak_pciefd_remove,
+};
+
+module_pci_driver(peak_pciefd_driver);
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index 25e20ef..6981333 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -23,11 +23,14 @@
 #define PUCAN_CMD_LISTEN_ONLY_MODE	0x003
 #define PUCAN_CMD_TIMING_SLOW		0x004
 #define PUCAN_CMD_TIMING_FAST		0x005
+#define PUCAN_CMD_SET_STD_FILTER	0x006
+#define PUCAN_CMD_RESERVED2		0x007
 #define PUCAN_CMD_FILTER_STD		0x008
 #define PUCAN_CMD_TX_ABORT		0x009
 #define PUCAN_CMD_WR_ERR_CNT		0x00a
 #define PUCAN_CMD_SET_EN_OPTION		0x00b
 #define PUCAN_CMD_CLR_DIS_OPTION	0x00c
+#define PUCAN_CMD_RX_BARRIER		0x010
 #define PUCAN_CMD_END_OF_COLLECTION	0x3ff
 
 /* uCAN received messages list */
@@ -35,6 +38,10 @@
 #define PUCAN_MSG_ERROR			0x0002
 #define PUCAN_MSG_STATUS		0x0003
 #define PUCAN_MSG_BUSLOAD		0x0004
+
+#define PUCAN_MSG_CACHE_CRITICAL	0x0102
+
+/* uCAN transmitted messages */
 #define PUCAN_MSG_CAN_TX		0x1000
 
 /* uCAN command common header */
@@ -43,6 +50,12 @@ struct __packed pucan_command {
 	u16	args[3];
 };
 
+/* return the opcode from the opcode_channel field of a command */
+static inline u16 pucan_cmd_get_opcode(struct pucan_command *c)
+{
+	return le16_to_cpu(c->opcode_channel) & 0x3ff;
+}
+
 #define PUCAN_TSLOW_BRP_BITS		10
 #define PUCAN_TSLOW_TSGEG1_BITS		8
 #define PUCAN_TSLOW_TSGEG2_BITS		7
@@ -108,6 +121,27 @@ struct __packed pucan_filter_std {
 	__le32	mask;		/* CAN-ID bitmask in idx range */
 };
 
+#define PUCAN_FLTSTD_ROW_IDX_MAX	((1 << PUCAN_FLTSTD_ROW_IDX_BITS) - 1)
+
+/* uCAN SET_STD_FILTER command fields */
+struct __packed pucan_std_filter {
+	__le16	opcode_channel;
+
+	u8	unused;
+	u8	idx;
+	__le32	mask;		/* CAN-ID bitmask in idx range */
+};
+
+/* uCAN TX_ABORT commands fields */
+#define PUCAN_TX_ABORT_FLUSH		0x0001
+
+struct __packed pucan_tx_abort {
+	__le16	opcode_channel;
+
+	__le16	flags;
+	u32	unused;
+};
+
 /* uCAN WR_ERR_CNT command fields */
 #define PUCAN_WRERRCNT_TE		0x4000	/* Tx error cntr write Enable */
 #define PUCAN_WRERRCNT_RE		0x8000	/* Rx error cntr write Enable */
@@ -184,10 +218,21 @@ struct __packed pucan_error_msg {
 	u8	rx_err_cnt;
 };
 
+static inline int pucan_error_get_channel(const struct pucan_error_msg *msg)
+{
+	return msg->channel_type_d & 0x0f;
+}
+
+#define PUCAN_RX_BARRIER		0x10
 #define PUCAN_BUS_PASSIVE		0x20
 #define PUCAN_BUS_WARNING		0x40
 #define PUCAN_BUS_BUSOFF		0x80
 
+#define PUCAN_STMSG_RB(e)		((e)->channel_p_w_b & PUCAN_RX_BARRIER)
+#define PUCAN_STMSG_PASSIVE(e)		((e)->channel_p_w_b & PUCAN_BUS_PASSIVE)
+#define PUCAN_STMSG_WARNING(e)		((e)->channel_p_w_b & PUCAN_BUS_WARNING)
+#define PUCAN_STMSG_BUSOFF(e)		((e)->channel_p_w_b & PUCAN_BUS_BUSOFF)
+
 struct __packed pucan_status_msg {
 	__le16	size;
 	__le16	type;
@@ -197,6 +242,11 @@ struct __packed pucan_status_msg {
 	u8	unused[3];
 };
 
+static inline int pucan_status_get_channel(struct pucan_status_msg *msg)
+{
+	return msg->channel_p_w_b & 0x0f;
+}
+
 /* uCAN transmitted message format */
 #define PUCAN_MSG_CHANNEL_DLC(c, d)	(((c) & 0xf) | ((d) << 4))
 
-- 
2.7.4


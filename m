From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v7] can: move can_stats.bus_off++ from can_bus_off into
 can_change_state
Date: Fri, 16 Jan 2015 14:30:28 +0000
Message-ID: <0324fb6a-bfe4-4a0f-8b77-b683694cf252@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0064.outbound.protection.outlook.com ([157.55.234.64]:44288
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754584AbbAPOaf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 16 Jan 2015 09:30:35 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

In order to be able to move the stats increment from can_bus_off() into
can_change_state(), the increment had to be moved back into code that was using
can_bus_off() but not can_change_state().

As a side-effect, this patch fixes the following bugs:
 * Redundant call to can_bus_off() in c_can.
 * Bus-off counted twice in xilinx_can.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes since last patch:
 * Rebase against linux-can-next
 * bfin_can: fix FTBFS

---
 drivers/net/can/bfin_can.c                  | 1 +
 drivers/net/can/c_can/c_can.c               | 2 +-
 drivers/net/can/cc770/cc770.c               | 1 +
 drivers/net/can/dev.c                       | 3 ++-
 drivers/net/can/janz-ican3.c                | 1 +
 drivers/net/can/m_can/m_can.c               | 1 +
 drivers/net/can/pch_can.c                   | 1 +
 drivers/net/can/rcar_can.c                  | 1 +
 drivers/net/can/softing/softing_main.c      | 1 +
 drivers/net/can/spi/mcp251x.c               | 1 +
 drivers/net/can/ti_hecc.c                   | 1 +
 drivers/net/can/usb/ems_usb.c               | 1 +
 drivers/net/can/usb/esd_usb2.c              | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb.c     | 1 +
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 1 +
 drivers/net/can/usb/usb_8dev.c              | 1 +
 16 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index 417d5099..e7a6363 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -352,6 +352,7 @@ static int bfin_can_err(struct net_device *dev, u16 isrc, u16 status)
 		netdev_dbg(dev, "bus-off mode interrupt\n");
 		state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
+		priv->can.can_stats.bus_off++;
 		can_bus_off(dev);
 	}
 
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index f94a9fa..70f77e9 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -866,7 +866,7 @@ static int c_can_handle_state_change(struct net_device *dev,
 	case C_CAN_BUS_OFF:
 		/* bus-off state */
 		priv->can.state = CAN_STATE_BUS_OFF;
-		can_bus_off(dev);
+		priv->can.can_stats.bus_off++;
 		break;
 	default:
 		break;
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index c486fe5..c11d449 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -535,6 +535,7 @@ static int cc770_err(struct net_device *dev, u8 status)
 		cc770_write_reg(priv, control, CTRL_INI);
 		cf->can_id |= CAN_ERR_BUSOFF;
 		priv->can.state = CAN_STATE_BUS_OFF;
+		priv->can.can_stats.bus_off++;
 		can_bus_off(dev);
 	} else if (status & STAT_WARN) {
 		cf->can_id |= CAN_ERR_CRTL;
diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3ec8f6f..e54dbc1a 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -289,6 +289,8 @@ static void can_update_state_error_stats(struct net_device *dev,
 		priv->can_stats.error_passive++;
 		break;
 	case CAN_STATE_BUS_OFF:
+		priv->can_stats.bus_off++;
+		break;
 	default:
 		break;
 	};
@@ -544,7 +546,6 @@ void can_bus_off(struct net_device *dev)
 	netdev_dbg(dev, "bus-off\n");
 
 	netif_carrier_off(dev);
-	priv->can_stats.bus_off++;
 
 	if (priv->restart_ms)
 		mod_timer(&priv->restart_timer,
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1b11839..0eb4d18 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1008,6 +1008,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 		if (status & SR_BS) {
 			state = CAN_STATE_BUS_OFF;
 			cf->can_id |= CAN_ERR_BUSOFF;
+			mod->can.can_stats.bus_off++;
 			can_bus_off(dev);
 		} else if (status & SR_ES) {
 			if (rxerr >= 128 || txerr >= 128)
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d7bc462..b2ecb6c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -589,6 +589,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 		/* bus-off state */
 		priv->can.state = CAN_STATE_BUS_OFF;
 		m_can_disable_all_interrupts(priv);
+		priv->can.can_stats.bus_off++;
 		can_bus_off(dev);
 		break;
 	default:
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index a67eb01..e187ca7 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -505,6 +505,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		pch_can_set_rx_all(priv, 0);
 		state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
+		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
 	}
 
diff --git a/drivers/net/can/rcar_can.c b/drivers/net/can/rcar_can.c
index 91cd48c..7deb80d 100644
--- a/drivers/net/can/rcar_can.c
+++ b/drivers/net/can/rcar_can.c
@@ -331,6 +331,7 @@ static void rcar_can_error(struct net_device *ndev)
 		priv->can.state = CAN_STATE_BUS_OFF;
 		/* Clear interrupt condition */
 		writeb(~RCAR_CAN_EIFR_BOEIF, &priv->regs->eifr);
+		priv->can.can_stats.bus_off++;
 		can_bus_off(ndev);
 		if (skb)
 			cf->can_id |= CAN_ERR_BUSOFF;
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 2bf98d8..7621f91 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -261,6 +261,7 @@ static int softing_handle_1(struct softing *card)
 				++priv->can.can_stats.error_passive;
 			else if (can_state == CAN_STATE_BUS_OFF) {
 				/* this calls can_close_cleanup() */
+				++priv->can.can_stats.bus_off;
 				can_bus_off(netdev);
 				netif_stop_queue(netdev);
 			}
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index c66d699..bf63fee 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -905,6 +905,7 @@ static irqreturn_t mcp251x_can_ist(int irq, void *dev_id)
 		if (priv->can.state == CAN_STATE_BUS_OFF) {
 			if (priv->can.restart_ms == 0) {
 				priv->force_quit = 1;
+				priv->can.can_stats.bus_off++;
 				can_bus_off(net);
 				mcp251x_hw_sleep(spi);
 				break;
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 9a07eaf..e95a9e1 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -715,6 +715,7 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 		hecc_clear_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
 		/* Disable all interrupts in bus-off to avoid int hog */
 		hecc_write(priv, HECC_CANGIM, 0);
+		++priv->can.can_stats.bus_off;
 		can_bus_off(ndev);
 	}
 
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 29d3f09..9376f5e 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -347,6 +347,7 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 			dev->can.state = CAN_STATE_BUS_OFF;
 			cf->can_id |= CAN_ERR_BUSOFF;
 
+			dev->can.can_stats.bus_off++;
 			can_bus_off(dev->netdev);
 		} else if (state & SJA1000_SR_ES) {
 			dev->can.state = CAN_STATE_ERROR_WARNING;
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index c063a54..bacca0b 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -250,6 +250,7 @@ static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
 			case ESD_BUSSTATE_BUSOFF:
 				priv->can.state = CAN_STATE_BUS_OFF;
 				cf->can_id |= CAN_ERR_BUSOFF;
+				priv->can.can_stats.bus_off++;
 				can_bus_off(priv->netdev);
 				break;
 			case ESD_BUSSTATE_WARN:
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4e1659d..2a1c9ce 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -488,6 +488,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 	switch (new_state) {
 	case CAN_STATE_BUS_OFF:
 		cf->can_id |= CAN_ERR_BUSOFF;
+		mc->pdev->dev.can.can_stats.bus_off++;
 		can_bus_off(mc->netdev);
 		break;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4cfa3b8..145fa87 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -634,6 +634,7 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	switch (new_state) {
 	case CAN_STATE_BUS_OFF:
 		can_frame->can_id |= CAN_ERR_BUSOFF;
+		dev->can.can_stats.bus_off++;
 		can_bus_off(netdev);
 		break;
 
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index ef674ec..dd52c7a 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -377,6 +377,7 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 	case USB_8DEV_STATUSMSG_BUSOFF:
 		priv->can.state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
+		priv->can.can_stats.bus_off++;
 		can_bus_off(priv->netdev);
 		break;
 	case USB_8DEV_STATUSMSG_OVERRUN:
-- 
1.9.1


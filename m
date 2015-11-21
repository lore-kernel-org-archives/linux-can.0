From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/2] can: fix assignment of error location in CAN error messages
Date: Sat, 21 Nov 2015 18:41:20 +0100
Message-ID: <1448127681-8533-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:49471 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbKURli (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2015 12:41:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: dan.carpenter@oracle.com, Oliver Hartkopp <socketcan@hartkopp.net>

As Dan Carpenter reported in http://marc.info/?l=linux-can&m=144793696016187
the assignment of the error location in CAN error messages had some bit wise
overlaps. Indeed the value to be assigned in data[3] is no bitfield but defines
a single value which points to a location inside the CAN frame on the wire.

This patch fixes the assignments for the error locations in error messages.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/c_can/c_can.c    | 6 ++----
 drivers/net/can/cc770/cc770.c    | 2 +-
 drivers/net/can/flexcan.c        | 4 ++--
 drivers/net/can/m_can/m_can.c    | 6 ++----
 drivers/net/can/pch_can.c        | 3 +--
 drivers/net/can/rcar_can.c       | 6 +++---
 drivers/net/can/ti_hecc.c        | 6 ++----
 drivers/net/can/usb/kvaser_usb.c | 5 ++---
 drivers/net/can/usb/usb_8dev.c   | 3 +--
 drivers/net/can/xilinx_can.c     | 5 ++---
 10 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 5d214d1..7c9892ab 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -975,8 +975,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
-				CAN_ERR_PROT_LOC_ACK_DEL);
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
@@ -988,8 +987,7 @@ static int c_can_handle_bus_err(struct net_device *dev,
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
-				CAN_ERR_PROT_LOC_CRC_DEL);
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		break;
 	default:
 		break;
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 70a8cbb..1e37313 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -578,7 +578,7 @@ static int cc770_err(struct net_device *dev, u8 status)
 				cf->data[2] |= CAN_ERR_PROT_BIT0;
 				break;
 			case STAT_LEC_CRC:
-				cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 				break;
 			}
 		}
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 868fe94..41c0fc9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -535,13 +535,13 @@ static void do_bus_err(struct net_device *dev,
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
 		cf->can_id |= CAN_ERR_ACK;
-		cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		tx_errors = 1;
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT;
-		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		rx_errors = 1;
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ef65517..9dd3ca7 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -500,8 +500,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] |= (CAN_ERR_PROT_LOC_ACK |
-				CAN_ERR_PROT_LOC_ACK_DEL);
+		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
@@ -513,8 +512,7 @@ static int m_can_handle_lec_err(struct net_device *dev,
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
-				CAN_ERR_PROT_LOC_CRC_DEL);
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		break;
 	default:
 		break;
diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index e187ca7..c131788 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -559,8 +559,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		stats->rx_errors++;
 		break;
 	case PCH_CRC_ERR:
-		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
-			       CAN_ERR_PROT_LOC_CRC_DEL;
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
 		break;
diff --git a/drivers/net/can/rcar_can.c b/drivers/net/can/rcar_can.c
index 7bd5419..9161f04 100644
--- a/drivers/net/can/rcar_can.c
+++ b/drivers/net/can/rcar_can.c
@@ -251,7 +251,7 @@ static void rcar_can_error(struct net_device *ndev)
 			tx_errors++;
 			writeb(~RCAR_CAN_ECSR_ADEF, &priv->regs->ecsr);
 			if (skb)
-				cf->data[3] |= CAN_ERR_PROT_LOC_ACK_DEL;
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK_DEL;
 		}
 		if (ecsr & RCAR_CAN_ECSR_BE0F) {
 			netdev_dbg(priv->ndev, "Bit Error (dominant)\n");
@@ -272,7 +272,7 @@ static void rcar_can_error(struct net_device *ndev)
 			rx_errors++;
 			writeb(~RCAR_CAN_ECSR_CEF, &priv->regs->ecsr);
 			if (skb)
-				cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		}
 		if (ecsr & RCAR_CAN_ECSR_AEF) {
 			netdev_dbg(priv->ndev, "ACK Error\n");
@@ -280,7 +280,7 @@ static void rcar_can_error(struct net_device *ndev)
 			writeb(~RCAR_CAN_ECSR_AEF, &priv->regs->ecsr);
 			if (skb) {
 				cf->can_id |= CAN_ERR_ACK;
-				cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 			}
 		}
 		if (ecsr & RCAR_CAN_ECSR_FEF) {
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index cf345cb..6eab4fe 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -737,13 +737,11 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 		}
 		if (err_status & HECC_CANES_CRCE) {
 			hecc_set_bit(priv, HECC_CANES, HECC_CANES_CRCE);
-			cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
-					CAN_ERR_PROT_LOC_CRC_DEL;
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		}
 		if (err_status & HECC_CANES_ACKE) {
 			hecc_set_bit(priv, HECC_CANES, HECC_CANES_ACKE);
-			cf->data[3] |= CAN_ERR_PROT_LOC_ACK |
-					CAN_ERR_PROT_LOC_ACK_DEL;
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		}
 	}
 
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 8b17a90..022bfa1 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -944,10 +944,9 @@ static void kvaser_usb_rx_error(const struct kvaser_usb *dev,
 			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
 
 			if (es->leaf.error_factor & M16C_EF_ACKE)
-				cf->data[3] |= (CAN_ERR_PROT_LOC_ACK);
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 			if (es->leaf.error_factor & M16C_EF_CRCE)
-				cf->data[3] |= (CAN_ERR_PROT_LOC_CRC_SEQ |
-						CAN_ERR_PROT_LOC_CRC_DEL);
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 			if (es->leaf.error_factor & M16C_EF_FORME)
 				cf->data[2] |= CAN_ERR_PROT_FORM;
 			if (es->leaf.error_factor & M16C_EF_STFE)
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index de95b1c..017ae50 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -402,8 +402,7 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 		break;
 	case USB_8DEV_STATUSMSG_CRC:
 		cf->data[2] |= CAN_ERR_PROT_UNSPEC;
-		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
-			       CAN_ERR_PROT_LOC_CRC_DEL;
+		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		rx_errors = 1;
 		break;
 	case USB_8DEV_STATUSMSG_BIT0:
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index fc55e8e..4c57ddf 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -618,7 +618,7 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 			stats->tx_errors++;
 			if (skb) {
 				cf->can_id |= CAN_ERR_ACK;
-				cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+				cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 			}
 		}
 
@@ -654,8 +654,7 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 			stats->rx_errors++;
 			if (skb) {
 				cf->can_id |= CAN_ERR_PROT;
-				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ |
-						CAN_ERR_PROT_LOC_CRC_DEL;
+				cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 			}
 		}
 			priv->can.can_stats.bus_error++;
-- 
2.1.4


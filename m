From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/2] [RFC] can: remove obsolete assignment for CAN protocol error type
Date: Sat, 21 Nov 2015 18:41:21 +0100
Message-ID: <1448127681-8533-2-git-send-email-socketcan@hartkopp.net>
References: <1448127681-8533-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:51953 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbKURln (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Nov 2015 12:41:43 -0500
In-Reply-To: <1448127681-8533-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: dan.carpenter@oracle.com, Oliver Hartkopp <socketcan@hartkopp.net>

The assignment 'cf->data[2] |= CAN_ERR_PROT_UNSPEC' used at CAN error message
creation time is obsolete as CAN_ERR_PROT_UNSPEC is zero and cf->data[2] is
initialized with zero in alloc_can_err_skb() anyway.

So we could either assign 'cf->data[2] = CAN_ERR_PROT_UNSPEC' correctly or we
can remove the obsolete OR operation entirely.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/bfin_can.c        | 2 --
 drivers/net/can/c_can/c_can.c     | 1 -
 drivers/net/can/janz-ican3.c      | 1 -
 drivers/net/can/m_can/m_can.c     | 1 -
 drivers/net/can/rcar_can.c        | 5 ++---
 drivers/net/can/sja1000/sja1000.c | 1 -
 drivers/net/can/sun4i_can.c       | 1 -
 drivers/net/can/ti_hecc.c         | 1 -
 drivers/net/can/usb/ems_usb.c     | 1 -
 drivers/net/can/usb/esd_usb2.c    | 1 -
 drivers/net/can/usb/usb_8dev.c    | 1 -
 drivers/net/can/xilinx_can.c      | 4 +---
 12 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index 57dadd5..1deb8ff 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -501,8 +501,6 @@ static int bfin_can_err(struct net_device *dev, u16 isrc, u16 status)
 			cf->data[2] |= CAN_ERR_PROT_FORM;
 		else if (status & SER)
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
-		else
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 	}
 
 	priv->can.state = state;
diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 7c9892ab..f91b094 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -962,7 +962,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	 * type of the last error to occur on the CAN bus
 	 */
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index c1e8536..5d04f54 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1096,7 +1096,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 			break;
 		default:
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 			cf->data[3] = ecc & ECC_SEG;
 			break;
 		}
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9dd3ca7..39cf911 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -487,7 +487,6 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	 * type of the last error to occur on the CAN bus
 	 */
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-	cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
diff --git a/drivers/net/can/rcar_can.c b/drivers/net/can/rcar_can.c
index 9161f04..bc46be3 100644
--- a/drivers/net/can/rcar_can.c
+++ b/drivers/net/can/rcar_can.c
@@ -241,10 +241,9 @@ static void rcar_can_error(struct net_device *ndev)
 		u8 ecsr;
 
 		netdev_dbg(priv->ndev, "Bus error interrupt:\n");
-		if (skb) {
+		if (skb)
 			cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
-			cf->data[2] = CAN_ERR_PROT_UNSPEC;
-		}
+
 		ecsr = readb(&priv->regs->ecsr);
 		if (ecsr & RCAR_CAN_ECSR_ADEF) {
 			netdev_dbg(priv->ndev, "ACK Delimiter Error\n");
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 7b92e91..c5dbdb7 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -446,7 +446,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 			break;
 		default:
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 			cf->data[3] = ecc & ECC_SEG;
 			break;
 		}
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index d9a42c6..68ef0a4 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -575,7 +575,6 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 				cf->data[2] |= CAN_ERR_PROT_STUFF;
 				break;
 			default:
-				cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 				cf->data[3] = (ecc & SUN4I_STA_ERR_SEG_CODE)
 					       >> 16;
 				break;
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 6eab4fe..680d1ff 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -722,7 +722,6 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 	if (err_status & HECC_BUS_ERROR) {
 		++priv->can.can_stats.bus_error;
 		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
-		cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 		if (err_status & HECC_CANES_FE) {
 			hecc_set_bit(priv, HECC_CANES, HECC_CANES_FE);
 			cf->data[2] |= CAN_ERR_PROT_FORM;
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 2d39038..fc5b756 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -377,7 +377,6 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 			cf->data[2] |= CAN_ERR_PROT_STUFF;
 			break;
 		default:
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 			cf->data[3] = ecc & SJA1000_ECC_SEG;
 			break;
 		}
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 0e5a449..113e64f 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -282,7 +282,6 @@ static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
 				cf->data[2] |= CAN_ERR_PROT_STUFF;
 				break;
 			default:
-				cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 				cf->data[3] = ecc & SJA1000_ECC_SEG;
 				break;
 			}
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 017ae50..a731720 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -401,7 +401,6 @@ static void usb_8dev_rx_err_msg(struct usb_8dev_priv *priv,
 		tx_errors = 1;
 		break;
 	case USB_8DEV_STATUSMSG_CRC:
-		cf->data[2] |= CAN_ERR_PROT_UNSPEC;
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		rx_errors = 1;
 		break;
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 4c57ddf..51670b3 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -608,10 +608,8 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	/* Check for error interrupt */
 	if (isr & XCAN_IXR_ERROR_MASK) {
-		if (skb) {
+		if (skb)
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
-		}
 
 		/* Check for Ack error interrupt */
 		if (err_status & XCAN_ESR_ACKER_MASK) {
-- 
2.1.4


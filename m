From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: janz-ican3: convert dev_<level> printing to netdev_<level>
Date: Tue,  4 Mar 2014 22:22:07 +0100
Message-ID: <1393968127-7295-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46110 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbaCDVWP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 16:22:15 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, "Ira W. Snyder" <iws@ovro.caltech.edu>

This patch converts the dev_<level> printing to netdev_<level>, this makes it
possible to remove the "struct device *dev" pointer from the "struct
ican3_dev".

Cc: Ira W. Snyder <iws@ovro.caltech.edu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c | 64 +++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 71594e5..b47df5e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -198,9 +198,6 @@ struct ican3_dev {
 	struct net_device *ndev;
 	struct napi_struct napi;
 
-	/* Device for printing */
-	struct device *dev;
-
 	/* module number */
 	unsigned int num;
 
@@ -295,7 +292,7 @@ static int ican3_old_recv_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	xord = locl ^ peer;
 
 	if ((xord & MSYNC_RB_MASK) == 0x00) {
-		dev_dbg(mod->dev, "no mbox for reading\n");
+		netdev_dbg(mod->ndev, "no mbox for reading\n");
 		return -ENOMEM;
 	}
 
@@ -340,7 +337,7 @@ static int ican3_old_send_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	xord = locl ^ peer;
 
 	if ((xord & MSYNC_WB_MASK) == MSYNC_WB_MASK) {
-		dev_err(mod->dev, "no mbox for writing\n");
+		netdev_err(mod->ndev, "no mbox for writing\n");
 		return -ENOMEM;
 	}
 
@@ -542,7 +539,7 @@ static int ican3_new_send_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	memcpy_fromio(&desc, desc_addr, sizeof(desc));
 
 	if (!(desc.control & DESC_VALID)) {
-		dev_dbg(mod->dev, "%s: no free buffers\n", __func__);
+		netdev_dbg(mod->ndev, "%s: no free buffers\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -573,7 +570,7 @@ static int ican3_new_recv_msg(struct ican3_dev *mod, struct ican3_msg *msg)
 	memcpy_fromio(&desc, desc_addr, sizeof(desc));
 
 	if (!(desc.control & DESC_VALID)) {
-		dev_dbg(mod->dev, "%s: no buffers to recv\n", __func__);
+		netdev_dbg(mod->ndev, "%s: no buffers to recv\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -883,7 +880,7 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
  */
 static void ican3_handle_idvers(struct ican3_dev *mod, struct ican3_msg *msg)
 {
-	dev_dbg(mod->dev, "IDVERS response: %s\n", msg->data);
+	netdev_dbg(mod->ndev, "IDVERS response: %s\n", msg->data);
 }
 
 static void ican3_handle_msglost(struct ican3_dev *mod, struct ican3_msg *msg)
@@ -899,7 +896,7 @@ static void ican3_handle_msglost(struct ican3_dev *mod, struct ican3_msg *msg)
 	 * error frame for userspace
 	 */
 	if (msg->spec == MSG_MSGLOST) {
-		dev_err(mod->dev, "lost %d control messages\n", msg->data[0]);
+		netdev_err(mod->ndev, "lost %d control messages\n", msg->data[0]);
 		return;
 	}
 
@@ -939,13 +936,13 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	/* we can only handle the SJA1000 part */
 	if (msg->data[1] != CEVTIND_CHIP_SJA1000) {
-		dev_err(mod->dev, "unable to handle errors on non-SJA1000\n");
+		netdev_err(mod->ndev, "unable to handle errors on non-SJA1000\n");
 		return -ENODEV;
 	}
 
 	/* check the message length for sanity */
 	if (le16_to_cpu(msg->len) < 6) {
-		dev_err(mod->dev, "error message too short\n");
+		netdev_err(mod->ndev, "error message too short\n");
 		return -EINVAL;
 	}
 
@@ -967,7 +964,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	 */
 	if (isrc == CEVTIND_BEI) {
 		int ret;
-		dev_dbg(mod->dev, "bus error interrupt\n");
+		netdev_dbg(mod->ndev, "bus error interrupt\n");
 
 		/* TX error */
 		if (!(ecc & ECC_DIR)) {
@@ -983,7 +980,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 		 */
 		ret = ican3_set_buserror(mod, 1);
 		if (ret) {
-			dev_err(mod->dev, "unable to re-enable bus-error\n");
+			netdev_err(mod->ndev, "unable to re-enable bus-error\n");
 			return ret;
 		}
 
@@ -998,7 +995,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	/* data overrun interrupt */
 	if (isrc == CEVTIND_DOI || isrc == CEVTIND_LOST) {
-		dev_dbg(mod->dev, "data overrun interrupt\n");
+		netdev_dbg(mod->ndev, "data overrun interrupt\n");
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_over_errors++;
@@ -1007,7 +1004,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	/* error warning + passive interrupt */
 	if (isrc == CEVTIND_EI) {
-		dev_dbg(mod->dev, "error warning + passive interrupt\n");
+		netdev_dbg(mod->ndev, "error warning + passive interrupt\n");
 		if (status & SR_BS) {
 			state = CAN_STATE_BUS_OFF;
 			cf->can_id |= CAN_ERR_BUSOFF;
@@ -1088,7 +1085,7 @@ static void ican3_handle_inquiry(struct ican3_dev *mod, struct ican3_msg *msg)
 		complete(&mod->termination_comp);
 		break;
 	default:
-		dev_err(mod->dev, "received an unknown inquiry response\n");
+		netdev_err(mod->ndev, "received an unknown inquiry response\n");
 		break;
 	}
 }
@@ -1096,7 +1093,7 @@ static void ican3_handle_inquiry(struct ican3_dev *mod, struct ican3_msg *msg)
 static void ican3_handle_unknown_message(struct ican3_dev *mod,
 					struct ican3_msg *msg)
 {
-	dev_warn(mod->dev, "received unknown message: spec 0x%.2x length %d\n",
+	netdev_warn(mod->ndev, "received unknown message: spec 0x%.2x length %d\n",
 			   msg->spec, le16_to_cpu(msg->len));
 }
 
@@ -1105,7 +1102,7 @@ static void ican3_handle_unknown_message(struct ican3_dev *mod,
  */
 static void ican3_handle_message(struct ican3_dev *mod, struct ican3_msg *msg)
 {
-	dev_dbg(mod->dev, "%s: modno %d spec 0x%.2x len %d bytes\n", __func__,
+	netdev_dbg(mod->ndev, "%s: modno %d spec 0x%.2x len %d bytes\n", __func__,
 			   mod->num, msg->spec, le16_to_cpu(msg->len));
 
 	switch (msg->spec) {
@@ -1406,7 +1403,7 @@ static int ican3_reset_module(struct ican3_dev *mod)
 		msleep(10);
 	} while (time_before(jiffies, start + HZ / 4));
 
-	dev_err(mod->dev, "failed to reset CAN module\n");
+	netdev_err(mod->ndev, "failed to reset CAN module\n");
 	return -ETIMEDOUT;
 }
 
@@ -1425,7 +1422,7 @@ static int ican3_startup_module(struct ican3_dev *mod)
 
 	ret = ican3_reset_module(mod);
 	if (ret) {
-		dev_err(mod->dev, "unable to reset module\n");
+		netdev_err(mod->ndev, "unable to reset module\n");
 		return ret;
 	}
 
@@ -1434,41 +1431,41 @@ static int ican3_startup_module(struct ican3_dev *mod)
 
 	ret = ican3_msg_connect(mod);
 	if (ret) {
-		dev_err(mod->dev, "unable to connect to module\n");
+		netdev_err(mod->ndev, "unable to connect to module\n");
 		return ret;
 	}
 
 	ican3_init_new_host_interface(mod);
 	ret = ican3_msg_newhostif(mod);
 	if (ret) {
-		dev_err(mod->dev, "unable to switch to new-style interface\n");
+		netdev_err(mod->ndev, "unable to switch to new-style interface\n");
 		return ret;
 	}
 
 	/* default to "termination on" */
 	ret = ican3_set_termination(mod, true);
 	if (ret) {
-		dev_err(mod->dev, "unable to enable termination\n");
+		netdev_err(mod->ndev, "unable to enable termination\n");
 		return ret;
 	}
 
 	/* default to "bus errors enabled" */
 	ret = ican3_set_buserror(mod, 1);
 	if (ret) {
-		dev_err(mod->dev, "unable to set bus-error\n");
+		netdev_err(mod->ndev, "unable to set bus-error\n");
 		return ret;
 	}
 
 	ican3_init_fast_host_interface(mod);
 	ret = ican3_msg_fasthostif(mod);
 	if (ret) {
-		dev_err(mod->dev, "unable to switch to fast host interface\n");
+		netdev_err(mod->ndev, "unable to switch to fast host interface\n");
 		return ret;
 	}
 
 	ret = ican3_set_id_filter(mod, true);
 	if (ret) {
-		dev_err(mod->dev, "unable to set acceptance filter\n");
+		netdev_err(mod->ndev, "unable to set acceptance filter\n");
 		return ret;
 	}
 
@@ -1487,14 +1484,14 @@ static int ican3_open(struct net_device *ndev)
 	/* open the CAN layer */
 	ret = open_candev(ndev);
 	if (ret) {
-		dev_err(mod->dev, "unable to start CAN layer\n");
+		netdev_err(mod->ndev, "unable to start CAN layer\n");
 		return ret;
 	}
 
 	/* bring the bus online */
 	ret = ican3_set_bus_state(mod, true);
 	if (ret) {
-		dev_err(mod->dev, "unable to set bus-on\n");
+		netdev_err(mod->ndev, "unable to set bus-on\n");
 		close_candev(ndev);
 		return ret;
 	}
@@ -1518,7 +1515,7 @@ static int ican3_stop(struct net_device *ndev)
 	/* bring the bus offline, stop receiving packets */
 	ret = ican3_set_bus_state(mod, false);
 	if (ret) {
-		dev_err(mod->dev, "unable to set bus-off\n");
+		netdev_err(mod->ndev, "unable to set bus-off\n");
 		return ret;
 	}
 
@@ -1545,7 +1542,7 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* check that we can actually transmit */
 	if (!ican3_txok(mod)) {
-		dev_err(mod->dev, "BUG: no free descriptors\n");
+		netdev_err(mod->ndev, "BUG: no free descriptors\n");
 		spin_unlock_irqrestore(&mod->lock, flags);
 		return NETDEV_TX_BUSY;
 	}
@@ -1657,7 +1654,7 @@ static int ican3_set_mode(struct net_device *ndev, enum can_mode mode)
 	/* bring the bus online */
 	ret = ican3_set_bus_state(mod, true);
 	if (ret) {
-		dev_err(mod->dev, "unable to set bus-on\n");
+		netdev_err(ndev, "unable to set bus-on\n");
 		return ret;
 	}
 
@@ -1682,7 +1679,7 @@ static int ican3_get_berr_counter(const struct net_device *ndev,
 
 	ret = wait_for_completion_timeout(&mod->buserror_comp, HZ);
 	if (ret == 0) {
-		dev_info(mod->dev, "%s timed out\n", __func__);
+		netdev_info(mod->ndev, "%s timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
 
@@ -1708,7 +1705,7 @@ static ssize_t ican3_sysfs_show_term(struct device *dev,
 
 	ret = wait_for_completion_timeout(&mod->termination_comp, HZ);
 	if (ret == 0) {
-		dev_info(mod->dev, "%s timed out\n", __func__);
+		netdev_info(mod->ndev, "%s timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
 
@@ -1778,7 +1775,6 @@ static int ican3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ndev);
 	mod = netdev_priv(ndev);
 	mod->ndev = ndev;
-	mod->dev = &pdev->dev;
 	mod->num = pdata->modno;
 	netif_napi_add(ndev, &mod->napi, ican3_napi, ICAN3_RX_BUFFERS);
 	skb_queue_head_init(&mod->echoq);
-- 
1.9.0


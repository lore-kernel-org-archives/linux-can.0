From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] can sja1000: Only create requested error messages
Date: Sat, 07 Dec 2013 17:06:47 +0100
Message-ID: <52A34797.8090305@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:51062 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3LGQGu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Dec 2013 11:06:50 -0500
Received: from [192.168.178.64] (p5B0B0F28.dip0.t-ipconnect.de [91.11.15.40])
	by smtp.strato.de (RZmta 32.17 DYNA|AUTH)
	with (TLSv1:DHE-RSA-AES256-SHA encrypted) ESMTPSA id i06753pB7G6l9pD
	for <linux-can@vger.kernel.org>; Sat, 7 Dec 2013 17:06:47 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is a proof of concept for the SJA1000 only.

Idea: Only create error message skbuffs when there is a request from a CAN
application which sets a filter for error messages.

Drawback: can.ko has to be available in the system to access the CAN filter
structures. This is usually the case. Alternatively the filter structures
could be made in linux/include/can/core.h instead of only providing a new
function can_dev_has_error_filter() there.
Don't know if this is 'nice design' then ?!?

Regards,
Oliver

---

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index bda1888..a5ea838 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -25,6 +25,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
+#include <linux/can/core.h> /* only for can_dev_error_has_filter() */
 #include <linux/can/netlink.h>
 #include <linux/can/led.h>
 #include <net/rtnetlink.h>
@@ -537,6 +538,12 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
 
+bool can_need_error_skb(struct net_device *dev)
+{
+	return can_dev_has_error_filter(dev);
+}
+EXPORT_SYMBOL_GPL(can_need_error_skb);
+
 /*
  * Allocate and setup space for the CAN network device
  */
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index f17c301..e894ae9 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -379,19 +379,24 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	struct sja1000_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	enum can_state state = priv->can.state;
 	uint8_t ecc, alc;
+	bool errmsg = can_need_error_skb(dev);
 
-	skb = alloc_can_err_skb(dev, &cf);
-	if (skb == NULL)
-		return -ENOMEM;
+	if (errmsg) {
+		skb = alloc_can_err_skb(dev, &cf);
+		if (!skb)
+			return -ENOMEM;
+	}
 
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		if (errmsg) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
@@ -403,7 +408,10 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 		if (status & SR_BS) {
 			state = CAN_STATE_BUS_OFF;
-			cf->can_id |= CAN_ERR_BUSOFF;
+
+			if (errmsg)
+				cf->can_id |= CAN_ERR_BUSOFF;
+
 			can_bus_off(dev);
 		} else if (status & SR_ES) {
 			state = CAN_STATE_ERROR_WARNING;
@@ -417,26 +425,29 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
 		ecc = priv->read_reg(priv, SJA1000_ECC);
 
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-		switch (ecc & ECC_MASK) {
-		case ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			cf->data[2] |= CAN_ERR_PROT_UNSPEC;
-			cf->data[3] = ecc & ECC_SEG;
-			break;
+		if (errmsg) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+			switch (ecc & ECC_MASK) {
+			case ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				cf->data[2] |= CAN_ERR_PROT_UNSPEC;
+				cf->data[3] = ecc & ECC_SEG;
+				break;
+			}
+
+			/* Error occurred during transmission? */
+			if ((ecc & ECC_DIR) == 0)
+				cf->data[2] |= CAN_ERR_PROT_TX;
 		}
-		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
 	}
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
@@ -452,36 +463,54 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		alc = priv->read_reg(priv, SJA1000_ALC);
 		priv->can.can_stats.arbitration_lost++;
 		stats->tx_errors++;
-		cf->can_id |= CAN_ERR_LOSTARB;
-		cf->data[0] = alc & 0x1f;
+		if (errmsg) {
+			cf->can_id |= CAN_ERR_LOSTARB;
+			cf->data[0] = alc & 0x1f;
+		}
 	}
 
-	if (state != priv->can.state && (state == CAN_STATE_ERROR_WARNING ||
-					 state == CAN_STATE_ERROR_PASSIVE)) {
-		uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
-		uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
-		cf->can_id |= CAN_ERR_CRTL;
-		if (state == CAN_STATE_ERROR_WARNING) {
-			priv->can.can_stats.error_warning++;
-			cf->data[1] = (txerr > rxerr) ?
-				CAN_ERR_CRTL_TX_WARNING :
-				CAN_ERR_CRTL_RX_WARNING;
-		} else {
-			priv->can.can_stats.error_passive++;
+	if (state != priv->can.state && state == CAN_STATE_ERROR_PASSIVE) {
+
+		if (errmsg) {
+			uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
+			uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
+
+			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] = (txerr > rxerr) ?
 				CAN_ERR_CRTL_TX_PASSIVE :
 				CAN_ERR_CRTL_RX_PASSIVE;
+
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
+		}
+		priv->can.can_stats.error_passive++;
+	}
+
+	if (state != priv->can.state && state == CAN_STATE_ERROR_WARNING) {
+
+		if (errmsg) {
+			uint8_t rxerr = priv->read_reg(priv, SJA1000_RXERR);
+			uint8_t txerr = priv->read_reg(priv, SJA1000_TXERR);
+
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = (txerr > rxerr) ?
+				CAN_ERR_CRTL_TX_WARNING :
+				CAN_ERR_CRTL_RX_WARNING;
+
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
 		}
-		cf->data[6] = txerr;
-		cf->data[7] = rxerr;
+		priv->can.can_stats.error_warning++;
 	}
 
 	priv->can.state = state;
 
-	netif_rx(skb);
+	if (errmsg) {
+		netif_rx(skb);
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+	}
 
 	return 0;
 }
diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index 78c6c52..2b6e01a 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -57,5 +57,6 @@ extern void can_rx_unregister(struct net_device *dev, canid_t can_id,
 
 extern int can_send(struct sk_buff *skb, int loop);
 extern int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
+extern bool can_dev_has_error_filter(struct net_device *dev);
 
 #endif /* CAN_CORE_H */
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..5c72b20 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -126,5 +126,6 @@ void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
+bool can_need_error_skb(struct net_device *dev);
 
 #endif /* CAN_DEV_H */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index d249874..cf6d701 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -328,6 +328,20 @@ EXPORT_SYMBOL(can_send);
  * af_can rx path
  */
 
+bool can_dev_has_error_filter(struct net_device *dev)
+{
+	if (dev) {
+		struct dev_rcv_lists *rcvlist;
+
+		rcvlist = (struct dev_rcv_lists *)dev->ml_priv;
+		if (&rcvlist->rx[RX_ERR] != NULL ||
+		    &can_rx_alldev_list.rx[RX_ERR] != NULL)
+			return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL(can_dev_has_error_filter);
+
 static struct dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
 {
 	if (!dev)

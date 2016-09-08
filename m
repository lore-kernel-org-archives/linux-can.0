From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH v4] can: sja1000: Optimise register accesses
Date: Thu,  8 Sep 2016 16:51:01 +0300
Message-ID: <20160908135101.17978-1-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35815 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbcIHNwW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Sep 2016 09:52:22 -0400
Received: by mail-lf0-f68.google.com with SMTP id s64so1352925lfs.2
        for <linux-can@vger.kernel.org>; Thu, 08 Sep 2016 06:52:21 -0700 (PDT)
Received: from latitude.int.redlab-i.ru (master.redlab-i.ru. [195.16.34.154])
        by smtp.gmail.com with ESMTPSA id 41sm2197350ljb.37.2016.09.08.06.52.18
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 06:52:18 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
instead of consecutive ioread8()/iowrite8() calls seems reasonable.

Thus, this patch introduces [read|write]_reg_rep() interface functions
that are used to read/write CAN ID and payload data.

  * For plx_pci driver this interface is implemented as
    plx_pci_[read|write]_reg_rep() that use ioread32()/iowrite32() for
    register accesses as much as possible to improve driver performance.

  * For other drivers the default implementation,
    sja1000_[read|write]_reg_rep(), is used for now. These functions
    still access registers in a series of ioread8()/iowrite8() calls.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 drivers/net/can/sja1000/plx_pci.c | 38 +++++++++++++++++++++++++++
 drivers/net/can/sja1000/sja1000.c | 55 ++++++++++++++++++++++++---------------
 drivers/net/can/sja1000/sja1000.h |  4 +++
 3 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 3eb7430..ff2858f 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -371,6 +371,42 @@ static void plx_pci_write_reg(const struct sja1000_priv *priv, int port, u8 val)
 	iowrite8(val, priv->reg_base + port);
 }
 
+static void plx_pci_read_reg_rep(const struct sja1000_priv *priv, int reg,
+                                 u8 *buffer, size_t count)
+{
+	while (count >= 4) {
+		*(__le32 *)buffer = cpu_to_le32(ioread32(priv->reg_base + reg));
+		buffer += 4;
+		reg += 4;
+		count -= 4;
+	}
+	if (count & 2) {
+		*(__le16 *)buffer = cpu_to_le16(ioread16(priv->reg_base + reg));
+		buffer += 2;
+		reg += 2;
+	}
+	if (count & 1)
+		*buffer = ioread8(priv->reg_base + reg);
+}
+
+static void plx_pci_write_reg_rep(const struct sja1000_priv *priv, int reg,
+                                  const u8 *buffer, size_t count)
+{
+	while (count >= 4) {
+		iowrite32(le32_to_cpu(*(__le32 *)buffer), priv->reg_base + reg);
+		buffer += 4;
+		reg += 4;
+		count -= 4;
+	}
+	if (count & 2) {
+		iowrite16(le16_to_cpu(*(__le16 *)buffer), priv->reg_base + reg);
+		buffer += 2;
+		reg += 2;
+	}
+	if (count & 1)
+		iowrite8(*buffer, priv->reg_base + reg);
+}
+
 /*
  * Check if a CAN controller is present at the specified location
  * by trying to switch 'em from the Basic mode into the PeliCAN mode.
@@ -626,6 +662,8 @@ static int plx_pci_add_card(struct pci_dev *pdev,
 		priv->reg_base = addr + cm->offset;
 		priv->read_reg = plx_pci_read_reg;
 		priv->write_reg = plx_pci_write_reg;
+		priv->read_reg_rep = plx_pci_read_reg_rep;
+		priv->write_reg_rep = plx_pci_write_reg_rep;
 
 		/* Check if channel is present */
 		if (plx_pci_check_sja1000(priv)) {
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 9f10779..ff046f3 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -82,6 +82,24 @@ static const struct can_bittiming_const sja1000_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static void sja1000_read_reg_rep(const struct sja1000_priv *priv, int reg,
+                                 u8 *buffer, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		buffer[i] = priv->read_reg(priv, reg + i);
+}
+
+static void sja1000_write_reg_rep(const struct sja1000_priv *priv, int reg,
+                                  const u8 *buffer, size_t count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		priv->write_reg(priv, reg + i, buffer[i]);
+}
+
 static void sja1000_write_cmdreg(struct sja1000_priv *priv, u8 val)
 {
 	unsigned long flags;
@@ -288,7 +306,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	canid_t id;
 	uint8_t dreg;
 	u8 cmd_reg_val = 0x00;
-	int i;
+	u8 id_buf[4];
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
@@ -305,19 +323,16 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 		fi |= SJA1000_FI_FF;
 		dreg = SJA1000_EFF_BUF;
 		priv->write_reg(priv, SJA1000_FI, fi);
-		priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
-		priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
-		priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
-		priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
+		*(__be32 *)id_buf = cpu_to_be32(id << 3);
+		priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 4);
 	} else {
 		dreg = SJA1000_SFF_BUF;
 		priv->write_reg(priv, SJA1000_FI, fi);
-		priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >> 3);
-		priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) << 5);
+		*(__be16 *)id_buf = cpu_to_be16(id << 5);
+		priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 2);
 	}
 
-	for (i = 0; i < dlc; i++)
-		priv->write_reg(priv, dreg++, cf->data[i]);
+	priv->write_reg_rep(priv, dreg, cf->data, dlc);
 
 	can_put_echo_skb(skb, dev, 0);
 
@@ -343,7 +358,7 @@ static void sja1000_rx(struct net_device *dev)
 	uint8_t fi;
 	uint8_t dreg;
 	canid_t id;
-	int i;
+	u8 id_buf[4];
 
 	/* create zero'ed CAN frame buffer */
 	skb = alloc_can_skb(dev, &cf);
@@ -355,25 +370,21 @@ static void sja1000_rx(struct net_device *dev)
 	if (fi & SJA1000_FI_FF) {
 		/* extended frame format (EFF) */
 		dreg = SJA1000_EFF_BUF;
-		id = (priv->read_reg(priv, SJA1000_ID1) << 21)
-		    | (priv->read_reg(priv, SJA1000_ID2) << 13)
-		    | (priv->read_reg(priv, SJA1000_ID3) << 5)
-		    | (priv->read_reg(priv, SJA1000_ID4) >> 3);
+		priv->read_reg_rep(priv, SJA1000_ID1, id_buf, 4);
+		id = be32_to_cpu(*(__be32 *)id_buf) >> 3;
 		id |= CAN_EFF_FLAG;
 	} else {
 		/* standard frame format (SFF) */
 		dreg = SJA1000_SFF_BUF;
-		id = (priv->read_reg(priv, SJA1000_ID1) << 3)
-		    | (priv->read_reg(priv, SJA1000_ID2) >> 5);
+		priv->read_reg_rep(priv, SJA1000_ID1, id_buf, 2);
+		id = be16_to_cpu(*(__be16 *)id_buf) >> 5;
 	}
 
 	cf->can_dlc = get_can_dlc(fi & 0x0F);
-	if (fi & SJA1000_FI_RTR) {
+	if (fi & SJA1000_FI_RTR)
 		id |= CAN_RTR_FLAG;
-	} else {
-		for (i = 0; i < cf->can_dlc; i++)
-			cf->data[i] = priv->read_reg(priv, dreg++);
-	}
+	else
+		priv->read_reg_rep(priv, dreg, cf->data, cf->can_dlc);
 
 	cf->can_id = id;
 
@@ -639,6 +650,8 @@ struct net_device *alloc_sja1000dev(int sizeof_priv)
 				       CAN_CTRLMODE_ONE_SHOT |
 				       CAN_CTRLMODE_BERR_REPORTING |
 				       CAN_CTRLMODE_PRESUME_ACK;
+	priv->read_reg_rep = sja1000_read_reg_rep;
+	priv->write_reg_rep = sja1000_write_reg_rep;
 
 	spin_lock_init(&priv->cmdreg_lock);
 
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 9d46398..68d5e5f 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -157,6 +157,10 @@ struct sja1000_priv {
 	/* the lower-layer is responsible for appropriate locking */
 	u8 (*read_reg) (const struct sja1000_priv *priv, int reg);
 	void (*write_reg) (const struct sja1000_priv *priv, int reg, u8 val);
+	void (*read_reg_rep) (const struct sja1000_priv *priv, int reg,
+	                      u8 *buffer, size_t count);
+	void (*write_reg_rep) (const struct sja1000_priv *priv, int reg,
+	                       const u8 *buffer, size_t count);
 	void (*pre_irq) (const struct sja1000_priv *priv);
 	void (*post_irq) (const struct sja1000_priv *priv);
 
-- 
2.9.3


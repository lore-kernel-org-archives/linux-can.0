From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH v2] can: sja1000: Optimise register accesses
Date: Wed,  7 Sep 2016 13:38:52 +0300
Message-ID: <20160907103852.28795-1-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36736 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757390AbcIGKkR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Sep 2016 06:40:17 -0400
Received: by mail-lf0-f67.google.com with SMTP id j41so593602lfi.3
        for <linux-can@vger.kernel.org>; Wed, 07 Sep 2016 03:40:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2168:c20:3f01:8219:34ff:fe1f:3777])
        by smtp.gmail.com with ESMTPSA id e79sm6375457lji.42.2016.09.07.03.40.13
        for <linux-can@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 03:40:14 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Since PCI bus width is at least 32 bits, using ioread32()/iowrite32()
instead of consecutive ioread8()/iowrite8() calls seems reasonable.

Thus, this patch introduces plx_pci_read_reg_rep() and
plx_pci_write_reg_rep() functions that use ioread32()/iowrite32() for
register accesses as much as possible. The functions are then used to
read/write CAN ID and payload data to improve driver performance.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 drivers/net/can/sja1000/plx_pci.c | 42 ++++++++++++++++++++++++++
 drivers/net/can/sja1000/sja1000.c | 62 +++++++++++++++++++++++++++++----------
 drivers/net/can/sja1000/sja1000.h |  4 +++
 3 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index 3eb7430..c319bbe 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -371,6 +371,46 @@ static void plx_pci_write_reg(const struct sja1000_priv *priv, int port, u8 val)
 	iowrite8(val, priv->reg_base + port);
 }
 
+static void plx_pci_read_reg_rep(const struct sja1000_priv *priv, int reg,
+                                 void *buffer, unsigned long count)
+{
+	u8 *p = buffer;
+
+	while (count >= 4) {
+		*(u32 *)p = cpu_to_le32(ioread32(priv->reg_base + reg));
+		p += 4;
+		reg += 4;
+		count -= 4;
+	}
+	if (count & 2) {
+		*(u16 *)p = cpu_to_le16(ioread16(priv->reg_base + reg));
+		p += 2;
+		reg += 2;
+	}
+	if (count & 1)
+		*p = ioread8(priv->reg_base + reg);
+}
+
+static void plx_pci_write_reg_rep(const struct sja1000_priv *priv, int reg,
+                                  const void *buffer, unsigned long count)
+{
+	const u8 *p = buffer;
+
+	while (count >= 4) {
+		iowrite32(le32_to_cpu(*(u32 *)p), priv->reg_base + reg);
+		p += 4;
+		reg += 4;
+		count -= 4;
+	}
+	if (count & 2) {
+		iowrite16(le16_to_cpu(*(u16 *)p), priv->reg_base + reg);
+		p += 2;
+		reg += 2;
+	}
+	if (count & 1)
+		iowrite8(*p, priv->reg_base + reg);
+}
+
 /*
  * Check if a CAN controller is present at the specified location
  * by trying to switch 'em from the Basic mode into the PeliCAN mode.
@@ -626,6 +666,8 @@ static int plx_pci_add_card(struct pci_dev *pdev,
 		priv->reg_base = addr + cm->offset;
 		priv->read_reg = plx_pci_read_reg;
 		priv->write_reg = plx_pci_write_reg;
+		priv->read_reg_rep = plx_pci_read_reg_rep;
+		priv->write_reg_rep = plx_pci_write_reg_rep;
 
 		/* Check if channel is present */
 		if (plx_pci_check_sja1000(priv)) {
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 9f10779..ca1766d 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -288,6 +288,7 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 	canid_t id;
 	uint8_t dreg;
 	u8 cmd_reg_val = 0x00;
+	u8 id_buf[4];
 	int i;
 
 	if (can_dropped_invalid_skb(dev, skb))
@@ -305,19 +306,33 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 		fi |= SJA1000_FI_FF;
 		dreg = SJA1000_EFF_BUF;
 		priv->write_reg(priv, SJA1000_FI, fi);
-		priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
-		priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
-		priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
-		priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
+		if (priv->write_reg_rep) {
+			*(u32 *)id_buf = cpu_to_be32(id << 3);
+			priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 4);
+		} else {
+			priv->write_reg(priv, SJA1000_ID1, (id & 0x1fe00000) >> 21);
+			priv->write_reg(priv, SJA1000_ID2, (id & 0x001fe000) >> 13);
+			priv->write_reg(priv, SJA1000_ID3, (id & 0x00001fe0) >> 5);
+			priv->write_reg(priv, SJA1000_ID4, (id & 0x0000001f) << 3);
+		}
 	} else {
 		dreg = SJA1000_SFF_BUF;
 		priv->write_reg(priv, SJA1000_FI, fi);
-		priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >> 3);
-		priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) << 5);
+		if (priv->write_reg_rep) {
+			*(u16 *)id_buf = cpu_to_be16(id << 5);
+			priv->write_reg_rep(priv, SJA1000_ID1, id_buf, 2);
+		} else {
+			priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >> 3);
+			priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) << 5);
+		}
 	}
 
-	for (i = 0; i < dlc; i++)
-		priv->write_reg(priv, dreg++, cf->data[i]);
+	if (priv->write_reg_rep) {
+		priv->write_reg_rep(priv, dreg, cf->data, dlc);
+	} else {
+		for (i = 0; i < dlc; i++)
+			priv->write_reg(priv, dreg++, cf->data[i]);
+	}
 
 	can_put_echo_skb(skb, dev, 0);
 
@@ -343,6 +358,7 @@ static void sja1000_rx(struct net_device *dev)
 	uint8_t fi;
 	uint8_t dreg;
 	canid_t id;
+	u8 id_buf[4];
 	int i;
 
 	/* create zero'ed CAN frame buffer */
@@ -355,24 +371,38 @@ static void sja1000_rx(struct net_device *dev)
 	if (fi & SJA1000_FI_FF) {
 		/* extended frame format (EFF) */
 		dreg = SJA1000_EFF_BUF;
-		id = (priv->read_reg(priv, SJA1000_ID1) << 21)
-		    | (priv->read_reg(priv, SJA1000_ID2) << 13)
-		    | (priv->read_reg(priv, SJA1000_ID3) << 5)
-		    | (priv->read_reg(priv, SJA1000_ID4) >> 3);
+		if (priv->read_reg_rep) {
+			priv->read_reg_rep(priv, SJA1000_ID1, id_buf, 4);
+			id = be32_to_cpu(*(u32 *)id_buf) >> 3;
+		} else {
+			id = (priv->read_reg(priv, SJA1000_ID1) << 21)
+			    | (priv->read_reg(priv, SJA1000_ID2) << 13)
+			    | (priv->read_reg(priv, SJA1000_ID3) << 5)
+			    | (priv->read_reg(priv, SJA1000_ID4) >> 3);
+		}
 		id |= CAN_EFF_FLAG;
 	} else {
 		/* standard frame format (SFF) */
 		dreg = SJA1000_SFF_BUF;
-		id = (priv->read_reg(priv, SJA1000_ID1) << 3)
-		    | (priv->read_reg(priv, SJA1000_ID2) >> 5);
+		if (priv->read_reg_rep) {
+			priv->read_reg_rep(priv, SJA1000_ID1, id_buf, 2);
+			id = be16_to_cpu(*(u16 *)id_buf) >> 5;
+		} else {
+			id = (priv->read_reg(priv, SJA1000_ID1) << 3)
+			    | (priv->read_reg(priv, SJA1000_ID2) >> 5);
+		}
 	}
 
 	cf->can_dlc = get_can_dlc(fi & 0x0F);
 	if (fi & SJA1000_FI_RTR) {
 		id |= CAN_RTR_FLAG;
 	} else {
-		for (i = 0; i < cf->can_dlc; i++)
-			cf->data[i] = priv->read_reg(priv, dreg++);
+		if (priv->read_reg_rep) {
+			priv->read_reg_rep(priv, dreg, cf->data, cf->can_dlc);
+		} else {
+			for (i = 0; i < cf->can_dlc; i++)
+				cf->data[i] = priv->read_reg(priv, dreg++);
+		}
 	}
 
 	cf->can_id = id;
diff --git a/drivers/net/can/sja1000/sja1000.h b/drivers/net/can/sja1000/sja1000.h
index 9d46398..887045a 100644
--- a/drivers/net/can/sja1000/sja1000.h
+++ b/drivers/net/can/sja1000/sja1000.h
@@ -157,6 +157,10 @@ struct sja1000_priv {
 	/* the lower-layer is responsible for appropriate locking */
 	u8 (*read_reg) (const struct sja1000_priv *priv, int reg);
 	void (*write_reg) (const struct sja1000_priv *priv, int reg, u8 val);
+	void (*read_reg_rep) (const struct sja1000_priv *priv, int reg,
+	                      void *buffer, unsigned long count);
+	void (*write_reg_rep) (const struct sja1000_priv *priv, int reg,
+	                       const void *buffer, unsigned long count);
 	void (*pre_irq) (const struct sja1000_priv *priv);
 	void (*post_irq) (const struct sja1000_priv *priv);
 
-- 
2.9.3


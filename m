Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A83128AE;
	Mon, 16 Feb 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250044; cv=none; b=OgGY5wtJ7fAyoaoL0hTzzqP3nUCTh6wBy097hZcVNnq96Z0GIE+7yGBoGtAOzisKRkXb/tT8q+RlPKVItrsZud4KLS4yotWrDJkd3A1BHClfJTOCgcrXrvZsvXKUIgDKwcW+ATn2+y4Fkze/RrheWte0Z5M1aAB9/yKT6DrRJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250044; c=relaxed/simple;
	bh=B0GLMV3cesPSPsRvbU9Pd3edbTphbbQyXzi59Q1AC2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6xMtZOtRh97Yaln50rtw9mpd76oG9W3yKPM4n5XyYl1kNeiHunZTq55PjocJ87mdXTL06lyK96BgXee3TP8OQlpycq7frBIO22HM8i6hM3I3Zj7tJqLkDD3SLgAIKeobsKm5roq+9dpDxEWfQp+M6mD2AVZm/uBNOTnPRwU/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=XZEnnFCe reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="XZEnnFCe"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44c40V4z1Fbwj;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44c246Bz1FbwS;
	Mon, 16 Feb 2026 14:53:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250032;
	bh=iRnFF5nLsoP6t6Q6GFyPF3u3sSqHl56MO1l7XvWk6zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XZEnnFCegugmjAhmWYvjfJq6L9cuy2TamapUSg6hsr1ms5LcTWVSX8xTwrMZTyp+r
	 n4z6jqVtG+XdXb26sPlrg6e1PNZbNPrYGyV81PVBHg0vGRD6zZ3cZUJ1PO4xx3I57e
	 gk2xXnG75iP6RWyK88nwxUZ3TLiDaNmb0pyeMsmnDAikfTQvSTfY83JwaNPuGITSvY
	 3Zwbb6i/RY6SFJHHFWgv5yvsTrGXE6igUR99B3e9MnvVbW2AWSAqHZH4r5wiU4xZG+
	 jYMlm7I8DGyrFfIwA45/DO+9C8ia3ZpNBmYk+y97PSGWCEn+n+YWDuBT81PHF8lWMk
	 ObWJbnft6WSKA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v5 14/16] can: grcan: Add CANFD RX support alongside legacy CAN
Date: Mon, 16 Feb 2026 14:53:42 +0100
Message-ID: <20260216135344.23246-15-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include CANFD RX support with the legacy CAN support, enabling
support for extended data payloads to provide higher bit rates.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 89 +++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ae9f6fd4c8bf..e54214f6112d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -235,6 +235,9 @@ struct grcan_registers {
 #define GRCAN_TX_BRS  BIT(25)
 #define GRCAN_TX_FDF  BIT(26)
 
+#define GRCAN_RX_BRS  BIT(25)
+#define GRCAN_RX_FDF  BIT(26)
+
 /* Hardware capabilities */
 struct grcan_hwcap {
 	/* CAN-FD capable, indicates GRCANFD IP.
@@ -1242,20 +1245,29 @@ static inline union grcan_msg_slot *grcan_tx_msg_slot(struct grcan_dma *dma, u32
 	return (union grcan_msg_slot *)((u8 *)dma->tx.msg_slot + off);
 }
 
+static inline union grcan_msg_slot *grcan_rx_msg_slot(struct grcan_dma *dma, u32 off)
+{
+	return (union grcan_msg_slot *)((u8 *)dma->rx.msg_slot + off);
+}
+
 static int grcan_receive(struct net_device *dev, int budget)
 {
+	struct net_device_stats *stats = &dev->stats;
 	struct grcan_priv *priv = netdev_priv(dev);
-	struct grcan_registers __iomem *regs = priv->regs;
+	struct grcan_registers __iomem *regs;
 	struct grcan_dma *dma = &priv->dma;
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
+	u32 bds, copy_len, payload_offset;
+	union grcan_msg_slot *msg;
+	u32 wr, rd, dlc, startrd;
+	struct canfd_frame *cf;
+	int i, work_done = 0;
 	struct sk_buff *skb;
-	u32 wr, rd, startrd;
-	u32 *slot;
 	u32 rtr, eff;
-	int work_done = 0;
+	u8 *data;
 
+	regs = priv->regs;
 	rd = grcan_read_reg(&regs->rxrd);
+
 	startrd = rd;
 	for (work_done = 0; work_done < budget; work_done++) {
 		/* Check for packet to receive */
@@ -1263,43 +1275,60 @@ static int grcan_receive(struct net_device *dev, int budget)
 		if (rd == wr)
 			break;
 
-		/* Take care of packet */
-		skb = alloc_can_skb(dev, &cf);
-		if (skb == NULL) {
-			netdev_err(dev,
-				   "dropping frame: skb allocation failed\n");
+		msg = grcan_rx_msg_slot(dma, rd);
+		if (msg->header.ctrl & GRCAN_RX_FDF)
+			skb = alloc_canfd_skb(dev, &cf);
+		else
+			skb = alloc_can_skb(dev, (struct can_frame **)&cf);
+
+		if (unlikely(!skb)) {
+			netdev_err(dev, "dropping frame: skb allocation failed\n");
 			stats->rx_dropped++;
 			continue;
 		}
 
-		slot = (u32 *)((u8 *)dma->rx.msg_slot + rd);
-		eff = slot[0] & GRCAN_MSG_IDE;
-		rtr = slot[0] & GRCAN_MSG_RTR;
+		dlc = FIELD_GET(GRCAN_MSG_DLC_MASK, msg->header.ctrl);
+		if (msg->header.ctrl & GRCAN_RX_FDF)
+			cf->len = can_fd_dlc2len(dlc);
+		else
+			cf->len = can_cc_dlc2len(dlc);
+
+		bds = grcan_numbds(cf->len);
+		payload_offset = 0;
+		data = cf->data;
+
+		eff = msg->header.id & GRCAN_MSG_IDE;
+		rtr = msg->header.id & GRCAN_MSG_RTR;
+
 		if (eff) {
-			cf->can_id = ((slot[0] & GRCAN_MSG_EID)
-				      >> GRCAN_MSG_EID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_EID_MASK, msg->header.id);
 			cf->can_id |= CAN_EFF_FLAG;
 		} else {
-			cf->can_id = ((slot[0] & GRCAN_MSG_BID)
-				      >> GRCAN_MSG_BID_BIT);
+			cf->can_id = FIELD_GET(GRCAN_MSG_BID_MASK, msg->header.id);
 		}
-		cf->len = can_cc_dlc2len((slot[1] & GRCAN_MSG_DLC)
-					  >> GRCAN_MSG_DLC_BIT);
-		if (rtr) {
+		if (rtr)
 			cf->can_id |= CAN_RTR_FLAG;
-		} else {
-			if (cf->can_dlc > 0)
-				memcpy(cf->data, &slot[2], sizeof(u32));
-			if (cf->can_dlc > 4)
-				memcpy(cf->data + 4, &slot[3], sizeof(u32));
 
-			stats->rx_bytes += cf->len;
+		copy_len = min_t(u32, cf->len, GRCAN_CLASSIC_DATA_SIZE);
+		memcpy(data, msg->header.data, copy_len);
+		payload_offset += copy_len;
+
+		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
+
+		for (i = 1; i < bds; i++) {
+			msg = grcan_rx_msg_slot(dma, rd);
+
+			copy_len = min_t(u32, (u32)cf->len - payload_offset, (u32)GRCAN_MSG_SIZE);
+			memcpy(data + payload_offset, msg->frags.data, copy_len);
+			payload_offset += copy_len;
+
+			rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 		}
-		stats->rx_packets++;
 
+		/* Update statistics and read pointer */
+		stats->rx_packets++;
+		stats->rx_bytes += cf->len;
 		netif_receive_skb(skb);
-
-		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}
 
 	/* Make sure everything is read before allowing hardware to
-- 
2.51.0


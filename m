Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7130449ECA;
	Thu, 22 Jan 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083865; cv=none; b=Id4p3i+zzPcdVAeS0pmU6Z6ttIe5InmnyaCF1j9Xe3EgBwLfnNth9Dwqp3yGKaERjMBzcWNxIMwpIdu74Yvrlr8TXLcsKw70MVO6jG8cIDagbTo4srK+iUpzObMDQ6C/tsYUkE3hPMPcb9rOovwazBRdYysr4YdTaPz4bkwCaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083865; c=relaxed/simple;
	bh=yzu11Z57nTas90/09+nK6ANfPzkmv2++yiMJl9jG0KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEYbaWxaOYWdpISLSIegXjsFnlPWip7NVqTHcym31Aoy8jDFbTlhDfN1y6qm2ajmQUNUQlrWUtYbylBxMBVYPPpxNXhaZbr1aNyhHarI1okyJcaV9B9v3upbC5w/eKibt7E+teFV78PGrvA8ic5mW/uRFxXbYRwwYBxzdLLSESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=oHwIpGZT reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="oHwIpGZT"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzG6Y8Rz1FlY3;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfzG4WSlz1FlY1;
	Thu, 22 Jan 2026 13:10:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083850;
	bh=Ifj/YMFPcPFEro+213ka+sB+HgXHGlvN61oSA9++Mfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHwIpGZTpG3v42jznLEsQ3TJ0pb5TXdBS4XK0RU35PzoPMSblXHduooaz6fPhK5w3
	 oLTUkxdRQA2eMehvMnk0JFUpjjsKy/WEyOJvOWwRSBDle3FsSbu2EJxEGor6WJYeuk
	 6FRVv49B4dMGvMnv6ne38k05XSaZ3bJk+dN1D9NuSO67CD2uPAqYUPWYnCnV8TYqO3
	 c56M8UUmEibv1x0mZcMLvrfQsFvbBtS+Fdu9NtuHj3DVXzYc5fSEm5oY9SR7XYDtn/
	 zRNJ1mkZnjo6lOGxVPZRuepQNaUTD3bY/V2s6Ktrj7k+9I/HXac1JF7yF0c4EfNnh7
	 C9Ov8n0LjTsKQ==
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
Subject: [PATCH v3 15/15] can: grcan: Update echo skb handling to match variable length CANFD frame
Date: Thu, 22 Jan 2026 13:10:38 +0100
Message-ID: <20260122121038.7910-16-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor echo socket buffer management by introducing dedicated indices
for current and next echo slots.

- Introduce "echo_skb_idx" to keep track of the current packet index in
  the echo buffer, and "next_echo_idx" for the next available slot.
- Adjust memory allocation for echo skb to calculate the number of slots
  based on slot size.
- Enhance logic in catch_up_echo_skb() to correctly process and free echo
  skbs.
- Initialize "next_echo_idx" in grcan_set_mode() to ensure proper starting
  conditions when the device enters proper modes.
- Improve memory and index handling in grcan_start_xmit() and
  added a check to stop the network queue when necessary.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 drivers/net/can/grcan.c | 51 ++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 39afb12c50d0..22c86e5d7002 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -298,6 +298,15 @@ struct grcan_priv {
 
 	struct sk_buff **echo_skb;	/* We allocate this on our own */
 
+	/*
+	 * Since the CAN FD frame has a variable length, this variable is used
+	 * to keep track of the index of the CAN echo skb (socket buffer) frame.
+	 */
+	u32 echo_skb_idx;
+
+	/* Next echo skb free slot index */
+	u32 next_echo_idx;
+
 	/* The echo skb pointer, pointing into echo_skb and indicating which
 	 * frames can be echoed back. See the "Notes on the tx cyclic buffer
 	 * handling"-comment for grcan_start_xmit for more details.
@@ -578,7 +587,7 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	struct grcan_registers __iomem *regs = priv->regs;
 	struct grcan_dma *dma = &priv->dma;
 	struct net_device_stats *stats = &dev->stats;
-	int i, work_done;
+	int work_done;
 
 	/* Updates to priv->eskbp and wake-ups of the queue needs to
 	 * be atomic towards the reads of priv->eskbp and shut-downs
@@ -589,19 +598,22 @@ static int catch_up_echo_skb(struct net_device *dev, int budget, bool echo)
 	for (work_done = 0; work_done < budget || budget < 0; work_done++) {
 		if (priv->eskbp == txrd)
 			break;
-		i = priv->eskbp / GRCAN_MSG_SIZE;
-		if (echo) {
-			/* Normal echo of messages */
-			stats->tx_packets++;
-			stats->tx_bytes += can_get_echo_skb(dev, i, NULL);
-		} else {
-			/* For cleanup of untransmitted messages */
-			can_free_echo_skb(dev, i, NULL);
-		}
 
 		priv->eskbp = grcan_ring_add(priv->eskbp, GRCAN_MSG_SIZE,
 					     dma->tx.size);
 		txrd = grcan_read_reg(&regs->txrd);
+
+		/* Grab the packet once the  packet is send or free untransmitted packet*/
+		if (priv->eskbp == txrd) {
+			if (echo) {
+				/* Normal echo of messages */
+				stats->tx_packets++;
+				stats->tx_bytes += can_get_echo_skb(dev, priv->echo_skb_idx, NULL);
+			} else {
+				/* For cleanup of untransmitted messages */
+				can_free_echo_skb(dev, priv->echo_skb_idx, NULL);
+			}
+		}
 	}
 	return work_done;
 }
@@ -1109,6 +1121,7 @@ static int grcan_set_mode(struct net_device *dev, enum can_mode mode)
 			if (!(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY))
 				netif_wake_queue(dev);
 		}
+		priv->next_echo_idx = 0;
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return err;
 	}
@@ -1120,6 +1133,7 @@ static int grcan_open(struct net_device *dev)
 	struct grcan_priv *priv = netdev_priv(dev);
 	struct grcan_dma *dma = &priv->dma;
 	unsigned long flags;
+	u32 nr_echo_slots;
 	int err;
 
 	/* Allocate memory */
@@ -1130,13 +1144,15 @@ static int grcan_open(struct net_device *dev)
 		return err;
 	}
 
-	priv->echo_skb = kcalloc(dma->tx.size, sizeof(*priv->echo_skb),
+	nr_echo_slots =  dma->tx.size / GRCAN_MSG_SIZE;
+
+	priv->echo_skb = kcalloc(nr_echo_slots, sizeof(*priv->echo_skb),
 				 GFP_KERNEL);
 	if (!priv->echo_skb) {
 		err = -ENOMEM;
 		goto exit_free_dma_buffers;
 	}
-	priv->can.echo_skb_max = dma->tx.size;
+	priv->can.echo_skb_max = nr_echo_slots;
 	priv->can.echo_skb = priv->echo_skb;
 
 	/* Get can device up */
@@ -1575,7 +1591,16 @@ static netdev_tx_t grcan_start_xmit(struct sk_buff *skb,
 	 * can_put_echo_skb would be an error unless other measures are
 	 * taken.
 	 */
-	can_put_echo_skb(skb, dev, slotindex, 0);
+
+	priv->echo_skb_idx = priv->next_echo_idx;
+
+	can_put_echo_skb(skb, dev, priv->next_echo_idx, 0);
+
+	/* Move to the next index in the echo skb buffer */
+	priv->next_echo_idx = (priv->next_echo_idx + 1) % priv->can.echo_skb_max;
+
+	if (priv->can.echo_skb[priv->echo_skb_idx])
+		netif_stop_queue(dev);
 
 	/* Make sure everything is written before allowing hardware to
 	 * read from the memory
-- 
2.51.0


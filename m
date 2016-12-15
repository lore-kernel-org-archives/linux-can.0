From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: ti hecc rx frames out of order
Date: Thu, 15 Dec 2016 08:45:18 +0100
Message-ID: <9271c254-c701-97e5-90de-356adafb96cb@grandegger.com>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
 <08de827f-0d1b-4523-0ed9-f0979345de87@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134942564@SSCOXCHG2.spray.com>
 <0b6dc834-db5b-a8e3-1461-f97c7c79ad44@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949AB3@SSCOXCHG2.spray.com>
 <83813a5e-b146-2763-1fb3-31d64fcebf4c@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949B2C@SSCOXCHG2.spray.com>
 <e49d562c-979e-ea1e-bdf1-3fc5b7a0926a@grandegger.com>
 <37dfc512-58de-535c-ed48-e5b9e67c748c@grandegger.com>
 <1579A5A5423CC14B827884B535F8E9513494B0BC@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.150]:37744 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755173AbcLOHp0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 15 Dec 2016 02:45:26 -0500
In-Reply-To: <1579A5A5423CC14B827884B535F8E9513494B0BC@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Denis,

Am 14.12.2016 um 19:44 schrieb Grim, Dennis:
... snip ...
>  
> Thank you Wolfgang.
> 
> I tried your second patch.  It did not correct the o-o-o issue.
> 
> Are there other ideas?
> 
> I am looking at ti_hecc.c.  The HECC and NAPI are new to me so my progress is slow.

OK. Then we need some instrumentation. The history of the mailbox
numbers would be interesting. The following patch may help to find
the problem:


diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index 7481c32..b04644d 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -115,7 +115,7 @@ MODULE_DEVICE_TABLE(pci, ems_pci_tbl);
 /*
  * Helper to read internal registers from card logic (not CAN)
  */
-static u8 ems_pci_v1_readb(struct ems_pci_card *card, unsigned int port)
+static u8 ems_pci_v1_readb(const struct ems_pci_card *card, unsigned int port)
 {
 	return readb(card->base_addr + (port * 4));
 }
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 680d1ff..1b823b6 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -532,15 +532,20 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, struct net_device *ndev)
 		netif_stop_queue(ndev);
 	}
 	hecc_set_bit(priv, HECC_CANME, mbx_mask);
-	spin_unlock_irqrestore(&priv->mbx_lock, flags);
 
 	hecc_clear_bit(priv, HECC_CANMD, mbx_mask);
 	hecc_set_bit(priv, HECC_CANMIM, mbx_mask);
+	spin_unlock_irqrestore(&priv->mbx_lock, flags);
 	hecc_write(priv, HECC_CANTRS, mbx_mask);
 
 	return NETDEV_TX_OK;
 }
 
+static RX_MBX_HIST_MAX 16
+static unsigned char rx_data0_last;
+static int rx_mbx_hist_idx;
+static int rx_mbx_history[RX_MBX_HIST_MAX];
+
 static int ti_hecc_rx_pkt(struct ti_hecc_priv *priv, int mbxno)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
@@ -573,6 +578,24 @@ static int ti_hecc_rx_pkt(struct ti_hecc_priv *priv, int mbxno)
 		data = hecc_read_mbx(priv, mbxno, HECC_CANMDH);
 		*(__be32 *)(cf->data + 4) = cpu_to_be32(data);
 	}
+
+	rx_mbx_history[rx_mbx_hist_idx++] = mbxno;
+	if (rx_mbx_hist_idx >= RX_MBX_HIST_MAX)
+		rx_mbx_hist_idx = 0;
+	
+	if (cf->can_id == 0x77) {
+		if (cf->data[0] != (rx_bx_last + 1)) {
+			int i;
+			pr_info("O-O at priv->rx_next = %d\n", priv->rx_next);
+			pr_info("rx_mbx_hist_idx = %d\n", rx_mbx_hist_idx);
+			for (i = 0; i < RX_MBX_HIST_MAX; i++)
+				pr_info("rx_mbx_history[%d] = %d\n",
+					i, rx_mbx_history[i]);
+			
+		}
+		rx_bx_last = cf->data[0];
+	}
+
 	spin_lock_irqsave(&priv->mbx_lock, flags);
 	hecc_clear_bit(priv, HECC_CANME, mbx_mask);
 	hecc_write(priv, HECC_CANRMP, mbx_mask);
@@ -649,9 +672,11 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 	if (hecc_read(priv, HECC_CANRMP) == 0) {
 		napi_complete(napi);
 		/* Re-enable RX mailbox interrupts */
+		spin_lock_irqsave(&priv->mbx_lock, flags);
 		mbx_mask = hecc_read(priv, HECC_CANMIM);
 		mbx_mask |= HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+		spin_unlock_irqrestore(&priv->mbx_lock, flags);
 	}
 
 	return num_pkts;
@@ -776,9 +801,9 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			mbx_mask = BIT(mbxno);
 			if (!(mbx_mask & hecc_read(priv, HECC_CANTA)))
 				break;
+			spin_lock_irqsave(&priv->mbx_lock, flags);
 			hecc_clear_bit(priv, HECC_CANMIM, mbx_mask);
 			hecc_write(priv, HECC_CANTA, mbx_mask);
-			spin_lock_irqsave(&priv->mbx_lock, flags);
 			hecc_clear_bit(priv, HECC_CANME, mbx_mask);
 			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			stats->tx_bytes += hecc_read_mbx(priv, mbxno,
@@ -798,9 +823,11 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 
 		/* Disable RX mailbox interrupts and let NAPI reenable them */
 		if (hecc_read(priv, HECC_CANRMP)) {
+			spin_lock_irqsave(&priv->mbx_lock, flags);
 			ack = hecc_read(priv, HECC_CANMIM);
 			ack &= BIT(HECC_MAX_TX_MBOX) - 1;
 			hecc_write(priv, HECC_CANMIM, ack);
+			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			napi_schedule(&priv->napi);
 		}
 	}

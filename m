Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC934F24A;
	Thu, 24 Sep 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261399; cv=none; b=neNCB04ve0pjE4+tsan1/j0zUUPKrX66J4Y5yXoNwfwG9GwNqqDobeHhYLpWuTo1PoP6Roe8freOTh//UyWLn8D2xTJ+IXNy+73o2F0RIGdsY8Al9Uo+ijy9Z3oT2ZKvvZ4/kdxdXG+K7tSGCLbuC1ehgsn49njKp9c6hzhxH6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261399; c=relaxed/simple;
	bh=D+IP4+4v7fnIPA9OmKnecZpBczuSIC/SdEFuJTJ/YHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZzsfKsYHoLZOgwTuIxG5dWivDKGk4y6W7YqIBqI+LGzsK8Jgpuh++sOZxiISuRtDxiFMU/O8BbQ6par+TX2awifp0D84e7JNHolHmvVmqdIw9k/iBKVgqs2PrSmhgYtib7cYGcej7ano84/fOZSX9hKrvj5ez7a5ADzr9hkv7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=vFtyYAgC; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="vFtyYAgC"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id ADDB2780514;
	Thu, 24 Sep 2026 16:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790261393;
	bh=D+IP4+4v7fnIPA9OmKnecZpBczuSIC/SdEFuJTJ/YHc=;
	h=From:Date:Subject:To:Cc:From;
	b=vFtyYAgCkhz1GQ/jOSG4KWSIiG3+OZakHdmvvz1xZNxxL4UZfkVYZ7LbjnbDQcXrr
	 YzImAIaawjgpKaYMAQvb/WAQXWkI3dmsLCSHgFtXJVAv+RoPnXYtA3MaQ2fYq74JJj
	 XNfzE8XjnBaznjGN4bVIhk9kp/YD7kMHuuvEPHKRBb4NcAHoOzG9bAjP5AtRaHQpdh
	 MModZUJbs5M0rPwC90CaZpsyan7DLN0/uQ9XneOLUm7ugpWXOO6teq5QyaKd2uf/gU
	 0iU8SDV3deywbfg7r037KsqDV54BguUwepjaKg7Uw75LUFIEAQn1LtErtjSwWyYkW6
	 /w3/Om1E+DP/A==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Thu, 24 Sep 2026 16:49:25 +0200
Subject: [PATCH] can: peak_usb: Add PCAN-USB bus errors reporting
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-peak_usb-v1-1-d48875169a59@peak-system.fr>
X-B4-Tracking: v=1; b=H4sIAHQ4tWoC/yXM7QpAQBCF4VvR/La1Nl/rViQtZhkK7SAl927x8
 6n3nAsYHSFDEVzg8CCmZfaIwgDawcw9Cuq8QUmVSq1isaKZ6p0bkXR5KjNjI6s1+Hx1aOn8rsr
 qN+/NiO327uG+H84P98BsAAAA
X-Change-ID: 20260924-peak_usb-5d8607af1f99
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.16.0

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The good old PCAN-USB was missing CAN bus error reporting. This patch fixes
that.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 101 ++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..e5be07f3dd54 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -115,6 +115,7 @@
 #define PCAN_USB_REC_BUSEVT		5
 
 /* CAN bus events notifications selection mask */
+#define PCAN_USB_ERR_ECC		0x01	/* ask for BERR */
 #define PCAN_USB_ERR_RXERR		0x02	/* ask for rxerr counter */
 #define PCAN_USB_ERR_TXERR		0x04	/* ask for txerr counter */
 
@@ -122,7 +123,20 @@
  * In other words, its interest is to know which side among rx and tx is
  * responsible of the change of the bus state.
  */
-#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
+#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_ECC | \
+				 PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
+
+/* SJA1000 ECC register */
+#define PCAN_SJA1000_ECC_SEG		0x1f
+#define PCAN_SJA1000_ECC_DIR		0x20
+#define PCAN_SJA1000_ECC_ERR		6
+#define PCAN_SJA1000_ECC_BIT		0x00
+#define PCAN_SJA1000_ECC_FORM		0x40
+#define PCAN_SJA1000_ECC_STUFF		0x80
+#define PCAN_SJA1000_ECC_MASK		0xc0
+
+/* SJA1000 Bus Error Interrupt */
+#define PCAN_SJA1000_IRQ_BEI		0x80
 
 /* identify bus event packets with rx/tx error counters */
 #define PCAN_USB_ERR_CNT_DEC		0x00	/* counters are decreasing */
@@ -550,7 +564,8 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 /* decode bus event usb packet: first byte contains rxerr while 2nd one contains
  * txerr.
  */
-static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
+static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir,
+				   u8 status_len)
 {
 	struct pcan_usb *pdev = mc->pdev;
 
@@ -569,6 +584,83 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 		break;
 	}
 
+	/* process bus error interrupt */
+	if (ir & PCAN_SJA1000_IRQ_BEI) {
+		u8 rec_len = status_len & PCAN_USB_STATUSLEN_DLC;
+		u8 *pd = mc->ptr, ecc = 0;
+
+		if (rec_len > 2)
+			ecc = *pd++;
+
+		if (rec_len > 1) {
+			/* save rx/tx error counters from data bytes */
+			pdev->bec.rxerr = *pd++;
+			pdev->bec.txerr = *pd++;
+		}
+
+		/* create an "bus-error frame" skb if any bit is set in ECC */
+		if (ecc) {
+			struct net_device_stats *stats = &mc->netdev->stats;
+			struct sk_buff *skb;
+			struct can_frame *cf;
+			u8 can_err_tx = 0;
+
+			pdev->dev.can.can_stats.bus_error++;
+
+			/* Error occurred during reception? */
+			if (ecc & PCAN_SJA1000_ECC_DIR) {
+				stats->rx_errors++;
+			} else {
+				stats->tx_errors++;
+				can_err_tx = CAN_ERR_PROT_TX;
+			}
+
+			/* if berr-reporting is off, stop here */
+			if (!(pdev->dev.can.ctrlmode &
+						CAN_CTRLMODE_BERR_REPORTING))
+				return 0;
+
+			/* allocate an skb to store the error frame */
+			skb = alloc_can_err_skb(mc->netdev, &cf);
+			if (!skb)
+				return -ENOMEM;
+
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+			cf->data[2] |= can_err_tx;
+
+			/* set error type according to 1st data byte (ECC) */
+			switch (ecc & PCAN_SJA1000_ECC_MASK) {
+			case PCAN_SJA1000_ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case PCAN_SJA1000_ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case PCAN_SJA1000_ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				break;
+			}
+
+			/* set error location */
+			cf->data[3] = ecc & PCAN_SJA1000_ECC_SEG;
+
+			cf->data[6] = pdev->bec.txerr;
+			cf->data[7] = pdev->bec.rxerr;
+
+			if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
+				struct skb_shared_hwtstamps *hwts =
+					skb_hwtstamps(skb);
+
+				peak_usb_get_ts_time(&mc->pdev->time_ref,
+						     mc->ts16, &hwts->hwtstamp);
+			}
+
+			netif_rx(skb);
+		}
+	}
+
 	return 0;
 }
 
@@ -627,7 +719,7 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 
 	case PCAN_USB_REC_BUSEVT:
 		/* bus event notifications (get rxerr/txerr) */
-		err = pcan_usb_handle_bus_evt(mc, n);
+		err = pcan_usb_handle_bus_evt(mc, n, status_len);
 		if (err)
 			return err;
 		break;
@@ -1017,7 +1109,8 @@ const struct peak_usb_adapter pcan_usb = {
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
 	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			      CAN_CTRLMODE_CC_LEN8_DLC,
+			      CAN_CTRLMODE_CC_LEN8_DLC |
+			      CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2,
 	},

---
base-commit: 3bb1277609aae9b56b8e9462fe18fc000944fa96
change-id: 20260924-peak_usb-5d8607af1f99

Best regards,
--  
Stéphane Grosjean <s.grosjean@peak-system.fr>


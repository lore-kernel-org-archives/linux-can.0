Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E8734BA50;
	Fri, 25 Sep 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342423; cv=none; b=GiBrOQjATN81HXM6hwhhShe21PlWpA9TFyJYlUk3LQlbh3nvXipxtRkxSZUPTvk44Wx9liq/Jq0UYRptz0fprdkhrbVRUs3qaVvQXy1vzI/8XUng4TFOuaRduVBJeDVUzBapGyTidz4sKluwyd7oJi2fUeKLoQfqBQYOSQuDPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342423; c=relaxed/simple;
	bh=6u6sTaRqCDHuYubIntY+rQRZA0XPjAkntwjn0GvRwT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ggxRqAVVVoViO8iPyiDYenRZ0y9MpD3lJ/AikRjT3U/U9Lh7tjgo2ES2NBjSfWvyZ8zrA7ZN4aLPKuakCgU+ThM7sa5dj5S1fdX/32I3ceyfrZJojlVdfAob6izczV5kSWJ8aGTBpYvZKZIGmrhbtmUy+kiVYrJB6bLAjIOKiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=oavdHTzg; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="oavdHTzg"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4945C780395;
	Fri, 25 Sep 2026 15:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790342412;
	bh=6u6sTaRqCDHuYubIntY+rQRZA0XPjAkntwjn0GvRwT4=;
	h=From:Date:Subject:To:Cc:From;
	b=oavdHTzgagm1PuObv3NDAS9845goDJjRYO3kBtBjjL90w4BLpbSk9vfBNY/BUkiFj
	 sVL4oMnFwPvjNybiD4zCM0NuM8Yg0eGUpbeyws3fvlbT8KW+AKlOl6VJMYGpp9g4VB
	 3O5PO520D2VtHCvwbRy/jNjBko2Ar4qGgnNFfTC+cgaDShCiwK2dhDnh3BL2aqfJkA
	 pxtzbFMZ/FJCcY/p6bq3awwUwLSorMEqK8BE8Q/12G0/p4SySULgPgVmQEbk8PurgR
	 OzjXdhQ2m21IC4yIaJUEBdcePeqWko2onYsl3r8pNUXZ+ehEJcVxbVBQvDVtZQjLzJ
	 rEfduan5Pxizw==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Fri, 25 Sep 2026 15:19:49 +0200
Subject: [PATCH v3] can: peak_usb: Add PCAN-USB bus errors reporting
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-peak_usb-v3-1-e7bfccacf795@peak-system.fr>
X-B4-Tracking: v=1; b=H4sIAPR0tmoC/22NUQ+CIBRG/4rjOZqggPTU/2itiVySWupAWc753
 wN7cavHs3vOdxfkwVnw6JQtyEGw3vZdhOKQoaatuztgqyMjmlOeS1riAernbfIKM13xXNSGGCl
 R1AcHxr63qcv1y35SD2jG1CejtX7s3bz9CiR5f2YDwQTrsqoEI1zWTJ7TCfvZj/A6GofSdqD7m
 u1qGmtTUCaUBiWA/9Trun4Ac3AhkPUAAAA=
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
Changes in v3:
- Remove PCAN_USB_ERR_CNT_* constants and their erroneous comment
- Rework error counter handling
- Fix out-of-bounds check
- Link to v2: https://patch.msgid.link/20260925-peak_usb-v2-1-f3257bdeb7e6@peak-system.fr

Changes in v2:
- Remove legacy bus error handling code
- Fix potential out-of-bounds read in pcan_usb_handle_bus_evt()
- Link to v1: https://patch.msgid.link/20260924-peak_usb-v1-1-d48875169a59@peak-system.fr

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 116 +++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..c59166a29648 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -115,6 +115,7 @@
 #define PCAN_USB_REC_BUSEVT		5
 
 /* CAN bus events notifications selection mask */
+#define PCAN_USB_ERR_ECC		0x01	/* ask for BERR */
 #define PCAN_USB_ERR_RXERR		0x02	/* ask for rxerr counter */
 #define PCAN_USB_ERR_TXERR		0x04	/* ask for txerr counter */
 
@@ -122,11 +123,20 @@
  * In other words, its interest is to know which side among rx and tx is
  * responsible of the change of the bus state.
  */
-#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
+#define PCAN_USB_BERR_MASK	(PCAN_USB_ERR_ECC | \
+				 PCAN_USB_ERR_RXERR | PCAN_USB_ERR_TXERR)
 
-/* identify bus event packets with rx/tx error counters */
-#define PCAN_USB_ERR_CNT_DEC		0x00	/* counters are decreasing */
-#define PCAN_USB_ERR_CNT_INC		0x80	/* counters are increasing */
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
 
 /* private to PCAN-USB adapter */
 struct pcan_usb {
@@ -550,23 +560,94 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 /* decode bus event usb packet: first byte contains rxerr while 2nd one contains
  * txerr.
  */
-static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
+static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir,
+				   u8 status_len)
 {
 	struct pcan_usb *pdev = mc->pdev;
+	u8 rec_len = status_len & PCAN_USB_STATUSLEN_DLC;
 
-	/* according to the content of the packet */
-	switch (ir) {
-	case PCAN_USB_ERR_CNT_DEC:
-	case PCAN_USB_ERR_CNT_INC:
+	/* Check for potential out-of-bound accesses
+	 * ("end" is a misnomer; it is not a pointer to the last valid byte,
+	 * but rather to the one following it)
+	 */
+	if (!rec_len || (mc->ptr + rec_len) > mc->end)
+		return -EINVAL;
 
-		/* save rx/tx error counters from in the device context */
+	/* 1st byte is ECC (if BEI), 2nd one is rxerr, 3rd one is txerr:
+	 * save rx/tx error counters from record data bytes first, so that
+	 * device error counters are always up-to-date.
+	 */
+	if (rec_len > 1) {
 		pdev->bec.rxerr = mc->ptr[1];
-		pdev->bec.txerr = mc->ptr[2];
-		break;
+		if (rec_len > 2)
+			pdev->bec.txerr = mc->ptr[2];
+	}
 
-	default:
-		/* reserved */
-		break;
+	/* Then process bus error interrupt (if any) */
+	if (ir & PCAN_SJA1000_IRQ_BEI) {
+		u8 ecc = mc->ptr[0];
+
+		/* create a "bus-error frame" skb if any bit is set in ECC */
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
 	}
 
 	return 0;
@@ -627,7 +708,7 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 
 	case PCAN_USB_REC_BUSEVT:
 		/* bus event notifications (get rxerr/txerr) */
-		err = pcan_usb_handle_bus_evt(mc, n);
+		err = pcan_usb_handle_bus_evt(mc, n, status_len);
 		if (err)
 			return err;
 		break;
@@ -1017,7 +1098,8 @@ const struct peak_usb_adapter pcan_usb = {
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


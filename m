Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422F3C4551;
	Fri,  2 Oct 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928916; cv=pass; b=gY6Xt0qLT3yhWDSDdQgfOXiV/TRHnGv2EHEjTyHeB4/6s/cCNCVjeJFYDPLfRZWByl1wFJqIzOLL7KhHd6Vo2z3QbtT0jVJUxYTsay2pMrdRsNXo9nkjic97HzVIcDF55kVpZ8WpLX2eMOCMxnRo/xXRd59rVhBoFq/mnngdOlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928916; c=relaxed/simple;
	bh=U/FOzc3jXtJ0hNnHQvNW4RnWAQ+wucUdjjUuo7WsXm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eY2Ha6agm2qP1qLGeBf9L8QrlGBP3znWHzAKjwTAQe/ryXP8LUydDwS4zmp0PYPZ8I8E2gkteRURMmYJ+oKA/TZHqB3ik45pIZ2pJeX8vrESNKuFjrKvl/MCBTOrStqgKXGIHM6eFA5VIVUiqolL/wTjq9Qoqh0M0/Wo2MtIsFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=BGfePNsu; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="BGfePNsu"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D36F220125E;
	Fri, 02 Oct 2026 10:15:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Untf1i3FYKzzcMLy3UhgkMcb/ai5xjiGsMTC1qjl9fM=;
	b=BGfePNsu+SyzyQ94wXELg7O2DueYeAVinMs64WnatT0L3H7LF+tl+wGpX8MUlVHrWDGDK6
	ORB0EqeExJbs2vTK22p+v/FbN3jsOUXFeU11MO0IPQkE2c6dlavcPb62Sd20MgDUuIB1S3
	VtUx+YgFC0GGdoYRpvPXjoiDlB8j0SOx6m5zZx7qXamkSzO1V+SfZCZm9PoIlpgcV2E1Wq
	peyUS/DTXb0G/BjbQfALImXhK6EUIFH+UiKkH6T7Y6XTnpIEtsbxPUnUWP7qH9qZ4vZ8nD
	eeaHLMA77e5C8JV6MhwEXTivBR4TycfOkdWK0vk+Szmlkahf/muXWUD84+LMYg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928910; a=rsa-sha256;
	cv=none;
	b=dv7C0Lu/ZUvjxHZnJ93Ya0FQw+h4tR5SzbAuxczoF6Px+uTNojUUfVEdILcDpeaKSqUQGC
	XzfmIT6fe7+vVEUm+pwTdvzd8JFDObZwqnS+BL4Z9CaOG/fobx14VKFdYflvIhwLSsIk5G
	TerurD2TK2LaWtmclxN9/m2xeDh76CHjLfOoU4a5ihHaQrEEK3OFG6qH+K1Z1w6ZZjIbYK
	2RpTzJNGs9PppuabeSl0vSaHAqaTN4YlyFrrXv9+HnmMgb5m4qdzu7M356lYApByPCkMI/
	2Xr9f9Qmq01jx/nOoKGiRqB3yaUBA89WlR2mCOOj1ea/iwivFQLWE9N8TYNLCQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Untf1i3FYKzzcMLy3UhgkMcb/ai5xjiGsMTC1qjl9fM=;
	b=VSInqropLreH0+zBxFg8ZAudZqosfKJbG+Ni73Per8RBYxlx5xcyl6uOGoKFU62kZ5MaU/
	M24jLCMZqfw2AIAWT7LkKIC5/yLcuCB2ldZXKZD1rpAV6ZrKkDN7O0Wuk3xvXfcsV+QGIC
	lZ2n050YEnxmUZ2NabIWaYmjFIC0yR8GNXd9u1N/ttUHBXlUvKgPpD220fYa1ql0cfr5GF
	G6XEtQVHxUH0ymGjxKeL67+08+wVDMKDMBQPQMtLmDvjN4EcRVQBelcpxmWRBtIsgsRHkv
	9IfJ1WYb9nxQb5+0RneKzw8r0ZAQZzva8F4I3j1TPLndldZzCb44f1cz0U3Sdw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVK-2R;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 661005B828A;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:11 +0200
Subject: [PATCH can-next 4/7] can: peak_usb: Add PCAN-USB bus errors
 reporting
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-peak_usb_enhancements-v1-4-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5531; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NVlFvFh0PMiFiwyiP9qwb0j3wkxWz7xxS/MDT50O+aQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan1xYMqdkaca6FnZO6Qu/LZ7IrwuNzH67/Y65XvXvt
 P0v0iIjOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRpymMDHMvR+Suf8DmlK5z
 Qp310Fn11Pc3zTnsfp+5ncdtqFovep+RoU2S6/jLd9N237T+6rE3Rs5swimTVkuX0uZ/Xz8wuqy
 cwg0A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The good old PCAN-USB was missing CAN bus error reporting. This patch fixes
that.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 115 +++++++++++++++++++++++++++-----
 1 file changed, 99 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 169c00d93463..e71ed7879c04 100644
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
@@ -550,23 +560,95 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
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
+			cf->can_id |= CAN_ERR_CNT | CAN_ERR_PROT |
+				      CAN_ERR_BUSERROR;
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
@@ -627,7 +709,7 @@ static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
 
 	case PCAN_USB_REC_BUSEVT:
 		/* bus event notifications (get rxerr/txerr) */
-		err = pcan_usb_handle_bus_evt(mc, n);
+		err = pcan_usb_handle_bus_evt(mc, n, status_len);
 		if (err)
 			return err;
 		break;
@@ -1018,6 +1100,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.ctrl_count = 1,
 	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
+			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2,

-- 
2.53.0


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4A428463;
	Mon, 20 Jul 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555325; cv=none; b=NY3QA2pU1cJDh34gu7bVDGWpMvVg6YHrO/FdrJo3c4VTUT16OIikbVVbcxaXNq+72GTaro3/lgU3CDET6veS8MXE8bCMnS/CC+DlU4LV98lIuDXNGz6YsBXUdGV5dCUErJ5Ce51cTVJNVhRJKlJ8SAp//XtLm2srA/Ydf8EPPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555325; c=relaxed/simple;
	bh=m93Tn6a3VPp7Ec8B5ez7OpvUxCFFb4wOlk9IKU6yK8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGipvYF2bbxMKl4idRbou57Jct+X7pHn1yz6vOoSh6TNYh433+1iSP8Fs3EBW2btXjEuGVdSCUeyiWgIwwlQJm+hmzabbOEK43jOzLFy/wm5k5KcZLx8RxSSGjKYEbULBi18iaoKdMRrPgYZsIHxuoS4W0iUPx74tNo0rghDomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 67B452028DD;
	Mon, 20 Jul 2026 15:48:28 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM8-000Pmt-12;
	Mon, 20 Jul 2026 15:48:28 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D010056E524;
	Mon, 20 Jul 2026 13:48:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:08 +0200
Subject: [PATCH can-next 07/13] can: gs_usb:
 gs_usb_receive_bulk_callback(): reduce scope of several variables
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-7-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=m93Tn6a3VPp7Ec8B5ez7OpvUxCFFb4wOlk9IKU6yK8E=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU5fbuPmLzt2WNdt1fbZukGx4yWoTrOGQVdtssHeKq
 6mcV0Z5RykLgxgXg6yYIsvSHycUBQIdSntfJkyCmcPKBDKEgYtTACayT5Xhn2ogx4a8cDddA7Wo
 WqdDW/kdVve+5XglsWjqiYkrsvwmHWL4H/bZYrFr+JLiqR9naoq+O73thf1noUClQxeEDiX9fDj
 7OScA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

To improve readability of the code, reduce the scope of the variables txc,
cf and cfd and skb.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d77f0940c035..473f125e20d8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -649,10 +649,6 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	struct net_device_stats *stats;
 	struct gs_host_frame *hf = urb->transfer_buffer;
 	unsigned int minimum_length, data_length;
-	struct gs_tx_context *txc;
-	struct can_frame *cf;
-	struct canfd_frame *cfd;
-	struct sk_buff *skb;
 
 	BUG_ON(!parent);
 
@@ -705,7 +701,11 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX) { /* normal rx */
+		struct sk_buff *skb;
+
 		if (hf->flags & GS_CAN_FLAG_FD) {
+			struct canfd_frame *cfd;
+
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
 				return;
@@ -719,6 +719,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 			memcpy(cfd->data, hf->canfd->data, data_length);
 		} else {
+			struct can_frame *cf;
+
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
 				return;
@@ -735,6 +737,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 
 		gs_usb_rx_offload(dev, skb, hf);
 	} else { /* echo_id == hf->echo_id */
+		struct gs_tx_context *txc;
+		struct sk_buff *skb;
+
 		if (hf->echo_id >= GS_MAX_TX_URBS) {
 			netdev_err(netdev,
 				   "Unexpected out of range echo id %u\n",
@@ -763,6 +768,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
+		struct can_frame *cf;
+		struct sk_buff *skb;
+
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 

-- 
2.53.0


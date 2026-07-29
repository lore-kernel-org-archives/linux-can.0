Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DF3FCB0C;
	Wed, 29 Jul 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320970; cv=none; b=sDcr8AIioEsfeJ/k8sAQHXJiQkfS4odbubWrgsYRa3prwPoobNfqfVQqqf3OCLqOkiGg3NdLF7oPaeB3vNY5wHmmIarCY+rxR8tE75RyYLM04xsWa2rj5Ef5abdfCHrk+0aBtq3K9BOopnpbrs9bdoXoWd54fR+/VPNtD+7U6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320970; c=relaxed/simple;
	bh=kYyEmKy4tvzwecBeBkufCNZIRPLT/8TnJVM+n0bu/NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQc9rs+PXFaWqOtdsCZ+KxsffQo6BwS5uA5rtYoY9pKBrg89uENYI+qFm3ad/F0+pGq+BgfpwfGuGtvcp6aqRIsgpsnIDrQOG/wNZjrDTV3ZpR1At8EyvbfbBDPS7SKjOTQG0PBXi9iFHFWHOVJ6dKs5VPxylnbnMMHTNnk5r0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E2E74202B57;
	Wed, 29 Jul 2026 12:29:25 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XR-001rmt-28;
	Wed, 29 Jul 2026 12:29:25 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 26829575DCB;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	James Gao <jamesgao5@outlook.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/20] can: peak_usb: add bounds check for USB channel index
Date: Wed, 29 Jul 2026 12:12:50 +0200
Message-ID: <20260729102802.505168-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Gao <jamesgao5@outlook.com>

The channel control index ctrl_idx is derived from rx->len which comes
directly from a device USB payload. The mask 0x0f allows values 0-15, but
the array size of usb_if->dev[] is only 2. Values 2-15 cause heap
out-of-bounds read, eventually causing kernel panic in the IRQ context.

Add bounds checking for ctrl_idx before the array access in both
pcan_usb_pro_handle_canmsg() and pcan_usb_pro_handle_error().

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Signed-off-by: James Gao <jamesgao5@outlook.com>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/TYWPR01MB8559DBAAAA6A7F410400329CF0012@TYWPR01MB8559.jpnprd01.prod.outlook.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index aefcded8e12a..b6be8c19e537 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -534,12 +534,18 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 				      struct pcan_usb_pro_rxmsg *rx)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	skb = alloc_can_skb(netdev, &can_frame);
 	if (!skb)
 		return -ENOMEM;
@@ -573,14 +579,20 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 {
 	const u16 raw_status = le16_to_cpu(er->status);
 	const unsigned int ctrl_idx = (er->channel >> 4) & 0x0f;
-	struct peak_usb_device *dev = usb_if->dev[ctrl_idx];
-	struct net_device *netdev = dev->netdev;
+	struct peak_usb_device *dev;
+	struct net_device *netdev;
 	struct can_frame *can_frame;
 	enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
 	u8 err_mask = 0;
 	struct sk_buff *skb;
 	struct skb_shared_hwtstamps *hwts;
 
+	if (ctrl_idx >= ARRAY_SIZE(usb_if->dev))
+		return -EINVAL;
+
+	dev = usb_if->dev[ctrl_idx];
+	netdev = dev->netdev;
+
 	/* nothing should be sent while in BUS_OFF state */
 	if (dev->can.state == CAN_STATE_BUS_OFF)
 		return 0;
-- 
2.53.0


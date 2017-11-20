From: =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
Subject: [PATCH] can: ti_hecc: Fix napi poll return value for repoll
Date: Mon, 20 Nov 2017 14:45:15 +0100
Message-ID: <20171120134515.2658-1-oliver.staebler@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:49100 "EHLO bytesatwork.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751086AbdKTNvM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 20 Nov 2017 08:51:12 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>

After commit d75b1ade567f ("net: less interrupt masking in NAPI") napi
repoll is done only when work_done == budget.
So we need to return budget if there are still packets to receive.

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
---
 drivers/net/can/ti_hecc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 4d4941469cfc..db6ea936dc3f 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -637,6 +637,9 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 		mbx_mask = hecc_read(priv, HECC_CANMIM);
 		mbx_mask |= HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+	} else {
+		/* repoll is done only if whole budget is used */
+		num_pkts = quota;
 	}
 
 	return num_pkts;
-- 
2.13.6


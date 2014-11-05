From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH V3 1/3] can: add can_is_canfd_skb() API
Date: Wed, 5 Nov 2014 21:16:31 +0800
Message-ID: <1415193393-30023-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bon0133.outbound.protection.outlook.com ([157.56.111.133]:61808
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751500AbaKEOXM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 5 Nov 2014 09:23:12 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, varkabhadram@gmail.com, netdev@vger.kernel.org, socketcan@hartkopp.net, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The CAN device drivers can use it to check if the frame to send is on
CAN FD mode or normal CAN mode.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
ChangesLog:
 * v1->v2: change to skb->len == CANFD_MTU;
---
 include/linux/can/dev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..4c3919c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -99,6 +99,11 @@ inval_skb:
 	return 1;
 }
 
+static inline int can_is_canfd_skb(struct sk_buff *skb)
+{
+	return skb->len == CANFD_MTU;
+}
+
 /* get data length from can_dlc with sanitized can_dlc */
 u8 can_dlc2len(u8 can_dlc);
 
-- 
1.9.1


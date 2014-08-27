From: David Jander <david@protonic.nl>
Subject: [PATCH 3/3] can: flexcan.c: Implement last step of workaround for errata ERR005829
Date: Wed, 27 Aug 2014 11:58:07 +0200
Message-ID: <1409133487-23367-4-git-send-email-david@protonic.nl>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17910 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933374AbaH0KTh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Aug 2014 06:19:37 -0400
In-Reply-To: <1409133487-23367-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, David Jander <david@protonic.nl>

It is not clear if this errata only applies to i.MX6, but the impact of
the workaround should be minimal. Basically it comes down to reserving
mailbox 0 as a permanently inactive MB and writing twice to its C/S field
on every message transmit.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index bf444ff..3998d4c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -434,6 +434,10 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
 	flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 
+	/* Errata ERR005829 step8: Write twice INACTIVE(0b1000) code to MB 0 */
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x8), &regs->cantxfg[0].can_ctrl);
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x8), &regs->cantxfg[0].can_ctrl);
+
 	return NETDEV_TX_OK;
 }
 
-- 
1.9.1


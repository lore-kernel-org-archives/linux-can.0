From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 2/4] can: c_can: fix: enable CAN HW interrupts after napi_enable()
Date: Thu, 10 May 2012 17:04:15 +0530
Message-ID: <1336649657-4152-3-git-send-email-anilkumar@ti.com>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56889 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755194Ab2EJLfW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 10 May 2012 07:35:22 -0400
In-Reply-To: <1336649657-4152-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Fix the issue of C_CAN interrupts getting disabled forever even though
we do can configuration multiple times using can utils. According to
NAPI usage we disable all the hardware interrupts in ISR and re-enable
them in poll(). Current implementation calls napi_enable() after hardware
interrupts are enabled. If we get any interrupts between these two steps
then we do not process those interrupts because napi is not enabled. Mostly
these interrupts come because of STATUS is not 0x7 or ERROR interrupts. If
napi_enable() happens before hardware interrupts enabled then c_can_poll()
function will be called eventual re-enabling of interrupts will happen.

This patch moves the napi_enable() call before interrupts enabled.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index fa01621..8dc84d6 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1064,10 +1064,11 @@ static int c_can_open(struct net_device *dev)
 		goto exit_irq_fail;
 	}
 
+	napi_enable(&priv->napi);
+
 	/* start the c_can controller */
 	c_can_start(dev);
 
-	napi_enable(&priv->napi);
 	netif_start_queue(dev);
 
 	return 0;
-- 
1.7.0.4


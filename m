From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] can: c_can: fix segfault during rmmod
Date: Thu, 27 Sep 2012 16:11:39 +0530
Message-ID: <1348742499-6526-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46369 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984Ab2I0Kl6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 27 Sep 2012 06:41:58 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch fixes an oops which occurs during unloading the driver. The
problem is that clock is not enabled during unregister_c_can_dev()
which does c_can/d_can module interrupts enable/disable.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 2c4a21f..638e3cc 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1265,8 +1265,10 @@ void unregister_c_can_dev(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
+	c_can_pm_runtime_get_sync(priv);
 	/* disable all interrupts */
 	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
+	c_can_pm_runtime_put_sync(priv);
 
 	unregister_candev(dev);
 
-- 
1.7.0.4


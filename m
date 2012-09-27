From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] can: c_can: fix segfault during rmmod
Date: Thu, 27 Sep 2012 17:54:58 +0530
Message-ID: <1348748698-5635-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41674 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255Ab2I0MZP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Sep 2012 08:25:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: swarren@wwwdotorg.org, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

This patch fixes an oops which occurs during unloading the driver.
unregister_c_can_dev() is doing c_can/d_can module interrupts
disable, which requires module clock enable. c_can/d_can interrupts
enable/disable is handled properly in c_can_start and c_can_stop,
so removing from unregister_c_can_dev().

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 drivers/net/can/c_can/c_can.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 25f4356..7a2a7e4 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1282,9 +1282,6 @@ void unregister_c_can_dev(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	/* disable all interrupts */
-	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
-
 	unregister_candev(dev);
 
 	c_can_pm_runtime_disable(priv);
-- 
1.7.9.5


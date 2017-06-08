From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: af_can: namespace support: fix lockdep splat: properly initialize spin_lock
Date: Thu,  8 Jun 2017 12:02:42 +0200
Message-ID: <20170608100242.5784-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37939 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751610AbdFHKCr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Jun 2017 06:02:47 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

This patch uses spin_lock_init() instead of __SPIN_LOCK_UNLOCKED() to
initialize the per namespace net->can.can_rcvlists_lock lock to fix this
lockdep warning:

| INFO: trying to register non-static key.
| the code is fine but needs lockdep annotation.
| turning off the locking correctness validator.
| CPU: 0 PID: 186 Comm: candump Not tainted 4.12.0-rc3+ #47
| Hardware name: Marvell Kirkwood (Flattened Device Tree)
| [<c0016644>] (unwind_backtrace) from [<c00139a8>] (show_stack+0x18/0x1c)
| [<c00139a8>] (show_stack) from [<c0058c8c>] (register_lock_class+0x1e4/0x55c)
| [<c0058c8c>] (register_lock_class) from [<c005bdfc>] (__lock_acquire+0x148/0x1990)
| [<c005bdfc>] (__lock_acquire) from [<c005deec>] (lock_acquire+0x174/0x210)
| [<c005deec>] (lock_acquire) from [<c04a6780>] (_raw_spin_lock+0x50/0x88)
| [<c04a6780>] (_raw_spin_lock) from [<bf02116c>] (can_rx_register+0x94/0x15c [can])
| [<bf02116c>] (can_rx_register [can]) from [<bf02a868>] (raw_enable_filters+0x60/0xc0 [can_raw])
| [<bf02a868>] (raw_enable_filters [can_raw]) from [<bf02ac14>] (raw_enable_allfilters+0x2c/0xa0 [can_raw])
| [<bf02ac14>] (raw_enable_allfilters [can_raw]) from [<bf02ad38>] (raw_bind+0xb0/0x250 [can_raw])
| [<bf02ad38>] (raw_bind [can_raw]) from [<c03b5fb8>] (SyS_bind+0x70/0xac)
| [<c03b5fb8>] (SyS_bind) from [<c000f8c0>] (ret_fast_syscall+0x0/0x1c)

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Oliver,

feel free to review this patch.

Marc

 net/can/af_can.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index b6406fe33c76..88edac0f3e36 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -872,8 +872,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 
 static int can_pernet_init(struct net *net)
 {
-	net->can.can_rcvlists_lock =
-		__SPIN_LOCK_UNLOCKED(net->can.can_rcvlists_lock);
+	spin_lock_init(&net->can.can_rcvlists_lock);
 	net->can.can_rx_alldev_list =
 		kzalloc(sizeof(struct dev_rcv_lists), GFP_KERNEL);
 
-- 
2.11.0


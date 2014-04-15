From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/5] can: slcan: Fix spinlock variant
Date: Tue, 15 Apr 2014 16:51:04 +0200
Message-ID: <1397573468-7619-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:40120 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbaDOOwa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 10:52:30 -0400
In-Reply-To: <1397573468-7619-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

slc_xmit is called within softirq context and locks sl->lock, but
slcan_write_wakeup is not softirq context, so we need to use
spin_[un]lock_bh!
Detected using kernel lock debugging mechanism.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
I found this by just enabling the kernel config options named in
Documentation/SubmitChecklist :)
> 12: Has been tested with CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT,
>    CONFIG_DEBUG_SLAB, CONFIG_DEBUG_PAGEALLOC, CONFIG_DEBUG_MUTEXES,
>    CONFIG_DEBUG_SPINLOCK, CONFIG_DEBUG_ATOMIC_SLEEP, CONFIG_PROVE_RCU
>    and CONFIG_DEBUG_OBJECTS_RCU_HEAD all simultaneously enabled.

 drivers/net/can/slcan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 3fcdae2..2577c1e 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -322,13 +322,13 @@ static void slcan_write_wakeup(struct tty_struct *tty)
 	if (!sl || sl->magic != SLCAN_MAGIC || !netif_running(sl->dev))
 		return;
 
-	spin_lock(&sl->lock);
+	spin_lock_bh(&sl->lock);
 	if (sl->xleft <= 0)  {
 		/* Now serial buffer is almost free & we can start
 		 * transmission of another packet */
 		sl->dev->stats.tx_packets++;
 		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
-		spin_unlock(&sl->lock);
+		spin_unlock_bh(&sl->lock);
 		netif_wake_queue(sl->dev);
 		return;
 	}
@@ -336,7 +336,7 @@ static void slcan_write_wakeup(struct tty_struct *tty)
 	actual = tty->ops->write(tty, sl->xhead, sl->xleft);
 	sl->xleft -= actual;
 	sl->xhead += actual;
-	spin_unlock(&sl->lock);
+	spin_unlock_bh(&sl->lock);
 }
 
 /* Send a can_frame to a TTY queue. */
-- 
1.8.3.2


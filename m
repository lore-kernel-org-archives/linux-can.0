From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 1/5] can: bcm: fix indention style
Date: Mon, 30 May 2016 20:36:26 +0200
Message-ID: <1464633390-24299-2-git-send-email-socketcan@hartkopp.net>
References: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:10898 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933480AbcE3Sgo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 May 2016 14:36:44 -0400
In-Reply-To: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 6863310..1f4ccc3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -184,42 +184,42 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ",
-				op->can_id, bcm_proc_getifname(ifname, op->ifindex));
+			   op->can_id, bcm_proc_getifname(ifname, op->ifindex));
 		seq_printf(m, "[%u]%c ", op->nframes,
-				(op->flags & RX_CHECK_DLC)?'d':' ');
+			   (op->flags & RX_CHECK_DLC)?'d':' ');
 		if (op->kt_ival1.tv64)
 			seq_printf(m, "timeo=%lld ",
-					(long long)
-					ktime_to_us(op->kt_ival1));
+				   (long long)
+				   ktime_to_us(op->kt_ival1));
 
 		if (op->kt_ival2.tv64)
 			seq_printf(m, "thr=%lld ",
-					(long long)
-					ktime_to_us(op->kt_ival2));
+				   (long long)
+				   ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-				op->frames_filtered, op->frames_abs);
+			   op->frames_filtered, op->frames_abs);
 
 		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
-				(reduction == 100)?"near ":"", reduction);
+			   (reduction == 100)?"near ":"", reduction);
 	}
 
 	list_for_each_entry(op, &bo->tx_ops, list) {
 
 		seq_printf(m, "tx_op: %03X %s [%u] ",
-				op->can_id,
-				bcm_proc_getifname(ifname, op->ifindex),
-				op->nframes);
+			   op->can_id,
+			   bcm_proc_getifname(ifname, op->ifindex),
+			   op->nframes);
 
 		if (op->kt_ival1.tv64)
 			seq_printf(m, "t1=%lld ",
-					(long long) ktime_to_us(op->kt_ival1));
+				   (long long) ktime_to_us(op->kt_ival1));
 
 		if (op->kt_ival2.tv64)
 			seq_printf(m, "t2=%lld ",
-					(long long) ktime_to_us(op->kt_ival2));
+				   (long long) ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
@@ -282,7 +282,7 @@ static void bcm_can_tx(struct bcm_op *op)
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
 		op->currframe = 0;
- out:
+out:
 	dev_put(dev);
 }
 
-- 
2.8.1


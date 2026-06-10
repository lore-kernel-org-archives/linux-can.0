Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DA1DED5C
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.216
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084091; cv=pass; b=ffeisIeGhJCPWAooO0RlX5UZwkCvbbVK15K1Mto13tugTOyen+hveDyhWESh/rLIhhbXVoB+YBhu4hHz1EayGLrnHGSO9uMSdX9OWX9Uymy6oJxgKChMAZlT84OmIEpQW/83CYsX2RbBKA5Wnf5PMWVdWjPTm4bRFK4AeCCbXp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084091; c=relaxed/simple;
	bh=jW3NEmCn/0ycem8KEvZg2b+kccu9thtPNFfJ3nab7Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D9e0KLMnpzLq4bKRZbeRO+itjAulucIi8BsUNMt1P5bn8o4JDTlxr/6gTDStG109FP/oqWwFmfyMiao5AKvL5Wh/wJdkk9IlVxEw+Q9gibTptdZZCYN63VECl469fNzS0pcF29F5Pq4PuxOhn6wsP1C9sUWhx2fo1q4ZYAJ3SoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Iyz5Whdh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gBpG8LpZ; arc=pass smtp.client-ip=81.169.146.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Iyz5Whdh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gBpG8LpZ"
ARC-Seal: i=1; a=rsa-sha256; t=1781084081; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iGPtqkh05cxxl0FcRQ0bsKJyX1+02L1KhNyFUhQunjsZuChLr64AZfruQuAvudTpOo
    sHnYc3FHlAUER+8zaU87jn9aPEXOwLbcI8Rmw5U40T2W0sKRfYYgmVtJTaxJIeKwLqFl
    XTeXBcD+71cOn0CYbTeZ57upAB6Z+AZlUpgfInEcGbEAQWj8xsJNu6xBB9V/sNxBVoKp
    jYSsKoD4ROKYMRwo3J5qH91vyM3GjMLv/TCuH17yd8BWLP0yJFnmCWJqh6ApkXR81SXN
    DBfwyWNOAl9kruiWpaLX4Z8LWNP1R3xOcgaleflLs86U8PkYnAd8Qq+Z7PrsQ2VTC2GR
    Hq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781084081;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZdMuBtLkN3Ww268Ug4nIJataA74CnerP5gJbDC9nk4g=;
    b=Zo4eq6if9PZRntVndNd7tCAcecOdLuRlxIPuZhrSB2r6eLhHHPaQ07M0BqzCQUvcqy
    Kmq2HGtiVK6/dWAxSVojlutQueryHSG1VT/bMTubruJ66qo9vH+pX+CmQptjTRPOEK36
    r+bXsGw5sTg8okI1I2a+51Jn+15rJcdk80JOHkChlwtW2I6cDo1zodRBQ59Xlyaq/A6T
    zCDX5uGzG9fcITvIm+P6F6OVpvJcRDLgXnnid4+4aWKc/FJ0ABBoxF1dv31FONLl5YTT
    SjP8Sjyjdt2ctPlpH4mrcwuIBzyxlmzwIXqm3KZxOP2O8mXY4NGi9HP+VkLBjmnBNjZg
    R0yA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781084081;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZdMuBtLkN3Ww268Ug4nIJataA74CnerP5gJbDC9nk4g=;
    b=Iyz5WhdhcQ0wRjOQqs3/tEvpljvHN/q1IIWSbJasPEVLSKx/jJPbY64DD8wWfluAea
    vCTpzTfaVz9xSaxuJJOLkKeMKdsFtPaSb1zrz9o/F+/6ba/1r02LazC7bqJjrmpN8Dbv
    sv5jgaKXN8MQGfDZzqkoTPt5i3jln2Y9EuK+YFE6ur61hBOOTkz0ZyL2Xuv6sf5wgjUy
    vXLubLmJpD/OuEhLQ/S5JHfE/IqxXS3/kEiwoJcOfwhLyaaz0LGEhbaqZsE45uKR/9fe
    /N8JAdrMeH6CsNkOy16mAjZGtcsMHMwZ56T+rf2nUliuMfclkMmcQjgfgKETIYIiebxk
    OIiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781084081;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZdMuBtLkN3Ww268Ug4nIJataA74CnerP5gJbDC9nk4g=;
    b=gBpG8LpZ1oJcshO3f6hW0tX0HzuU7nChFshEfLWC3OJwBUhz9nLnKTQoDMHOQseblC
    hWjqN0eeN4juhCSoTMAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25A9Yfi4b
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 11:34:41 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can: bcm: fix CAN frame rx/tx statistics
Date: Wed, 10 Jun 2026 11:34:22 +0200
Message-ID: <20260610093422.39847-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in a separate bcm_update_stats() function.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 658c4a7a55df..d3d1ed7fd862 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -106,11 +106,11 @@ struct bcm_op {
 	struct list_head list;
 	struct rcu_head rcu;
 	int ifindex;
 	canid_t can_id;
 	u32 flags;
-	unsigned long frames_abs, frames_filtered;
+	atomic_long_t frames_abs, frames_filtered;
 	struct bcm_timeval ival1, ival2;
 	struct hrtimer timer, thrtimer;
 	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
 	int rx_ifindex;
 	int cfsiz;
@@ -223,14 +223,17 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
-		unsigned long reduction;
+		long reduction, frames_filtered, frames_abs;
+
+		frames_filtered = atomic_long_read(&op->frames_filtered);
+		frames_abs = atomic_long_read(&op->frames_abs);
 
 		/* print only active entries & prevent division by zero */
-		if (!op->frames_abs)
+		if (!frames_abs)
 			continue;
 
 		seq_printf(m, "rx_op: %03X %-5s ", op->can_id,
 			   bcm_proc_getifname(net, ifname, op->ifindex));
 
@@ -248,13 +251,13 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		if (op->kt_ival2)
 			seq_printf(m, "thr=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
 		seq_printf(m, "# recv %ld (%ld) => reduction: ",
-			   op->frames_filtered, op->frames_abs);
+			   frames_filtered, frames_abs);
 
-		reduction = 100 - (op->frames_filtered * 100) / op->frames_abs;
+		reduction = 100 - (frames_filtered * 100) / frames_abs;
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
 	}
 
@@ -274,20 +277,30 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 		if (op->kt_ival2)
 			seq_printf(m, "t2=%lld ",
 				   (long long)ktime_to_us(op->kt_ival2));
 
-		seq_printf(m, "# sent %ld\n", op->frames_abs);
+		seq_printf(m, "# sent %ld\n",
+			   atomic_long_read(&op->frames_abs));
 	}
 	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
 
+static void bcm_update_stats(struct bcm_op *op)
+{
+	/* prevent statistics overflow */
+	if (atomic_long_inc_return(&op->frames_abs) > LONG_MAX / 100) {
+		atomic_long_set(&op->frames_filtered, 0);
+		atomic_long_set(&op->frames_abs, 0);
+	}
+}
+
 /*
  * bcm_can_tx - send the (next) CAN frame to the appropriate CAN interface
  *              of the given bcm tx op
  */
 static void bcm_can_tx(struct bcm_op *op)
@@ -334,11 +347,11 @@ static void bcm_can_tx(struct bcm_op *op)
 
 	/* update currframe and count under lock protection */
 	spin_lock_bh(&op->bcm_tx_lock);
 
 	if (!err)
-		op->frames_abs++;
+		bcm_update_stats(op);
 
 	op->currframe++;
 
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
@@ -487,16 +500,12 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
  */
 static void bcm_rx_changed(struct bcm_op *op, struct canfd_frame *data)
 {
 	struct bcm_msg_head head;
 
-	/* update statistics */
-	op->frames_filtered++;
-
-	/* prevent statistics overflow */
-	if (op->frames_filtered > ULONG_MAX/100)
-		op->frames_filtered = op->frames_abs = 0;
+	/* update statistics (frames_filtered <= frames_abs) */
+	atomic_long_inc(&op->frames_filtered);
 
 	/* this element is not throttled anymore */
 	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
@@ -733,11 +742,11 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	/* save rx timestamp */
 	op->rx_stamp = skb->tstamp;
 	/* save originator for recvfrom() */
 	op->rx_ifindex = skb->dev->ifindex;
 	/* update statistics */
-	op->frames_abs++;
+	bcm_update_stats(op);
 
 	if (op->flags & RX_RTR_FRAME) {
 		/* send reply for RTR-request (placed in op->frames[0]) */
 		bcm_can_tx(op);
 		return;
-- 
2.53.0


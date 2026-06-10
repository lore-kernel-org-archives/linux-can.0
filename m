Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC270165F1A
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109661; cv=pass; b=R2is15OnJKI/DJPfT0pY1LW4Zv6HNeubozYocQzb9E58in1PCMa7N81rAsa/E8xj20W0HTpzTgN3cOnj2Cc2nr1jEhjztemolu7UEowclXLQX6SP9a/UD6AzihP1yMjQacF/bWrOEX0BFRmZt5YR/GX41RAuQDEIhOwIn98PZ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109661; c=relaxed/simple;
	bh=wYqNqeOnViQHwQ14UVqcaF9YNT0VbK/yoBm8yddmSOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=acd+hjHd77hw3CPoh4+Ef3G01fPz2ciOdYNXKrRptwzQxQeYFFcN+lDccOi/+lq5Ju3yCZnOuTI0LL5W1JYJvjnTCECddKo0X1wR373gHhagswvjm5rdRIdPjZcvlgXAJItbUyWvTFfgo18jzFeDYF3ilv0tJt2JWUA1dVUvFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=iYBrPTb4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=7dmc+qM4; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="iYBrPTb4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="7dmc+qM4"
ARC-Seal: i=1; a=rsa-sha256; t=1781109471; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nI1EmVl9pcGRdNuwFZrN2kdNM/sZwAO90pQt2M/qVA3VMcIK/bfb8wQ6tVCqxVVQnW
    lAM/EehMsCJ/ITdWdyetUSZ2MPBdF4ycII6+ui/zxu422qFheLZ8bDv7+3eM73ejYpU/
    ounMySY+SQ2U+MK+SuU2ZcdC1vNEo0TSuNs+mepk/9Qg2eKht367rENfykrVKMkUTcua
    dA5FyJtZlTttBFwGU9feClTSuz/UmWCfqoPPzLF3fevGPRZgHJk95gfZbBdorzvJNukn
    wtpe1HY/+ydmBdX/qbKFsrrVz7CXIx049KFh+XKY7liiAYAgtlJLwQcD2TAp+kYPw4Tj
    tiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781109471;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=tjgVwi4FNaxJJViF/7FBEpHu/xIqa/70y4+kgnq3xvY=;
    b=Bq0mRuyEuibYFqLGJeQPVvzcdZcvz765TyXwdbUC2+/ly0R+NqhBkHmVTT+eehyYsR
    FzMiD+nK6nWIDSLmtOfOTC4OeBBqWzyJ9yTdq9ZeXEYBXnr7PzIuLUd6rJxH41TrC4OY
    GmkT+dN1fgUqeOp5vgI3wSL5eQzkfZzCVPh7WHs8kcIcoRPjMdXxAk+ObytTQw5DPt1q
    Z0kPULQLRk9ZVRPGuEQRsrSdeO5PoBqJRylF2z2GzguErxDx2dY+9JqsJLoCC1NEjP06
    bej4baW1h31MgWMhG8B2mcxoRxgOHtaqHIu3T+S0ANNWKLM5Gxdu9Log1dCRLjGWYs5p
    Fmiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781109471;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=tjgVwi4FNaxJJViF/7FBEpHu/xIqa/70y4+kgnq3xvY=;
    b=iYBrPTb4HM0DFZwg7JFHY0Mprl4FnPJYQDFgO7kQc4csJz/6e/Xa4Me1vRFNxB49JV
    BRr1EeALbIRu/mU6E0awC45Y5Isj7U3wINaFxETAXk4s3X6ta1vT7r5b2JYHVZkVJNER
    HqJpA9valEcexQ1Nb2qskKt1NQvCBzA9VLkZoJaVTd99HU/vekeGcHRPdImrrkCG/5rh
    iCKJk7m/DYOplIrRkAsrOqDB8e6IWlrOs7kFCCW/kbOCsAU8eVOt4FdMitGY6H1wc0KE
    pED19InJqkFPhI/evBfEWh66QeRjkhq5w5Dxu/9Asm7K2LkXf+2I+6XkThSJWn0E5e9r
    wqxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781109471;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=tjgVwi4FNaxJJViF/7FBEpHu/xIqa/70y4+kgnq3xvY=;
    b=7dmc+qM4VzxFOcFGWufrHKcB9rOAyGQswY62jjWBE3QxKBoJCin8WiiEzLq3Ggk7Gw
    m9lvHp2m/SiJ2gv4pcAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from vivo.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25AGbprfm
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Jun 2026 18:37:51 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2] can: bcm: fix CAN frame rx/tx statistics
Date: Wed, 10 Jun 2026 18:37:43 +0200
Message-ID: <20260610163744.51980-1-socketcan@hartkopp.net>
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
 net/can/bcm.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 658c4a7a55df..e5db4dca8d5a 100644
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
@@ -487,16 +500,13 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
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
+	if (atomic_long_read(&op->frames_abs))
+		atomic_long_inc(&op->frames_filtered);
 
 	/* this element is not throttled anymore */
 	data->flags &= ~RX_THR;
 
 	memset(&head, 0, sizeof(head));
@@ -733,11 +743,11 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
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


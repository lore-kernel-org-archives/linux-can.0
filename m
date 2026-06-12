Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BDE364059
	for <linux-can@vger.kernel.org>; Fri, 12 Jun 2026 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262346; cv=pass; b=Y7onPkocKGDhxfdmw/CnJBX85ic19BrOpcQdOL+5wJPXBk63VTzEg/e2lYGq3Maxt2w0bXcgJh9P1ZQxlNBSfKKEH51EyPT4MBTB/tmzwouaW9VZTU6+LdYKPVhOphOjaghfa5uDPH2xBeTy1Zir7/CwKdEy6Xm/94y2Xu9Gee0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262346; c=relaxed/simple;
	bh=nUY9mm3+YuEaI/p5mEo+sCceD6YhdL0/TRU42ATFRfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZleZHMvawb+oi+0RWoHnoys2fimuyYqblDO9UHCRcG92m5kUIpcDi4+UKxk6joOnnUI1++J+2u3ROwns984FVrW9lsKPG34NwFnRWiRJfSEs3xCIo0gbKfCbQw7sc3VHUtCYwBf2bC30P3XuPFxMGrfjY0zKF5G93ep78EaCtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sP2kV3h+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8ABS/pfl; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sP2kV3h+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8ABS/pfl"
ARC-Seal: i=1; a=rsa-sha256; t=1781262337; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rsrSeN5B2M2FNjj9H18F3aY5xJ/4J/vmUnBM2vwpUrxHcCUDy2XKJYoG91aNqCav+R
    3pTRh3eQ8DCGDWJQUdrS31wdiSqZWi311z3yoo+Cxh+UqE/94K1zwDqnMsx0bYBz9puo
    N3i8rK4FbRiH+b1LWisuHoSvqIcG+zi7Q9ktILposrp7gGwCuaB4mmVtnSl+04fPav1b
    nH4nXHTgpRm9Wnt5ir39rT7qGFfkKnM8AdI2PBfxuW79LQHUibwABYaswDCj4PApZDNk
    +3JXm23tzcKZXysbZlltLI+tqZSilRessi1Qie9TNe+yUhXQy4RNlb/XT3kDg/xf5gSG
    M4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Rbhzw+SMeGaT5jYzRbnQAbZ3kO9SSkpwiwF2B9tAuKY=;
    b=UiXphrUMlTB3M3d8xoGQQqY1OHu7rDXfWFJC4nlxO9A6cd5bKsJpDRCNdGzGAXnDEz
    DL4K7Atc/HM7JRy3WlpCx8afnRKkwbgkB/SHGar6yk8n0Vh1pksYmpC8P9dYRq+l5rWM
    VVZbUu532sm2fkTqcAtJxm5lL2rHcvkCec45b1hhY2W+a5elKw8daFObkG0fVV9GxK/D
    KkpfXo4+2p8/WbBoLCnN9rZMcnWIYT+VD+htVdnIiAT7FqD7PAOw3hbOWktH9ebm+Xm5
    Ijny4QB7S/Ltt6UwkByOTyQlhweIRPjFhh8bWXoYC6HZsiMHl7N58uUW4zFQ47wtorh1
    +DAA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Rbhzw+SMeGaT5jYzRbnQAbZ3kO9SSkpwiwF2B9tAuKY=;
    b=sP2kV3h+1hbcRWayHwBUlHU+HiveOyVIWkxKwHksc+BvV43xmwcDsarwFVPffS7aHK
    Xe/CQu0bzDHqhw4frUsFWxPjZgzEHhIEFDfXiBZ2YX66xDlFMARGsAOj45V7wxHoOP9a
    DI9lyfe8PbOay/66U8bBQ1JwbniN/126VPGHx+iAxr7Ovd2V2IdgKPWize/ebszvYxXZ
    Uk3GFyz8SEbc6TxrWz/4g6Ak5CmBaHht+3VlbyrdD5sJ6JtEhsIwSjMgdEah0GTqAriR
    sSPffyB5kfe308olPZ9QSDQBIdKOvqF85nRIuhPxtkSxxugdIZvp/JiQGH9sqapNP664
    B/zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781262337;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Rbhzw+SMeGaT5jYzRbnQAbZ3kO9SSkpwiwF2B9tAuKY=;
    b=8ABS/pflH8c3KFzFbeEU/SQ+OXVQ332zx+xZjbIyWWFJ5p113AJjj/oCRHaKqiDJaH
    bLUO9rVzWEHGhhwG7TBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d25CB5b8wC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 12 Jun 2026 13:05:37 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 12 Jun 2026 13:05:20 +0200
Subject: [PATCH 5/5] can: bcm: use list_add_rcu() in bcm_[rx|tx]_setup()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-bcm_fixes-v1-5-ca2fa07ee70f@hartkopp.net>
References: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
In-Reply-To: <20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781262336; l=3644;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=nUY9mm3+YuEaI/p5mEo+sCceD6YhdL0/TRU42ATFRfU=;
 b=l7strvXtmECWUMgCJxdhtlBUMnb+KsoFu4h7KYSWmFnBDRWr6GD1Q82ILx/vnIWT6HwoVKsiv
 EusQTYTBWCzCD05Yot8wVxh5EynvgdwHWSx3YGrmLxHyO3Zv4keiRxl
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

sashiko-bot remarked the missing use of list_add_rcu() in
bcm_[rx|tx]_setup() to have a proper initialized bcm_op structure
when bcm_proc_show() traverses the bcm_op's under rcu_read_lock().

To cover all initial settings of the bcm_op's the list_add_rcu() calls
are moved to the end of the setup code.

Reported-by: sashiko-reviews@lists.linux.dev
Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.kernel.org/
Fixes: dac5e6249159 ("can: bcm: add missing rcu read protection for procfs content")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index f1f1f11d1f92..6a1d52189c0a 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -263,11 +263,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "%s%ld%%\n",
 			   (reduction == 100) ? "near " : "", reduction);
 	}
 
-	list_for_each_entry(op, &bo->tx_ops, list) {
+	list_for_each_entry_rcu(op, &bo->tx_ops, list) {
 
 		seq_printf(m, "tx_op: %03X %s ", op->can_id,
 			   bcm_proc_getifname(net, ifname, op->ifindex));
 
 		if (op->flags & CAN_FD_FRAME)
@@ -969,10 +969,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 	struct canfd_frame *cf;
+	bool add_op_to_list = false;
 	unsigned int i;
 	int err;
 
 	/* we need a real device to send frames */
 	if (!ifindex)
@@ -1109,12 +1110,11 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 		/* currently unused in tx_ops */
 		hrtimer_setup(&op->thrtimer, hrtimer_dummy_timeout, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the tx_ops */
-		list_add(&op->list, &bo->tx_ops);
+		add_op_to_list = true;
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
 	if (op->flags & SETTIMER) {
 		/* set timer values */
@@ -1132,10 +1132,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_cancel(&op->timer);
 		/* spec: send CAN frame when starting timer */
 		op->flags |= TX_ANNOUNCE;
 	}
 
+	/* add this bcm_op to the list of the tx_ops? */
+	if (add_op_to_list)
+		list_add_rcu(&op->list, &bo->tx_ops);
+
 	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1293,13 +1297,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
 			      HRTIMER_MODE_REL_SOFT);
 
-		/* add this bcm_op to the list of the rx_ops */
-		list_add(&op->list, &bo->rx_ops);
-
 		/* call can_rx_register() */
 		do_rx_register = 1;
 
 	} /* if ((op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex))) */
 
@@ -1374,14 +1375,16 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			err = can_rx_register(sock_net(sk), NULL, op->can_id,
 					      REGMASK(op->can_id),
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
+
+		/* add this bcm_op to the list of the rx_ops */
+		list_add_rcu(&op->list, &bo->rx_ops);
 	}
 
 	return msg_head->nframes * op->cfsiz + MHSIZ;
 }
 

-- 
2.53.0


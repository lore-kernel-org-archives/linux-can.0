Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FA3644BE
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784023934; cv=none; b=pBYrv+cBzL0T14+xc4CfY4vfABbyqj2sE/H6B374RKLZjEsFj3nuEkMtWJAdCiZmntNfDBXxoFET4WWVLn0a0PVNS0yl0bZJ/ZD/QP16+OngzCcBs311fCyiXTVUZv/Kh0UUcqw2lR18jwKvBkya5Z1OB7QhoVfHBEhvbqVbgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784023934; c=relaxed/simple;
	bh=ITxp5N1anUjruBzD62UPJkbbBWHVqPOjhEUE5EnXCXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5O4p/tZ0r3WdMpt5gcHW6ikuhZ3sWUdAouUlXeCkr3iaiGgEsYLVHKKxX7pahvKUwcYVqztv8+PH0BAzNG9Rc7ZL5MNoAK2cW4mlIwka88D9+LM9uRBBs3IcY3RwwSrKn6CpaqyVbhgwPhyjdZYnuYZqQ2UEM418u9GtNhILCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMM/PxVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMM/PxVH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA302C2BCFB;
	Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784023933;
	bh=ITxp5N1anUjruBzD62UPJkbbBWHVqPOjhEUE5EnXCXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oMM/PxVHxSSQchowNDfRnmnojeyPLMOe0y6DJU/dFX7pj1UZgaofIrQHCgDB979F+
	 UTOgCrp2ds+aVzjq1k/kiLTtqBBYPgD4IkFVo3BcwmxOPxRCGwWs7T5bqkadZxfPMW
	 Bta18df3hu332KuF2JP7bFL3m6VqWGY3EM6Rdt8Ginweo/3xeCwYPzhvThrvdE/329
	 9MJvtwppLKaiWofhgAT4hDaFKSYHr8zHnYnvKtaVYdvXm1FpaJA5W178vXpZGVa9Q3
	 tvKMwpLJssj1XsUOUXd+9p+dl/K4sEWtQUKIUoWrzkj5OGmF35bzQOu7mElcYAL3Ev
	 +fVtk6pFriuXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C7C44507;
	Tue, 14 Jul 2026 10:12:13 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Tue, 14 Jul 2026 12:12:14 +0200
Subject: [PATCH v13 10/11] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-bcm_fixes-v13-10-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784023931; l=2506;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=wXwF661IknEKW7qZ15IavlY5BkrubuQhc/7C/5uYwEI=;
 b=WETOyJs36pKMDb/nc4s2M8mq8aLEt0MSfe2Fc19EKXwLLavjGoLcSbwf6mSnpciJ2bGI0lLmH
 O7LMF0bpWe8Bpk7+aUoIXeGu/91grF4PP8gxBX9z4H6osinAeKTqnB7
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

From: Oliver Hartkopp <socketcan@hartkopp.net>

For an rx op subscribed on all interfaces (ifindex == 0), the same op
is registered once in the shared per-netns wildcard filter list, so
bcm_rx_handler() can run concurrently on different CPUs for frames
arriving on different net devices.

op->rx_stamp and op->rx_ifindex were written before bcm_rx_update_lock was
taken, allowing concurrent writers to race each other - including a torn
store of the 64-bit rx_stamp on 32-bit platforms.

Beyond a torn store bcm_send_to_user() must report the timestamp/ifindex
of the very same frame whose content it is delivering. So the assignment
is placed in the same unbroken bcm_rx_update_lock section as the content
comparison.

As a side effect, the RTR-request frame feature (which never reach
bcm_send_to_user()) no longer updates rx_stamp/rx_ifindex, since only
the notification path needs them.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 10dd99ecce70..0ada2402c24c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -777,15 +777,10 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 	}
 
 	/* disable timeout */
 	hrtimer_cancel(&op->timer);
 
-	/* save rx timestamp */
-	op->rx_stamp = skb->tstamp;
-	/* save originator for recvfrom() */
-	op->rx_ifindex = skb->dev->ifindex;
-
 	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
 	spin_lock_bh(&op->bcm_rx_update_lock);
 
 	rtr_frame = op->flags & RX_RTR_FRAME;
 	if (rtr_frame) {
@@ -813,10 +808,18 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
 		traffic_flags |= RX_LOCAL;
 		if (skb->sk == op->sk)
 			traffic_flags |= RX_OWN;
 	}
 
+	/* save rx timestamp and originator for recvfrom() under lock.
+	 * For an op subscribed on all interfaces (ifindex == 0)
+	 * bcm_rx_handler() can run concurrently on different CPUs so
+	 * the CAN content and the meta data must be bundled correctly.
+	 */
+	op->rx_stamp = skb->tstamp;
+	op->rx_ifindex = skb->dev->ifindex;
+
 	if (op->flags & RX_FILTER_ID) {
 		/* the easiest case */
 		bcm_rx_update_and_send(op, op->last_frames, rxframe,
 				       traffic_flags);
 		goto rx_starttimer;

-- 
2.53.0



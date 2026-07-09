Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672974DB54B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619782; cv=none; b=adSix52UawXZS0rq2xEw1ha1wUbR4OdpvZolu9AM/hrE1Be3uBTXPNZB/bgjDkHh5RVkQhhgsJWdGC1R1c83kmw0rejfCbCviBKgaBwsWsWT73uvqrvS0h+d51oXJp84GdGnEae43KfSDQk97xje1TN23mz9xx09xOckde4rCWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619782; c=relaxed/simple;
	bh=NaLu2bcKFax2q55qcoiSIhxlY7LIkmWJ2DtI+XiDPqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SN6SKIsbmPdIqmOYxUqZukyADNOMSlv6DwoDnY780eTIB5iBrAZSODZcXtrns+OFh2Yb1BHSNFHEAIj2ufgnCU6U+6JruByy023q5inElUuQxh01x2IWtY5L8tJQ1oXPqj947oI1tj0dTgdLwhjYsRb5k9QUDbiM9UPL3Ywfy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtwYqtFp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtwYqtFp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EC2AC2BCFA;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783619782;
	bh=NaLu2bcKFax2q55qcoiSIhxlY7LIkmWJ2DtI+XiDPqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TtwYqtFpkaN8ra1jivOCUAVgluUoLB5hksAQTsimFQMRA2JQ7pck6qeSvz0ZljQOk
	 GJG13HNxoIgUhhwm7qzqC8jHdHXvXQSNfPuYLIxxLod+vx3lvrXIZnKLJOn99VYhZj
	 L967UXZaYxDZ7fWjgeJV0uZOg8aC5lyM6UvqScM0Ds5dpcg6l/Vtf8SIWByqFhbZzE
	 8+mw9+uWp0+AFgFlfAWpJV4nHm6DEHphiAz5kjwSzXpXu0LrKJ2Q70BORHurpoe2JV
	 rqhPTZZ9w0Bd+yfkzD6aJo+0WNBYIEQr1/GwCjVrF3C8rMbzM3YFhBgvda42NAc9Ln
	 iD0EpOf/woCZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF78C44501;
	Thu,  9 Jul 2026 17:56:22 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 09 Jul 2026 19:56:24 +0200
Subject: [PATCH v11 10/11] can: bcm: fix data race on rx_stamp/rx_ifindex
 in bcm_rx_handler()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-bcm_fixes-v11-10-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783619780; l=2506;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=w5zqfxihgc/yy09d86zBn5oM6DwZxtzW1xBRcXs3jsM=;
 b=7Iut/fa3uNwBv7v062HsQshZSZ4C3yp0Lvrg68ZHoiMwv8pQdBBq6L6W9Yj61oLgXtsPBsx2f
 wZnofwaPBFZA690VihCe5Mod2sCOqk3KzpCpHBshXVztN0cIfBKRqjE
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
index fbf1cbb7c99f..10a883b50fc6 100644
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



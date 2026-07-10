Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91443DA21
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702073; cv=none; b=EI8pbmWZAGxUrgv3ivHawNf/7T7ntNheSRR5wOGjVX2s9EHP8jEg1GKeWKlkAODcsxRQXwO1fIVp9pEqPKyEmQA2/12ncMMvQZp/DL54mMEcJgdVE1A/asuegmztLEBFXjhQaQLAY2ZjbkHxn8WXE/yImhzw8Ny/WwZ0LnuIT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702073; c=relaxed/simple;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU43Ld2THq1jFqHrTQS9qDeE0QW2g/nQkzFXqGE63ZkhSA92i01Fm0YNEW54++uHGGmkZSZVLG9lR0Am7AzyP3zQr/bCFd3YrgkwELo9FVJqjhGzuH+AB/y5wgeIJ8CSApgcKAvOUEa1iW+HNuXF75g2q5hPDW42JEsiAep+o78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7Cb3t83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7Cb3t83"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB9CDC2BCB8;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783702071;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o7Cb3t834XW/7VzDF6SQ97phKePbXIy1TiZunbnhjtKaQMnh198+E2/w65HmCtNeQ
	 EPu+LoQ97Yx7y1zCd9FOTbcT6WE37I4UMRR/nvrwZfPTQQFHFSBLOlKHk78BFog/5I
	 LI4u1P8U1nFtuT08ppDpYVJMU+iC4hUkLAMqRzRYyUar8Srvnehvpx1QE9i4j9FdIn
	 FSTm91n5Ou1AaUnZDAnZW7Za7U9IZnPOjW1FhG7D0Uzt3vTMSMbRR//G/RUJESv33u
	 bmiopK4NRUrt8nrtJp263d7cBgrpcX/Yn0ZhixCqKP+YDVvBtf1cjpdJslyec97oWh
	 0xh+z3cxj3Q3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ED1C44510;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 18:47:42 +0200
Subject: [PATCH v5 1/4] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v5-1-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702070; l=2234;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cSnqoBGcs6wuKBDxRmdL8uS6RqC/TXOr+Os8bOLeol4=;
 b=macVHCWFM9RU6PIYD6969JJoJ+FdnbYAYiXLYITOohM/2raAsgiCX6AQjpfUKQF/0kTFYPCGF
 gsLWAgZpz5/BVl/7ZmRd2p26iHfHbs06P2EVLWEt25bkRAave+pctZb
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
and clears so->bound without waiting for a grace period. isotp_release()
uses so->bound to decide whether it needs to call synchronize_rcu()
before cancelling so->rxtimer, so when NETDEV_UNREGISTER runs first it
skips that synchronize_rcu() and can cancel the timer while an
in-flight isotp_rcv() is still executing and about to re-arm it via
isotp_send_fc(), leading to a use-after-free timer callback on the
freed socket.

sakisho-bot remarked a problem with rtnl_lock held in isotp_notify(),
therefore make isotp_release() always call synchronize_rcu() before
cancelling the timers, regardless of so->bound. This still closes the
original race (isotp_notify() clearing so->bound without waiting for
in-flight isotp_rcv() callers before isotp_release() cancels the RX
timer) without adding any RCU wait to the netdevice notifier path.

Fixes: 14a4696bc311 ("can: isotp: isotp_release(): omit unintended hrtimer restart on socket release")
Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.kernel.org/
Reported-by: Nico Yip <zdi-disclosures@trendmicro.com> (ZDI-CAN-31764)
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c48b4a818297..d30937345bcd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1235,15 +1235,22 @@ static int isotp_release(struct socket *sock)
 
 				can_rx_unregister(net, dev, so->txid,
 						  SINGLE_MASK(so->txid),
 						  isotp_rcv_echo, sk);
 				dev_put(dev);
-				synchronize_rcu();
 			}
 		}
 	}
 
+	/* Always wait for a grace period before touching the timers below.
+	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
+	 * filters and cleared so->bound in isotp_notify() without waiting
+	 * for in-flight isotp_rcv() callers to finish, so this call must not
+	 * be skipped just because so->bound is already 0 here.
+	 */
+	synchronize_rcu();
+
 	hrtimer_cancel(&so->txfrtimer);
 	hrtimer_cancel(&so->txtimer);
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;

-- 
2.53.0



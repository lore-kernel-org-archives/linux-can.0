Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422435DA43
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783879183; cv=none; b=FdEbeiGl0MVuB2jcNteZnJFjZle04/3TPkhLL7SxKhZR2/u7BxzbVB3iozAYnHMaxriEHApTAq3hKFcIsZOJ0qflZiXlENz4W/rR6DZ5xy8Eff2SZmdbTMRYmo8IZ06TfHNhn+BTYyYADpNO8NHbzcF9B5QilTaf9L+FlOSx54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783879183; c=relaxed/simple;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JD18HnpyvLkjlj7lahx5X8nfKh5iek0dd3LMkmngKXY2hd+D7ZTFOcsB3EzYQPdjrA1TP5WMP1xIsrTukVVfS8XmCiS3jfDXVpn1wQA7Q4LNBcsicZffaKt/TVHmr0dlWNoGRwnoCvFc77iTdJVbyyZtUgUVu5dLA2lbnIc3/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRusD1HN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRusD1HN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38DE6C2BCB7;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783879183;
	bh=VQe/jgFFTN7W5Ep2gIvymZ3dZ87mYZKX5LamygCl/20=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tRusD1HNu1siABeQjzSGy37qBssjcHE2L6sKsPCGT0RivwdMUnqYO7cokF3aT1eRw
	 fwNhhGyv5n1SRfKv0/xXstjZWAQgxU1kEqOr1d+AtFnl7jVmbaK5ndeQ706XLwj4qb
	 0//WiIQLRQXQoEBU7T058d/iYkoqInVbdXJuqD+EYWRdbzEkMolsiur94yg0aasuiT
	 kYhsX7IgzVZB5nP9YF3H2BcunXdSKmLLDQHJGCr7WasGPmsDC9Cs5XwI412udaIvJM
	 EtqKXPSedP914K0X3PJxFqeoiEKQnxJ/4vPP7SWzDsqXTDXcBMifdkw2hb8lLqHdh/
	 1xL2pty8ssT5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A5BC44506;
	Sun, 12 Jul 2026 17:59:43 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sun, 12 Jul 2026 19:59:41 +0200
Subject: [PATCH v10 1/3] can: isotp: use unconditional synchronize_rcu() in
 isotp_release()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-isotp-fixes-v10-1-793a1b1ce17f@hartkopp.net>
References: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
In-Reply-To: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Nico Yip <zdi-disclosures@trendmicro.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783879181; l=2234;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=cSnqoBGcs6wuKBDxRmdL8uS6RqC/TXOr+Os8bOLeol4=;
 b=3J6d7XxxejEHfJNYgEFbKQ9EDpVhINGM7g5JHgw8fBoqEhJrvCfvq/NcwByJEIT+HN1a6MNnC
 k6OzNxpnndPBtmsd3Nnd9lKQFE1UyPK+8CEwLmwRqhHSmMbIPTbmLHM
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



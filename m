Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EE3A5421
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771636; cv=none; b=Xm5YJwFJz2bK5FhFVyxOeM/tiGLaOy2m3KBX7G6euUHah0+CnejwCGYsJfzkq6aNGhLSY3TtoqT4CFHkdTx+pU3NVY7DDtCFJuwTe11tRF/sIrbBOSRCqXZxN6gMvZJP3Wkq2XyM7JSkxbIgcppC2QpALizp15fgJiEztYiYxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771636; c=relaxed/simple;
	bh=O580kP1XGO7p7EnnOw9Wqtd4zlJwEnXRf5ufI5BU94E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2gBKdI1E53OzEIzKVwVczt2RQyvTTNb3/O+el77qTPn0mOGT2XjyPlyTt71SHjRafgbCNE+mY3M8Kq4O++tnBUFuWxtCDOeLXGjRgGD+Sz5Lugpa5/q28ixtH/cYGJnzhcdzKiZA6AUSBfHTvL8v46ZZ95yhnPOQY9ZfKzHcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqoQvoHB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqoQvoHB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 258E4C2BCF5;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783771636;
	bh=O580kP1XGO7p7EnnOw9Wqtd4zlJwEnXRf5ufI5BU94E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SqoQvoHB39xKhAm/zyiXVQEgvqlzPAev2+ZwarBEdnDzwksdEm8DL4Sl0A8swthuU
	 NlARnlvG+Sa0yhwSQdOOUEAsnXC0WDK3MJlVnjDqBVZmIUrGIuHXBnJdHrEyTvBXK2
	 fUtLiFMAIagvCFIK79vF0y9FGghqPNLOqby0EKyyF3ITAQ7WknywylZYwuvsJyp7xj
	 xi1DjyV8stEHg8wciXJ6mwmtrQpzl+a0qRlL+hk4/Y7q0c6FRgqjvusg2ydt3aiNP3
	 O327+TvXPE8/8RWCmwwYAG22dqmM8EzVFzUSCVVl9vYzWKKrF0QkOGSn/dUsgTLXNo
	 eGX5L5NcgFIKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D23C44508;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sat, 11 Jul 2026 14:07:15 +0200
Subject: [PATCH v7 4/5] can: isotp: fix lock-free state transition in tx
 timer handler
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-isotp-fixes-v7-4-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
In-Reply-To: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783771634; l=2796;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=xz7GuYuo8P+J3FDWgky5q/m8YvwXVjcontDxzs7dXqM=;
 b=TAI6vdthk/5GhjcFxrfq31Gb6e0DCEWONoQUHwlBi1CHOeUYlasZgZOq5ZGBIwg6W9/QQPsFw
 QsgXHCMeWylBQaG3/u6LbVEzZVFZDzV18oCHkWMuVDQ7RG2hRPsjOKG
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit 051737439eae ("can: isotp: fix race between isotp_sendsmg() and
isotp_release()") introduced a lock-free state machine check
to prevent race conditions between the TX timer and concurrent state
updates. However, the original patch missed replacing the initial
state checks and left the late assignment of ISOTP_IDLE as a blind,
non-atomic write.

Fix this by properly sampling the initial state into 'old_state' and using
cmpxchg() to atomically move the state to ISOTP_IDLE. If the state changed
concurrently (e.g., due to an incoming echo or a new sendmsg), the timeout
is stale and we bail out safely without corrupting the state machine.

Fixes: 43a08c3bdac4cb ("can: isotp: isotp_sendmsg(): fix TX buffer concurrent access in isotp_sendmsg()")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.kernel.org/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f05703ddd2ea..fdb2109d7c27 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -940,24 +940,37 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 gen = READ_ONCE(so->tx_gen);
+	u32 old_state = READ_ONCE(so->tx.state);
 
 	/* don't handle timeouts in IDLE or SHUTDOWN state */
-	if (so->tx.state == ISOTP_IDLE || so->tx.state == ISOTP_SHUTDOWN)
+	if (old_state == ISOTP_IDLE || old_state == ISOTP_SHUTDOWN)
+		return HRTIMER_NORESTART;
+
+	/* Only claim timeout if state is unchanged to avoid overwriting
+	 * concurrent state updates from isotp_sendmsg/isotp_rcv_echo.
+	 */
+	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) != old_state)
 		return HRTIMER_NORESTART;
 
 	/* we did not get any flow control or echo frame in time */
 
-	/* report 'communication error on send' */
-	sk->sk_err = ECOMM;
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	/* Once the cmpxchg() above released ISOTP_IDLE, a concurrent
+	 * sendmsg() may already have claimed it for a new transfer
+	 * (tx_gen changed); don't taint that new transfer with an error
+	 * that belongs to the one that just timed out.
+	 */
+	if (READ_ONCE(so->tx_gen) == gen) {
+		/* report 'communication error on send' */
+		sk->sk_err = ECOMM;
+		if (!sock_flag(sk, SOCK_DEAD))
+			sk_error_report(sk);
+	}
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 

-- 
2.53.0



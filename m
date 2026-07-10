Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D836DA04
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702073; cv=none; b=rB8OZO9In5YFdt/MkdAhyDWcMDKV7EuHL7dTTKmiQYVjrassrcELIjiQLg0cib6ekbwjv9k1mbWUL2FMgHtj0a3Iviqy4VfwQphoXbSOHU8LWL3Q3IwHt047wD7No/+8IE4YYyxKk+ywISuYXLMWi8+cMATuFaCbyKc0pL8bhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702073; c=relaxed/simple;
	bh=PLV/jooVwuihNW2OX8gBQsL9YdQlxmhiJYZOClq9bNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgZ2/g53zFGcUGJPf+swgGdEaLx2L3GNVPX9RE+OXfO2J9vQpfhbX/3AzJMopPL9QNl8ppDcTGzizMc7I/FBmhUNrHX/R7V4Cbg2yAofjAWCTE8nZ8v9Md3Newly5CKH03RJJ2cqBVZZj+HO1Y+bs2wr+na9rdcmpy0QgaH2qEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+BRbT/x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+BRbT/x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0336C2BCF6;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783702071;
	bh=PLV/jooVwuihNW2OX8gBQsL9YdQlxmhiJYZOClq9bNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z+BRbT/xMh7GvXj9k/52VJGxViksSj/AgzPhW8YHFxBd9/cy2IXIyFInGwq/dRH7k
	 D4kZ8spRP8Zv2Dq1nSFD8xlf1LNxTV6ipkgZS/nopz/FIU9X4dibb0zdmGOAqOt1wq
	 /r4pdBJnA+vnoSljJiJQpaHih9Q4g7+v8PiHz7XPFVI1PLQ3p5XWqeiVGEVPNc7ehR
	 3Bcz1GJWwPbVv5wgSUT/Tpx+pPqVsNSoxEetgGMoDeywJgcycaRripnTtIxpvJnJ5L
	 wX3rZ4T2q2ChPJfq6nD+aKGFN4V/H6oaf4K0eX+vVqSKWMDqnU1QXaIQQtRZV27jwH
	 zU9QO4h8GfPwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0925C44510;
	Fri, 10 Jul 2026 16:47:51 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Fri, 10 Jul 2026 18:47:45 +0200
Subject: [PATCH v5 4/4] can: isotp: fix lock-free state transition in tx
 timer handler
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-isotp-fixes-v5-4-15174d82d6f1@hartkopp.net>
References: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v5-0-15174d82d6f1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783702070; l=2302;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=+W/UstpuXO4qYvPTEsT8MwwHKxsCbxJm2/DKnaFQnmo=;
 b=7YrOWQHP859FFbhGobj/lHa1w6L7TPt75xfba/rzEQOINQgIgdsJXGkVTqBjJ2IomDervbZ+v
 dkdh+PE6VKACnX8tTgJASKCnJwjcN9fULdByGgcdeujMnTXFNChyyCZ
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
 net/can/isotp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index c0edbd35516c..e49a58e188e6 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -920,24 +920,29 @@ static void isotp_rcv_echo(struct sk_buff *skb, void *data)
 static enum hrtimer_restart isotp_tx_timer_handler(struct hrtimer *hrtimer)
 {
 	struct isotp_sock *so = container_of(hrtimer, struct isotp_sock,
 					     txtimer);
 	struct sock *sk = &so->sk;
+	u32 old_state = so->tx.state;
 
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
 
 	/* report 'communication error on send' */
 	sk->sk_err = ECOMM;
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk_error_report(sk);
 
-	/* reset tx state */
-	so->tx.state = ISOTP_IDLE;
 	wake_up_interruptible(&so->wait);
 
 	return HRTIMER_NORESTART;
 }
 

-- 
2.53.0



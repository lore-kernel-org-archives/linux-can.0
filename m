Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67F3D3499
	for <linux-can@vger.kernel.org>; Wed, 13 May 2026 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653160; cv=none; b=I6llTU6fhBLHnU0YmYbpRs1IgSIfZhPPO4woUo+f6VNKKREFStS4LywC85t3h5js54oyY/i81gxgQmkWhFfY+CLa6pAsqML8g5hX/VLqZ37auQrbqBHTyrfDpmDRTG8d2w2rxXB9QL7j/L26OEPS9zLqvJeG0CdzTibppJ9dwC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653160; c=relaxed/simple;
	bh=PHaGKgtvzC6KHwX0lmmeI2qFFzCI2UodpxK+IBGcxnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ks6bafHAYG/XgoY9sdQYq08rLzh+39RRozIijAj15++Kj52gSQZb/s6gXGKoFfJQiha06RdUjTclVfxbt/y8VRQOBRXf9drbC06P0BCmW4d0LJfLjLNPXy5Qtqs9dJO0sUbiJzE4MnlmGYD2n9Vclk0xCXtEsx+Xnrk9w8Od60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=wjw8yAQm; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="wjw8yAQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1778653155;
	bh=ZPfd4QVU32sg85rtvgJTvaqyRqM7XRlftnMouVyTzP4=;
	h=From:Subject:Date:Message-Id;
	b=wjw8yAQm1kBOhHKxZ3m+E5DLvy27dfC9Z8zC2osojBxPqvxeQyqZCHbLGH/qpquzx
	 SuTCmH7WDzdNxEwwz/llt5TR/UQHVHiWpkaZrmlrlNyxkGRZJHx06VM+3IpvQQ1pkw
	 7oq/IYnle2T6DkntRF8lN00EG5Dach8WrMjrlWnk=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.23) with ESMTP
	id 6A0417B4000014C5; Wed, 13 May 2026 14:18:34 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 3135098913013
X-SMAIL-UIID: CD07E9044C1644B3847C377BF3937D6D-20260513-141834-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sam@bynar.io
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 6.1.y] can: raw: fix ro->uniq use-after-free in raw_rcv()
Date: Wed, 13 May 2026 14:18:28 +0800
Message-Id: <20260513061828.3671533-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Page <sam@bynar.io>

[ Upstream commit a535a9217ca3f2fccedaafb2fddb4c48f27d36dc ]

raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
but receiver deletion is deferred with call_rcu(). This leaves a window
where raw_rcv() may still be running in an RCU read-side critical section
after raw_release() frees ro->uniq, leading to a use-after-free of the
percpu uniq storage.

Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
socket destructor. can_rx_unregister() takes an extra reference to the
socket and only drops it from the RCU callback, so freeing uniq from
sk_destruct ensures the percpu area is not released until the relevant
callbacks have drained.

Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame for overlapping CAN filters")
Cc: stable@vger.kernel.org # v4.1+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Link: https://patch.msgid.link/26ec626d-cae7-4418-9782-7198864d070c@bynar.io
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
[mkl: applied manually]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 net/can/raw.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 488320738e31..bcd6061f43d8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -336,6 +336,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -362,6 +370,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -409,7 +419,6 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
-- 
2.34.1


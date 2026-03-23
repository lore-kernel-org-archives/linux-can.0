Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651C38BF92
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261957; cv=none; b=A+Zw0i4oLCABoNNSirR9AEJsys1IIaSl/HYnDJxbBy6tHTQ8PKvHovRUH1QIvtsLcBnFOeGmLjY3yEuK5wEIC501DzJ97t3JBYv2gW80GlQ+Cg0XtjNwoqlVLGIDZKeDjXllpschrmvwA1AiTYcqdQh/r6LBSPUteOWI6YiKviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261957; c=relaxed/simple;
	bh=fDHrWXDpkRPsmJEbJNpTDh7CHwdncGu6UJRNbda6ZGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu2nSbsiUBizCHM2tlXwDFVrBtw+BfKTFN95SggPhA2wHXQ99Q9OEVMWOgl/km0ODDlXo7YEv2+hPfkqx3A66XobAPQVXo3LkIdvQFVF7+gkMxWgNRf+SZIQKOXdh7aDzeefk6SsN7J/GU9CIR/vNKjSyYAi/la5pnEisNUFoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caC-0008FU-6m; Mon, 23 Mar 2026 11:32:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caB-001i5m-1P;
	Mon, 23 Mar 2026 11:32:27 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 203BB50A7C1;
	Mon, 23 Mar 2026 10:32:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	stable@vger.kernel.org,
	Ali Norouzi <ali.norouzi@keysight.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 5/5] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
Date: Mon, 23 Mar 2026 11:28:01 +0100
Message-ID: <20260323103224.218099-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323103224.218099-1-mkl@pengutronix.de>
References: <20260323103224.218099-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
wait_event_interruptible() and then calls kfree(so->tx.buf).

If a signal interrupts the wait_event_interruptible() inside close()
while tx.state is ISOTP_SENDING, the loop exits early and release
proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
while sendmsg may still be reading so->tx.buf for the final CAN frame
in isotp_fill_dataframe().

The so->tx.buf can be allocated once when the standard tx.buf length needs
to be extended. Move the kfree() of this potentially extended tx.buf to
sk_destruct time when either isotp_sendmsg() and isotp_release() are done.

Fixes: 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260319-fix-can-gw-and-can-isotp-v2-2-c45d52c6d2d8@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/isotp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index da3b72e7afcc..2770f43f4951 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1248,12 +1248,6 @@ static int isotp_release(struct socket *sock)
 	so->ifindex = 0;
 	so->bound = 0;
 
-	if (so->rx.buf != so->rx.sbuf)
-		kfree(so->rx.buf);
-
-	if (so->tx.buf != so->tx.sbuf)
-		kfree(so->tx.buf);
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
@@ -1622,6 +1616,21 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void isotp_sock_destruct(struct sock *sk)
+{
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* do the standard CAN sock destruct work */
+	can_sock_destruct(sk);
+
+	/* free potential extended PDU buffers */
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+}
+
 static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1666,6 +1675,9 @@ static int isotp_init(struct sock *sk)
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 
+	/* re-assign default can_sock_destruct() reference */
+	sk->sk_destruct = isotp_sock_destruct;
+
 	return 0;
 }
 
-- 
2.53.0


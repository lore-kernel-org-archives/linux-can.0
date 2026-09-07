Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD444D01F;
	Mon,  7 Sep 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793029; cv=none; b=ArJAmXJxQUGeUjw60XVMI0bDhQvi2i+rTCA67q0DS7GZGxF/34/BUHbaTYgKVCCpZtqFm8/9oVAECiN9xhHx0VLoNnWY5d4tB3HSvuBcEFI0eQ2Jwmo6kFv5vFdPiNo87Ask8DwvCeDUccl7g0hsPT2q1hOay+hq9ptwnTkkMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793029; c=relaxed/simple;
	bh=8sSEO5KFxU3nzE/P3FVIVGqT93El+9a/o2uSrXsV4OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrpdOBauDq1ZNQn/fDjclJreRhMk2CVEkWASJN/pz+0syhZL8iFZCHQBCswuN6rFWKC0O8rSHM/EYjZSSRni6anGO0CqAd2mlrkmgbvGUNbQ/do2jnlnxY7dhPr2ET2IEbg0Oo1hVVOr+r9h9njieKQ6vJzjnvr9IcDfLDwp+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=vSfg4LRe; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="vSfg4LRe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1788793018; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/aI+qVOhEOvgrbm26woGel0noT1B6NJwZUDW1xq5WII=;
	b=vSfg4LRez0ZoHArxnWc8fqma02fqgvrhTeySOSpSHENsGY5YVAHMrkptjVpaDLzAqTYApIRuDuC7/dqlQGqHvsTUuiDiLpKQyk6O5BYy1W7bd8XAwHQpl5wPPMCIMDcTcHkcSPl6cgkxeRvnPn8fGG8tqxziRijPAfnePu6qjPI=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439715|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0992727-0.00469584-0.896032;FP=14468796828864806579|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.j7vgS.1_1788793015;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.j7vgS.1_1788793015 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 22:56:57 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH 2/2] can: j1939: check received packet count before completing session
Date: Mon,  7 Sep 2026 22:56:39 +0800
Message-ID: <20260907145640.1106170-3-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260907145640.1106170-1-liuc63@xiaopeng.com>
References: <20260907145640.1106170-1-liuc63@xiaopeng.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_eoma_one() marks a session complete as soon as it sees
an EOMA without verifying that all data packets arrived.  Add a pkt.rx
check so a session with missing packets gets aborted instead of
delivering a short message to userspace.

Also tighten the existing EOMA size-mismatch warning to actually abort
for receive sessions instead of just logging.

Only unicast receive sessions are gated:

 - Transmitter sessions track pkt.rx via loopback confirmations which
   may legitimately lag behind the real transmit count, so the check
   would cause false aborts on the tx path.

 - BAM (broadcast) sessions never go through EOMA -- they complete via
   the final flag in j1939_xtp_rx_dat_one() when pkt.rx reaches
   pkt.total directly.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 net/can/j1939/transport.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fdce5792..2ecce49ad 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1397,6 +1397,7 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *skcb = j1939_skb_to_cb(skb);
 	const u8 *dat;
+	unsigned int expected_total;
 	int len;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
@@ -1409,11 +1410,23 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 	else
 		len = j1939_tp_ctl_to_size(dat);
 
-	if (session->total_message_size != len) {
+	if (!session->transmission && session->total_message_size != len) {
 		netdev_warn_once(session->priv->ndev,
-				 "%s: 0x%p: Incorrect size. Expected: %i; got: %i.\n",
+				 "%s: 0x%p: EOMA size mismatch, expected %i got %i\n",
 				 __func__, session, session->total_message_size,
 				 len);
+		goto out_session_cancel;
+	}
+
+	if (!session->transmission) {
+		expected_total = (session->total_message_size + 6) / 7;
+		if (session->pkt.rx < expected_total) {
+			netdev_warn(session->priv->ndev,
+				    "%s: 0x%p: EOMA but only %u/%u data packets rx'd\n",
+				    __func__, session,
+				    session->pkt.rx, expected_total);
+			goto out_session_cancel;
+		}
 	}
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
@@ -1422,6 +1435,11 @@ j1939_xtp_rx_eoma_one(struct j1939_session *session, struct sk_buff *skb)
 	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
 	j1939_session_completed(session);
+	return;
+
+out_session_cancel:
+	j1939_session_timers_cancel(session);
+	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
 }
 
 static void
-- 
2.50.1


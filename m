Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705428;
	b=wzMED36wSrQc767NnbI/h2Vb2DNctitSaHGUhebfcv0q34o8TsZLRF/eYqoA70+yIaD+
	 YbBPuKnHqSwcykIVbfP+0j5KqH2ylRudiB6yNog/Zjh+uOnvbsPFcjVyO/Noeg1y+iiCO
	 c7WsD2M0++83iQSuwNXXiDQhbqtaAmuiLBJw9QBmVv1ELndrLxmGZRE1ZZIjMbVjTX6An
	 WlZxe8PIYGDvcWj4dfgl2GfzvWpdB3PAOlc1mQANpbuqFJ/3pT5EQ7wF/IHhEsIDldr9i
	 hipilN82n58b/yLsE9CaR66lDkBafq+CMZLVlWzo8WyDqL5Phwu7kDwe0CHEppubQGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A0nHs2DHN4CrZLg8J552iINpEC7h8BMV5slPOBKdd7I=;
	b=XAh68i9lNcTmoV7GSpTPHCB31E8YNQyYMGTSswBcYjZF0WPglX3As3RJkwThg7skfomO
	 7hAJdDdYtD3hzA9eBxJ1ssGqeCYTjMbE6ifBNz9I524cCgXtQbX3fWgLcE8XiY5kHIyf7
	 cb57QU30PscBmsd/1jigUUN3K8gD/3I69wdbUhsw7gE0df2kqafMuoXlXfMn2fNtxdFVT
	 5j1L5+gu28bIhHUWeOzyGTvjDZZj249dBhc/onPVQvu6gFc+erAx2khGUkhxHMuFm1rjL
	 r3HKjpcecsCj3zkuJYpgOEaI4ZSxWdRsGrf/dqa4Q+ApGJclU2wUeCvbHYy6DpH376w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=XwK+P0aQ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC9606A326
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 15:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3AC9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=XwK+P0aQ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f05bc71e01so30384485ad.0
        for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795705426; x=1796310226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0nHs2DHN4CrZLg8J552iINpEC7h8BMV5slPOBKdd7I=;
        b=XwK+P0aQ+Rp31QXWvDcqbUfM+HK9MCbbBjOXaSxSKoyI+MU00NKDs5WBIOGhY9E1qp
         EQaDUBnD/jk83Laus9blkljVsfUxthsfTXpsawPmCTmqWaqq+z1pcENJFmGbgjGKmZBf
         3xH6J79M17d0C0BMBT7JtlujhM+d3f0uXi0G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705426; x=1796310226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0nHs2DHN4CrZLg8J552iINpEC7h8BMV5slPOBKdd7I=;
        b=vSmQAELInsJ95lZ/Fl9YyzpcbY1bw4i8zemYM6i/tiKadzChsWYJcFeVjG0v4z06bp
         KRC1ee928COpfbQtXD6qZ/elZnGJMNp9NhEzeG0y0kw5Bm2hCd/Dc0+ADmE3bWz7Lg8Y
         ovAuxIzeOWgDU0e7wIh/Rs2bFNDN1aBQFWsUo7+fs8Xx0w3BVJxn750+AgZ4DVSjJS8w
         1P5/9dvvK/bqBdCfJ4TSfHbnX91JPlmSuDYC0dxMMhrVrISzIvjjRdV/Yp3c1fnkT0AO
         +/iEX7xGNCw6SiMVz1t/QcrxHmaVPt0p3tyHow+LLiKAN1ATozry7SbH4+sGXXT65R4W
         iAIA==
X-Forwarded-Encrypted: i=1; AL+hErGLm0N9j7ERsR44VrXi3QwStbyZ7NhXsW7g9w8Yjh+P5+y5WfkPMPxg6FKDTBFJfL4fJ1i/QfadTP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OLa2nRswf5+2hpF1XZXeXyjRWOMwGFp4bOFjDSHGc8oI8ONSk
	7wVaIQPNSMiFttfkDqDJk0ZElUnLO8/B4iuUa66QSQXzaLtbyIO0m4QyYM2SYwzAtSZDZ1M2LH/
	4WptjodbEmA==
X-Gm-Gg: AZFdTZeySqrJBuIwYVfM43qhZs5E21mup+84wDCM1A1ykYsimmZowoS97XImWQo01xo
	VKE/TvTtR9lvcfLt5VTqaCCNEq1OCDEQHmpjoD+3q+/w+ZPlLWANfXNIrYzvMqRxZ1mK6yX1bpb
	68t2KFc01hB3l71Zv6cUTQ3WTVsCrwTv0da8jeMsL8sq6/vzudcjzDa5lz6/h0nOn10Bv8y5CgJ
	X4SG9U2C9aOwSFu/NH5uEhYUDy4SUFUzbvuT4tNxPvVfqSMqVCUUlPPiKnTnDSnBnnZFbBzxAVB
	+ZutMpfU5H8G+Hi6CL5X0jXv2GRSnER7KKZNWfFe4b3Kn859QJf2Hru62DSzyNeJ1N46jBnlJz6
	o53vpugGf6MHhejXpUGhgikMkAlU7ePQpuerpx4H57kc771lLzQQZ1YyVELFLYoTCMnuzZDCsCu
	AzFLRcQ9CU6fxZJd2aK36v73eTkX4gQZaBdyfA0epwAnNEw03e5s8Bz5T3b3UGfLxkzOsXmeULg
	lHLPyje0deRv9vh4EnAq7OYtFzkth+rMxnmn67ZneqQbSrJnqpNl3o6xY1Lb3evID0FbWnVUtD4
	kTSAbzyOcdrrHh/vWCACOua/o/ternoMpzA2R9nMeUqUobztXavi++TE/kIZLXOzdlauv39qoGN
	gYsBqe1heOZ1iEoajdpOhF8fwST/VE5WNq3c9C/sKBEQeGDepWlr+3LySyZ8B3X1kWKULoAwgxJ
	3t8nSAEDe6YQ==
X-Received: by 2002:a17:903:b4b:b0:2ef:f51c:7b09 with SMTP id d9443c01a7336-2f03f19075bmr209178975ad.28.1795705426236;
        Thu, 26 Nov 2026 07:03:46 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm104226565ad.17.2026.11.26.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:03:45 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org
Cc: kernel@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kapil@presceralabs.ai
Subject: [PATCH net v3] can: j1939: reject an out-of-range data packet offset
Date: Thu, 26 Nov 2026 20:33:39 +0530
Message-Id: <20261126150339.2110025-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_xtp_rx_dpo_one() takes the peer's data packet offset and stores it
without checking it against the session:

	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

j1939_session_skb_get_by_offset() then looks for a buffered skb at
pkt.dpo * 7, and j1939_xtp_rx_dat_one() copies into the session's skb at
that offset.  An offset past the session's packet count has no skb behind
it, so the lookup returns NULL and the copy and the completion run on it.

Reject an offset that is not below session->pkt.total, and look the
completed receive message up at offset 0 rather than at whatever window
the peer's last DPO named.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Co-developed-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Kapil Vaswani <kapil@presceralabs.ai>
Signed-off-by: Piyus Kedia <piyus@iiitd.ac.in>
---
v3: addresses the review of v2
    (https://lore.kernel.org/r/sashiko-outbox-233959@kernel.org)

    - a second out-of-range DPO no longer leaks the session.  Both
      findings there are right.  j1939_session_cancel() does nothing once
      the state is WAITING_ABORT, so on a second bad DPO the
      j1939_session_timers_cancel() in front of it cancelled the 500 ms
      timeout and nothing restarted it: the session stayed on
      priv->active_session_list with no timers, holding its skb and its
      netdev references, and unregister_netdevice() hangs behind that.
      v3 deactivates the session in that case, the way
      j1939_xtp_rx_rts_session_active() already does for a second RTS.
      The first bad DPO still cancels and lets the abort go out, so the
      change is confined to the session that was already dying.

    - an EOMA no longer completes a cancelled session.
      j1939_xtp_rx_eoma_one() checks the PGN and the size but not the
      state, so an EOMA arriving inside the abort window completed the
      session: with v2 looking the message up at offset 0 that handed the
      aborted session's data to the receiving sockets and queued a second
      J1939_ERRQUEUE_RX_ABORT.  The delivery itself predates this series -
      j1939_session_completed() always called j1939_sk_recv() - but v2 is
      what made it reach a whole message, so the state test belongs here.

v2: rejected the offset instead of tolerating it, and looked the completed
    message up at offset 0.

    How this was found: an AI-driven fuzzing harness built on syzkaller,
    developed jointly by Kapil Vaswani and myself, driving ETP sessions at
    j1939 under KASAN on x86_64.  The analysis and this changelog were
    written with the assistance of a large language model and checked by
    hand against the tree; the reproducer and the KASAN report in the v1
    posting were produced by us.  Both v3 changes come from addressing an
    AI-generated review of v2 on the list, and each mechanism it described
    was read in the tree before being acted on.

Link: https://lore.kernel.org/all/179553126874.3135.14817947057284289051@kernel.org/

 net/can/j1939/transport.c | 49 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..54e7ae9a88c3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1242,10 +1242,15 @@
 	struct sk_buff *se_skb;
 
 	if (!session->transmission) {
-		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		/* the whole message, not the window the peer's last DPO
+		 * happened to name
+		 */
+		se_skb = j1939_session_skb_get_by_offset(session, 0);
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1418,6 +1423,18 @@
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	if (session->state >= J1939_SESSION_WAITING_ABORT) {
+		/* This session has been cancelled and is waiting for its abort
+		 * to go out.  Completing it here would hand its data to the
+		 * receiving sockets and queue a second RX_ABORT, so leave it to
+		 * the abort path.
+		 */
+		netdev_info(session->priv->ndev,
+			    "%s: 0x%p: EOMA on a cancelled session\n",
+			    __func__, session);
+		return;
+	}
+
 	session->pkt.tx_acked = session->pkt.total;
 	j1939_session_timers_cancel(session);
 	/* transmitted without problems */
@@ -1823,14 +1840,36 @@
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+	if (dpo >= session->pkt.total) {
+		bool was_dying = session->state >= J1939_SESSION_WAITING_ABORT;
+
+		netdev_info(session->priv->ndev,
+			    "%s: 0x%p: data packet offset %u is not below the %u packet(s) of this session\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+		if (was_dying)
+			/* The cancel above is a no-op once the state is
+			 * WAITING_ABORT, so it does not restart the timeout
+			 * this function just cancelled.  Deactivate instead,
+			 * as j1939_xtp_rx_rts_session_active() does, or the
+			 * session stays on the active list with no timers and
+			 * holds its skb and netdev references for good.
+			 */
+			j1939_session_deactivate_activate_next(session);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.43.0


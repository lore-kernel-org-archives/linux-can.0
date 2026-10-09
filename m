Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE54D0A12;
	Fri,  9 Oct 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543279; cv=none; b=LWHaL4QCB1MCqFYRg5pxJhNrlL+tuczHQKOfeuA82wAvHK7KEr/9TfWq/dnsCRjRcpPpXrsGZG60Xr6oQHwQNEdWtLZOkvweNX1FbhTi6BZFcTClMmNpKUvui2mZo/Bt8aQHTFEcoN7zwSFT//BwxVArTdAHyRLw1wpA6wOVLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543279; c=relaxed/simple;
	bh=zoDfHhtgvunMEO6H66ZDuNue7sAMTEp60qQm8ISmNKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n3jhm8weES0nj+GIpaXSg65MwaVLmRxTxGzZPDPBxHOvi5dWQimS9Q/+8igxoBsmMUCfmajO8eBsbQSDqFRwDb+ybigoEY9w8hQ5jxMtUnBCcO9Of3hqFxuR/Z334oWzRODTtEruhAR3ryaIwbQWZNb0svhoZqx5PqkKgOaAt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CenqFas8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CenqFas8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=m2
	mtN8IO16pWKO7OBR+wjeUWK9kQFnaSKWG9bvyX9rk=; b=CenqFas8joyAy1KfKI
	dGXHZJJgJB2mrNXNFPf+h0uVtxBGKr80k2V9d3H/dsT6fzZv7sBMRWc8iLrND/e+
	sJDPcLqsHfFq2FmYTR7X8tGsGkSTxGgld0I53z4W1TLs4jBmd11LVglaYvcmD95e
	OKO+09jO4WOjNA5WdofnnggW4=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDX_3rSx8hqceRFDQ--.27797S2;
	Fri, 09 Oct 2026 18:54:11 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v3] can: j1939: validate the EDPO packet number
Date: Fri,  9 Oct 2026 18:54:10 +0800
Message-ID: <20261009105410.300321-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_3rSx8hqceRFDQ--.27797S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1xGFWxAFW8WFyxtFWxXrb_yoW7Jry7pF
	W3Kry5GrnrJrn7Aws3trZ8X34Yyws3JryrGF9Fq3s3Cw45CF45tF98tryxWayqy395u3ya
	gF1qqa1UKr4vq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU1lkxUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BPyaGrIx9NM7wAA34

From: Chaosheng Qu <quchaosheng000406@163.com>

ETP.CM_DPO is peer controlled and its packet number is accepted without
any validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
a value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer still completes normally in that case.  With
pkt.dpo == pkt.total, a closing ETP.DT frame with dat[0] == 0 evaluates to
packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
pkt.total and the receiver emits its own EOMA.  The local loopback of that
EOMA runs j1939_session_completed(), which asks
j1939_session_skb_get() for offset "pkt.dpo * 7" -- one full packet past
the end of the queued skb -- gets NULL, and passes it straight to
j1939_sk_recv(), which dereferences oskb->sk.

Reaching the dereference needs two things, and this patch keeps them as
two separate changes because neither is sufficient alone:

  - the range check in j1939_xtp_rx_dpo_one(), which stops pkt.dpo from
    leaving the message
  - the NULL guard in j1939_session_completed(), which covers the offset
    lookup coming up empty for any other reason

The reproducer in the link was run three times in each configuration: the
unpatched kernel panics 3/3, a kernel with only the NULL guard still
panics 3/3, and this patch gives 0/3.  The middle result is the point --
it shows the guard does not close this hole on its own, so the range check
is not redundant with it.

Nothing on the path checks a capability: net/can has no CAP_NET_RAW check
at all, CAN_J1939 does not require one, and the only capability gate
nearby is SO_J1939_SEND_PRIO < 2, which asks for CAP_NET_ADMIN and is not
needed here.  The vcan interface used by the reproducer has to be created
first, which normally needs privileges; given the interface, any user can
reach this.

  ETP.CM_RTS (size 1786)  -> total = 256 packets
  ETP.CM_DPO (packet 0)
  ETP.DT seq 1..255       -> packets 0..254, pkt.rx = 255
  ETP.CM_DPO (packet 256) -> pkt.dpo = 256, unvalidated
  ETP.DT seq 0            -> packet 255 == pkt.rx, completes the transfer

J1939_XTP_ABORT_BAD_EDPO_OFFSET and its "Bad EDPO offset" string are
already in the tree and have no caller; the range check uses that abort.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..065b4f71e9af 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1243,9 +1243,18 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+
+		/* The offset "pkt.dpo * 7" is not necessarily covered by a
+		 * queued skb, e.g. when a peer names a packet past the end of
+		 * the message in an EDPO.  j1939_simple_txnext() already
+		 * guards its call the same way; dropping the message is
+		 * better than handing a NULL skb to j1939_sk_recv().
+		 */
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+
+	/*
+	 * EDPO is peer controlled.  It names the packet the announced window
+	 * starts at, and j1939_xtp_rx_dat_one() places data at
+	 * "dat[0] - 1 + pkt.dpo", so it has to stay inside the message.  A
+	 * value past the end moves pkt.dpo beyond the reassembled buffer and
+	 * makes the ETP completion path look up offset "pkt.dpo * 7", which is
+	 * no longer covered by any queued skb.
+	 */
+	if (dpo >= session->pkt.total) {
+		netdev_warn(session->priv->ndev,
+			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
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


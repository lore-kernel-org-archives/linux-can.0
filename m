Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464666;
	b=Vb6g+YqbgOyc9OFz3mcSU7NoiiX1ONhsmMA2S9Y+UkQdB/D3GTDDUZeVy5uVhsc5yGnN
	 ImftfqACBhpnt4Sq4WqojN5SGYmqCnLx1ZXMebCtcUK9Maa+NcMR6hJQZQ3P6MT2iMG1A
	 UeSZ1ErK6p3URilUGz6TSD8SNQ15lZiGLTDvkMmq+qWQbkRn2U945c4frMF0bHTZREVlk
	 qnulN9NB6AzhbxPu39jZ/yBkPkxWyc1oJffqSs+56mHwRsBsx7R7lAYT3CbxCi+ejGU6f
	 D22mYKAI62UiRXlPTe3ivR9jhsmnXGooXbOWExnnzB2flZRIkhxhD1MPAK5e2R3zAyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464666;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=/uRS3Vea5xa2usxGVceBMi/4OQCMX3rft1XIK4h03p4=;
	b=hcM2ldYG6q5W1WHOrZB/GaLydjzFf2xtXLdUssKJIwPmHxNs91smpRhnTnUfR2sKcXtl
	 nIB7sDEEV7jwwEpL7mp4wY6Qn2pD56m+ix78cXCWjZjLawLRTBrfclqNGRuqeM8/L1oyL
	 vfRhBNPoyUj2HERTf/HUQPwR3B2cfi4vBCqtq4orEnNSRMFHfSt1LILvhNFkUrsIbf2Jl
	 UwQQHRndRM/rzep8IHfN6t2Yj707k1Qeoe1KhisrooCxP/3jWB3nLTEi0lZM9zBDWgY/h
	 /yezmZvt/VKriy/ESD6aHK1XImNuKAvZvIla3vN21CkoGIoV+M7wlYdmT+glmY51mlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F71XTr1K;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89683606A31F;
	Tue, 20 Oct 2026 02:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89683606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F71XTr1K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/u
	RS3Vea5xa2usxGVceBMi/4OQCMX3rft1XIK4h03p4=; b=F71XTr1KWqj8R9BkOT
	QyuIYc/JK1f2kd8fO/rOHfVvmKDBdqWXOmb/IoYT4oiCoItzP5+88dvbVAOE5h0v
	UpHYMsfZlAErdCKsrOzITX5TgjQFllpfEMcpP6DP/WLRY/abwaiz7lPINS8nDwRe
	fUm1Hdt1NzSO2jITEySDVymAY=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3Z6b81tZqKuWeAw--.50653S2;
	Tue, 20 Oct 2026 10:50:37 +0800 (CST)
From: Chaosheng Qu <quchaosheng000406@163.com>
To: quchaosheng000406@163.com,
	Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v5] can: j1939: validate the EDPO packet number
Date: Tue, 20 Oct 2026 10:50:36 +0800
Message-ID: <20261020025036.74454-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:QCgvCgC3Z6b81tZqKuWeAw--.50653S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1UurWrCFWrAr17KryUWrg_yoW3WF47pF
	W3KryUGryDJr4xAr4xJrWDX34Syws3XryrJFy7t3s2k3y5AF45tFn8tryfWayqy3s5u3y3
	u3Z8Xan8Gr40g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUHUhUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x5FumrW1v7rbgAA3P

ETP.CM_DPO is peer controlled and its packet number is accepted without
any validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
a value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer can still complete in that case.  With pkt.dpo == pkt.total,
a closing ETP.DT frame with dat[0] == 0 evaluates to packet pkt.total - 1,
which is the last in-order packet, so pkt.rx reaches pkt.total and the
receiver emits its own EOMA.  The local loopback of that EOMA runs
j1939_session_completed(), which asks j1939_session_skb_get() for offset
"pkt.dpo * 7".  That offset is past the end of the queued skb, so the
lookup returns NULL.  Before this patch the NULL was passed to
j1939_sk_recv(), which dereferenced oskb->sk.

  ETP.CM_RTS (size 1786)  -> total = 256 packets
  ETP.CM_DPO (packet 0)
  ETP.DT seq 1..255       -> packets 0..254, pkt.rx = 255
  ETP.CM_DPO (packet 256) -> pkt.dpo = 256, unvalidated
  ETP.DT seq 0            -> packet 255 == pkt.rx, completes the transfer

Reject an EDPO that names a packet at or past pkt.total and abort the
session with J1939_XTP_ABORT_BAD_EDPO_OFFSET, the SAE J1939-21 abort code
for this case.  The check has to be ">=" and not ">": pkt.total is a
packet count, so the last valid packet is pkt.total - 1.

The EDPO is also looped back to the transmitter session.  A peer can make
that role see an out-of-range EDPO too by putting an oversized packet
number in ETP.CM_CTS: j1939_xtp_rx_cts_one() only rejects packet 0, and
stores "packet - 1" in pkt.tx_acked without comparing it to pkt.total.
j1939_session_tx_dpo() then copies pkt.tx_acked into the EDPO.  Rejecting
the looped-back EDPO aborts the transmission instead of letting it run
with an offset that cannot be encoded.  Validating ETP.CM_CTS is a
separate change.

The abort branch must not strand a session that is already waiting for
an abort.  j1939_session_cancel() re-arms the abort timer only while the
state is below J1939_SESSION_WAITING_ABORT.  On a second out-of-range
EDPO the first call has already moved the session to that state, so
j1939_session_timers_cancel() removes the pending timer and the second
j1939_session_cancel() does nothing.  Make j1939_session_cancel() report
whether it started the abort, and force-deactivate the receiver when it
did not.  This is the same recovery used by the second-RTS path.

Guard j1939_session_completed() against a NULL skb as defense in depth,
so a future regression in the offset arithmetic degrades to a dropped
message instead of a kernel panic.

Tested on v7.3.0-rc5 under QEMU, with the reproducer below:

  - an unpatched kernel panics in j1939_sk_recv()
  - the guard alone does not fix the bug: it drops the message but the
    transfer still completes, so it is not the fix for the bad offset
  - the range check alone survives the single-EDPO reproducer
  - two out-of-range EDPOs followed by two RTS frames leave the receiving
    session deactivated; no netdev reference remains stuck
  - a full 1786 byte ETP transfer between two J1939 sockets still
    completes with the payload intact.  Its last EDPO announces
    pkt.total - 1, one below the rejected boundary, and exercises both
    the receiver and the transmitter loopback

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
v5:
 - Make j1939_session_cancel() report whether it armed the abort timer.
   A second out-of-range EDPO now force-deactivates a receiver that is
   already waiting for an abort instead of leaving it without a timer.
 - Drop the claim that the range check and the NULL guard are both
   required for the original reproducer.  Both survive that sequence;
   the guard is defense in depth, while the range check is the fix for
   the bad offset.
 - Drop the incorrect "one full packet past the end" description.  The
   offset starts six bytes past a 1786 byte reassembly skb.
 - Correct the transmitter-role statement.  An oversized ETP.CM_CTS can
   make the looped-back EDPO out of range, because the CTS path does not
   validate its packet number against pkt.total.
 - Add the Fixes tag.
 net/can/j1939/transport.c | 46 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..8e171b713859 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1158,13 +1158,16 @@ static void __j1939_session_cancel(struct j1939_session *session,
 		j1939_sk_send_loop_abort(session->sk, session->err);
 }
 
-static void j1939_session_cancel(struct j1939_session *session,
+static bool j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool active = false;
+
 	j1939_session_list_lock(session->priv);
 
 	if (session->state >= J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
+		active = true;
 		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
 	}
@@ -1173,6 +1176,8 @@ static void j1939_session_cancel(struct j1939_session *session,
 
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+
+	return active;
 }
 
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1243,9 +1248,18 @@ static void j1939_session_completed(struct j1939_session *session)
 
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
@@ -1823,14 +1837,36 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
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
+		if (!j1939_session_cancel(session,
+					  J1939_XTP_ABORT_BAD_EDPO_OFFSET))
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


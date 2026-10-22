Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654991;
	b=llvtbzz3DLT1qPmGUO8X7GryB/MeFUzyYeDaOekzJpg1xRZBZ5ZVyq7hDGvg2HiXSD/y
	 jJgXEWp0hL2A28Po9nXqjDcUNbCA1wlNfMtd5iWIEbEwefevguzKJCqKeLNYAbr3RdjPr
	 rQB3tyrt49yt6cYIN9e0HSs1NkqBEI26m4KjOVuS8T63mls9g5fbEHw/CiAN73sw38RTK
	 YfW8+QXGyTq8sJvaadncl1UK4R9qxyRkv1hURQ7trK+lm+YTRhgVHuCTCmSSm3fyqExR2
	 /vpV1XZq9NJ68IW7Tzz6NugCi9+sMDB96erJ8BdsRcGn8cTZDaFbbVr49SZ4oQ3bRjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654991;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=OaoPzcRaYTs9jwhaSXrSUNcTy0/5uxaRkFad05SYW2E=;
	b=UFA09Fi9Fhhm8zZc9fwQUOC68nWO8UjMb01cxIvUyBC8k8DADqzOUKeD3WoDmx3+nmsR
	 o+Xkilv/KmndsZtk+0IUa1ear6RMAka/2rBisvtCpi2hqp+jqxH3hxhkGa0QpUnVAGK6D
	 1xjRVTSgJwfUyqJA1al06EOSRWh+T75yzNIWWLfi9nj7ybZNP3qRawWnxDZUQwwZ/nfAw
	 eLz2qXjYmU9ihDZ1h0zg8MGb6x20zKi93wwJgCycQlkp37m4OU4OhMkaA7m2vyD79/bpf
	 n7i8WCGrojP/aZa/ntVVnJFCfpMo+PLe19L4UIi9PztoZrCZZJjF7j53TPMzB/eodJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Vpos8ddr;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB63606A319;
	Thu, 22 Oct 2026 07:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB63606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Vpos8ddr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=OaoPzcRaYTs9jwhaSXrSUNcTy0/5uxaRkFad05SYW2E=;
	b=Vpos8ddr6biihKKlVe8EifAP/jyqgSWaalpEw3nN3POIOqX7OZnKLrq8rQkSL1
	Hdif/stLA7/07IMsOWSkRDaancvCsWeMCKo/ztQW9cTliCqwyXpdxvM0Aedbid1+
	iuPSEaBOPUGH/lJCbIvfMZgKA8olACfKYd7r14S9IrMrE=
From: Quchaosheng <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net v6 1/1] can: j1939: validate the EDPO packet number
Date: Thu, 22 Oct 2026 15:42:28 +0800
Message-Id: <179265494813.314254.14725785769836234084@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:PCgvCgDnJHlkvtlqCuTeBA--.29259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cr15Kw1kGFWUGFyxCF4fuFg_yoWDWFWkpF
	W3Wry7GrnrJF1Yyr4ktFWDW34Fyws3JryfWF17t3s2kw43Cr43tF4DK34xWayDt395u3ya
	9w1jqanxGr4qq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ud-BiUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5AbZT2rZvmYBOQAA3n


ETP.CM_DPO is peer controlled and its packet number is accepted without
validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so a
value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer can still complete in that case.  With pkt.dpo =3D=3D pkt.total,
a closing ETP.DT frame with dat[0] =3D=3D 0 evaluates to packet pkt.total - 1,
the last in-order packet, so pkt.rx reaches pkt.total and the receiver
emits its own EOMA.  The local loopback of that EOMA runs
j1939_session_completed(), which asks j1939_session_skb_get() for offset
"pkt.dpo * 7".  That offset is past the end of the queued skb, the lookup
returns NULL, and the NULL reached j1939_sk_recv(), which dereferenced
oskb->sk.

  ETP.CM_RTS (size 1786)  -> total =3D 256 packets
  ETP.CM_DPO (packet 0)
  ETP.DT seq 1..255       -> packets 0..254, pkt.rx =3D 255
  ETP.CM_DPO (packet 256) -> pkt.dpo =3D 256, unvalidated
  ETP.DT seq 0            -> packet 255 =3D=3D pkt.rx, completes the transfer

Reject an EDPO that names a packet at or past pkt.total.  The check is ">=3D"
and not ">": pkt.total is a packet count, so the last valid packet is
pkt.total - 1.

The abort code depends on the role.  A receiver is told
J1939_XTP_ABORT_BAD_EDPO_OFFSET.  A transmitter only sees an out-of-range
EDPO on the echo of one it built itself, from an ETP.CM_CTS packet number
that j1939_xtp_rx_cts_one() does not bound, so the responder is told
J1939_XTP_ABORT_ECTS_TOO_BIG, the code j1939_tp_txtimer() already uses for
that condition.  Bounding ETP.CM_CTS is a separate change; the comment in
j1939_xtp_rx_dpo_one() says so, because it is the other writer of pkt.dpo.

j1939_session_cancel() changes in two ways:

  - It cancels the rxtimer before taking active_session_list_lock.
    j1939_tp_set_rxtimeout() cancels synchronously, hrtimer_cancel() waits
    for a running callback, and j1939_tp_rxtimer() takes that same lock.
    j1939_tp_txtimer()'s -EOVERFLOW and default branches reach
    j1939_session_cancel() without cancelling the timer first.  The abort
    timer is then armed with hrtimer_start() under the lock, which does not
    wait for the callback.

  - It deactivates a session that is already in
    J1939_SESSION_WAITING_ABORT.
    Callers cancel the timers first, so a second cancel otherwise leaves an
    active session with nothing left to deactivate it, including on the
    ETP.DT and ETP.CM_CTS paths that do not use the new EDPO branch.  With
    that in the helper, the second-RTS path's receiver branch reduces to
    what its transmitter branch already does.

Guard j1939_session_completed() against a NULL skb as defense in depth, so
future regression in the offset arithmetic drops the message instead of
panicking.

Tested on v7.3-rc7 under QEMU (KVM, vcan).  Three kernels from one tree and
one configuration (defconfig plus CONFIG_CAN_J1939=3Dy, CONFIG_CAN_VCAN=3Dy,
CONFIG_LOCKDEP=3Dy, CONFIG_DEBUG_SPINLOCK=3Dy), differing only in this hunk:
stock, v5, and this revision.  Each case is a standalone guest.

  T1  out-of-range EDPO (DPO 256, then DT seq 0)
  T2  legal 1786-byte ETP transfer, payload compared byte for byte
  T3  abort EDPO, then an unparsable DT; is a second ETP.CM_RTS from the
      same SA/DA answered with a CTS?
  T4  same as T3, last socket closed, does `ip link del vcan0` return?
  T5  two unparsable DTs, no EDPO; second RTS answered?
  T6  two unparsable DTs; does `ip link del vcan0` return?
  T7  oversized ETP.CM_CTS against a real sender: which abort code?

            T1       T2     T3          T5          T7
  stock     panic    -      SLOT-STUCK  SLOT-STUCK  -
  v5        ok       PASS   SLOT-STUCK  SLOT-STUCK  12
  this rev  ok       PASS   SLOT-FREE   SLOT-FREE   15

            T4             T6
  stock     REF-DROPPED*   never returns
  v5        never returns  never returns
  this rev  returns        returns

* T4 on stock aborts with code 6, UNEXPECTED_DATA, which leaves the session
  to the abort timer, and the timer deactivates it as the device goes down.
  T3 is still stuck on stock, so the slot is not reusable and a peer that
  restarts the transfer is refused until the timeout.

T1 on stock is "BUG: kernel NULL pointer dereference, address: 0x18" in
j1939_sk_recv(), then a kernel panic.  T2 delivers all 256 packets intact
on both patched kernels.

T5 and T6 strand the session on stock with no EDPO involved: the second
unparsable DT cancels the abort timer the first one armed, and
j1939_session_cancel() finds the state already WAITING_ABORT.  T6 prints
"unregister_netdevice: waiting for vcan0 to become free. Usage count =3D 7"
until the guest is killed.  v5 fixed only the caller it added, so T3
through T6 are unchanged from stock.  This revision deactivates in the
helper, and all four clear.

The lockdep race that the first change addresses was not reproduced: it
needs a timer callback racing a caller, and none of these sequences
schedules one at the right moment.  No lockdep report or call trace
appeared in any run.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.=
de?part=3D3
Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 81 ++++++++++++++++++++++++++++++++++++++++++---=
------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..2cc6c46c4d50 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1161,18 +1161,39 @@ static void __j1939_session_cancel(struct j1939_sessi=
on *session,
 static void j1939_session_cancel(struct j1939_session *session,
 				 enum j1939_xtp_abort err)
 {
+	bool waiting;
+
+	/* Cancel the rxtimer before taking the list lock: hrtimer_cancel()
+	 * waits for a running callback, and j1939_tp_rxtimer() takes the
+	 * same lock.
+	 */
+	j1939_session_rxtimer_cancel(session);
 	j1939_session_list_lock(session->priv);
=20
+	waiting =3D session->state =3D=3D J1939_SESSION_WAITING_ABORT;
 	if (session->state >=3D J1939_SESSION_ACTIVE &&
 	    session->state < J1939_SESSION_WAITING_ABORT) {
-		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
 		__j1939_session_cancel(session, err);
+		/* hrtimer_start() does not wait for the callback, so arming
+		 * the abort timer here cannot deadlock.
+		 */
+		j1939_session_get(session);
+		hrtimer_start(&session->rxtimer,
+			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
+			      HRTIMER_MODE_REL_SOFT);
 	}
=20
 	j1939_session_list_unlock(session->priv);
=20
 	if (!session->sk)
 		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
+
+	/* The abort went out on an earlier call, and this caller has just
+	 * cancelled the timer that would have finished the session off, so
+	 * nothing else is left to deactivate it.
+	 */
+	if (waiting)
+		j1939_session_deactivate_activate_next(session);
 }
=20
 static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
@@ -1243,9 +1264,17 @@ static void j1939_session_completed(struct j1939_sessi=
on *session)
=20
 	if (!session->transmission) {
 		se_skb =3D j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+
+		/* Defense in depth: pkt.dpo is range checked when an EDPO is
+		 * received, so the lookup should always find the skb.  Drop
+		 * the message rather than hand a NULL skb to j1939_sk_recv()
+		 * if the offset arithmetic ever regresses.
+		 */
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
=20
 	j1939_session_deactivate_activate_next(session);
@@ -1729,16 +1758,10 @@ static int j1939_xtp_rx_rts_session_active(struct j19=
39_session *session,
=20
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
-		if (session->transmission) {
-			j1939_session_deactivate_activate_next(session);
-		} else if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
-			/* Force deactivation for the receiver.
-			 * If we rely on the timer starting in j1939_session_cancel,
-			 * a second RTS call here will cancel that timer and fail
-			 * to restart it because the state is already WAITING_ABORT.
-			 */
-			j1939_session_deactivate_activate_next(session);
-		}
+		/* Both roles: the peer is restarting the transfer, so free the
+		 * slot now rather than wait out the abort timeout.
+		 */
+		j1939_session_deactivate_activate_next(session);
=20
 		return -EBUSY;
 	}
@@ -1823,14 +1846,42 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session=
 *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat =3D skb->data;
+	unsigned int dpo;
=20
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
=20
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
=20
+	dpo =3D j1939_etp_ctl_to_packet(dat);
+
+	/* EDPO is peer controlled.  j1939_xtp_rx_dat_one() places data at
+	 * "dat[0] - 1 + pkt.dpo", so a value at or past pkt.total moves
+	 * pkt.dpo past the reassembled buffer, and the ETP completion path
+	 * then looks up an offset no queued skb covers.
+	 *
+	 * This bounds the receiver-side writer only.  j1939_session_tx_dpo()
+	 * copies pkt.tx_acked, which comes from an ETP.CM_CTS packet number
+	 * that j1939_xtp_rx_cts_one() does not bound; that is a separate fix.
+	 */
+	if (dpo >=3D session->pkt.total) {
+		netdev_warn(session->priv->ndev,
+			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
+			    __func__, session, dpo, session->pkt.total);
+		j1939_session_timers_cancel(session);
+		/* The transmitter only sees this on the echo of an EDPO it built
+		 * from an oversized ETP.CM_CTS packet number, so it is the
+		 * responder's CTS that is too big, not the EDPO offset.
+		 */
+		j1939_session_cancel(session,
+				     session->transmission ?
+				     J1939_XTP_ABORT_ECTS_TOO_BIG :
+				     J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		return;
+	}
+
 	/* transmitted without problems */
-	session->pkt.dpo =3D j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo =3D dpo;
 	session->last_cmd =3D dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
=20


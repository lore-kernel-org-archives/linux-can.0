Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333535201A;
	Mon, 28 Sep 2026 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578243; cv=none; b=s/4u2SR0o/WTSlGDIUBuBqa8M03W6mTAg7Ymq9zqPMSURBIib3KnkYTJ+RGx/jiicYjCeDlmcWnYmc5j2xMZ8ZXIID0TKzudeHemMpUtC7v1ggDoWGCoE22rURqOeVeOSbbbOKDwdwR3aJoJxUmMvaW+GdslJCzt1kDSlkWV+qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578243; c=relaxed/simple;
	bh=/PMiTRhTca/Ba2WyyagmYvvuRWbUSJVJwgY0dmft4l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXHAkNHNmBENkJJ37RSmK54Dz9zxdcpWnVlbdHgBj3WxmfN5C5QWbxpJtj3HwvE0HEit60EUznmpW6n8/6f32FS6C4AagfnYmO+K9FkthcqQ/lsd4bBxf40HCDCQufuP5nRgEAkDG/s+FXaJXymI3kMOSMAwIGnSGTDX/L/g7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eL+fpo1Z; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eL+fpo1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IL
	2EBXZ/+Q17dXypphHNBR4Qhatsa1DOCyC+1LTMRqs=; b=eL+fpo1ZAIaJC4sHvO
	y/R7HLKkfwrcj9u9yYFY950jancOGuDfxdlaee69RcAObjJ5gQ48+BzvoHK16dr4
	xNJamOesmqB5HDvjReDkUFSmkXdzn4b0IjTVKSUzNm0HsCB3etS9WKarvcrRpbCy
	TzsRk7yUkflj/geYNRWtgeCmA=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD350wnDrpqY_dYBQ--.60414S2;
	Mon, 28 Sep 2026 14:50:16 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] can: j1939: validate the EDPO packet number
Date: Mon, 28 Sep 2026 14:49:59 +0800
Message-ID: <20260928065000.1749383-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD350wnDrpqY_dYBQ--.60414S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr1UurWrCFWrXF4rtry7Jrb_yoW7Ww4fpF
	y3KryUGr1kArsrAw4rJrWUX34ayws3JryrJasFq3sakw45ZF45tF98tryfWayqy3s5u343
	W3WDXwsxKr40q37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRvtC5UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAAjWTGq6DiiEmQAA35


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

The trigger is deterministic and needs no hardware, no race and no memory
pressure.  All of it is reachable by an unprivileged user through a
virtual CAN interface:

  ETP.CM_RTS (size 1786)  -> total = 256 packets
  ETP.CM_DPO (packet 0)
  ETP.DT seq 1..255       -> packets 0..254, pkt.rx = 255
  ETP.CM_DPO (packet 256) -> pkt.dpo = 256, unvalidated
  ETP.DT seq 0            -> packet 255 == pkt.rx, completes the transfer

resulting in:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  RIP: 0010:j1939_sk_recv+0xaf/0x150
  Call Trace:
   <IRQ>
   j1939_session_completed+0x69/0x80
   j1939_xtp_rx_eoma+0xc1/0x170
   j1939_tp_recv+0x41b/0x4c0
   j1939_can_recv+0x1ad/0x290
  Kernel panic - not syncing: Fatal exception in interrupt

Reject an EDPO that names a packet at or past pkt.total and abort the
session with J1939_XTP_ABORT_BAD_EDPO_OFFSET, the SAE J1939-21 abort code
for exactly this case.  The check has to be ">=" and not ">": pkt.total is
a packet count, so the last valid packet is pkt.total - 1 and
"dpo == pkt.total" is already out of range -- it is the value used by the
trigger above.

Both roles tolerate the check because a transmitter derives the offset
from pkt.tx_acked, which is "cts_packet - 1" with cts_packet <= pkt.total,
so the largest value it ever announces is pkt.total - 1.

Also guard j1939_session_completed() against a NULL skb as defense in
depth, so that any future regression in the offset arithmetic degrades to
a dropped message instead of a kernel panic.  The only other caller of
j1939_session_skb_get(), j1939_simple_txnext(), already does this.

Tested on v7.3.0-rc5 under QEMU:

  - the frame sequence above panics an unpatched kernel in
    j1939_sk_recv() and is cleanly aborted by this patch
  - a full 1786 byte ETP transfer between two J1939 sockets still
    completes with the payload intact.  That transfer announces
    pkt.total - 1 in its last EDPO, so it exercises the boundary value
    one below the rejected one, and it runs the transmitter's own EDPO
    through the vcan loopback as well.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5..065b4f71e 100644
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
 


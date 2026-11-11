Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381509;
	b=EREkdLJ2MtOP7aLBOhorC0mD3v/j+ShYFc/+5wN/y2QF3Q6eouaHsXK/20YBqMwR8rBr
	 UwKp4x4LblEhr3JAHgwuR0C82sjB5FpVovZU28u48CvCFWK6LljXydrSXVn63wh0QmZv7
	 Cmzkf/kJQoQbzihFnDYxpcEn7nfPgRdu474QFtZBQ60/VQRN1qNTXHNwwCk6tYUs+mats
	 Rr/QbCdNewv0Rv3CDdZ316AOPQgK9YTIStjjyc28RqqTP36vyZ5yK2xY2BVGTOaIz4Umg
	 W9IIoucOaeoGCt5pScFuc5dVBfGXqGo4axmE963tC+UNK8MPbLs92h+sdbXmdv08q9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381509;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bDnKGKNCTIrDPoq6HWM3uedhGulwz3qMiOh9kua2BGQ=;
	b=wl2m1ZcrKstXzUMUBuvuquvxI0GSvWLp7HTWuublRLVXFzsa3/tu0C/4pOasdG1z8Gd0
	 J+fuB75caaQleE2Gu5gJH4GLWUXeQ+vmn0XkDqPiJiOThJe4UPeQCtSOj0tr+WwfIImz4
	 81YcuUM4aiWibHam5OzC7rWhDxplSYLIvA+Hj9ZpgmL73R9l+Y00WoU//JjUKcz74v2zQ
	 2VSw+O2V+C9gN3zx5EfxIfoXW2GHxKyOeKKoFBXY+78PNF2Vn4H9eOxeGtQzaEZ6zLojb
	 UziDVlyRFeFQMn0qRi+fsHMl5MtHjZVq0C+5aGusepp3XTipt5uiYbkBOPNdyaHi1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gU+zBAqJ;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3520606A324;
	Wed, 11 Nov 2026 07:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3520606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gU+zBAqJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=bDnKGKNCTIrDPoq6HWM3uedhGulwz3qMiOh9kua2BGQ=;
	b=gU+zBAqJrMoCY13hScxMWYewWmNICiJ5KHTdOpjXtcRGZUqs3A4xG4Ph/M2i6B
	is8/rMX0fuaBjJ9HEvv8cKNyKT0AhWila2O2tksyyd4bQPIs6sRRsVYSP71DOlaJ
	LVdF4mFAOUWj/zTFDEfZfrHbJwXQqrBQMRGncZHWoLAb4=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v8 2/4] can: j1939: validate the EDPO packet number
Date: Wed, 11 Nov 2026 15:22:00 +0800
Message-ID: <1794300102.11111.1000002@163.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3lRGvFvRqCa4IGw--.11095S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1xGFWxAFW8WFyxtFWxXrb_yoWrXFy5pa
	yagFW3Gr9rJF1Iyws3JrZ5Xr9ayrs3JFWfW3W2q3s3CwsxCF43tF98Kry7WayDJ3y8u345
	uFyUXanxGr4vqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGeHkUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BCJ-mr0FrAQzQAA3m

ETP.CM_DPO is peer controlled and its packet number is accepted without
any validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so
a value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer still completes normally in that case.  With
pkt.dpo == pkt.total, a closing ETP.DT frame with dat[0] == 0 evaluates to
packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
pkt.total and the receiver emits its own EOMA.  The local loopback of that
EOMA runs j1939_session_completed(), which asks j1939_session_skb_get()
for offset "pkt.dpo * 7" -- one full packet past the end of the queued
skb -- gets NULL, and passes it straight to j1939_sk_recv(), which
dereferences oskb->sk.

Reject an EDPO that names a packet at or past pkt.total and abort the
session.  The check has to be ">=" and not ">": pkt.total is a packet
count, so the last valid packet is pkt.total - 1.  The abort code depends
on the role: a receiver rejects a bad offset with
J1939_XTP_ABORT_BAD_EDPO_OFFSET, while a transmitter only builds an EDPO
from pkt.tx_acked, which comes from the responder's ETP.CM_CTS, so an
out-of-range value there is an oversized CTS and is reported as
J1939_XTP_ABORT_ECTS_TOO_BIG.

Cancel the session timers before aborting, as the other receive-path abort
handlers do.  j1939_session_cancel() only rearms the abort timer and
leaves session->txtimer armed, so on the transmitter path the retry timer
keeps firing on an aborting session, retries up to J1939_XTP_TX_RETRY_LIMIT
and overwrites session->err with -ENETUNREACH; on the receiver path the
retries transmit CTS or EOMA and clobber the abort timeout.

Bounding the CTS packet number in j1939_xtp_rx_cts_one() is a separate
change; this one only stops the value from being used as an offset.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fa23260e1833..ab42a383ff87 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1853,14 +1853,42 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
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
+	if (dpo >= session->pkt.total) {
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
-	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	session->pkt.dpo = dpo;
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.43.0



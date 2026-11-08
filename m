Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378616;
	b=XARo9G2mQKOcc2wxHi18B9CK1LvDlKQHKogOGXFTUsyfiunZ9+8+AkK5ErdeZU3doYG4
	 GyK1xzVnx7bDhMPS9oktOVdrHdeO9yi8ZD5uRqHJgnCtg5GSLrN/iEhL57n578+ZMmD66
	 F50REKJ7UUHeumIVdifpTbm8ge7MRE6mbEohBh1a1VBttXq91Biff5KcEzLGcbx/v2IQg
	 ZkB7ilRnTp+eTWBdSbZlOjMKRp9KFolK+hRmTthZMw6NT/k6CD0EomPLAeauQeDHJ8+UJ
	 eb9GuvOlTh6Ec6hCCQzLVRu+TngnhLmOS1RIwZzbFOnL6iT0H1xtoRfI84B0i/FqVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378616;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=O95dECCIAcFDXphPPXMrJbirxnrSShmVHl5hqYIsptg=;
	b=K/zcJ4jCrXwtkDvS6xwbTmDLtKqDQ/wVB7DNkb5gf3bZC+DomGg+zTKna/us3+pUejP2
	 iMByQtSy5mJPZV3PVynZnbL8bgDsIzmqBTjLXGgQOENSz2U67cXiIWzWsL3yKRO403sa+
	 5efuRY1KoeE1frzb7Xak7lBq6V40wwY2iiy6NgrQHSGxoN1pPeFU5PNWHxfBRetbcL2zV
	 71tWfVrZrGK9H+RmPKsQJQbiGNK+MtgQv0H6d30ls13QZLf94BN99jnueo62X/Sol7MoN
	 zQj0WCWfxiASjVwjQE2GMuiNR7H2MbDdWq94UwGxnKND0aHDT2/KL8Kij2wTGmom/YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W47mpJUS;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84860A2613;
	Wed, 11 Nov 2026 06:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B84860A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=W47mpJUS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=O95dECCIAcFDXphPPXMrJbirxnrSShmVHl5hqYIsptg=;
	b=W47mpJUSXyqU3rs2o2lTfw+4UMkNb3xU0bMCv6gcFDn88zm8Wrz7106whTcE9p
	MbsfNbBJOY8OfxAHFGRvkFGK21yK5xElfez5iOHVzmjzaNxy3ZmpKxc4KpOQyaTw
	+4eaRTjf3PuzVQMPCoEMozYoAhA6IWJQ88A42DTUYniws=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v7 2/4] can: j1939: validate the EDPO packet number
Date: Sun, 08 Nov 2026 09:34:23 +0800
Message-ID: <179410166345.60581.5430129940541091934@163.com>
In-Reply-To: <179410166344.60581.3898011861151549156@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
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
X-CM-TRANSID:_____wD33+5fC_RqtF8XHQ--.2745S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr4UJryxKr45AFy5Ar45trb_yoWrGFyxpa
	y3KrWxGrykJrs7Aws3tr95Xr9ayFs3AryfWa42q3sakws8uF4ftFZ8trySgayDJa4rC345
	ur15Xa13GrWDK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG2NNUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-wCyKGr0C2BtrwAA3S

From 4fca2aa63eeaefe7f14a6b1c5b9a3b67a2439c98 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <quchaosheng000406@163.com>
Date: Sun, 8 Nov 2026 09:22:29 +0800
Subject: [PATCH net v7 2/4] can: j1939: validate the EDPO packet number

ETP.CM_DPO is peer controlled and its packet number is accepted without any
validation.  It names the packet a transmission window starts at, and
j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so a
value past the end of the message moves pkt.dpo beyond the reassembled
buffer.

The transfer still completes normally in that case.  With
pkt.dpo == pkt.total, a closing ETP.DT frame with dat[0] == 0 evaluates to
packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
pkt.total and the receiver emits its own EOMA.  The local loopback of that
EOMA runs j1939_session_completed(), which asks j1939_session_skb_get() for
offset "pkt.dpo * 7" -- one full packet past the end of the queued skb --
gets NULL, and passes it straight to j1939_sk_recv(), which dereferences
oskb->sk.

Reject an EDPO that names a packet at or past pkt.total and abort the
session.  The check has to be ">=" and not ">": pkt.total is a packet
count,
so the last valid packet is pkt.total - 1.

The abort code depends on the role.  A receiver rejects a bad offset with
J1939_XTP_ABORT_BAD_EDPO_OFFSET, which the comment next to the definition
describes as "Bad EDPO offset" and which had no callers.  A transmitter
only
builds an EDPO from pkt.tx_acked, which comes from the responder's
ETP.CM_CTS, so an out-of-range value there is an oversized CTS and is
reported as J1939_XTP_ABORT_ECTS_TOO_BIG.

Bounding the CTS packet number in j1939_xtp_rx_cts_one() is a separate
change; this one only stops the value from being used as an offset.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 590a04c453b5..b0e62822b56e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1849,14 +1849,43 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 				 struct sk_buff *skb)
 {
 	const u8 *dat = skb->data;
+	unsigned int dpo;
 
 	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
 		return;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
 
+	dpo = j1939_etp_ctl_to_packet(dat);
+
+	/* ETP.CM_DPO is peer controlled.  j1939_xtp_rx_dat_one() places data at
+	 * "dat[0] - 1 + pkt.dpo", so a value at or past pkt.total moves pkt.dpo
+	 * beyond the reassembled buffer.  The transfer still completes: with
+	 * pkt.dpo == pkt.total a closing ETP.DT with dat[0] == 0 evaluates to
+	 * the last in-order packet, so pkt.rx reaches pkt.total and the receiver
+	 * emits its own EOMA.  The loopback of that EOMA runs
+	 * j1939_session_completed(), which asks j1939_session_skb_get() for a
+	 * packet past the end of the queued skb, gets NULL, and passes it to
+	 * j1939_sk_recv().
+	 *
+	 * pkt.total is a packet count, so the last valid packet is
+	 * pkt.total - 1 and the check has to be ">=".
+	 */
+	if (dpo >= session->pkt.total) {
+		if (session->transmission) {
+			/* A transmitter only builds an EDPO from pkt.tx_acked,
+			 * which comes from the responder's ETP.CM_CTS, so an
+			 * out-of-range value there is an oversized CTS.
+			 */
+			j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
+		} else {
+			j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
+		}
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



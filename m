Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381509;
	b=FBnpEAvjVz1A6efix/wHI4SRPqhXY+IibbDrUdX157FmtKPyyuzbqcl/LPCdJveagV79
	 LTcf0S7qb5aUOgpmlMwAJt98UepMHnzBziimbfExTyUHbRdq1A6c/KdcSnfNsA/Kh3aWP
	 EBrZIo53082SK+7Sl/K8RAOPTC/lIDrGYuBp2RPAuYki4pIgQfdIqZb87aut4fJIIRxex
	 3R7IB9Gsq5tTX3PeY/dKvZUWCGknL7jSnd+M6DfztlweM2BY+pNrVQAjObrYjlTMoOQEd
	 gtpSd/Z1Jo8mV5w5WXTXVCBOgPaOC1Xoq8q97ptD4zUOz6fHnAQA9nZBpgO3Plqjqpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381509;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=JZeKXoQzRpgt98dlewKxgP1rRaScfz9W3tzUscQhPQQ=;
	b=u7dBpBMVfVO6fy1dg64XuYsy3sTBy97JNioOVkZTP05vGK34rxAIqd2zu+c+5pSWb+9J
	 +pOiWZrPMzUZ59hUivklSh3C8rUvaIxtIIB4t0ybR2NKGHkrdDROqkGtTB6vxxizMpRVL
	 A20V7u7vFZhdZusA9zRkgiZshFuWFJKWOsfW4gjlHybFYf43xxakPzxH12zUMqXTinEq/
	 PDl+2lPUIu0SrCiUCj8S4AYC13jh3ICHqL/AmYI+9N+06YAkm88F64HS3VhMDufpoBCX6
	 UM+RWyv7GB/VqVjaRSnTvIQFbCIy+vkRk3OC7a7RMiR6xk/F3udJHO0Yoow5TSbJ3Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MZKYg3h6;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6814E606A321;
	Wed, 11 Nov 2026 07:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6814E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=MZKYg3h6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=JZeKXoQzRpgt98dlewKxgP1rRaScfz9W3tzUscQhPQQ=;
	b=MZKYg3h658zCR+AJI5yx6ms2Isez4hPtTVl4NxPfe+x25GdAy66k2BU//H0t6O
	3/KA6EJEQPeWjSw+85jVQ3gPG7vSjA+GTz9jDTclMH1OLMPBODtvYHD05vjxAWch
	2yMlguf+OX6ndSqo0qiwttMDr7LrhVrJ2Iz+uElgNNooI=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v8 4/4] can: j1939: reject a CTS that names more packets
 than the message has
Date: Wed, 11 Nov 2026 15:24:00 +0800
Message-ID: <1794300104.11111.1000004@163.com>
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
X-CM-TRANSID:PCgvCgBndnqyFvRqUUrOEg--.11589S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWfXFW5WFyfGrWxZF1kXwb_yoW8XF4rpa
	sxKry7Gr1xJrs3Aws7KF1DJa4UCws8G347Wryjq3s3Kw4DCF43t3WqqrZ2gayDJF45W3y5
	uF4Yqwn3W34vg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYUDJUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xOJ-mr0FrPHrwAA3U

j1939_xtp_rx_cts_one() rejects a zero packet number and a window above
pkt.block, but not a packet number above pkt.total.  It then stores
"pkt - 1" in pkt.tx_acked, and the transmitter reports that value back in
an ETP.CM_DPO.

That value is what j1939_xtp_rx_dpo_one() now bounds, so an oversized CTS
is currently caught one step later and reported as a bad EDPO offset.
Reject it where it originates instead, with the abort code that describes
it: J1939_XTP_ABORT_ECTS_TOO_BIG, "ECTS requested packets exceeds message
size".

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 124054668650..49ddf6c8f22d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1512,6 +1512,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		goto out_session_cancel;
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
+	else if (pkt > session->pkt.total) {
+		/* The responder asks for more packets than the message has.
+		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
+		 * reports that value in an ETP.CM_DPO, where it would name a
+		 * packet past the end of the message.
+		 */
+		err = J1939_XTP_ABORT_ECTS_TOO_BIG;
+		goto out_session_cancel;
+	}
 
 	/* set packet counters only when not CTS(0) */
 	session->pkt.tx_acked = pkt - 1;
-- 
2.43.0



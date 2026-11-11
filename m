Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381509;
	b=QRg7/T6nNmx0PHLhQuKEfJupw6LAJNpckFvnze7zrv9LOwNoOjSENaYcZ8XRrhLVaE59
	 aS7fF9NFSOhrQ0x2GmYwK7nAU+50gMqqFamMQZ0eh02ZL9PdpPBv5CGa+DQPGCxlw+LhK
	 5v2uc+MuoRDwfn2TREg1u1QV1fzWNeRo9iSnA49rCN7yS7TZm6KLHkpWWYBA9OlsoIDZx
	 Hmrd3f15T0YIuyoTAzXkHeND4KRD6zCKpN7d8WRp2Vq9tOb7NE4uJEcYMw1B807ec9LCB
	 Y9oZ+n37l3viIl9Lq2ceOxGN86YtUy6Ily25p4J+MB/ayZS7m9wynLHPs6Exln0aBXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381509;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=lBylGOCrZK4L+Nv4YxggCgZsA0EFYXjRMQDKTrR5xIU=;
	b=noefVIwar/jIqPg97SqdbL7Gs6XaZSAM/JnxtbyNapmb+9VEqPy2hrkA1fET2itfHK4R
	 8pwB49mo42mYNSSXIWL4A6JAhhOxGRiOaJ6DVO0zRBobsCo7QxsOgTIkfaoD7DsBSX93z
	 S8d2xa728ufbMQQSIFsj7mAFoLBiGO2aESytdGSwHFxugbmjUK0Jk6pWZjMJMhdGQ4eRU
	 gdQvaafGi6c67KiLDtLdEOFIxP75CnE+zj9R6V7CZofHkEm5Y2XXLLsUCDQ8NWzv7G6r4
	 ytS4g1Ra/qmLqAVroH/+VM7HHCDpI/8qByQ3t78yIkYrIdpoCqvrULhdCtZ5nRorDng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I5tvYamW;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB4606A320;
	Wed, 11 Nov 2026 07:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74FB4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=I5tvYamW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=lBylGOCrZK4L+Nv4YxggCgZsA0EFYXjRMQDKTrR5xIU=;
	b=I5tvYamWMQ+03FSdh16+JymmZsrhpFLrIe5e14t+9+GnnvLR41tZE0OTdsDZan
	G3KAszmKctAMXlGkn9I4qogaQmZ/CWhb44f1QBxBmn4ly5xoC8hfIRIZPsgLXhYs
	VLYg/YG6UXhCr21jufxLfEreWmSmsmlp9gjh+7fIO/zG0=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net v8 3/4] can: j1939: drop the message when the reassembled
 skb is gone
Date: Wed, 11 Nov 2026 15:23:00 +0800
Message-ID: <1794300103.11111.1000003@163.com>
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
X-CM-TRANSID:PigvCgDn70WxFvRq_qpNFQ--.12025S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy7KFW7Cr1UArW5AryfCrg_yoW8Xw1fpF
	y3KFyUGr9rJF4UAw4SgrWUX345C3ZaqryrGFy7twn3C3y3Ar4rtr45Kryaqa98Aa95u3ya
	ga43X3W7K3y0g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOHUDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4xKJ-mr0FrLHkwAA3o

j1939_session_completed() hands the result of j1939_session_skb_get() to
j1939_sk_recv() without checking it, and j1939_sk_recv() dereferences
oskb->sk.  A NULL here is the last step of the EDPO out-of-range sequence
fixed by the previous patch; the bounds check makes the lookup succeed,
but the dereference should not depend on that.

Drop the message instead, which is what the other caller of
j1939_session_skb_get(), j1939_simple_txnext(), already does.

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index ab42a383ff87..124054668650 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1281,9 +1281,17 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
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
 
 	j1939_session_deactivate_activate_next(session);
-- 
2.43.0



Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=mMAJy1NxqOr1XoIPpvASNOItnQluM0uHdz/3on7f5tBDuR2QPcOcwNjBmFERZzpvFzpr
	 RoRljZZpIjBVQuEAl8DrfHXTswPAcSoiAUR12YffyvbW00pWUzhHyIr3eqR6HpKgAbpsY
	 1sZDCt2XvSePe8jQ+a7WKhCAciUF3Yxcjr7ppxQS6n0GnS+D2PWD8YBHjMvUNothT+0CV
	 7nVyCDAKBgOLJZhgc4mq0QpoN1DOnOm8HWIClKdwFScB3ETSuKj9Wg5RHRrMcuUBvzeoc
	 O6uhDJB8bw0JCOyzXKW0gbJ2wE0Cix5yH9XwnF8v0kUSVEjc7xWvYPE9yjP80DG+UtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=n4LpNLUGmCOK7WTCx9HepQgf9h2uRNCxZ+WuM3lV2Og=;
	b=0e6FAMS7KSC3pHZ/hzDVn5vP62/3aeDYpfrpgf1hd5LmhJfw+cIiEbaO3+EYFVwl9Xp2
	 FSwJ68YSweYvytp2HNfcbwfk5UaVG6soPIuL8u3FyhhDQL32ZrtJlNEU9Gr9U/PVCK2xf
	 4GLeE31SDtc9c5PwJyf+vHHAKiRtCLHoPyIoB+oEyUAUbd5A4jj3AOlTKn4TIK/qA+Mii
	 o7M882k1GslpyWYUmjMDD4ePyEjKaxUPa81Zrv2e96PbSxIKeYiSG5agf5RAEXThA/lqu
	 FE5ccN9C/UpoKGoxmCX3odefQ1vtg0ohTNf6SnWE3XzMvh45r3sFknekhXjYxfNZN4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h9dmz3nU;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3Cbn8hG8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1015606A32E
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1015606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=h9dmz3nU;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3Cbn8hG8
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WwaPUb3r9G0bUy2ZfBlp/b/tNnD0Rrdy1rfRC9iwBprpo0SnjD3+O3bUjDOKT4p5gh
    MucixP9S5fdrr4Say4c5H1DIW1hfeE/MCx/wrKPZIMy/Xyyu2z1b7fG4DXbZ2RK86VMW
    vI4LSr4pGmdd2NfpzNHTewnclWhV226JQjicrU6FKOuXsYAPiXKw9mA3w6E4ufVN00rY
    Yg0Sk7m3yohujeG8eocnSAFs16JCYiC0G24a07AneQ3vx5UijpSBlIQQhfi616i5GKku
    Ru71j8j2uHtGHSAOuZqAUeUnCexM+rgsuzRlvCatYKq43fodXciv8L6ZcVvcbZVPwV2z
    x37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n4LpNLUGmCOK7WTCx9HepQgf9h2uRNCxZ+WuM3lV2Og=;
    b=n2Q07hf5mm+rW2pDR4xpsdvdaqYEbwGlAIwdUFlPG1VI3tBBN92N2dHwkmXpsy01X8
    7QolaBYMp5ejZ7KqDFNSrBQ9l+i5z6uCGDEa5ciVZFI8ogOLCY/MOBXxiy/SApJME/ru
    AJ5EqGrALLDJpKMejm/kjERmKGiowW/lQ265u+yy2pz6bJj1cLQpqkeIN0LgvkTNLqUH
    aDcU0zLFV6g49MjBEbafoFGrehb8Ozt1NEkUvSpHXyQQg3qAawZnUcIKgh1ym00FKoxP
    aagZG2GfcP/f3ZBwLfwlsrb453FNpHDHBTfHsIdnx1Avvo7mjIW6Md8NzXacY1zJUUvV
    pXjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n4LpNLUGmCOK7WTCx9HepQgf9h2uRNCxZ+WuM3lV2Og=;
    b=h9dmz3nUYXY4UB8nD85K8uNAyBHmLHTAg381n5CtHyDjv30u9jooEEvdqtDPrb7LTp
    jbFhvCkt7aqjBd2GhfZ/Wu8jQSjV+IYiryjonkyI77RfcbiR17mqF3+7JYYQ1bEkfAg9
    nJdlbEbZ+afbIjfxkHLNmXF0IzaVc2JPt1GxVsqRKnccYTOSPx0/VNThf2tFR9oBjSyh
    holynJa9oMcHVILsUjdxmInPwyv8gFlzaxorw3Y2nj/Jlb8iJgnLZDEv5zxQ94qk9TqV
    V4lMZhgHhToJwHKtJ8hMPXweqoyTlzE/ywHuxIVZD2gRJaR8pxpJmi+eCeSk5GKRptyu
    HxwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=n4LpNLUGmCOK7WTCx9HepQgf9h2uRNCxZ+WuM3lV2Og=;
    b=3Cbn8hG8B2/QzUrafyVvG9lWULxiiBZJ+kUHDV02JVrNMxueEV2FbUMzb9zQnyNt2J
    oRjGtNIYbNl4hrBzxCBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:51 +0100
Subject: [PATCH can-next 09/22] can: isotp: drop frames without N_PCI
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-9-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=950;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=sXtwrWZyYeec/rSqacTzPU/TRf7pyONH2oThGo/oQgY=;
 b=HqgWn0LVqPoGZWTLm99e34F8czAh9kVnqi7PN5NcSVGKtBM2fpXOdCpUseZRzT7KrhT64dpe1
 cBzBadpGmqpC1tJxyjbU6W+5YOkXocIe3/HbsEEgL/6iUbLwwrEUjk3
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_rcv() reads the address extension and the N_PCI without checking
the CAN frame data length. So frames with CAN_DL < ae + N_PCI_SZ are
processed with stale data beyond CAN_DL, e.g. as SF, CF or FC.

Drop these frames as they are no valid N_PDUs.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0af1a689fdd3..e51a513402b3 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -777,10 +777,14 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 		return;
 	}
 
 	cf = (struct canfd_frame *)skb->data;
 
+	/* frames without N_PCI (and AE) are no N_PDUs */
+	if (cf->len < ae + N_PCI_SZ)
+		return;
+
 	/* if enabled: check reception of my configured extended address */
 	if (ae && cf->data[0] != so->opt.rx_ext_address)
 		return;
 
 	n_pci_type = cf->data[ae] & 0xF0;

-- 
2.53.0


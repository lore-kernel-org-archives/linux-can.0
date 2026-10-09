Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3D4E432E;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553425; cv=pass; b=YaGe87UZXBQnqjKBjvxf8MuSnB6rrjoqdWWy7122CmsyFB4JgDTM7LyE+Ngl23robsx8iaivEEXwPshoEfRG5McAVRGiDIg+ZIPRjXt/VxapRnBNLs/ekmfrNMdCRicO/FgCmxg2b7RiHno1WbKCqS2SrGXorvSqIx95z3k6LXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553425; c=relaxed/simple;
	bh=JejBXx72CU2mW1yYvpU2sbl9m/y5FYH91bk7US4u3Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sc+G+j74AKjITqw+Zxu90wfu5IqtTHuFGa75NAiIJxYLbbNhfVBxykFF1twXyyt3ZooN1kkg6Ist/QyqeTuar1e0p1rfEwzlfY3CKnXLQcfYgDKBcXYYD7vpklV9iTKOvbO3uarwr4JR8mXeNoOFcaW2U20AQC2s7BOVA04Zq88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=EymQUD/A; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="EymQUD/A"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 33512202668;
	Fri, 09 Oct 2026 15:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWUdI+5WSZvqGaNL3ACtccYFLFFedLnSh4In6J/NUVs=;
	b=EymQUD/AFfSK3e4tXWUZ6YlHcDMS03O0319d7DbjMyT0wLjPtVzzhmkwXURngSmYqH33lk
	MptAf2AClEKo3aZ4eGLBYXLfq1SgjCz3AymD/IcsvFQwCFbes8ZMySLu0KqgSk4J6sMmtk
	egOKXqtdxwVkcIHP011uF/2M8+w+hyAK9AkgQ1FfLyMlA86ndRUlhONsifk2rva/sfm/L6
	s0Jr9jtPZ53UcF9myigPBkIpMedc1qLL+mx0Q2jBhaGbFs4xp/b042diwXDUJvA8Gu+RGJ
	Vx+S0D/IJ5ap3MlZ6Be3wnrZvvzclKJaBorycY82u7ElwMUOHc8O4s2g8faOcg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553419; a=rsa-sha256;
	cv=none;
	b=Y8cTNnk59cB0D9edVOYdLqW4JIcQm7bRt2lNBg/nZYgfKyxCTPF1vCYylFnTMpM8ucUmkI
	m2YU/oAv+sB1gjwpsHltHPnrcKHeklaA7oUsmofK3hyyr78AteM1nkz1wUOqqhyM/2iMcO
	CI56zIe6OXZdLyMos8v7ik7d0wFmYmyrX0fzc0UUM0+MlQv7ph56jPYs4RdM2b9ySolQSL
	MOIxBZbOwraH5K1emAAP7klk4S9IEZeEHZwZxUm7dPgTLx5lqCNVV3tExame+45iT9n3Br
	iN/FztssF90rkcJlDkEBvIAkb9/jZsWWq7W0p6eOL6miCAJcCLD9A79B9/J8Ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWUdI+5WSZvqGaNL3ACtccYFLFFedLnSh4In6J/NUVs=;
	b=W8M62dbwEZl6XsLBaDinA0LopxQf3DLzhkMltb3s+1AaKqUdeExqyZXkf3eDs+MX9/Vout
	dKxbMpeu/Zt7JHiT3K0F56tSDQZLU48dkKKOrQg0z3D8dAN1zV4PRZb0joN+DKT15Djk6F
	IjYbWvrVLFKe2cMMRUB9qyEO074vnfuspYSgQilVbLCNn3TZi6Quo6Bb41TX2S5khYB7NE
	DiF34BOaJXxh/ui5s9z2sa5GkqQL+HR495JgIjBSqDGKXdZQhZB1R3TFeZ602KwgZDcjHI
	BPImi8t2eI3zcl33hh4tIdMvEWt/9wU7rgTkktxaUbIAMAbqxErnsM+Tzzm4Tg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAst-0053TD-0L;
	Fri, 09 Oct 2026 15:43:39 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B60425BD8D9;
	Fri, 09 Oct 2026 13:43:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 27/37] can: esd: acc_start_xmit(): do not touch skb after can_put_echo_skb()
Date: Fri,  9 Oct 2026 15:27:59 +0200
Message-ID: <20261009134323.64064-28-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the call to can_put_echo_skb() in acc_start_xmit() the skb should be
considered invalid and not accessed anymore, but acc_txq_put() will access
the skb's data.

So far acc_txq_put() first loads the CAN data into the controller then
starts the TX. Move the start-TX functionality into the acc_txq_start()
function.

In acc_start_xmit(), first load the data into the controller using
acc_txq_put(), then can_put_echo_skb() and finally start the TX with
acc_txq_start().

Link: https://patch.msgid.link/20260929-esd-fix-skb-deref-v2-1-542e3e19fb25@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esdacc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index 73e66f9a3781..05d41ed34a02 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -62,14 +62,17 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
-static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
-			const void *data)
+static void acc_txq_put(struct acc_core *core, u32 acc_dlc, const void *data)
 {
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
 			   *((const u32 *)(data + 4)));
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
 			   *((const u32 *)data));
 	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
+}
+
+static void acc_txq_start(struct acc_core *core, u32 acc_id)
+{
 	/* CAN id must be written at last. This write starts TX. */
 	acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
 }
@@ -287,11 +290,12 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 		acc_id = cf->can_id & CAN_SFF_MASK;
 	}
 
-	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
+	acc_txq_put(core, acc_dlc, cf->data);
 
+	can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
 	core->tx_fifo_head = acc_tx_fifo_next(core, tx_fifo_head);
 
-	acc_txq_put(core, acc_id, acc_dlc, cf->data);
+	acc_txq_start(core, acc_id);
 
 	return NETDEV_TX_OK;
 }
-- 
2.53.0


Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010B411660
	for <linux-can@vger.kernel.org>; Thu,  3 Sep 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429356; cv=none; b=Q1pOM+knSPvIMMrgjdBpGtr5dlIlj2jNk3958bpk6pIxPtGvGtMJxR9osh+VaNNHR0rqQWSEuMJ0ScLAMGxib9jiRXzSptAISHgajUX7vJMuFi8qJDB1MNr1w26yx/sCeFSHEVY1SXmwFlaeDscCwOaR2P9AFl+OMGkci96Tu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429356; c=relaxed/simple;
	bh=FxSE0ftZwobdenuKclseLK1NyrAH4QAW42Gahf10Gg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CSSAUI52FoR+mLEfPSqIYSvbKaGuONA46qvm+QfDREivxSJ+0jbxG+Wumor2aogiRp/2JjYL28fHAuPvn6YLiMMQpXELLFVte5p61jFl50DYXRAOvsLcGVjZ73zZ/7rZ7yaJbR8TF3i7kjfbbWeCXjVehayOq4m1ys7ZtFfGRZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gp4JNHMi; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gp4JNHMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CI
	NcGimKjkqa/6nlkn0DE3c+vmrNtQ7+LapJpVCkJIk=; b=gp4JNHMiTaqBJQb8N4
	7BKjDBoeICWeabsQT3RWpuwL7TedZn9OUmjcvAl68ILk5wpe7EGVDMom3lfsSxb/
	zvtI7GNqJA7jhnijkw+HmAA1YBlHJRIu7TixqdpTueujTJJbH61j104xX7nSW43I
	Lq3QUJZn0JuZ6dHPZS3osHRvs=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3DJLkQ5lqpS9qAQ--.62791S2;
	Thu, 03 Sep 2026 17:54:45 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	m.tretter@pengutronix.de,
	pkshih@realtek.com,
	tmuehlbacher@posteo.net,
	socketcan@hartkopp.net
Cc: enelsonmoore@gmail.com,
	davem@davemloft.net,
	wg@grandegger.com,
	linux-can@vger.kernel.org
Subject: [PATCH] can: sja1000: drop RX frame when skb allocation fails
Date: Thu,  3 Sep 2026 17:54:44 +0800
Message-ID: <20260903095444.495807-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3DJLkQ5lqpS9qAQ--.62791S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr15Zw48tFWfXryxJr48Xrb_yoW8Wr18pr
	ZYyF10yr1kXF45X3Wqv3W8ury5tan7WrW5CFZ2v3W5Zr13AFnIvr1fKrWjq3yDZrWxJFW3
	uF1YyF17GF4DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjCJQUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AYL2WqZQ+YUCwAA3x

From: Yun Lu <luyun@kylinos.cn>

When alloc_can_skb() fails, sja1000_rx() returns without reading
the frame and without releasing the receive buffer (CMD_RRB), so
SR_RBS stays set. The interrupt handler's inner RX loop

	while (status & SR_RBS) {
		sja1000_rx(dev);
		status = priv->read_reg(priv, SJA1000_SR);
		/* check for absent controller */
		if (status == 0xFF && sja1000_is_absent(priv))
			goto out;
	}

has no iteration limit, so under sustained memory pressure every
retry fails the same way and the loop never exits, livelocking the
CPU in hard IRQ context until the hard lockup detector fires.

Release the receive buffer and count the drop instead, as other
CAN drivers do on allocation failure, so the interrupt handler
always makes progress.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/can/sja1000/sja1000.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 3cdb583ee3e5..da107feb22af 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -348,8 +348,12 @@ static void sja1000_rx(struct net_device *dev)
 
 	/* create zero'ed CAN frame buffer */
 	skb = alloc_can_skb(dev, &cf);
-	if (skb == NULL)
+	if (!skb) {
+		/* drop the frame to guarantee forward progress of the ISR */
+		sja1000_write_cmdreg(priv, CMD_RRB);
+		stats->rx_dropped++;
 		return;
+	}
 
 	fi = priv->read_reg(priv, SJA1000_FI);
 
-- 
2.43.0


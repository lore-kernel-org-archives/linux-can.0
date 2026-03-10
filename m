Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CF936EAB2
	for <linux-can@vger.kernel.org>; Tue, 10 Mar 2026 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138963; cv=none; b=HlRzGtcjGkrn88SolA4v891PAQ9xSlZgzMRzf3PbrmNuK2b0r3UWklGW1e31vwlD+SqCFjS46bDzu8C2bF2zaW7+1VpmuUExnKpjnPXon6tdvhmPsyY+xnEF/yEfwRUiTPROiobl6SN8wv2oWe1e7GzFGhoHoQKBUMlrofI0pO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138963; c=relaxed/simple;
	bh=NNfQBAczDK2ctlXoMn2m1CGkbV49byIIrJ3oS/Va/vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZj2jJeSHdR9sV7PkjAaGAoFoJLZd1PJh3avZ2x1abxVvahZaJRWF7S5p0BhwtzFUI1b3iH9IOh/s0CGLtA08SjD4Gdt2VnJsNZOi4jgOUTidq+2dqbkGKOhAfI3nPqBLmJy/kYrwFlEsOtuxTmRdmRtLAPM36tvatUV4sMz0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRP-0001Kp-6e; Tue, 10 Mar 2026 11:35:55 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vzuRM-004gN4-1F;
	Tue, 10 Mar 2026 11:35:53 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 767CC4FD2B2;
	Tue, 10 Mar 2026 10:35:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wenyuan Li <2063309626@qq.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/2] can: hi311x: hi3110_open(): add check for hi3110_power_enable() return value
Date: Tue, 10 Mar 2026 11:30:35 +0100
Message-ID: <20260310103547.2299403-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310103547.2299403-1-mkl@pengutronix.de>
References: <20260310103547.2299403-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Wenyuan Li <2063309626@qq.com>

In hi3110_open(), the return value of hi3110_power_enable() is not checked.
If power enable fails, the device may not function correctly, while the
driver still returns success.

Add a check for the return value and propagate the error accordingly.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
Link: https://patch.msgid.link/tencent_B5E2E7528BB28AA8A2A56E16C49BD58B8B07@qq.com
Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
[mkl: adjust subject, commit message and jump label]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index e00d3dbc4cf4..91b1fa970f8f 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -755,7 +755,9 @@ static int hi3110_open(struct net_device *net)
 		return ret;
 
 	mutex_lock(&priv->hi3110_lock);
-	hi3110_power_enable(priv->transceiver, 1);
+	ret = hi3110_power_enable(priv->transceiver, 1);
+	if (ret)
+		goto out_close_candev;
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -790,6 +792,7 @@ static int hi3110_open(struct net_device *net)
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
+ out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->hi3110_lock);
 	return ret;
-- 
2.51.0


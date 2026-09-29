Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D5D38DC62;
	Tue, 29 Sep 2026 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666465; cv=none; b=iHEsvG9LIO/DsVQM//cKISaGBbzsqEzIEhm6PhFxPxGYzREtn8dLLF+PAq49/ZXFWAtBU0J3tfpqtEX3624YIX6lbdum9FMCve/qKpJE3ulGRGn5TsIfA6d4JWVLqP3pxeCZ0M1DmCFGIyUGu+Eb0O3rdQ3v6IFWFv2prp7n49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666465; c=relaxed/simple;
	bh=Vs/P4dXs6c8s/aZmKt4aclnH7hl6ek5iwzflNmhTyyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUBAeykQ3wuiSvdyR75nruySloFVxxmaIrxCtZZHCvMpHOZpxBQHToGsc8Gpz5WI6zUVt+V2IV/C87PXCezUYz7EskupetQz8blfRe29NngFmGAfmMpfvZ4Nomohz4+jmYztUYuoNMRbY3GnxStmHvaJ/7lGxZn4OcvHjomuU7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht; spf=pass smtp.mailfrom=yinhe.ht; dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b=C9wDqC8o; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b="C9wDqC8o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1790666459; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6gcvWUduQgZEnxtGhj0Epfu23aKKk62jDLHDS30ht6o=;
	b=C9wDqC8osqPOZl+Hs2sURwG47VrZILMaqtOt5S/kbFKpsF1+KXtXdGIMQrGzyqVGO0SJdX1Eh8oD/A/9dS8y+U7DyU4wZF25CyL3NKMlU6knkTkr61BKTZwxbu6xed2brG3ltiGAL99nGweqfV6G++TyjaBkbMI+kKZ38b8EzqfGeqYh8IzEAvBGOnojx6Qtpfc10IBhRc+QtwSfcGblESXfSvAAifCFV4chdB5lGBTqz1AmZWaFD63k4zMSaikMsEgF+Dgv67GqiTojPDZ0ItybG/gT1BgAfkT4gC5goPyyeSKM804hbOO4VxymuDLGRUmnOu7mUK5symf8fJ4tKQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07798738|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00296266-0.0030093-0.994028;FP=16189559442658389668|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jR1atg0_1790666138;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jR1atg0_1790666138 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 15:15:38 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	haibo.chen@oss.nxp.com,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH net v2] can: flexcan: fix synchronous external abort in flexcan_get_berr_counter()
Date: Tue, 29 Sep 2026 15:12:36 +0800
Message-ID: <20260929071236.185683-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the interface is down, can_fill_info() still calls
flexcan_get_berr_counter() to fill the error counters for a netlink
dump. On some SoCs (e.g. i.MX8QXP) this can trigger a synchronous
external abort.

The root cause is platform-specific clocking. On i.MX8QXP the CAN
clocks are gated through the SCU LPCG and the whole subsystem shares
the IMX_SC_R_CAN_0 power domain. flexcan_runtime_resume() only calls
flexcan_clks_enable(); combined with the LPCG e10858 synchronization
erratum, there is a window where pm_runtime_resume_and_get() has
returned but the clock has not actually reached the module yet. The
immediate readl(&regs->ecr) in that window hits an un-clocked target
and faults with the external abort:

    Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT SMP
    pc : flexcan_read_le+0x0/0x18
    lr : flexcan_get_berr_counter+0x4c/0x8c
    Call trace:
     flexcan_read_le+0x0/0x18
     can_fill_info+0x1f8/0x434
     rtnl_fill_ifinfo+0x8fc/0xbb4
     rtnl_dump_ifinfo+0x364/0x448
     ...

This is the same class of problem that was already fixed for m_can:

  commit 91a55c72a821d ("can: m_can: m_can_get_berr_counter(): don't
  wake up controller if interface is down")

Fix this by returning early if the interface is not running.

Tested on i.MX8QXP: after the patch, `ip link show` no longer triggers
the abort.

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Link: https://lore.kernel.org/netdev/20260915063511.3010642-1-chunyuzhiqiang@yinhe.ht/
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v1 -> v2:
  - Reword the commit message to drop the MDIS reasoning and describe
    the actual i.MX8QXP SCU/LPCG clocking window as the root cause.
  - Reference the m_can precedent (91a55c72a821d).
  - Add Fixes: tag pointing to ec56acfef2af1.
  - Add Link: to v1.

 drivers/net/can/flexcan/flexcan-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 06d5d35fc1b5..b08779ee2a0a 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -765,6 +765,9 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
+	if (!netif_running(dev))
+		return 0;
+
 	err = pm_runtime_resume_and_get(priv->dev);
 	if (err < 0)
 		return err;
-- 
2.47.3


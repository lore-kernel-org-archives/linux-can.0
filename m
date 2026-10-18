Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD83905EF;
	Sun, 18 Oct 2026 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792318901; cv=none; b=K5E48NwtbwO/qaBAjVlcGWN8a+JGxcKotUv16mT25N500HbkGVNNKqd4nkq/AmzwcxPzpDjNESpElEfmYubC2o4jgL+XhTTRDWkWiKl1RbFG9DlwEjx0OygU6PZi8PftIRb01BIpdu1Pbgo0M6b1raSV8LVjUJ9/euQsJdR/1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792318901; c=relaxed/simple;
	bh=MqIop+Ry5uHGldSb9XPw77eJyDNc2sII9hGClB09mQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyNgJGNMSozUQAw/FbMVi7Q8ns+bOcQLQNzCdZbh9rCQOrRKS410hcFe5Tw1+WNy3nFnhUMaWyQwJgU/Z3hC7tnosjLDYOR0tDXquLjhXnw3OgMJ2DyZs2w97dO2KOqOpebT47idfVlkCeHqVkzP/iz3BQT4qpnS5TCHDvQkjnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht; spf=pass smtp.mailfrom=yinhe.ht; dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b=JjcZSRpD; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b="JjcZSRpD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792318889; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oPcpo3LDbQ/rlNvHeFnmd3lUFBVjp8gt26UuGxzknmc=;
	b=JjcZSRpDg6jjBbke8IR/NJYHugk5fUm4hQ1ZxMtp/KEElxFFawxcxtzE2HpzcJDNQo1lAvtmhNxMcAnaTPW30Qhqq3ezioLZiIuzGE21OOe5u0nibiV/v0oR2NxxxZiX90G2OfSI5OUXagSo/5r6CRlW7a3+5YGrzONUnYUJkUFtMBqGJ4G3N0el6NL8u2m+zgpuu6EBEZRPtAvZNtXWMZ8faT6hkBmG0fw8gcEzFg5Y8NH9tsCqwpgWaF9EDBLi5napfU1TuHA66ITXltvhOHB85uyPPp9IifBotxhvIz5Fy6nqBa+EOs5eX5zyTkwgdVP5aOhqyxC14Rti7yrhFg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07668728|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0457954-0.00438278-0.949822;FP=5349324788030295733|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jiygvZo_1792318888;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jiygvZo_1792318888 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 18 Oct 2026 18:21:29 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	haibo.chen@oss.nxp.com,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH net v4] can: dev: can_fill_info(): don't wake up controller if interface is down
Date: Sun, 18 Oct 2026 18:17:44 +0800
Message-ID: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the interface is down, the CAN controller might be powered down, the
clock disabled, and/or its external reset asserted.

Don't call do_get_berr_counter() to read the CAN bus error counters if
the interface is down. This fixes a generic logic problem that exists
on all platforms.

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v1 -> v2:
  - Reword the commit message to drop the MDIS reasoning.
  - Add Fixes: tag.

v2 -> v3:
  - Use the title and commit message suggested by Bough Chen.
  - Drop the i.MX8QXP-specific crash dump and erratum explanation.
  - Drop the m_can reference.
  - Drop the Link: tag.

v3 -> v4:
  - Move the netif_running() check from the flexcan driver to
    can_fill_info() and can_get_size() in the CAN core, as suggested by
    Marc Kleine-Budde. This covers all CAN drivers, not just flexcan.

 drivers/net/can/dev/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6f83b87d54fc..d17f4e9cc144 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -584,7 +584,7 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
-	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+	if (priv->do_get_berr_counter && netif_running(dev))	/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
 	if (priv->termination_const) {
 		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
@@ -735,7 +735,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 
-	    (priv->do_get_berr_counter &&
+	    (priv->do_get_berr_counter && netif_running(dev) &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
 
-- 
2.47.3


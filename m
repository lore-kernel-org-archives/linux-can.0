Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5723D0908;
	Wed, 30 Sep 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790749865; cv=none; b=Scb81N7SP7yX1WX/KPC9W4qhE5OTHBIKSwikol5s3yMCA26sWyz7zp7m+eTqHHnE4m5M60sL72CfQqx3aGd5GU3HfSHhsTyussjTIJd6b6AoaxdFUCSNOuBi2lbfWEW1COFdXwBZZ2smsyYPiKsyOt7lS5FTeFvxCcnfMIfjL60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790749865; c=relaxed/simple;
	bh=x1/PaJ5FcXJHLyRok53idUHH6w1VF5hbdT0jMUDmBfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOsf9qBRijKSJNueFqXSVjwfqUPi52MH1khfcKTwt+7VkTQ8oiL+z9Nxiwwhk863w7Aphi4O4GZ/FowRe/T78FAxV4qlzF00o0urXGUjae2X2JJPx63f+vJVFIA4mXOigDLOKan1Ak8/P4fTD/U0BjGYu1cihbdAhOFZnp/emu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht; spf=pass smtp.mailfrom=yinhe.ht; dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b=qCrNGytf; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.b="qCrNGytf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1790749844; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MlqJFUlVHM/xR3/p161TrnxuVaSq+hhAtT+kF3/GzaA=;
	b=qCrNGytfHRFoIamppdYZiRpRV3RxMW3kOs8SHsdcciiMlAgcf/Gia//3LqTJ6Gs83174xXSdUvWzZihE+Ggxpc+e4gntNIf2uhtUmrWLLt6K7ihVfDtu42jvU5nfR6eby3oSSu7iNmQ/afGRZtl3/BQIme5b0zpXveSdsEqFRs8XkS/vRf8u6g/2bUj8rtxq8XyUQiz6EkNJsKkUJ8YliEUtSFfaRV5bZY/AQXDMBDAWptsqPtSoquoDn1DLQ98rDtSQOKbRMWCYWZ2JZ0itE7hRlX+PcNCwiq3XfxuG9EoL68tKh241W670IcfkTsOKKu/Mq8lJzS3Fv2HSo4a+Gg==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1625943|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00184855-0.00134104-0.99681;FP=12411038805622681252|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jS1Xuy5_1790749842;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.jS1Xuy5_1790749842 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 30 Sep 2026 14:30:43 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	kernel@pengutronix.de,
	haibo.chen@oss.nxp.com,
	shawnguo@kernel.org,
	imx@lists.linux.dev,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Subject: [PATCH net v3] can: flexcan: flexcan_get_berr_counter: don't wakeup controller if interface is down
Date: Wed, 30 Sep 2026 14:27:38 +0800
Message-ID: <20260930062738.30145-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the interface is down, the CAN controller might be powered down, the
clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if the
interface is down.

Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
Cc: stable@vger.kernel.org
Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
v1 -> v2:
  - Reword the commit message to drop the MDIS reasoning.
  - Add Fixes: tag.

v2 -> v3:
  - Use the title and commit message suggested by Bough Chen.
  - Drop the i.MX8QXP-specific crash dump and erratum explanation;
    the fix addresses a generic logic problem that exists on all
    platforms.
  - Drop the m_can reference.
  - Drop the Link: tag (added by the maintainer at merge time).

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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110C43C067;
	Tue,  7 Jul 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447248; cv=none; b=SmFaMS3Pb8/M7vSHI0KpGK7wU8FXl1P725QHlJZzwMnLVI8Bn4tseN9vueQx7bdKwuS1xxK90Qqjlm7scPWC7EkKnilZmGVVutCJXKtxT7YbliAwUGwePbARu3TJSAYF+kvWWlSSdXv6GsZVweeDVlbPAJBIbqzNgbIJf7LkWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447248; c=relaxed/simple;
	bh=loo2OdcIs+xpNjMCDmWrUTELPSdUl6N1IWlt+SriCGQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R4ArxCtXVQDiUQ2TVgABSWGtZ7P7ElRaRXCbXQN4qVAHCqDHROZX06p8cNTYU5IZ4UYdaoTkB5J1KRpGuAGv6Q1j42nlSu1eGt3T9Rs79YKW5YdR8ottcu5IowY6A8i2+mPq8PltfSP72k76bqZdpYUOFBIcoKN9pHgtYpa50KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgAGe7JP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgAGe7JP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6975FC2BCB9;
	Tue,  7 Jul 2026 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783447248;
	bh=loo2OdcIs+xpNjMCDmWrUTELPSdUl6N1IWlt+SriCGQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=pgAGe7JPfU+idnkY2or49+RtTJHyGfmTQZ7EJPRUw9UndZQjc7Vn4JZCMS6TAvOwm
	 zEIOlg+yY1Il9/5m9ftAxNObdNQyEnS//KeYxXefKxrew74XoCkOWB5mpn+Ywneb9G
	 75eglahfqP86HgFZp931bkeXWO/yMwZs/5EmZzVB5mDjRuC1dPKqIp+whtOboDrygv
	 +1QEpUfbnX+dZdrJxQPoUEjLIt40r2rOThkqHWK4OzgaoufX94WvdXqv++R5rEdGU/
	 657heU7YtqApJJT16TsaB2I+fdUSwYLyfRBFeWVLc6/sb0GmOCJaGPXSuxsreJmTEQ
	 WPLaJJZwVTOIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E77C43458;
	Tue,  7 Jul 2026 18:00:48 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v5 0/8] can: bcm: collected fixes
Date: Tue, 07 Jul 2026 20:00:36 +0200
Message-Id: <20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQ+TWoC/3XOQW7DIBAF0KtErEs0Bgw4q9wjiqoBj2taxbbAs
 VJZvntwumgUOcuv+e/DzBLFQIkddjOLNIUU+i6H8mPHfIvdF/FQ58wECA26ENz5y2cTbpS4VY1
 TiJVEL1juD5Eeh1w/nf9yurpv8uM6sDbakMY+/j4em4q1t7U7FRy4R9EgGCIDzbHFOP70w7Dva
 GTr9CT+sQHzjEXGldYCfCmVM+UGlm+xzNgqDeBR19ZWG1i9xSpjRGucdVUt5eu3l2W5AwSSCwV
 uAQAA
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783447246; l=2272;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=loo2OdcIs+xpNjMCDmWrUTELPSdUl6N1IWlt+SriCGQ=;
 b=tlCSoZLjbDzh56/Ka8aze7um56VYHf1qpKlVYR3MfbyCl+ffmXMbRo0+UahC8dN9J2lTG2skb
 DatPowdmWWzAlnic3doWJKiP6hN5f2uUor7+BBBfDzHzBm5HU9JRl75
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

Hi Marc,

as there were different patches flying arround to fix CAN_BCM issues and
AI assisted stuff pop's up again and again, I've created this collection
to be applied.

I'm not sure whether sashiko-bot takes the sequence of this series into
account when checking the last patches. So let's see.

Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v5:
- patch 6: changed comment for bcm_op::bcm_tx_lock (mkl)
- patch 8: new: add missing device refcount for CAN filter removal
- Link to v4: https://patch.msgid.link/20260707-bcm_fixes-v4-0-aa87b8b9d33f@hartkopp.net

Changes in v4:
- incorporated more sashiko-bot concerns from v3
- patch 3: omit hrtimer_forward with zero interval
- patch 4: put bcm_update_stats() under bcm_rx_update_lock
- Link to v3: https://patch.msgid.link/20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net

Changes in v3:
- incorporated more sashiko-bot concerns from v2
- patch 3: make snapshot of currframe
- patch 6: add error patch for memcpy_from_msg()
- patch 7: new RTR-reply validation in bcm_rx_setup() from bcm_tx_setup() 
- Link to v2: https://patch.msgid.link/20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net

Changes in v2:
- incorporated all sashiko-bot concerns from v1
- Link to v1: https://patch.msgid.link/20260612-bcm_fixes-v1-0-ca2fa07ee70f@hartkopp.net

---
Lee Jones (1):
      can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

Oliver Hartkopp (7):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal

 net/can/bcm.c | 476 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 351 insertions(+), 125 deletions(-)
---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



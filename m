Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55683381AEF;
	Tue,  7 Jul 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419377; cv=none; b=ha6v9z2LiCRoYy5/W6wAGLsp0bYlKUVWMDx9yIs4ArZ++HthvnkRudmTWEmoykLzGcRKZKRLCQHRvaokGiLGiZCXV//r6FTAfkgYQ9FI4ffBjUzyH6b02s6KwCmsc6j0S5moX6rDRzxwnx4W3majW+32JQgtfSpWMz2+W1XliKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419377; c=relaxed/simple;
	bh=y2H9QtAl1+vBSs56o1KfjI/JrbU58kVjOgl4MWaQQAE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XQIe/DO+1uD4Hk+LPO2iwVMsz1PmJQY796fFKlAq95S4nZLdj6cpxix7T2YU5yt2x0vHkYkIh882isGBSkGnGpM7SF4mRDqoAcSUFCpR+EKic57kexrU9gM5HeTAvxxUCBfS402d0j0aOQJhGL9206YiuKhZxv1apuWf0raIwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9S+bt6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9S+bt6s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05860C2BCB8;
	Tue,  7 Jul 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783419377;
	bh=y2H9QtAl1+vBSs56o1KfjI/JrbU58kVjOgl4MWaQQAE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R9S+bt6snBJzkyUgIN6CNt9oCO2OsZTleuyubv4zSKMLHqnCaSFdKHkPufGQuix1Q
	 M244fIa/GPVIJuBf2KfVZtZXgn8jRUis/60Jb1vN2F7b8dDBQl2gUOR2oCF5+6eEdW
	 ui1w+Aax/7gXE6HrUpfTF9e3pkcltBvOvRtH+gFAEpsankECXPoJ/VuNbnQY9B1QKR
	 FnKn+rgpCANdtKuXxJpS+G7rvsCCyFtP0HRkCLzSa2c/iPrYQBKXcDYaYuYkqa2NTy
	 vIFdgb5O8wwh4cdGFFEovucGEXIBVi5V1a7RxskpZfMedk1sIsmYJRqGfP/FhuKHgV
	 8CiXagDuVJC5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BACC43602;
	Tue,  7 Jul 2026 10:16:16 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v3 0/7] can: bcm: collected fixes
Date: Tue, 07 Jul 2026 12:16:07 +0200
Message-Id: <20260707-bcm_fixes-v3-0-84600ca6d889@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfRTGoC/22NQQ7CIBBFr9KwFkOnLVhX3sMYAzhYNLYNINE0v
 btQFxrj8mfeezMRj86iJ9tiIg6j9Xbo06hWBdGd7M9I7SltAgw44yVQpW9HYx/o6aY2qpayraQ
 GkvjR4XJI+P7w3v6uLqhDDmSisz4M7rk8i2Xm/nVjSRnVEoxkAlEws+ukC9dhHNc9BpLTET6yY
 OJbhiS3nAPTTVUr0fzI8zy/ACbJo2n0AAAA
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783419375; l=1700;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=y2H9QtAl1+vBSs56o1KfjI/JrbU58kVjOgl4MWaQQAE=;
 b=CSfirpZaCUrg5h2n3eQ9Ka3Vpmiqc+gDhsROMlw1ui9v1/VjK4MfKGMVKvms5cYeLiQxrMBx6
 mUvbUWF2dO2A5IcMQj2u2Srw5Y+LCrypDCCVqYlEteyN34NPqBfH58E
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

Oliver Hartkopp (6):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies

 net/can/bcm.c | 416 ++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 314 insertions(+), 102 deletions(-)
---
base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



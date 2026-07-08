Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6E2459EA;
	Wed,  8 Jul 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531625; cv=none; b=N8uu/dJEJ8pPmCbe9mcT73nbacp9nEzYpwOEDV8DVxsLNFp9sC+Mu2AfKMOsQkdPAIjO+ttuFngbpDPgOqlPQDNvvFDQ3WSBsssSQXuc+J8Tp84r/aOjnl2RXpl/E0dhFnRMFdUDfSvA52c8M52RuHMuWb9JtC+alRQY3RSZkxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531625; c=relaxed/simple;
	bh=emJK7s3uH0kc9GlzsWmRPhn814QD8Pe744LrTxCXzNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tMi8Y1l1n3yUniWjnW0pNkFldeS3ZbfeNWOzbdHd5c0OiLz4LgGnUWi4+Fn0Klichv9f6h2tlubPnN+tlGNQEtseTMHFSOsbdIrfKxVBMzi8nxgxiO5hE/VxScQovHRc8BWklqEAYUuk4uuDluHf/RnlBiJyzUWkuiyoslUmgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DluASXUZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DluASXUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 017E4C2BCB9;
	Wed,  8 Jul 2026 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783531625;
	bh=emJK7s3uH0kc9GlzsWmRPhn814QD8Pe744LrTxCXzNc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DluASXUZ4/nhj0iBg+gSIxMYt20RwrA/u72/XF8laEPAbpiAUkjm5z+4IBx4Jck41
	 RLAOye4Q+RqckPpplXuD02aNgzIxHbZLur9GHut2VU2XX1tBPr4oIwxGpVGXIYERRi
	 rSzXdwwW7sv4WOcBouXAnhy/TdTK5fJrcWjPCOCzEowgBHifj0qHj6PynMR9dfm0sp
	 oiZe3YAXJhO0r+DOWSv1DDko9TkqFepn2fG9ySphKffOthROFmKZjg8PGOQ9Kj6sqD
	 Z0W/lcCDMUZCEKJQ+ImgdEBmp5harav37skBJr+2YFnsxOgt8V2CgNv6ldC/c/c7Jc
	 jFkiYWxHtJv4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34D1C43458;
	Wed,  8 Jul 2026 17:27:04 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Subject: [PATCH v8 00/10] can: bcm: collected fixes - final3 :-/
Date: Wed, 08 Jul 2026 19:26:57 +0200
Message-Id: <20260708-bcm_fixes-v8-0-8c2f5f3bc212@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKITmoC/3XPy07FIBAG4Fc5YS1mCpShrnwPY8xAwaKxbUptN
 Cd9d+G4sDF0OZn/m8uVJb9En9jD5coWv8UUpzEX5u7C3EDjq+exzzUTIDToRnDrPl5C/PKJGxW
 sIuokOcFyfl78rZHjT8+/dfq0b96tZUBJDDGt0/J9W7Y1JVebuzUcuCMRCNB7hPA40LK+T/N8P
 /qVldGb+MMIeMQi405rAa6VymJbwfIUy4yN0gCOdG9MV8HqFKuMiQxaY7teytrZ7Sluy8/SoQq
 mNyFgBesjNkesy9mADZCwTnamgvEUY9mM+VltpRJe/cP7vv8A4nYpTiUCAAA=
X-Change-ID: 20260612-bcm_fixes-84fb4aa93ac2
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Feng Xue <feng.xue@outlook.com>, Ginger <ginger.jzllee@gmail.com>, 
 syzbot+75e5e4ae00c3b4bb544e@syzkaller.appspotmail.com, 
 sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783531623; l=3945;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=emJK7s3uH0kc9GlzsWmRPhn814QD8Pe744LrTxCXzNc=;
 b=YyouBw/RiSUDrke+wwDWSmNhnGSVQFmIgxjpJ79pD/B0HKRhqbfuxusL+nb6WAWfJZ3Emhnu3
 Ja8xl1K2dygAtibRW1eRdHZq7HTZjq9P0LP42IBxYxCg28PYsZBAzgv
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

The patch series fixes ALL issues reported by ALL kind of AI bots involved
and the fixes were assisted by claude code and later rephrased and shortened
by myself.

Inserted a new patch 9 that addresses a late sashiko-bot report fixing some
stale rx/tx ops behaviour after device removal.

Btw. I added a bug when reworking the patch that sashiko-bot found.

So the potential new AI reports on this patch set report problems that are
solved later in the series. This can not be resolved.

Best regards,
Oliver

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v8:
- patch 9: fixed two issues reported by sashiko-bot:
  https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.kernel.org/
- Link to v7: https://patch.msgid.link/20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net

Changes in v7:
- patch 9: new: fix stale rx/tx ops after device removal reported by
  sashiko-bot: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.kernel.org/
- patch 10: formerly patch 9 as new patch 8 & 9 belong together 
- Link to v6: https://patch.msgid.link/20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net

Changes in v6:
- patch 1: added Tested-by: tags
- patch 3: changed commit message and comment regarding a wrong claim
  about synchronous delivery from dev_queue_xmit() as remarked by
  https://netdev-ai.bots.linux.dev/ai-review.html?id=6105ebab-87ef-43db-a085-7c190b9f119f
- patch 4: rebased patch 3 comment
- patch 9: new: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()
  reported by sashiko-bot: https://lore.kernel.org/linux-can/20260707145135.5BC831F00A3A@smtp.kernel.org/
- Link to v5: https://patch.msgid.link/20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net

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

Oliver Hartkopp (9):
      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
      can: bcm: add locking when updating filter and timer values
      can: bcm: fix CAN frame rx/tx statistics
      can: bcm: add missing rcu list annotations and operations
      can: bcm: extend bcm_tx_lock usage for data and timer updates
      can: bcm: validate frame length in bcm_rx_setup() for RTR replies
      can: bcm: add missing device refcount for CAN filter removal
      can: bcm: fix stale rx/tx ops after device removal
      can: bcm: fix data race on rx_stamp/rx_ifindex in bcm_rx_handler()

 net/can/bcm.c | 527 +++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 391 insertions(+), 136 deletions(-)
---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260612-bcm_fixes-84fb4aa93ac2

Best regards,
--  
Oliver Hartkopp <socketcan@hartkopp.net>



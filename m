Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91915FD13
	for <linux-can@vger.kernel.org>; Fri, 14 Jun 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378152; cv=none; b=N+g4OpeheA7cplD0lCKhwaoi1oiE1+mtFAJd1eOXKVuNJiOwpz6mCbA6QFv8/kE9iO/OvHdYP3ZxBZZMff1LOL2hCsBXEqLrioFNCT7Lg7wc28+u6NnhBcl6Ca1qFRqrZ55QIxVV+1igP0ps+LZGm2WWdA+QIjjevXhYoXZO8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378152; c=relaxed/simple;
	bh=iD+Cl3dZe6ypbAAWqN3/5XdXiWwGe/WyiIXhFZPuCtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZBW5a2HnNcBwKSOwQ0dFnmKP+UlTF07oUXDqHhUcTnW2zTQWroUm0SsLnyNKmxMSo1Vmj1rXs+g6zHHMi+NhO9QU3pM7bT6u9tpWeD1LGAno8fpKFQgo2b6eGxmyQhObYtq6xK5v+M2282KuTQ3r0DIkSdp3bFQpLFZSKhoBfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Received: from localhost (balder.kvaser.se [10.0.6.1])
	by qmail.kvaser.se (Postfix) with ESMTP id DCB2AE014A;
	Fri, 14 Jun 2024 17:15:41 +0200 (CEST)
From: Martin Jocic <martin.jocic@kvaser.com>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	mailhol.vincent@wanadoo.fr
Cc: extja@kvaser.com
Subject: [PATCH 4/7] can: kvaser_pciefd: Add inline
Date: Fri, 14 Jun 2024 17:15:21 +0200
Message-Id: <20240614151524.2718287-5-martin.jocic@kvaser.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240614151524.2718287-1-martin.jocic@kvaser.com>
References: <20240614151524.2718287-1-martin.jocic@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the short function kvaser_pciefd_set_tx_irq inline. This function
is effectively three lines long and therefore inlining it should be
OK according to rule #15 of the Linux kernel coding style.

Signed-off-by: Martin Jocic <martin.jocic@kvaser.com>
---
 drivers/net/can/kvaser_pciefd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 8c9abc702b24..3d40d7b3d64c 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -550,7 +550,7 @@ static void kvaser_pciefd_disable_err_gen(struct kvaser_pciefd_can *can)
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
-static void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
+static inline void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 {
 	u32 msk;
 
-- 
2.40.1


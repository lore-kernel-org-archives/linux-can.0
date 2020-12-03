Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2EC8302E
	for <linux-can@archiver.kernel.org>; Thu,  3 Dec 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083AF20637
	for <linux-can@archiver.kernel.org>; Thu,  3 Dec 2020 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436626AbgLCNac (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436562AbgLCNac (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 3 Dec 2020 08:30:32 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        syzbot+381d06e0c8eaacb8706f@syzkaller.appspotmail.com,
        syzbot+d0ddd88c9a7432f041e6@syzkaller.appspotmail.com,
        syzbot+76d62d3b8162883c7d11@syzkaller.appspotmail.com,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 39/39] can: af_can: can_rx_unregister(): remove WARN() statement from list operation sanity check
Date:   Thu,  3 Dec 2020 08:28:33 -0500
Message-Id: <20201203132834.930999-39-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203132834.930999-1-sashal@kernel.org>
References: <20201203132834.930999-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit d73ff9b7c4eacaba0fd956d14882bcae970f8307 ]

To detect potential bugs in CAN protocol implementations (double removal of
receiver entries) a WARN() statement has been used if no matching list item was
found for removal.

The fault injection issued by syzkaller was able to create a situation where
the closing of a socket runs simultaneously to the notifier call chain for
removing the CAN network device in use.

This case is very unlikely in real life but it doesn't break anything.
Therefore we just replace the WARN() statement with pr_warn() to preserve the
notification for the CAN protocol development.

Reported-by: syzbot+381d06e0c8eaacb8706f@syzkaller.appspotmail.com
Reported-by: syzbot+d0ddd88c9a7432f041e6@syzkaller.appspotmail.com
Reported-by: syzbot+76d62d3b8162883c7d11@syzkaller.appspotmail.com
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20201126192140.14350-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/af_can.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0e71e0164ab3b..086a595caa5a7 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -541,10 +541,13 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 
 	/* Check for bugs in CAN protocol implementations using af_can.c:
 	 * 'rcv' will be NULL if no matching list item was found for removal.
+	 * As this case may potentially happen when closing a socket while
+	 * the notifier for removing the CAN netdev is running we just print
+	 * a warning here.
 	 */
 	if (!rcv) {
-		WARN(1, "BUG: receive list entry not found for dev %s, id %03X, mask %03X\n",
-		     DNAME(dev), can_id, mask);
+		pr_warn("can: receive list entry not found for dev %s, id %03X, mask %03X\n",
+			DNAME(dev), can_id, mask);
 		goto out;
 	}
 
-- 
2.27.0


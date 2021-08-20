Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F498C4338F
	for <linux-can@archiver.kernel.org>; Fri, 20 Aug 2021 16:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BEC61131
	for <linux-can@archiver.kernel.org>; Fri, 20 Aug 2021 16:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhHTQPe (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:15:34 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:50922 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231527AbhHTQPe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Aug 2021 12:15:34 -0400
X-IronPort-AV: E=Sophos;i="5.84,338,1620658800"; 
   d="scan'208";a="91278064"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2021 01:14:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id EAF93409F9A6;
        Sat, 21 Aug 2021 01:14:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org
Cc:     netdev@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH -next] can: rcar_canfd: Fix redundant assignment
Date:   Fri, 20 Aug 2021 17:14:49 +0100
Message-Id: <20210820161449.18169-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Fix redundant assignment of 'priv' to itself in
rcar_canfd_handle_channel_tx().

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5d4d52afde15..c47988d3674e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1182,7 +1182,7 @@ static void rcar_canfd_state_change(struct net_device *ndev,
 
 static void rcar_canfd_handle_channel_tx(struct rcar_canfd_global *gpriv, u32 ch)
 {
-	struct rcar_canfd_channel *priv = priv = gpriv->ch[ch];
+	struct rcar_canfd_channel *priv = gpriv->ch[ch];
 	struct net_device *ndev = priv->ndev;
 	u32 sts;
 
-- 
2.17.1


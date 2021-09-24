Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FEC433F5
	for <linux-can@archiver.kernel.org>; Fri, 24 Sep 2021 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA0D60E08
	for <linux-can@archiver.kernel.org>; Fri, 24 Sep 2021 07:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbhIXH5j (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 24 Sep 2021 03:57:39 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:28405 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244433AbhIXH5j (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Sep 2021 03:57:39 -0400
X-IronPort-AV: E=Sophos;i="5.85,319,1624287600"; 
   d="scan'208";a="94903428"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2021 16:56:05 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D3C540108F3;
        Fri, 24 Sep 2021 16:56:05 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     wg@grandegger.com, mkl@pengutronix.de
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ayumi Nakamichi <ayumi.nakamichi.kf@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2] can: rcar_can: Fix suspend/resume
Date:   Fri, 24 Sep 2021 16:55:56 +0900
Message-Id: <20210924075556.223685-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

If the driver was not opened, rcar_can_suspend() should not call
clk_disable() because the clock was not enabled.

Fixes: fd1159318e55 ("can: add Renesas R-Car CAN driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Ayumi Nakamichi <ayumi.nakamichi.kf@renesas.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Changes from v1:
 - Add Reviewed-by and Tested-by.
 - Remove unrelated modification.
 https://lore.kernel.org/all/20210921051959.50309-1-yoshihiro.shimoda.uh@renesas.com/

 drivers/net/can/rcar/rcar_can.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 00e4533c8bdd..8999ec9455ec 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -846,10 +846,12 @@ static int __maybe_unused rcar_can_suspend(struct device *dev)
 	struct rcar_can_priv *priv = netdev_priv(ndev);
 	u16 ctlr;
 
-	if (netif_running(ndev)) {
-		netif_stop_queue(ndev);
-		netif_device_detach(ndev);
-	}
+	if (!netif_running(ndev))
+		return 0;
+
+	netif_stop_queue(ndev);
+	netif_device_detach(ndev);
+
 	ctlr = readw(&priv->regs->ctlr);
 	ctlr |= RCAR_CAN_CTLR_CANM_HALT;
 	writew(ctlr, &priv->regs->ctlr);
@@ -868,6 +870,9 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	u16 ctlr;
 	int err;
 
+	if (!netif_running(ndev))
+		return 0;
+
 	err = clk_enable(priv->clk);
 	if (err) {
 		netdev_err(ndev, "clk_enable() failed, error %d\n", err);
@@ -881,10 +886,9 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 	writew(ctlr, &priv->regs->ctlr);
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	if (netif_running(ndev)) {
-		netif_device_attach(ndev);
-		netif_start_queue(ndev);
-	}
+	netif_device_attach(ndev);
+	netif_start_queue(ndev);
+
 	return 0;
 }
 
-- 
2.25.1


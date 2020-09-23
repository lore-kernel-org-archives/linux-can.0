Return-Path: <SRS0=s8nA=DA=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED990C2D0A8
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 08:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FA420756
	for <linux-can@archiver.kernel.org>; Wed, 23 Sep 2020 08:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIWIyu (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 23 Sep 2020 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgIWIyf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 04:54:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57EC0613D1
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 01:54:35 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kL0Xl-0000uS-OX; Wed, 23 Sep 2020 10:54:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, michael@walle.cc, qiangqing.zhang@nxp.com,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 17/20] can: flexcan: add CAN FD BRS support
Date:   Wed, 23 Sep 2020 10:54:15 +0200
Message-Id: <20200923085418.2685858-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923085418.2685858-1-mkl@pengutronix.de>
References: <20200923085418.2685858-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

This patch adds CAN FD BitRate Switch (BRS) support to driver.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Link: https://lore.kernel.org/r/20190712075926.7357-5-qiangqing.zhang@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e3ecce80eadb..fc0e9d5fd02b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -723,9 +723,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 	if (cfd->can_id & CAN_RTR_FLAG)
 		ctrl |= FLEXCAN_MB_CNT_RTR;
 
-	if (can_is_canfd_skb(skb))
+	if (can_is_canfd_skb(skb)) {
 		ctrl |= FLEXCAN_MB_CNT_EDL;
 
+		if (cfd->flags & CANFD_BRS)
+			ctrl |= FLEXCAN_MB_CNT_BRS;
+	}
+
 	for (i = 0; i < cfd->len; i += sizeof(u32)) {
 		data = be32_to_cpup((__be32 *)&cfd->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
@@ -956,6 +960,9 @@ static struct sk_buff *flexcan_mailbox_read(struct can_rx_offload *offload,
 
 	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
 		cfd->len = can_dlc2len(get_canfd_dlc((reg_ctrl >> 16) & 0xf));
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
+			cfd->flags |= CANFD_BRS;
 	} else {
 		cfd->len = get_can_dlc((reg_ctrl >> 16) & 0xf);
 
-- 
2.28.0


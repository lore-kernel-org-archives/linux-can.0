Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C269CC63777
	for <linux-can@archiver.kernel.org>; Sat, 14 Nov 2020 17:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E0A2222C
	for <linux-can@archiver.kernel.org>; Sat, 14 Nov 2020 17:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKNReq (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Sat, 14 Nov 2020 12:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKNReq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Nov 2020 12:34:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF6C0613D1
        for <linux-can@vger.kernel.org>; Sat, 14 Nov 2020 09:34:46 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kdzRg-0000mY-VO; Sat, 14 Nov 2020 18:34:41 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Wu Bo <wubo.oduw@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net 12/15] can: m_can: m_can_handle_state_change(): fix state change
Date:   Sat, 14 Nov 2020 18:33:56 +0100
Message-Id: <20201114173358.2058600-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114173358.2058600-1-mkl@pengutronix.de>
References: <20201114173358.2058600-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Wu Bo <wubo.oduw@gmail.com>

m_can_handle_state_change() is called with the new_state as an argument.

In the switch statements for CAN_STATE_ERROR_ACTIVE, the comment and the
following code indicate that a CAN_STATE_ERROR_WARNING is handled.

This patch fixes this problem by changing the case to CAN_STATE_ERROR_WARNING.

Signed-off-by: Wu Bo <wubo.oduw@gmail.com>
Link: http://lore.kernel.org/r/20200129022330.21248-2-wubo.oduw@gmail.com
Cc: Dan Murphy <dmurphy@ti.com>
Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02c5795b7393..63887e23d89c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	unsigned int ecr;
 
 	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cdev->can.can_stats.error_warning++;
 		cdev->can.state = CAN_STATE_ERROR_WARNING;
@@ -694,7 +694,7 @@ static int m_can_handle_state_change(struct net_device *dev,
 	__m_can_get_berr_counter(dev, &bec);
 
 	switch (new_state) {
-	case CAN_STATE_ERROR_ACTIVE:
+	case CAN_STATE_ERROR_WARNING:
 		/* error warning state */
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
-- 
2.29.2


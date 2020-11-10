Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536BCC388F7
	for <linux-can@archiver.kernel.org>; Tue, 10 Nov 2020 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B4020674
	for <linux-can@archiver.kernel.org>; Tue, 10 Nov 2020 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731173AbgKJPtR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 10 Nov 2020 10:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgKJPtR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Nov 2020 10:49:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47789C0613CF
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2020 07:49:17 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcVtT-0005w8-AU; Tue, 10 Nov 2020 16:49:15 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, mailhol.vincent@wanadoo.fr,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 1/2] can-dev: introduce helpers to access Classical CAN DLC values
Date:   Tue, 10 Nov 2020 16:49:12 +0100
Message-Id: <20201110154913.1404582-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110154913.1404582-1-mkl@pengutronix.de>
References: <20201110154913.1404582-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

This patch adds the following helper to functions to access Classical CAN DLC
values.

can_get_cc_dlc(): get the data length code for Classical CAN raw DLC access
can_frame_set_cc_len(): set len and len8_dlc value for Classical CAN raw DLC access

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://lore.kernel.org/r/20201110101852.1973-8-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/dev.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e767a96ae075..197a79535cc2 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -170,6 +170,31 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 	return skb->len == CANFD_MTU;
 }
 
+/* helper to get the data length code (DLC) for Classical CAN raw DLC access */
+static inline u8 can_get_cc_dlc(const struct can_frame *cf, const u32 ctrlmode)
+{
+	/* return len8_dlc as dlc value only if all conditions apply */
+	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
+	    (cf->len == CAN_MAX_DLEN) &&
+	    (cf->len8_dlc > CAN_MAX_DLEN && cf->len8_dlc <= CAN_MAX_RAW_DLC))
+		return cf->len8_dlc;
+
+	/* return the payload length as dlc value */
+	return cf->len;
+}
+
+/* helper to set len and len8_dlc value for Classical CAN raw DLC access */
+static inline void can_frame_set_cc_len(struct can_frame *cf, const u8 dlc,
+					const u32 ctrlmode)
+{
+	/* the caller already ensured that dlc is a value from 0 .. 15 */
+	if (ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC && dlc > CAN_MAX_DLEN)
+		cf->len8_dlc = dlc;
+
+	/* limit the payload length 'len' to CAN_MAX_DLEN */
+	cf->len = can_cc_dlc2len(dlc);
+}
+
 /* helper to define static CAN controller features at device creation time */
 static inline void can_set_static_ctrlmode(struct net_device *dev,
 					   u32 static_mode)
-- 
2.28.0


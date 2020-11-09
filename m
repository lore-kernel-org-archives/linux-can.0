Return-Path: <SRS0=26Ma=EP=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1908CC61DD8
	for <linux-can@archiver.kernel.org>; Mon,  9 Nov 2020 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B037E2080C
	for <linux-can@archiver.kernel.org>; Mon,  9 Nov 2020 10:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="IWKfFVe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgKIK1D (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:27:03 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:15081 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgKIK0s (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2020 05:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604917605;
        s=strato-dkim-0002; d=hartkopp.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Qp48c5t7TozH+uOikq8RBTGpum4IMb5hjKZR4w/MrZw=;
        b=IWKfFVe16jTRSSgqLnRr9MF50jdy/PF14R2D7wn2kIrrUuZ3aNTlil44QQDSBSQhTG
        wqlULtMkdo7UwFlFfu6frbyA49CqL1DYFpUqlLQ9kp3O+uoBmkyj44xfBLsWr6rOqtUH
        oqh8Prsr9H17ZxnA24yrWOgkdXcGJiwGNX/7TD8MAbfMepkKCNWJzfWy8CR6fHkv57pq
        B7L4UEM9izx6DZCoTEYohGaDQmm0u4DzGvPwnofRpurViXW6Oeq/MXLzGVGUr8LcW5HE
        Gk8DrDucd88OZzTYLMsIBRnALpefNIJQp/VIS5KwsPWqHlwXZo5iZXfq1LCG3GkvyhQK
        2xYw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejudJywjskA="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.3.3 DYNA|AUTH)
        with ESMTPSA id V0298cwA9AQh6dT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 9 Nov 2020 11:26:43 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org, mkl@pengutronix.de,
        mailhol.vincent@wanadoo.fr
Cc:     netdev@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 6/7] can-dev: introduce helpers to access Classical CAN DLC values
Date:   Mon,  9 Nov 2020 11:26:17 +0100
Message-Id: <20201109102618.2495-7-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109102618.2495-1-socketcan@hartkopp.net>
References: <20201109102618.2495-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

can_get_len8_dlc: get value to fill len8_dlc at frame reception time
can_get_cc_dlc: get DLC value to be written into CAN controller

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/linux/can/dev.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 72671184a7a2..410a53a09f1b 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -168,10 +168,29 @@ static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
 	/* the CAN specific type of skb is identified by its data length */
 	return skb->len == CANFD_MTU;
 }
 
+/* helper to handle len8_dlc value for Classical CAN raw DLC access */
+static inline u8 can_check_len8_dlc(u32 ctrlmode, u8 len, u8 dlc, u8 ret)
+{
+	/* return value for len8_dlc only if all conditions apply */
+	if ((ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC) &&
+	    (len == CAN_MAX_DLEN) &&
+	    (dlc > CAN_MAX_DLEN && dlc <= CAN_MAX_RAW_DLC))
+		ret = dlc;
+
+	/* no valid len8_dlc value -> return provided default value */
+	return ret;
+}
+
+/* get value to fill len8_dlc in struct can_frame at frame reception time */
+#define can_get_len8_dlc(cm, len, dlc) can_check_len8_dlc(cm, len, dlc, 0)
+
+/* get DLC value to be written into Classical CAN controller at tx time */
+#define can_get_cc_dlc(cm, len, dlc) can_check_len8_dlc(cm, len, dlc, len)
+
 /* helper to define static CAN controller features at device creation time */
 static inline void can_set_static_ctrlmode(struct net_device *dev,
 					   u32 static_mode)
 {
 	struct can_priv *priv = netdev_priv(dev);
-- 
2.28.0


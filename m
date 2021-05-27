Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FF1C47089
	for <linux-can@archiver.kernel.org>; Thu, 27 May 2021 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D2261222
	for <linux-can@archiver.kernel.org>; Thu, 27 May 2021 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhE0IuI (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 27 May 2021 04:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhE0Itw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 May 2021 04:49:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60FCC061348
        for <linux-can@vger.kernel.org>; Thu, 27 May 2021 01:48:19 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lmBgf-00022M-UL
        for linux-can@vger.kernel.org; Thu, 27 May 2021 10:48:18 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 7A21762D419
        for <linux-can@vger.kernel.org>; Thu, 27 May 2021 08:45:38 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id D82B862D3DE;
        Thu, 27 May 2021 08:45:34 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 543047b9;
        Thu, 27 May 2021 08:45:34 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [net-next 04/21] can: uapi: introduce CANFD_FDF flag for mixed content in struct canfd_frame
Date:   Thu, 27 May 2021 10:45:15 +0200
Message-Id: <20210527084532.1384031-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527084532.1384031-1-mkl@pengutronix.de>
References: <20210527084532.1384031-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

The struct can_frame and struct canfd_frame intentionally share the
same layout to be able to write CAN frame content into a CAN FD frame
structure. When this is done the former differentiation via CAN_MTU /
CANFD_MTU is lost. CANFD_FDF allows programmers to mark CAN FD frames
in the case of using struct canfd_frame for mixed CAN/CAN FD
content (dual use).

N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside
of struct canfd_frame therefore the CANFD_FDF flag is disregarded by
Linux.

Link: https://lore.kernel.org/r/20170411134343.3089-1-socketcan@hartkopp.net
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/uapi/linux/can.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index ac5d7a31671f..90801ada2bbe 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -135,9 +135,18 @@ struct can_frame {
  * controller only the CANFD_BRS bit is relevant for real CAN controllers when
  * building a CAN FD frame for transmission. Setting the CANFD_ESI bit can make
  * sense for virtual CAN interfaces to test applications with echoed frames.
+ *
+ * The struct can_frame and struct canfd_frame intentionally share the same
+ * layout to be able to write CAN frame content into a CAN FD frame structure.
+ * When this is done the former differentiation via CAN_MTU / CANFD_MTU gets
+ * lost. CANFD_FDF allows programmers to mark CAN FD frames in the case of
+ * using struct canfd_frame for mixed CAN / CAN FD content (dual use).
+ * N.B. the Kernel APIs do NOT provide mixed CAN / CAN FD content inside of
+ * struct canfd_frame therefore the CANFD_FDF flag is disregarded by Linux.
  */
 #define CANFD_BRS 0x01 /* bit rate switch (second bitrate for payload data) */
 #define CANFD_ESI 0x02 /* error state indicator of the transmitting node */
+#define CANFD_FDF 0x04 /* mark CAN FD for dual use of struct canfd_frame */
 
 /**
  * struct canfd_frame - CAN flexible data rate frame structure
-- 
2.30.2



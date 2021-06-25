Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA2C2B9F4
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 13:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6353161954
	for <linux-can@archiver.kernel.org>; Fri, 25 Jun 2021 13:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFYNND (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 25 Jun 2021 09:13:03 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:31012 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231405AbhFYNND (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 25 Jun 2021 09:13:03 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id A9C625FFA0;
        Fri, 25 Jun 2021 15:10:37 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 4/5] can: peak_usb: pcan_usb_encode_msg(): adds information
Date:   Fri, 25 Jun 2021 15:09:30 +0200
Message-Id: <20210625130931.27438-5-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210625130931.27438-1-s.grosjean@peak-system.com>
References: <20210625130931.27438-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This patch adds information by replacing hard-coded values with their
symbol and adding comments.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 341ace36570b..7d18bc6911f5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -63,6 +63,8 @@
 
 #define PCAN_USB_MSG_HEADER_LEN		2
 
+#define PCAN_USB_MSG_TX_CAN		2	/* Tx msg is a CAN frame */
+
 /* PCAN-USB adapter internal clock (MHz) */
 #define PCAN_USB_CRYSTAL_HZ		16000000
 
@@ -836,8 +838,8 @@ static int pcan_usb_encode_msg(struct peak_usb_device *dev, struct sk_buff *skb,
 	u32 can_id_flags = cf->can_id & CAN_ERR_MASK;
 	u8 *pc;
 
-	obuf[0] = 2;
-	obuf[1] = 1;
+	obuf[0] = PCAN_USB_MSG_TX_CAN;
+	obuf[1] = 1;	/* only one CAN frame is stored in the packet */
 
 	pc = obuf + PCAN_USB_MSG_HEADER_LEN;
 
-- 
2.25.1


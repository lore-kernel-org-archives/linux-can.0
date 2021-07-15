Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1C7C07E96
	for <linux-can@archiver.kernel.org>; Thu, 15 Jul 2021 14:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49824613C0
	for <linux-can@archiver.kernel.org>; Thu, 15 Jul 2021 14:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhGOOcB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:32:01 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:26382 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhGOOcB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 15 Jul 2021 10:32:01 -0400
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9E2702003CC;
        Thu, 15 Jul 2021 16:29:03 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH v3 2/2] can: peak_usb: Add a "firmware update available" msg to old PCAN-USB
Date:   Thu, 15 Jul 2021 16:28:42 +0200
Message-Id: <20210715142842.35793-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210715142842.35793-1-s.grosjean@peak-system.com>
References: <20210715142842.35793-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

When the driver detects that the PCAN-USB device runs an old firmware
(< 4.1) then it prints a message suggesting to contact
<support@peak-system.com> for a possible firmware update.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 3af3136645ac..cb492584fdb0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -850,6 +850,19 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		 pcan_usb.name, dev->device_rev, serial_number,
 		 pcan_usb.ctrl_count);
 
+	/* Since rev 4.1, PCAN-USB is able to make single-short as well as
+	 * looped back frames.
+	 */
+	if (dev->device_rev >= 41) {
+		struct can_priv *priv = netdev_priv(dev->netdev);
+
+		priv->ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT |
+					    CAN_CTRLMODE_LOOPBACK;
+	} else {
+		dev_info(dev->netdev->dev.parent,
+			 "Firmware update available. Please contact support@peak-system.com\n");
+	}
+
 	return 0;
 }
 
-- 
2.25.1


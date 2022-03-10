Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBAC433EF
	for <linux-can@archiver.kernel.org>; Thu, 10 Mar 2022 09:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiCJKAR (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiCJKAQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Mar 2022 05:00:16 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1AF113D88
        for <linux-can@vger.kernel.org>; Thu, 10 Mar 2022 01:59:15 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id D81FF20040F;
        Thu, 10 Mar 2022 10:59:11 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 7/8 v3] can: peak_usb: replace device_number priv field with netdev dev_port field
Date:   Thu, 10 Mar 2022 10:58:40 +0100
Message-Id: <20220310095841.9134-8-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095841.9134-1-s.grosjean@peak-system.com>
References: <20220310095841.9134-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

With this patch, the driver uses the dev_port field of struct net_device to
store the value it has read from the flash memory of the USB device. The
old private field device_number has become useless and is removed.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 1 -
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 2 --
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 338a7eb3f8fc..7f71549a5bc0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -948,11 +948,11 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 		__le32 ledevid;

 		if (!dev->adapter->dev_get_user_devid(dev, &ledevid))
-			dev->device_number = le32_to_cpu(ledevid);
+			netdev->dev_port = le32_to_cpu(ledevid);
 	}
 
 	netdev_info(netdev, "attached to %s channel %u (device %u)\n",
-			peak_usb_adapter->name, ctrl_idx, dev->device_number);
+		    peak_usb_adapter->name, ctrl_idx, netdev->dev_port);
 
 	return 0;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index a181684474fc..5b06b57bcf32 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -123,7 +123,6 @@ struct peak_usb_device {
 	u8 *cmd_buf;
 	struct usb_anchor rx_submitted;
 
-	u32 device_number;
 	u8 device_rev;
 
 	u8 ep_msg_in;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 61f0e5b3916f..9f6712f8610e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -976,8 +976,6 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 	}
 
 	pdev->usb_if->dev[dev->ctrl_idx] = dev;
-	dev->device_number =
-		le32_to_cpu(pdev->usb_if->fw_info.dev_id[dev->ctrl_idx]);
 
 	/* set clock domain */
 	for (i = 0; i < ARRAY_SIZE(pcan_usb_fd_clk_freq); i++)
-- 
2.25.1


Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7FBC433F5
	for <linux-can@archiver.kernel.org>; Wed, 29 Sep 2021 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53891613A7
	for <linux-can@archiver.kernel.org>; Wed, 29 Sep 2021 14:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbhI2ORQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:17:16 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:35244 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245475AbhI2ORP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 Sep 2021 10:17:15 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 706BE5FF7A;
        Wed, 29 Sep 2021 16:14:59 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/2] can: peak_usb: exchange the order of information messages
Date:   Wed, 29 Sep 2021 16:14:21 +0200
Message-Id: <20210929141421.55580-2-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929141421.55580-1-s.grosjean@peak-system.com>
References: <20210929141421.55580-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Proposes the possible update of the PCAN-USB firmware after indicating its
name and current version.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 4c8993f69e6b..403e10b56f0c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -883,6 +883,11 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		return err;
 	}
 
+	dev_info(dev->netdev->dev.parent,
+		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
+		 pcan_usb.name, dev->device_rev, serial_number,
+		 pcan_usb.ctrl_count);
+
 	/* Since rev 4.1, PCAN-USB is able to make single-shot as well as
 	 * looped back frames.
 	 */
@@ -896,11 +901,6 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 			 "Firmware update available. Please contact support@peak-system.com\n");
 	}
 
-	dev_info(dev->netdev->dev.parent,
-		 "PEAK-System %s adapter hwrev %u serial %08X (%u channel)\n",
-		 pcan_usb.name, dev->device_rev, serial_number,
-		 pcan_usb.ctrl_count);
-
 	return 0;
 }
 
-- 
2.25.1


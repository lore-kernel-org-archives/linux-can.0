Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83016C43334
	for <linux-can@archiver.kernel.org>; Tue, 19 Jul 2022 12:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiGSMVG (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiGSMT2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Jul 2022 08:19:28 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053758857
        for <linux-can@vger.kernel.org>; Tue, 19 Jul 2022 05:06:57 -0700 (PDT)
Received: from stf-laptop.peak-system.com (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0219D2005A1;
        Tue, 19 Jul 2022 14:06:52 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/3] can: peak_usb: constify characters string
Date:   Tue, 19 Jul 2022 14:06:30 +0200
Message-Id: <20220719120632.26774-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index b850ff8fe4bd..0bce3a61559e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -57,7 +57,7 @@ MODULE_DEVICE_TABLE(usb, peak_usb_table);
  * dump memory
  */
 #define DUMP_WIDTH	16
-void pcan_dump_mem(char *prompt, void *p, int l)
+void pcan_dump_mem(const char *prompt, void *p, int l)
 {
 	pr_info("%s dumping %s (%d bytes):\n",
 		PCAN_USB_DRIVER_NAME, prompt ? prompt : "memory", l);
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index f60af573a2e0..3f9024f0b7b6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -132,7 +132,7 @@ struct peak_usb_device {
 	struct peak_usb_device *next_siblings;
 };
 
-void pcan_dump_mem(char *prompt, void *p, int l);
+void pcan_dump_mem(const char *prompt, void *p, int l);
 
 /* common timestamp management */
 void peak_usb_init_time_ref(struct peak_time_ref *time_ref,
-- 
2.34.1


From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH v2 2/4] can: netlink: Remove space before tab
Date: Fri, 11 Jul 2014 16:13:21 +0400
Message-ID: <1405080803-5604-2-git-send-email-nebaruzdin@gmail.com>
References: <53BEA26D.2040007@pengutronix.de>
 <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:54967 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbaGKMNm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Jul 2014 08:13:42 -0400
Received: by mail-la0-f47.google.com with SMTP id s18so814438lam.6
        for <linux-can@vger.kernel.org>; Fri, 11 Jul 2014 05:13:41 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id kh4sm3015648lbc.29.2014.07.11.05.13.39
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jul 2014 05:13:40 -0700 (PDT)
In-Reply-To: <1405080803-5604-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Fixes the corresponing checkpatch.pl warning.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 include/uapi/linux/can/netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 813d11f..3bbf5c7 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -92,7 +92,7 @@ struct can_ctrlmode {
 };
 
 #define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
-#define CAN_CTRLMODE_LISTENONLY		0x02 	/* Listen-only mode */
+#define CAN_CTRLMODE_LISTENONLY		0x02	/* Listen-only mode */
 #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
-- 
2.0.1


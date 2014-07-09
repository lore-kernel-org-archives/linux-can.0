From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH 2/4] can: netlink: Remove space before tab
Date: Wed,  9 Jul 2014 23:31:11 +0400
Message-ID: <1404934273-19233-2-git-send-email-nebaruzdin@gmail.com>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:51359 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721AbaGITbc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 15:31:32 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so5419456lab.10
        for <linux-can@vger.kernel.org>; Wed, 09 Jul 2014 12:31:30 -0700 (PDT)
Received: from localhost.localdomain ([89.249.162.12])
        by mx.google.com with ESMTPSA id uh6sm22425493lac.13.2014.07.09.12.31.29
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jul 2014 12:31:29 -0700 (PDT)
In-Reply-To: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
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


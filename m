From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [libsocketcan 1/2] Update CAN netlink header
Date: Mon, 21 Jul 2014 13:43:19 +0400
Message-ID: <1405935800-26622-4-git-send-email-nebaruzdin@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34594 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbaGUJnf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Jul 2014 05:43:35 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so3660967lbj.37
        for <linux-can@vger.kernel.org>; Mon, 21 Jul 2014 02:43:34 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id ks4sm10999632lac.18.2014.07.21.02.43.32
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 02:43:33 -0700 (PDT)
In-Reply-To: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 include/can_netlink.h | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/can_netlink.h b/include/can_netlink.h
index 31cfa6a..3e4323a 100644
--- a/include/can_netlink.h
+++ b/include/can_netlink.h
@@ -5,19 +5,25 @@
  *
  * Copyright (c) 2009 Wolfgang Grandegger <wg@grandegger.com>
  *
- * Send feedback to <socketcan-users@lists.berlios.de>
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
  *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
  */
 
-#ifndef CAN_NETLINK_H
-#define CAN_NETLINK_H
+#ifndef _UAPI_CAN_NETLINK_H
+#define _UAPI_CAN_NETLINK_H
 
 #include <linux/types.h>
 
 /*
  * CAN bit-timing parameters
  *
- * For futher information, please read chapter "8 BIT TIMING
+ * For further information, please read chapter "8 BIT TIMING
  * REQUIREMENTS" of the "Bosch CAN Specification version 2.0"
  * at http://www.semiconductors.bosch.de/pdf/can2spec.pdf.
  */
@@ -85,11 +91,13 @@ struct can_ctrlmode {
 	__u32 flags;
 };
 
-#define CAN_CTRLMODE_LOOPBACK	0x01	/* Loopback mode */
-#define CAN_CTRLMODE_LISTENONLY	0x02 	/* Listen-only mode */
-#define CAN_CTRLMODE_3_SAMPLES	0x04	/* Triple sampling mode */
-#define CAN_CTRLMODE_ONE_SHOT 0x08 /* One-Shot mode */
-#define CAN_CTRLMODE_BERR_REPORTING 0x10 /* Bus-error reporting */
+#define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
+#define CAN_CTRLMODE_LISTENONLY		0x02	/* Listen-only mode */
+#define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
+#define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
+#define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
+#define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 
 /*
  * CAN device statistics
@@ -116,9 +124,11 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
+	IFLA_CAN_DATA_BITTIMING,
+	IFLA_CAN_DATA_BITTIMING_CONST,
 	__IFLA_CAN_MAX
 };
 
 #define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
 
-#endif /* CAN_NETLINK_H */
+#endif /* !_UAPI_CAN_NETLINK_H */
-- 
2.0.2


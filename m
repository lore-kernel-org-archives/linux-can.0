From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [iproute2 1/2] Update CAN netlink header
Date: Mon, 21 Jul 2014 13:43:17 +0400
Message-ID: <1405935800-26622-2-git-send-email-nebaruzdin@gmail.com>
References: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:51593 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbaGUJnc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Jul 2014 05:43:32 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so1379681lbg.6
        for <linux-can@vger.kernel.org>; Mon, 21 Jul 2014 02:43:31 -0700 (PDT)
Received: from localhost.localdomain (lvk-gate.cs.msu.ru. [188.44.42.233])
        by mx.google.com with ESMTPSA id ks4sm10999632lac.18.2014.07.21.02.43.29
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 02:43:30 -0700 (PDT)
In-Reply-To: <1405935800-26622-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 include/linux/can/netlink.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/can/netlink.h b/include/linux/can/netlink.h
index df944ed..3e4323a 100644
--- a/include/linux/can/netlink.h
+++ b/include/linux/can/netlink.h
@@ -15,8 +15,8 @@
  * GNU General Public License for more details.
  */
 
-#ifndef CAN_NETLINK_H
-#define CAN_NETLINK_H
+#ifndef _UAPI_CAN_NETLINK_H
+#define _UAPI_CAN_NETLINK_H
 
 #include <linux/types.h>
 
@@ -92,10 +92,12 @@ struct can_ctrlmode {
 };
 
 #define CAN_CTRLMODE_LOOPBACK		0x01	/* Loopback mode */
-#define CAN_CTRLMODE_LISTENONLY		0x02 	/* Listen-only mode */
+#define CAN_CTRLMODE_LISTENONLY		0x02	/* Listen-only mode */
 #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
+#define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 
 /*
  * CAN device statistics
@@ -122,9 +124,11 @@ enum {
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


From: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Subject: [PATCH 3/4] can: netlink: Add CAN_CTRLMODE_PRESUME_ACK flag
Date: Wed,  9 Jul 2014 23:31:12 +0400
Message-ID: <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:48291 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756723AbaGITbd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Jul 2014 15:31:33 -0400
Received: by mail-la0-f53.google.com with SMTP id b8so5310313lan.40
        for <linux-can@vger.kernel.org>; Wed, 09 Jul 2014 12:31:32 -0700 (PDT)
Received: from localhost.localdomain ([89.249.162.12])
        by mx.google.com with ESMTPSA id uh6sm22425493lac.13.2014.07.09.12.31.30
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jul 2014 12:31:31 -0700 (PDT)
In-Reply-To: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Most CAN controllers have a support for ignoring ACK absence. Some of
them refer to this feature as a self test mode (e. g. SJA1000) and some
include it as a part of a loopback mode (e. g. MCP2510).

Setting the introduced flag via netlink should make CAN controller
perform a successful transmission, even if there is no acknowledgement
(dominant ACK bit) received.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
---
 include/uapi/linux/can/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 3bbf5c7..3e4323a 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -97,6 +97,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
+#define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 
 /*
  * CAN device statistics
-- 
2.0.1


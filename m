From: David Jander <david@protonic.nl>
Subject: [PATCH 09/14] can: rx-fifo: Add documentation to struct can_rx_fifo.
Date: Thu,  6 Nov 2014 09:34:08 +0100
Message-ID: <1415262853-22907-10-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26401 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbaKFIeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:07 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 include/linux/can/dev.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c8b8519..10e0a16 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -64,6 +64,42 @@ struct can_priv {
 #endif
 };
 
+/*
+ * CAN rx-fifo struct:
+ *
+ * User-provided parameters (when calling can_rx_fifo_add()):
+ *
+ *	@low_first:	Number of message-box (MB) that gets filled first by
+ *			CAN controller.
+ *	@high_first:	Number of the MB that gets filled first if the lower
+ *			half is disabled (first MB of the second half).
+ *	@high_last:	Number of the MB that gets filled last by the CAN-
+ *			controller
+ *	@mailbox_enable_mask:
+ *			Enable the corresponding MB for each bit set in 'mask'.
+ *	@mailbox_enable:
+ *			Enable MB number 'mb'.
+ *	@mailbox_move_to_buffer:
+ *			This function should atomically copy one message to the
+ *			provided buffer and lock the MB, so that no more
+ *			messages can be received. This function must also take
+ *			care of clearing interrupt-flags if necessary.
+ *	@poll_can_state:
+ *			This function should take care of bus state tracking.
+ *			It is called by	the NAPI poll handler, before
+ *			mailbox_move_to_buffer(). It should handle and generate
+ *			bus-state error-frames such as error-warning and bus-off.
+ *			Set this to NULL if not needed. Returns 1 if an error-
+ *			frame was generated, 0 otherwise.
+ *	@poll_bus_errors:
+ *			This function should check for (bus)-errors and
+ *			generate the corresponding error frames. It is called
+ *			by the NAPI poll handler, after mailbox_move_to_buffer().
+ *			It should typically check for and generate bit-, frame-,
+ *			stuff-,	crc- and ack error-frames.
+ *			Set this to NULL if not needed. Returns 1 if an error-
+ *			frame was generated, 0 otherwise.
+ */
 struct can_rx_fifo {
 	struct net_device *dev;
 
-- 
1.9.1


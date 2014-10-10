From: David Jander <david@protonic.nl>
Subject: [PATCH 10/15] can: rx-fifo: remove obsolete comment
Date: Fri, 10 Oct 2014 17:46:55 +0200
Message-ID: <1412956020-21489-11-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18406 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbaJJPrC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:02 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 include/linux/can/dev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ada324c..c49c37b 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -69,7 +69,7 @@ struct can_rx_fifo {
 
 	unsigned int low_first;
 	unsigned int high_first;
-	unsigned int high_last;		/* not needed during runtime */
+	unsigned int high_last;
 
 	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
 	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
-- 
1.9.1


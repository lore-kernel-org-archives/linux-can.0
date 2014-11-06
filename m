From: David Jander <david@protonic.nl>
Subject: [PATCH 04/14] can: rx-fifo: fix long lines
Date: Thu,  6 Nov 2014 09:34:03 +0100
Message-ID: <1415262853-22907-5-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26353 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaKFIeF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:05 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 9b17592..3e32ec3 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -301,17 +301,21 @@ static unsigned int can_rx_fifo_inc(struct can_rx_fifo *fifo, unsigned int *val)
 static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
 {
 	if (fifo->inc)
-		return ~0LLU >> (64 + fifo->low_first - fifo->high_first) << fifo->low_first;
+		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
+			     << fifo->low_first;
 	else
-		return ~0LLU >> (64 - fifo->low_first + fifo->high_first) << (fifo->high_first + 1);
+		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
+			     << (fifo->high_first + 1);
 }
 
 static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
 {
 	if (fifo->inc)
-		return ~0LLU >> (64 + fifo->high_first - fifo->high_last - 1) << fifo->high_first;
+		return ~0LLU >> (64 + fifo->high_first - fifo->high_last - 1)
+			     << fifo->high_first;
 	else
-		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
+		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1)
+			     << fifo->high_last;
 }
 
 static int can_rx_fifo_read_napi_frame(struct can_rx_fifo *fifo, int index)
-- 
1.9.1


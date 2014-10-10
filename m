From: David Jander <david@protonic.nl>
Subject: [PATCH 08/15] can: rx-fifo: fix long lines
Date: Fri, 10 Oct 2014 17:46:53 +0200
Message-ID: <1412956020-21489-9-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18402 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaJJPrC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:02 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 22a3955..3e1160a 100644
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


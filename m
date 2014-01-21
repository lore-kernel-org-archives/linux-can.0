From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 09/10] include: gw.h: update comment
Date: Tue, 21 Jan 2014 14:00:03 +0100
Message-ID: <1390309204-19854-10-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44842 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbaAUNAL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:11 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This comment was added to the kernel in patch:

    391ac12 can: gw: add a per rule limitation of frame hops

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can/gw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/gw.h b/include/linux/can/gw.h
index a9d4363..4e27c82 100644
--- a/include/linux/can/gw.h
+++ b/include/linux/can/gw.h
@@ -128,7 +128,7 @@ enum {
  * Limit the number of hops of this specific rule. Usually the received CAN
  * frame can be processed as much as 'max_hops' times (which is given at module
  * load time of the can-gw module). This value is used to reduce the number of
- * possible hops for this gateway job to a value smaller then max_hops.
+ * possible hops for this gateway rule to a value smaller then max_hops.
  *
  * CGW_CS_XOR (length 4 bytes):
  * Set a simple XOR checksum starting with an initial value into
-- 
1.8.5.2


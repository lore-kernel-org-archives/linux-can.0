From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: peak_canfd: fix uninitialized symbol warnings
Date: Fri,  9 Jun 2017 14:55:09 +0200
Message-ID: <20170609125513.24436-3-mkl@pengutronix.de>
References: <20170609125513.24436-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45407 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751645AbdFIMzW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Jun 2017 08:55:22 -0400
In-Reply-To: <20170609125513.24436-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch fixes two uninitialized symbol warnings in the new code adding
support of the PEAK-System PCAN-PCI Express FD boards, in the socket-CAN
network protocol family.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 0d57be5ea97b..85268be0c913 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -489,7 +489,7 @@ int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
 				struct pucan_rx_msg *msg_list, int msg_count)
 {
 	void *msg_ptr = msg_list;
-	int i, msg_size;
+	int i, msg_size = 0;
 
 	for (i = 0; i < msg_count; i++) {
 		msg_size = peak_canfd_handle_msg(priv, msg_ptr);
-- 
2.11.0


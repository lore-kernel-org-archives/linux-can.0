From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: pch_can: fix invalid error codes
Date: Sat, 26 Jan 2013 17:33:27 +0100
Message-ID: <1359218007-18586-4-git-send-email-mkl@pengutronix.de>
References: <1359218007-18586-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56864 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab3AZQdh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 Jan 2013 11:33:37 -0500
In-Reply-To: <1359218007-18586-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Olivier Sobrie <olivier@sobrie.be>

Errors in CAN protocol (location) are reported in data[3] of the can
frame instead of data[2].

Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/pch_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 7d17485..5c314a9 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -560,7 +560,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		stats->rx_errors++;
 		break;
 	case PCH_CRC_ERR:
-		cf->data[2] |= CAN_ERR_PROT_LOC_CRC_SEQ |
+		cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ |
 			       CAN_ERR_PROT_LOC_CRC_DEL;
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
-- 
1.7.10.4


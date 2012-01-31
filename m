From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/12] pch_can: fix error passive level test
Date: Tue, 31 Jan 2012 22:46:44 +0100
Message-ID: <1328046410-21392-7-git-send-email-mkl@pengutronix.de>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44851 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab2AaVrD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 16:47:03 -0500
In-Reply-To: <1328046410-21392-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Xi Wang <xi.wang@gmail.com>

The test (((errc & PCH_REC) >> 8) > 127) would always be false because
the receive error counter ((errc & PCH_REC) >> 8) is at most 127, where
PCH_REC is defined as 0x7f00.  To test whether the receive error counter
has reached the error passive level, the RP bit (15) should be used.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/pch_can.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index d11fbb2..6edc25e 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -66,6 +66,7 @@
 #define PCH_IF_CREQ_BUSY	BIT(15)
 
 #define PCH_STATUS_INT		0x8000
+#define PCH_RP			0x00008000
 #define PCH_REC			0x00007f00
 #define PCH_TEC			0x000000ff
 
@@ -527,7 +528,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		priv->can.can_stats.error_passive++;
 		state = CAN_STATE_ERROR_PASSIVE;
 		cf->can_id |= CAN_ERR_CRTL;
-		if (((errc & PCH_REC) >> 8) > 127)
+		if (errc & PCH_RP)
 			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
 		if ((errc & PCH_TEC) > 127)
 			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
-- 
1.7.4.1


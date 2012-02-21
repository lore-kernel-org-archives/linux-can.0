From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/2] pch_can: (re)start Tx queue at first entry
Date: Tue, 21 Feb 2012 17:00:02 +0100
Message-ID: <1329840002-20746-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1329840002-20746-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53707 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab2BUQAK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2012 11:00:10 -0500
In-Reply-To: <1329840002-20746-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

If we restart and our queue stopped at the last entry we will already
stop it again after the first message inserted.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/pch_can.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 3af5341..8d617c7 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -817,6 +817,9 @@ static void pch_can_start(struct net_device *ndev)
 	pch_can_set_tx_all(priv, 1);
 	pch_can_set_rx_all(priv, 1);
 
+	/* Reset Tx Obj to 1st one */
+	priv->tx_obj = PCH_TX_OBJ_START;
+
 	/* Setting the CAN to run mode. */
 	pch_can_set_run_mode(priv, PCH_CAN_RUN);
 
-- 
1.7.3.4


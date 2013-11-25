From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/3] can: c_can: fix calculation of transmitted bytes on tx complete
Date: Mon, 25 Nov 2013 21:56:27 +0100
Message-ID: <1385412987-31205-4-git-send-email-mkl@pengutronix.de>
References: <1385412987-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45686 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3KYU4g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Nov 2013 15:56:36 -0500
In-Reply-To: <1385412987-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Holger Bechtold <Holger.Bechtold@gmx.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Holger Bechtold <Holger.Bechtold@gmx.net>

The number of bytes transmitted was not updated correctly, if several CAN
messages (with different length) were transmitted in one 'bunch'. Thus
programs like 'ifconfig' showed wrong transmit byte counts. Reason was, that
the message object whose DLC is to be read was not necessarily the active one
at the time when

    priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, 0)) & IF_MCONT_DLC_MASK;

was executed.

Signed-off-by: Holger Bechtold <Holger.Bechtold@gmx.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e59c42b..77061ee 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -763,6 +763,7 @@ static void c_can_do_tx(struct net_device *dev)
 		if (!(val & (1 << (msg_obj_no - 1)))) {
 			can_get_echo_skb(dev,
 					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
+			c_can_object_get(dev, 0, msg_obj_no, IF_COMM_ALL);
 			stats->tx_bytes += priv->read_reg(priv,
 					C_CAN_IFACE(MSGCTRL_REG, 0))
 					& IF_MCONT_DLC_MASK;
-- 
1.8.5.rc0


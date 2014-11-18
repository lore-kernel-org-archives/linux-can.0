From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/17] can: xilinx_can: add .ndo_change_mtu function
Date: Tue, 18 Nov 2014 21:37:37 +0100
Message-ID: <1416343067-9810-8-git-send-email-mkl@pengutronix.de>
References: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1416343067-9810-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Use common can_change_mtu function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 47b2f801d127..8a998e3884ce 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -962,6 +962,7 @@ static const struct net_device_ops xcan_netdev_ops = {
 	.ndo_open	= xcan_open,
 	.ndo_stop	= xcan_close,
 	.ndo_start_xmit	= xcan_start_xmit,
+	.ndo_change_mtu	= can_change_mtu,
 };
 
 /**
-- 
2.1.3

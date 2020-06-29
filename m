From: Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] can: flexcan: use ctrlmode to enable CAN-FD
Date: Mon, 29 Jun 2020 20:18:08 +0200
Message-ID: <20200629181809.25338-2-michael@walle.cc>
References: <20200629181809.25338-1-michael@walle.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200629181809.25338-1-michael@walle.cc>
Sender: netdev-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, Michael Walle <michael@walle.cc>
List-Id: linux-can.vger.kernel.org

The driver will enable CAN-FD mode according to the ctrlmode_supported,
which will always be true, if the controller supports it. This is wrong.
Use the correct ctrlmode instead.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 12043250e398..183e094f8d66 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1345,7 +1345,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mcr |= FLEXCAN_MCR_SRX_DIS;
 
 	/* MCR - CAN-FD */
-	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD)
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		reg_mcr |= FLEXCAN_MCR_FDEN;
 	else
 		reg_mcr &= ~FLEXCAN_MCR_FDEN;
-- 
2.20.1

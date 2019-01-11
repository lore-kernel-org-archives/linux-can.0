From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] can: flexcan: fix NULL pointer exception during bringup
Date: Fri, 11 Jan 2019 12:20:41 +0100
Message-ID: <20190111112041.10710-1-u.kleine-koenig@pengutronix.de>
References: <20190111105619.gkf2735zlpe6qbxv@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190111105619.gkf2735zlpe6qbxv@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stable <stable@vger.kernel.org>, linux-can@vger.kernel.org, kernel@pengutronix.de, davem@davemloft.net, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-can.vger.kernel.org

Commit cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
introduced a loop letting i run up to (including) ARRAY_SIZE(regs->mb)
and in the body accessed regs->mb[i] which is an out-of-bounds array
access that then resulted in an access to an reserved register area.

Later this was changed by commit 0517961ccdf1 ("can: flexcan: Add
provision for variable payload size") to iterate a bit differently but
still runs one iteration too much resulting to call

	flexcan_get_mb(priv, priv->mb_count)

which results in a WARN_ON and then a NULL pointer exception. This
only affects devices compatible with "fsl,p1010-flexcan",
"fsl,imx53-flexcan", "fsl,imx35-flexcan", "fsl,imx25-flexcan",
"fsl,imx28-flexcan", so newer i.MX SoCs are not affected.

Fixes: cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..4c0173d2aff1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1106,7 +1106,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		}
 	} else {
 		/* clear and invalidate unused mailboxes first */
-		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i <= priv->mb_count; i++) {
+		for (i = FLEXCAN_TX_MB_RESERVED_OFF_FIFO; i < priv->mb_count; i++) {
 			mb = flexcan_get_mb(priv, i);
 			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
 				    &mb->can_ctrl);
-- 
2.20.1

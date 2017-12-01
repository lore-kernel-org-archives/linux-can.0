From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 7/9] can: flexcan: fix VF610 state transition issue
Date: Fri,  1 Dec 2017 15:17:37 +0100
Message-ID: <20171201141739.5816-8-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for VF610 to report correct state
transitions.

Tested-by: Mirza Krak <mirza.krak@gmail.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v4.11
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index eefddae2e99a..0626dcfd1f3d 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -189,7 +189,7 @@
  *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no
  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
- *   VF610 FlexCAN3  ?               no       yes         ?      yes       yes?
+ *   VF610 FlexCAN3  ?               no       yes        no      yes       yes?
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
@@ -297,7 +297,8 @@ static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
+		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
-- 
2.15.0

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/9] can: flexcan: Update IRQ Err Passive information
Date: Fri,  1 Dec 2017 15:17:36 +0100
Message-ID: <20171201141739.5816-7-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

The flexcan IP cores used on MX25 and MX35 do not generate Error Passive
IRQs. Update the IP core overview table in the driver accordingly.

Suggested-by: ZHU Yi (ST-FIR/ENG1-Zhu) <Yi.Zhu5@cn.bosch.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a13a4896a8bd..eefddae2e99a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -184,9 +184,9 @@
  * Below is some version info we got:
  *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err Memory err RTR re-
  *                                Filter? connected?  Passive detection  ception in MB
- *   MX25  FlexCAN2  03.00.00.00     no        no         ?       no        no
+ *   MX25  FlexCAN2  03.00.00.00     no        no        no       no        no
  *   MX28  FlexCAN2  03.00.04.00    yes       yes        no       no        no
- *   MX35  FlexCAN2  03.00.00.00     no        no         ?       no        no
+ *   MX35  FlexCAN2  03.00.00.00     no        no        no       no        no
  *   MX53  FlexCAN2  03.00.00.00    yes        no        no       no        no
  *   MX6s  FlexCAN3  10.00.12.00    yes       yes        no       no       yes
  *   VF610 FlexCAN3  ?               no       yes         ?      yes       yes?
-- 
2.15.0

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: flexcan: Update IRQ Err Passive information
Date: Wed, 22 Nov 2017 13:53:51 +0100
Message-ID: <20171122125351.8185-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51267 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdKVMx4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Nov 2017 07:53:56 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

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


From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 6/6] can: flexcan: update quirk documentation
Date: Thu, 31 Aug 2017 08:28:21 +0000
Message-ID: <61a39edb79784053bb441782edaddda9@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:47947 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdHaI2Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 31 Aug 2017 04:28:25 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 83d8a00f38c098b7df6ea948449851dbfa01921d Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Thu, 31 Aug 2017 16:21:58 +0800
Subject: [PATCH 6/6] can: flexcan: update quirk documentation

Add "IRQ Err Passive" column to document which SOC is affected.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/flexcan.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d9b997b..b71456e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -182,14 +182,14 @@
 /* FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
- *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT Memory err RTR re-
- *                                Filter? connected?  detection  ception in MB
- *   MX25  FlexCAN2  03.00.00.00     no        no         no        no
- *   MX28  FlexCAN2  03.00.04.00    yes       yes         no        no
- *   MX35  FlexCAN2  03.00.00.00     no        no         no        no
- *   MX53  FlexCAN2  03.00.00.00    yes        no         no        no
- *   MX6s  FlexCAN3  10.00.12.00    yes       yes         no       yes
- *   VF610 FlexCAN3  ?               no       yes        yes       yes?
+ *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT IRQ Err  Memory err RTR re-
+ *                                Filter? connected?  Passive detection  ception in MB
+ *   MX25  FlexCAN2  03.00.00.00     no        no        ?        no        no
+ *   MX28  FlexCAN2  03.00.04.00    yes       yes        ?        no        no
+ *   MX35  FlexCAN2  03.00.00.00     no        no        ?        no        no
+ *   MX53  FlexCAN2  03.00.00.00    yes        no       no?       no        no
+ *   MX6s  FlexCAN3  10.00.12.00    yes       yes       no        no       yes
+ *   VF610 FlexCAN3  ?               no       yes        ?       yes       yes?
  *
  * Some SOCs do not have the RX_WARN & TX_WARN interrupt line connected.
  */
-- 
2.7.4


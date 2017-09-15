From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH V1 5/6] can: flexcan: fix i.MX28 state transition issue
Date: Fri, 15 Sep 2017 07:08:23 +0000
Message-ID: <ed9f2dc0fe3840419a3862a1842da1da@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:34738 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdIOHI1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 15 Sep 2017 03:08:27 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 4b4b1ad71be065d7cae8b590c3aa22ed1b05d420 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@grandegger.com>
Date: Mon, 11 Sep 2017 08:59:53 +0200
Subject: [PATCH V1 5/6] can: flexcan: fix i.MX28 state transition issue

Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for i.MX28 to report correct
state transitions, especially to error passive.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/net/can/flexcan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7ea38e6..09e4bc7 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -285,7 +285,9 @@ static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE,
 };
 
-static const struct flexcan_devtype_data fsl_imx28_devtype_data;
+static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
+	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE,
+};
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-- 
2.7.4




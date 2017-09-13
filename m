From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 4/6] can: flexcan: fix i.MX6 state transition issue
Date: Wed, 13 Sep 2017 09:38:20 +0000
Message-ID: <03b75d73914844e0aeb780cb3df204c4@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:34307 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdIMJiY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 05:38:24 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From c756a3c4cbb305a728f73b7119b4cf648c05ad2d Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Thu, 31 Aug 2017 11:06:47 +0800
Subject: [PATCH 4/6] can: flexcan: fix i.MX6 state transition issue

Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for i.MX6
to report correct state transitions.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 52b69fc..57b37446 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -289,7 +289,7 @@ static const struct flexcan_devtype_data fsl_imx28_devtype_data;
 
 static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
-		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
 };
 
 static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
-- 
2.7.4




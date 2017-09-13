From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 6/6] can: flexcan: fix p1010 state transition issue
Date: Wed, 13 Sep 2017 09:40:24 +0000
Message-ID: <98c0d0e5df7b4cd79d959bf94b40a601@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:37300 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdIMJk2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 05:40:28 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 6fc859dea2a4f930a41e5a26345d3fa2f4b908d5 Mon Sep 17 00:00:00 2001
From: Zhu Yi <yi.zhu5@cn.bosch.com>
Date: Tue, 12 Sep 2017 16:01:42 +0800
Subject: [PATCH 6/6] can: flexcan: fix p1010 state transition issue

Enable FLEXCAN_QUIRK_BROKEN_WERR_STATE and
FLEXCAN_QUIRK_BROKEN_PERR_STATE for p1010
to report correct state transitions.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c9b3a1a..c355a53 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -282,7 +282,8 @@ struct flexcan_priv {
 };
 
 static const struct flexcan_devtype_data fsl_p1010_devtype_data = {
-	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE,
+	.quirks = FLEXCAN_QUIRK_BROKEN_WERR_STATE |
+		FLEXCAN_QUIRK_BROKEN_PERR_STATE,
 };
 
 static const struct flexcan_devtype_data fsl_imx28_devtype_data = {
-- 
2.7.4




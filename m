From: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue
Date: Wed, 13 Sep 2017 09:39:34 +0000
Message-ID: <b1bfae3d42ca46ecaa83fe8a943da591@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:36930 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdIMJji (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 13 Sep 2017 05:39:38 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>

From 19a2e96683debb514b266d1435327ab4edd8f882 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <wg@grandegger.com>
Date: Mon, 11 Sep 2017 08:59:53 +0200
Subject: [PATCH 5/6] can: flexcan: fix i.MX28 state transition issue

Enable FLEXCAN_QUIRK_BROKEN_PERR_STATE for i.MX28 to report correct
state transitions, especially to error passive.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 57b37446..c9b3a1a 100644
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




Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694D4A0EF5;
	Thu,  1 Oct 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841490; cv=fail; b=CHkHhvBRoGhwcnNUeE5IeHckcpqCOH0rbX0fE6NVRqbtNk/+Spcj3KxgPsWN5TkyEPrY3hnUIVpFk7qW4Tdig52OKyuasQSN61OgCv2eejiiAQBaRcRYdCAIYbe9fxQtWjFo/CDloj5DhGtRQPBvHZqxdQJKzx+ECsaxVG4YAV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841490; c=relaxed/simple;
	bh=6pNT/ubvSVeCsVOZmMov7aagfxcIDM12+/v2C2c+tg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8m4ZStPECyE8X+u7VQtcZh6rDo4CqSF2Z+skPjFoyj+BCcke0kHlDKXbrMR6AAXLzNfSOXKgQtv1svwQx8YEc2GXFIAC54B9JOJvoi4pM2Cd1kVHcWIeGqyfGSRcJF35ALBIWXwPOKHmJmlJVJoRbnUcDPq1s6IMtTALJfnGmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=AhR9fra7; arc=fail smtp.client-ip=40.107.74.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="AhR9fra7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZCjXMslEwkpV16+5pkw9P1Mc1ri0iHIpOqvtBc5udAD6zXbBB4tpVHxxktWPvj3zD+81dhUEK9xiZUvNDC6RaSenM0YE47I+t5f9aNTjaf7Ul0vXYuaJSLruuEZkycmsyW4w5u9N9srOFboAh7RDlDhuE1lqhrKWXNNotGupnZCNQfteKNQ7FVOfMQhiJcC/G/gh8aGU5uK+vGJI6Brsw9BoR1LavQX/B51iDchdYBMEojL9vl1C+IKzkvFgJjSHy3bWcp7+L+J1/SP5HMm5VKzAQrdioqp90c6r14xoQHdQkdrqEhh2ScilHogWYYlr2U+62/GEggdhRSPvIb6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCkQwvZ56VK1QY1DRHnhKgC72qPvufqWB+l2lObem24=;
 b=eXoiK27CWeG/tEz2HAyb6DtnORkB445vTvEH798BCSKteu5d+21ExS5BiEgfCV6NZxrb84kevXOoM7oNJMDBlSJLbODpfovR19s6jj40CXdH/pbi2lbAIN6vd40OPjbavbc/e7GwVB5791+jrJwOBD0k95iVxaEChmhqhI0Fwc/7AhHGBKXGtn2wWlvD5XirbspWXjmGMANpAy/jF0Fw+KCuS2qjSn0lkBCeX2ZuGAyr3gTmyeQh2nLMoAaQIFR9+5hcnf+7eNrUfRA5cKI8RxCugICwTHY+2R+PMhOL799SAM4hOmOcyaUCOdWu+GGnQdOovdjPzHBF1xQC8d63kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCkQwvZ56VK1QY1DRHnhKgC72qPvufqWB+l2lObem24=;
 b=AhR9fra7AdafNxlRS3YdlJot301v20/8iYz0XyTyo/PPEsYYWrMYlCJQI6n7fHcRDjt4D2Cs6fQaAAshEo6BNvLBlt/5C0qq6IPz0w7bmEgJ1kfNGR+I7CIUmme/akzRdvFXHuqPBeJ8cGV/2NQzyVHFsB4xv8uiOCyNZSPOk3Y=
Received: from OS3P286CA0085.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f6::12)
 by TY4PR01MB17422.jpnprd01.prod.outlook.com (2603:1096:405:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 07:58:03 +0000
Received: from OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f6:cafe::52) by OS3P286CA0085.outlook.office365.com
 (2603:1096:604:1f6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:58:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D216.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Thu, 1 Oct 2026 07:58:03 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.25])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C7C193000239;
	Thu,  1 Oct 2026 16:57:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tu Nguyen <tu.nguyen.xg@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v4 2/3] can: rcar_canfd: Derive max_channels from the device tree
Date: Thu,  1 Oct 2026 08:57:38 +0100
Message-ID: <20261001075742.21961-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D216:EE_|TY4PR01MB17422:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa5b7d55-95fe-44f4-bd4c-08df1f91b868
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r1u2hI1o3F6bcFi8u0HCsZ2m5hqMLhuSxznt2ssip8tlb3GGR/X/vP5wDbpf0VuvsfgRgcFf+RGT3Ii/tNLXb3sEARDdQWvTk734GHvYIX+/lA7WlFjVJQSfaOtwdNQ/wzdSjNd6anmTFHVJ2YfySIc7eViDoafpEoFJvewCPxoCymqMoNKpIbj87OdFb/P9QFSvKzz3buftx5R2BWWOukKMBiZxVr+E3khIoZzeb3k+EUXPBAuLWcHTj/32m9hD0M44Uh/+STU1LvFYRi7p2M0eCnUS8CJtaHMML8nk73EoQT/0+YSEjnLjIIUBN5a9tSwGiTVXagQsmQcf+Vu3sfScoCkNJYKegWKiTEZSFQ6wQeMQj05IC3jpQYSStYNadDacCCcZrWezG9exUS8dwRvkRt5i7QZtWoAznqinbMVmvKD/8VEPiU9ipYW+xUg8zujfCznfFrKwKXE/WnAsGvZH0O3BZfp7fmGjv8t9fkokQKj3Zv6RhRYxOFrbp2eoxEYF6ABm1KXBgGtUd5rUtvKNcuOiBKcrwygVNoYuT6GqVV71IBnGdyIynqHGfRGRt/aQ1ueisdWYJtGLBkQe//jxKS95ENgC06mzecNAoquWaNwZUuMXjC28toNnwZ9USJ+4M1JrMUUA40tYjh8GgEls0tJKo/TSZwxDUyBswsl3kQn0MWllDgI/J/WbX36jCVW+AEl49KOp2SLjSMlT/Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gsVy22dCQg9DrZWdtRmVnH8PaESOXb3HDHzt01GxgBltf57n2/2nNlDMsnvg7USQjphbBk+2p7uTIx9FbfWAhNal8FSUbDVJW3Z284mYM8OGgGHWLqHdF8v3cmaQ//pXRPZyfZOjEI63K1bSXCKBFHBdNmmHRLdxYF3vtUQGnxv70l3kS/dGHoEnQrH89CoywScIR1FknbkaZ18I7cPDBc3y2itE0QTR05/8loq4/yqI0ziPz4WKA3I6C7IZvi4pmlH1NXXEyuMtIC+tRqjNITDkwpSl6QRYAaO5AYHnD6d3cSLZ15AGBEeeodQyWJBBiCUIdzDgAcj3CgRaTrGVbvcoMB/sZjTVftwznZUI3OGbFuoPacRc8VYJv8K9k0QsRnfI7GdVAJjbrw+Tu5BG3moKfHxaYyCW9/auBaxWuRRVJxGmxtFJG/EVtIZ0q3Qo
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:58:03.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5b7d55-95fe-44f4-bd4c-08df1f91b868
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D216.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17422

The maximum number of channels is currently hardcoded per SoC in
struct rcar_canfd_hw_info. Since the DT describes the channels as
child nodes of the controller, the count can be obtained at probe time
with of_get_child_count() instead.

Drop max_channels from struct rcar_canfd_hw_info and store the value
in struct rcar_canfd_global, so it no longer needs to be maintained
for each SoC variant. Update all for_each_set_bit() users over
channels_mask to use gpriv->max_channels.

No functional change.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Collected tags.
v2->v3:
 * Added check against RCANFD_NUM_CHANNELS, to avoid overrunning the
   fixed-size rcar_canfd_global.ch[] and transceivers[] arrays.
v2:
 * New patch
---
 drivers/net/can/rcar/rcar_canfd.c | 39 +++++++++++++++----------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..41c395118949 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -436,7 +436,6 @@ struct rcar_canfd_hw_info {
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
-	u8 max_channels;
 	u8 postdiv;
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
@@ -478,6 +477,7 @@ struct rcar_canfd_global {
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
+	u8 max_channels;
 };
 
 /* CAN FD mode nominal rate constants */
@@ -613,7 +613,6 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
-	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
@@ -632,7 +631,6 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
-	.max_channels = 8,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
@@ -651,7 +649,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
-	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
@@ -670,7 +667,6 @@ static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 15,
 	.max_cftml = 31,
-	.max_channels = 2,
 	.postdiv = 2,
 	.shared_global_irqs = 0,
 	.multi_channel_irqs = 1,
@@ -690,7 +686,6 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 63,
 	.max_cftml = 31,
-	.max_channels = 6,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 1,
@@ -709,7 +704,6 @@ static const struct rcar_canfd_hw_info r9a09g077_hw_info = {
 	.rnc_field_width = 16,
 	.max_aflpn = 15,
 	.max_cftml = 31,
-	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 1,
@@ -854,7 +848,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	}
 
 	/* Transition all Channels to reset mode */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
 				     RCANFD_CCTR(ch), RCANFD_CCTR_CSLPR);
 
@@ -922,7 +916,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCFG, cfg);
 
 	/* Channel configuration settings */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_set_bit(gpriv->base, RCANFD_CCTR(ch),
 				   RCANFD_CCTR_ERRD);
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
@@ -1293,7 +1287,7 @@ static irqreturn_t rcar_canfd_global_err_interrupt(int irq, void *dev_id)
 	struct rcar_canfd_global *gpriv = dev_id;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_handle_global_err(gpriv, ch);
 
 	return IRQ_HANDLED;
@@ -1325,7 +1319,7 @@ static irqreturn_t rcar_canfd_global_receive_fifo_interrupt(int irq, void *dev_i
 	struct rcar_canfd_global *gpriv = dev_id;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_handle_global_receive(gpriv, ch);
 
 	return IRQ_HANDLED;
@@ -1339,7 +1333,7 @@ static irqreturn_t rcar_canfd_global_interrupt(int irq, void *dev_id)
 	/* Global error interrupts still indicate a condition specific
 	 * to a channel. RxFIFO interrupt is a global interrupt.
 	 */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_handle_global_err(gpriv, ch);
 		rcar_canfd_handle_global_receive(gpriv, ch);
 	}
@@ -1435,7 +1429,7 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	u32 ch;
 
 	/* Common FIFO is a per channel resource */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_handle_channel_err(gpriv, ch);
 		rcar_canfd_handle_channel_tx(gpriv, ch);
 	}
@@ -2072,7 +2066,7 @@ static int rcar_canfd_global_init(struct rcar_canfd_global *gpriv)
 	rcar_canfd_configure_controller(gpriv);
 
 	/* Configure per channel attributes */
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		/* Configure Channel's Rx fifo */
 		rcar_canfd_configure_rx(gpriv, ch);
 
@@ -2145,14 +2139,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	u8 max_channels;
 	int i;
 
 	info = of_device_get_match_data(dev);
+	max_channels = of_get_child_count(dev->of_node);
+	if (max_channels > RCANFD_NUM_CHANNELS)
+		return -EINVAL;
 
 	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */
 
-	for (i = 0; i < info->max_channels; ++i) {
+	for (i = 0; i < max_channels; ++i) {
 		name[7] = '0' + i;
 		of_child = of_get_available_child_by_name(dev->of_node, name);
 		if (of_child) {
@@ -2199,6 +2197,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->pdev = pdev;
 	gpriv->channels_mask = channels_mask;
 	gpriv->fdmode = fdmode;
+	gpriv->max_channels = max_channels;
 	gpriv->info = info;
 
 	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
@@ -2300,7 +2299,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_mode;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
 					       transceivers[ch]);
 		if (err)
@@ -2314,7 +2313,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	return 0;
 
 fail_channel:
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_global_deinit(gpriv, false);
@@ -2327,7 +2326,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
@@ -2341,7 +2340,7 @@ static int rcar_canfd_suspend(struct device *dev)
 	int err;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
@@ -2378,7 +2377,7 @@ static int rcar_canfd_resume(struct device *dev)
 		return err;
 	}
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
-- 
2.43.0


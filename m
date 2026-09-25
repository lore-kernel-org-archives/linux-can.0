Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011058.outbound.protection.outlook.com [40.107.74.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A35A393;
	Fri, 25 Sep 2026 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790324529; cv=fail; b=nEpOW188JWANFA7MS3QIoO81hRBUliITwUaO+VyG02hBN3wUaiLghTe0QMFX10u/E4ZaKwpA0Q0wjvAb+JjsRF4rxEa1gQBi0U0SOh1V9J/nXPUmTIcgm1hbDsrD5fHxSBeh1xtCjeSMma4bOjjyoEgG2O2TwEwH7TAfrDrgmtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790324529; c=relaxed/simple;
	bh=J2GPz7WuwYDhPT05Ae5K1UK/GkBHuYh8GGElUIZO3WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzNirTA99k7Q8Ly4Vi2AFkEuZJGlgTLAeYDDddLJjtX3U69AyG80PTvFjOP6q9l5ycZFbywu4IDX/vYPeVaJS9g1EHez54aS4Lqr/r5JIyOSeNN6s7z9+KotGvPIfURtXWWgk82oWmJyIY3NBHuNhes3gOfGHBwA9ujpJoYq2HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=t5Du7R76; arc=fail smtp.client-ip=40.107.74.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="t5Du7R76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZA7uPv7xtEjIGv7jgY8dOUmDTNBsel2MMZMHNeIYgk4zVZPnkp6iFriYHXaQpChea3NnmphZjNg8dWNysGeniiql60yrZJioY25scJZL6pnyPYhhjNe9rRHFttDmCAm3ISmOo4rC93iOb5uWERtRPwfyKfOA/6n51PrN6OwukvsF5dw3q/9xFa3txIEUwOjdguQZgVkJABQVyD2nD/vC+FAeSVZ0c2JlJmMeLeJZEMMBtmC/vRZAjtl8yVcVHGQyr18zWslI9RDlNoPpARnNGOmDZAFkCtQaGBFULLfSRCxVVSdJ4QlODoLaMhb/G7coVM6GpntOBJx99r+NqrTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRE0h5VQfv4ge0c1GX5MyP0IztJvVaHGhkFn3YIOR0o=;
 b=eyrn3dnupaN/zwvFj09W4fHTGT2iSq6f3hqup+yWIVxyXLgxJjNqefzBpozZ2OULjo28QGD8EJeRyOxsD5oWMfectizxaMdIVDNpGvfNbvo8kr+DTSGtbiIOj12mhMmaL+GVDVo1bUrgx0Tjnaplipcw1Mpvfoa4Z+d0CeRnzJzulrAEY1Qh3v+SuG0D21Hhn0OIHTzkp+3iuNzvJBbTWHQhZ0osnT4ZcIL6TJZkIO2duJg5/19rn1lJRWu9r2RZI80crGcW8CB/wdLZ5hknq7WAzVfgajip7xexgG4AcShVAO6+UsQJxvzv41uDttSXGWc0lX6B8hMZX9AWyFxGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRE0h5VQfv4ge0c1GX5MyP0IztJvVaHGhkFn3YIOR0o=;
 b=t5Du7R762PsadykEQ58VuI8HPJza+oorMsRNtx8i39+RBqe+nmXLn6TFwovJUtvtE7ZoQgA7GwgFoSK0xUshbazcJ0WMooak4Do51+jT4Q3qidAOVX+ezHbr0ub7W0WLJmzLFASTG+FdNzE/DLDqHgy7wjJOpVRrRtWoigrGF2s=
Received: from TY6P286CA0003.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::17)
 by OSZPR01MB9485.jpnprd01.prod.outlook.com (2603:1096:604:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 08:22:01 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::e) by TY6P286CA0003.outlook.office365.com
 (2603:1096:405:3b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 08:22:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 08:22:01 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.93.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 6364E300021F;
	Fri, 25 Sep 2026 17:21:54 +0900 (JST)
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
Subject: [PATCH v3 2/3] can: rcar_canfd: Derive max_channels from the device tree
Date: Fri, 25 Sep 2026 09:21:29 +0100
Message-ID: <20260925082134.146015-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|OSZPR01MB9485:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29870d01-570a-4dbe-5489-08df1ade1323
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|11063799006|6133799003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	lQbW6d7H8L4U9xYjwgcrE81kqwdaPpv9+ScZGrvzFgXXR72g7HdTt3vDzdhfQ593kx/VCo8hdgCdqqXKGI1q5cC7N/aMlNdQMXAulcYlYaQunZZivEvsRab5hCmaSnWwqdcjiSVw8PXgyDAyyO4jG7vh7aM8frfFb2SeD66pLcjlGITXjXtUz9CeTaG+TWfvMMBMp73wovGlRpXtw+wt+PGY1E9Li7Z5PZgcx8eB0IqKzzm8oELClRYVVNwFwZDhzczhOpNCRvGnKq0DR4LL1DjHmnz9kuNG9BEZ/kA/plTKGhplntgBUpCTxfVBDGCyveWywb16Wudl9PvDdvcnyorj0NgFDGgSpdmbBwzT8p+of1RDsyA8BCMCLIOxcLfn6E/Z7Se3W24d3h6snDeX8Ij9nlnwcqUE7OIaJ65VXbG5tm6p36bYcWcqCLqdbgN7Jlq3/8Iw5nwt1FUi5Ic28LuNpe3ydRpw0TmrxcNKRAudOxBV5+l5h31+pSBnLdlOiM+7grCrBoqpmOHhRVU/ZyHchOOIsKUtVpAGjZwj9G2RKJxH1MsKBn0g77WomHZ8LI/aoTUR4T2w+kk7TNTLC70/myfp72InmwtZ5N7DcWXkwoNRPk4utyCo/Ye5PfI9ghDvb/okBuggJqG6vBbVNy4iAVcGAPEPNgh9C5K0V0ppvZmpYs9vInAA7kFfgIWIG26GP7M0NIsjoqfkYEgWNg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(6133799003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	alxzEPSiP8+gAyOc8Uc4THiTgkznatfrwrB+nEIITwrsVjeFHsLUZViYK/EIjtU9BBScqheAA7uySshBJ60mvY8ZBsbGpc3FsAf3kaKk7HaXZyV1NabCDzoJfNLCwYNsYqYaECKSvmXkMcJyf2p8sh4espuJCrEbcbg7d/lva+UqcC1aFvmAGKH1JK8q62zLzIkubky5WGAh5RiiBPB1u727K+vdePZzEbr79NpN24dQQwFynC0GXpaF2hFUI5oaT+QctFezkzPD/Sa1mBg+11THDIz2MPIcezATBVYiVh7ebZ867R/l7vrmLHG6rIEBO1y9QcZdBySItJN3gcg0hC5pldGcW/CcAJpCbn3JttAQJNx3RaEcXNOBjOhR78cg0HzCQqEEJndALHGuykROgJX6MRh04O1Km1GnglMgFenVxBqHC38328R7x+uGMUcX
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 08:22:01.5550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29870d01-570a-4dbe-5489-08df1ade1323
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9485

The maximum number of channels is currently hardcoded per SoC in
struct rcar_canfd_hw_info. Since the DT describes the channels as
child nodes of the controller, the count can be obtained at probe time
with of_get_child_count() instead.

Drop max_channels from struct rcar_canfd_hw_info and store the value
in struct rcar_canfd_global, so it no longer needs to be maintained
for each SoC variant. Update all for_each_set_bit() users over
channels_mask to use gpriv->max_channels.

No functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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


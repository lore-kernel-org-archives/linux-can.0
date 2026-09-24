Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010049.outbound.protection.outlook.com [52.101.229.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA413BCD3F;
	Thu, 24 Sep 2026 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790227704; cv=fail; b=G6JXg9KtFzZPY3tTMaEtU0ULjNSKNZ+NDQ+F67o+0/vmq7dGsWC7bPdVXQk9azAe0rog32IusVFbIjAb8oP/yEYu7g6KUbbn9c2p+qXx3mC3IK/ejn+U2yYZ8FaMJdAMrBm0GHb3WSp4Wfp6gC/y18ugsDnGV3qo+RBLo3VvA7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790227704; c=relaxed/simple;
	bh=uH+LyYbd1lAPih0ckq8/8OfpROEhKpctFnSDD5KP33w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqyqIZsjEaJOLbc2Uywsi2Ry6jYLPF9snP3AtujoyDm+Md6v3GtZGaEvfAY/RqLi7q//0icbDMb+uB48SuTepGAelmL9YjGhj1P6UwjixxWxBB3ASMBROMTc9TIvoKMl4ToeC1KZxRMANsWxG/pYJj+LouE2ZxPbZ0K1dlHZgRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=amz3ez61; arc=fail smtp.client-ip=52.101.229.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="amz3ez61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSqcMBUbbZT9D/QNoZ3Bsgh2mPt8JtsAdjPpaa1bY+WAbhJekzdfLG8pSj4R+upkuqsvsN1J1bRJIEqoIxcTKBwAAaTx5Z6TUl9DDz2dnRqOGvpUndcZri0yf0bS/Tyf7fa+HZ0RfM+mMN8tbQgOkHx+OtjIl3OfDPmzMOMuIVFgRkjXh+QhShdeOjQbjdXYXuJYW43vN0c6QROwSu7rg/GbFULqxZR6bV3RqmPXrk7VrJxMdWOF9vYCkelk7BKM1HxIIGdhS4kkN95knOfEys5pgrMXL3ni0pvoCCdlfGg9tdISmVa6GxqHmiT60RxqBv7mKZadqhGQu1H9J/8Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Jv/8p8nqJ+HB1bKxqTzN2bd9AYDqCcPJULmokJHxsk=;
 b=r5jMcNQV3XT+23eWm6OZjF0KW39j/qoRRjCQdyUxnoxF1/PErv4EzsF85Y5bajHzyjKJ6AgWtvMF0UO1zd05y6p4c1kfyddujeJYVVe09KpDCltV0n8oC+xQnm3l5zv2ntKZj8PEYfd6ZnAGhFrx6OZavLjNZF9inkp6N9B8xiQS51y+fd3pELBtDA5OxPpoVVFmHim22cdPlLKMZYTizn76CyuuUTHciqIpNhOveQLAjwmmJo0kH/nlmpR2nt39/TXq/WpVuzB6wnXtzNMG9Nki6n2Kltr1/KOzQlvlvz4GHxTBHPyTQdpZobOFls6heZqPR16TQBtZUacmL9QX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Jv/8p8nqJ+HB1bKxqTzN2bd9AYDqCcPJULmokJHxsk=;
 b=amz3ez613dumS9my+mkvCN6sKyPDlKWQDA6uxB+MDBcj3ICp50eepV9AYuu0KWOvs6RVzNdLINs6iZ5JDytX54Bf7UJpSo7uQaPLa9ci7dx2gH7oER8wTxC94P4BUV2ndiwMthYqZ5LDNx92OmGnl2ctWvaSzC3PS3mNHNSrr4w=
Received: from TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36b::15)
 by TYYPR01MB16246.jpnprd01.prod.outlook.com (2603:1096:405:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 05:28:17 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36b:cafe::a6) by TY4P301CA0052.outlook.office365.com
 (2603:1096:405:36b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 05:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 05:28:17 +0000
Received: from biju-VirtualBox.adwin.renesas.com (unknown [10.226.92.63])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id B061F3000265;
	Thu, 24 Sep 2026 14:28:11 +0900 (JST)
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
Subject: [PATCH v2 2/3] can: rcar_canfd: Derive max_channels from the device tree
Date: Thu, 24 Sep 2026 06:27:34 +0100
Message-ID: <20260924052741.130658-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TYYPR01MB16246:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 277f6ad9-ac0c-4c0c-eeee-08df19fca3b2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	uyxWAUkpUVP6pxk8ZJH/Vm2qCZS/Nl4638zAeTBw6LOh5MZwG7sdae9wRxx2LtJ1W+yAXlOB3zzvma1uJvVZ8/qvmVETg3yFogVhqehWia/O6O+NRbLwjs9FwV1oPn0paFqqQ7WP/aThhhpPxj/XFt0dYjdbdolSEDv6pHO9ttP/luBbgQnCF3+AbPe3Mz0HtHZh7Do14WfFd4a0Lxk37M5akAnkHep/9kg7/d/11fJTUdxQMJHUg3AcH9TNDWc08Y9XHhCR09G1xYL4u3k1ptDZ6dRMpv7XNO2AFDo2TAsSgJK/q6DHpHr8VL4qQ/RjV+NRGJ3/+YLPKPSJ0+XeUPk1kP5eap4mOliLLh9+L3HqNXmeUaN4NSLos62gqE61yT1+ZB0iGAPWSHBYRc7SUmIZE2iS0GHTsYm5iPulHSLwh89do0d8zSN92tsJMZhtG/jaSPKzfPaJ+TuQvUAuwUjYSOWhKj6hohjW4xUdMNGkMQGdbv8iQeGuR3v3dVdio80+wSLXR8ES1u0cZLPxDvakCnQgbX3JRZrQZ3qI6k8qncWyFUjv5bCoOBIvRThjXu+h4TsanK8lcgJ+QqmgEG1q/eCKtFTGdkoOWaHfF9dJpMU/JEmcX+aPlafh7Ff/A8dr9BPBziZL0FVd3l+cQErejAvZfv3/O4YvNIicPaX8HIw4+YeiZTPF2dKlqIl7tu0Opv4JY1UPxiegW7NSFg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wRp2mPtmJ3+uIgDTrJNVtm5cB0RPnU2+pedSMZuTdwawKZQc9r2R+DwmTpoHQPq30QzR2dP3ZRaOmt54Jp8P9GH2Ta2vadZhRCFU6SEsSAw/lOR6NAlW0dv9zSQQAYyrv8GVxvgSnnouz3hixoziN9XYX+0zNB4uvpgmdUVOt2XsDKvFVdB1yu3mEDFN8hY0xaa41BnqqhmYkCFmh3SrHruyQPYJl9YIqQ3BwUeD/gB1U74jj3+1XlV3+PWeqv26Ia0K67gerPBmHv1srhNRe5tZjUFs3gcR72QvkNHt4Rf+TTCls08Bybu8U9yQ8izzySDoM6pHIo3fktS5xKvpz500EYDnoIE6OVT9V42y2JPdYr3pIpRz5idn2VlXmIxRjV6V/yhIHoCzQg1w0kpez8+HM5yVjMOdwFrWeM1MDKa208PandT7ncwaSCle6oAk
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 05:28:17.8263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277f6ad9-ac0c-4c0c-eeee-08df19fca3b2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16246

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
v2:
 * New patch
---
 drivers/net/can/rcar/rcar_canfd.c | 37 ++++++++++++++-----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74c3c3f20991..721099cb113b 100644
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
 
@@ -2145,14 +2139,16 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	u8 max_channels;
 	int i;
 
 	info = of_device_get_match_data(dev);
+	max_channels = of_get_child_count(dev->of_node);
 
 	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */
 
-	for (i = 0; i < info->max_channels; ++i) {
+	for (i = 0; i < max_channels; ++i) {
 		name[7] = '0' + i;
 		of_child = of_get_available_child_by_name(dev->of_node, name);
 		if (of_child) {
@@ -2199,6 +2195,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->pdev = pdev;
 	gpriv->channels_mask = channels_mask;
 	gpriv->fdmode = fdmode;
+	gpriv->max_channels = max_channels;
 	gpriv->info = info;
 
 	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
@@ -2300,7 +2297,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_mode;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		err = rcar_canfd_channel_probe(gpriv, ch, fcan_freq,
 					       transceivers[ch]);
 		if (err)
@@ -2314,7 +2311,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	return 0;
 
 fail_channel:
-	for_each_set_bit(ch, &gpriv->channels_mask, info->max_channels)
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_global_deinit(gpriv, false);
@@ -2327,7 +2324,7 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
@@ -2341,7 +2338,7 @@ static int rcar_canfd_suspend(struct device *dev)
 	int err;
 	u32 ch;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
@@ -2378,7 +2375,7 @@ static int rcar_canfd_resume(struct device *dev)
 		return err;
 	}
 
-	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels) {
 		struct rcar_canfd_channel *priv = gpriv->ch[ch];
 		struct net_device *ndev = priv->ndev;
 
-- 
2.43.0

